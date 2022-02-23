package egovframework.com.wkp.cmm.service;

import java.io.IOException;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.math.MathContext;
import java.util.Iterator;
import java.util.List;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.apache.poi.hwpf.converter.HtmlDocumentFacade;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.*;
import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTCol;
import org.openxmlformats.schemas.spreadsheetml.x2006.main.CTCols;
import org.springframework.web.multipart.MultipartFile;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class XlsxConverter {

    private XSSFWorkbook x;
    private HtmlDocumentFacade htmlDocumentFacade;
    private Element page;
    private StringBuilder css = new StringBuilder();

    private XlsxConverter(MultipartFile multipartFile) throws IOException, InvalidFormatException, ParserConfigurationException {

        x = new XSSFWorkbook(multipartFile.getInputStream());
        Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument();
        this.htmlDocumentFacade = new HtmlDocumentFacade(document);

        Element window = htmlDocumentFacade.createBlock();
        window.setAttribute("id", "window");
        page = htmlDocumentFacade.createBlock();
        page.setAttribute("id", "page");

        window.appendChild(page);
        htmlDocumentFacade.getBody().appendChild(window);
    }

    /**
     *
     * @param filePath
     * @throws InvalidFormatException
     * @throws IOException
     * @throws ParserConfigurationException
     * @throws TransformerException
     */
    public static void convert(MultipartFile multipartFile, StringBuffer sb) throws InvalidFormatException, IOException, ParserConfigurationException, TransformerException {
        XlsxConverter converter = new XlsxConverter(multipartFile);

        Integer sheetNum = converter.x.getNumberOfSheets();
        for (int i = 0; i < sheetNum; i++) {
            XSSFSheet sheet = converter.x.getSheet(converter.x.getSheetName(i));
            String sheetName = converter.x.getSheetName(i);
            //System.out.println("----starting process sheet : " + sheetName);
            // add sheet title
            {
                Element title = converter.htmlDocumentFacade.createHeader2();
                title.setTextContent(sheetName);
                converter.page.appendChild(title);
            }

            converter.processSheet(converter.page, sheet, "_" + i + "_");
        }

        converter.htmlDocumentFacade.updateStylesheet();

        Element style = (Element) converter.htmlDocumentFacade.getDocument().getElementsByTagName("style").item(0);
        style.setTextContent(converter.css.append(style.getTextContent()).toString());
        converter.saveAsHtml(sb, converter.htmlDocumentFacade.getDocument());
    }

    private void processSheet(Element container, XSSFSheet sheet, String sID) {

        Element table = htmlDocumentFacade.createTable();
        int sIndex = sheet.getWorkbook().getSheetIndex(sheet);
        String sId = "sheet_".concat(String.valueOf(sIndex));
        table.setAttribute("id", sId);
        table.setAttribute("border", "1");
        table.setAttribute("cellpadding", "2");
        table.setAttribute("cellspacing", "0");
        table.setAttribute("style", "border-collapse: collapse;");

        if (sheet.getDefaultRowHeightInPoints() > 0) {
            css.append("#").append(sId).append(" tr{height:").append(sheet.getDefaultRowHeightInPoints() / 28.34).append("cm}\n");
        }
        if (sheet.getDefaultColumnWidth() > 0) {
            css.append("#").append(sId).append(" td{width:").append(sheet.getDefaultColumnWidth() * 0.21).append("cm}\n");
        }
        // cols
        generateColumns(sheet, table);
        //rows

        final short col_num = get_col_max(sheet);
        final int row_num = sheet.getLastRowNum() + 1;
        for (int i = 0; i < row_num; i++) {
            Row row = sheet.getRow(i);
            processRow(table, (XSSFRow) row, sheet, col_num, sID, i);
        }

        container.appendChild(table);
    }

    private short get_col_max(XSSFSheet sheet) {
        short ans = -1;
        //rows
        Iterator<Row> rows = sheet.iterator();
        while (rows.hasNext()) {
            Row row = rows.next();
            if (row instanceof XSSFRow) {
                short c = (short) (row.getLastCellNum());
                if (ans < c) {
                    ans = c;
                }
            }
        }
        return ans;
    }

    /**
     * generated
     * <code><col><code> tags.
     *
     * @param sheet
     * @param table container.
     */
    private void generateColumns(XSSFSheet sheet, Element table) {
        List<CTCols> colsList = sheet.getCTWorksheet().getColsList();
        MathContext mc = new MathContext(3);
        for (CTCols cols : colsList) {
            long oldLevel = 1;
            for (CTCol col : cols.getColArray()) {
                while (true) {
                    if (oldLevel == col.getMin()) {
                        break;
                    }
                    Element column = htmlDocumentFacade.createTableColumn();
                    // htmlDocumentFacade.addStyleClass(column, "col", "width:2cm;");
                    column.setAttribute("style", "width:2cm;");
                    table.appendChild(column);
                    oldLevel++;
                }
                Element column = htmlDocumentFacade.createTableColumn();
                String width = new BigDecimal(sheet.getColumnWidth(Long.bitCount(oldLevel)) / 1440.0, mc).toString();
                column.setAttribute("style", "width:".concat(width).concat("cm;"));
                table.appendChild(column);

                oldLevel++;
            }
        }
    }

    private void processRow(Element table, XSSFRow row, XSSFSheet sheet, final int col_num, String sID, int pos_row) {
        Element tr = htmlDocumentFacade.createTableRow();

        if (!(row instanceof XSSFRow)) {
            for (int pos_col = 0; pos_col < col_num; pos_col++) {
                processCell(tr, null, sID, pos_col, pos_row);  // empty line
            }
        } else {
            if (row.isFormatted()) {
            	
            }

            if (row.getCTRow().getCustomHeight()) {
                tr.setAttribute("style", "height:".concat(String.valueOf(row.getHeightInPoints())).concat("pt;"));
            }

            for (int pos_col = 0; pos_col < col_num; pos_col++) {
                Cell cell = row.getCell(pos_col);
                if (cell instanceof XSSFCell) {
                    processCell(tr, (XSSFCell) cell, sID, pos_col, pos_row);
                } else {
                    processCell(tr, null, sID, pos_col, pos_row);
                }
            }
        }
        table.appendChild(tr);
    }

    private void processCell(Element tr, XSSFCell cell, String sID, int pos_col, int pos_row) {

        int cols = 1;
        int rows = 1;
        if (cell != null) {

            if (cell != null) {
                int num = cell.getSheet().getNumMergedRegions();
                // System.out.println(cell.getCTCell());
                for (int i = 0; i < num; i++) {

                    CellRangeAddress c = cell.getSheet().getMergedRegion(i);

                    //System.out.println(c.getFirstColumn());
                    //System.out.println(c.getLastColumn());
                    //System.out.println(c.getFirstRow());
                    //System.out.println(c.getLastRow());
                    //System.out.println();
                    //System.out.println(cell.getRowIndex());
                    //System.out.println(cell.getColumnIndex());
                    //System.out.println("\n\n\n");
                    // System.out.println(cra);
                    int x0 = c.getFirstColumn();
                    int x1 = c.getLastColumn();
                    int y0 = c.getFirstRow();
                    int y1 = c.getLastRow();
                    if (x0 == pos_col && y0 == pos_row) {
                        cols = c.getLastColumn() - c.getFirstColumn() + 1;
                        rows = c.getLastRow() - c.getFirstRow() + 1;
                    } else if ((x0 <= pos_col) && (pos_col <= x1) && (y0 <= pos_row) && (pos_row <= y1)) {
                        return;
                    }
                }
            }
        }

        Element td = htmlDocumentFacade.createTableCell();
        if (cols > 1) {
            td.setAttribute("colspan", "" + cols);
        }
        if (rows > 1) {
            td.setAttribute("rowspan", "" + rows);
        }
        Object value;
        if (cell == null) {
            // processCellStyle(td, cell.getCellStyle(), null);
            td.setTextContent("\u00a0");
        } else {
            switch (cell.getCellType()) {
                case BLANK:
                    value = "\u00a0";
                    break;
                case NUMERIC:
                    value = cell.getNumericCellValue();
                    break;
                case BOOLEAN:
                    value = cell.getBooleanCellValue();
                    break;
                case FORMULA:
                    value = cell.getStringCellValue();
                    break;
                default:
                    value = cell.getRichStringCellValue();
                    break;
            }
            if (value instanceof XSSFRichTextString) {
                processCellStyle(td, cell.getCellStyle(), (XSSFRichTextString) value, sID);
                td.setTextContent(value.toString());
            } else {
                processCellStyle(td, cell.getCellStyle(), null, sID);
                td.setTextContent(value.toString());
            }
            // String s = value.toString();
            // System.out.println(s);
        }
        // System.err.println(value);
        tr.appendChild(td);
    }

    private void processCellStyle(Element td, XSSFCellStyle style, XSSFRichTextString rts, String sID) {
        StringBuilder sb = new StringBuilder();

        if (rts != null) {
            XSSFFont font = rts.getFontOfFormattingRun(1);
            if (font != null) {
                sb.append("font-family:").append(font.getFontName()).append(";");
                // sb.append("color:").append(font.getColor() ).append(";");
                sb.append("font-size:").append(font.getFontHeightInPoints()).append("pt;");
                if (font.getXSSFColor() != null) {
                    String color = font.getXSSFColor().getARGBHex().substring(2);
                    sb.append("color:#").append(color).append(";");
                }
                if (font.getItalic()) {
                    sb.append("font-style:italic;");
                }
                if (font.getBold()) {
                    sb.append("font-weight:").append(font.getBold()).append(";");
                }
                if (font.getStrikeout()) {
                    sb.append("text-decoration:underline;");
                }
            }
        }
        if (style.getAlignment().getCode() != 1) {
            switch (style.getAlignment()) {
                case CENTER:
                    sb.append("text-align:").append("center;");
                    break;
                case RIGHT:
                    sb.append("text-align:").append("right;");
                    break;
			default:
				sb.append("text-align:").append("left;");
				break;
            }
        }

        if (style.getBorderBottom() != null) {
            sb.append("border-bottom:solid; ").append(style.getBorderBottom()).append("px;");
        }
        if (style.getBorderLeft() != null) {
            sb.append("border-left:solid; ").append(style.getBorderLeft()).append("px;");
        }
        if (style.getBorderTop() != null) {
            sb.append("border-top:solid; ").append(style.getBorderTop()).append("px;");
        }
        if (style.getBorderRight() != null) {
            sb.append("border-right:solid; ").append(style.getBorderRight()).append("px;");
        }

        //if (style.getFillBackgroundXSSFColor() != null) {
        //    XSSFColor color = style.getFillBackgroundXSSFColor();
        //}

        // System.out.println(style.getFillBackgroundXSSFColor());
        if (style.getFillBackgroundXSSFColor() != null) {
            sb.append("background:#fcc;");
        }
        // System.out.println(sb.toString());
        htmlDocumentFacade.addStyleClass(td, "td" + sID, sb.toString());
    }

    /**
     * @param output
     * @param document
     * @throws IOException
     * @throws TransformerException
     */
	private void saveAsHtml(StringBuffer sb, org.w3c.dom.Document document) throws IOException, TransformerException {

        DOMSource domSource = new DOMSource(document);
        StreamResult result = new StreamResult(new StringWriter());

        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer serializer = tf.newTransformer();
        serializer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
        serializer.setOutputProperty(OutputKeys.INDENT, "yes");
        serializer.setOutputProperty(OutputKeys.METHOD, "html");
        //serializer.setOutputProperty(OutputKeys.DOCTYPE_SYSTEM, "");
        serializer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");

        serializer.transform(domSource, result);
        String s = "<!DOCTYPE html>\n" + result.getWriter().toString();
        sb.append(s);
    }

}