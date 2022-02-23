package egovframework.com.kf.dao;

import egovframework.com.kf.common.DCUtil;
import egovframework.rte.fdl.property.EgovPropertyService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/**
 * Class Name : KsfModule.java
 * Description : 검색엔진의 KSF 모듈이용하여 검색결과 조회 모듈
 * <p>
 * Modification Information
 * <p>
 * 수정일                        수정자           수정내용
 * --------------------  -----------  ---------------------------------------
 * 2017년 12월  00일                       최초 작성
 *
 * @version V1.0
 * @see (c) Copyright (C) by KONANTECH All right reserved
 * @since 2017년
 */
@Component("ksfModule")
public class KsfModule {

    private static final Logger KS_LOGGER = LoggerFactory.getLogger(KsfModule.class);

    /**
     * EgovPropertyService
     */
    @Resource(name = "konanPropertiesService")
    private EgovPropertyService konanPropertiesService;

    @Autowired
    private DCUtil dc;


    /**
     * 검색어 자동완성 메소드 (getAutocomplete).
     *
     * @param seed           키워드
     * @param maxResultCount 최대 결과 수
     * @param flag           결과 형식 플래그 (앞, 뒤 단어 일치 여부)
     * @param mode           첫단어, 끝단어
     * @param domainNo       모듈 도메인 번호
     * @return String
     */
    public String[] getAutocomplete(String seed, String mode, int maxResultCount, int domainNo) {
        String charset = konanPropertiesService.getString("charset");
        StringBuffer ksfUrl = new StringBuffer();
        ksfUrl.append(konanPropertiesService.getString("ksfUrl"));
        ksfUrl.append("suggest");
        ksfUrl.append("?target=complete");
        String param1 = "&term=" + dc.urlEncode(seed, charset); 
        ksfUrl.append(param1);
        String param2 = "&mode=" + mode; 
        ksfUrl.append(param2);
        String param3 = "&domain_no=" + domainNo; 
        ksfUrl.append(param3);
        String param4 = "&max_count=" + maxResultCount; 
        ksfUrl.append(param4);

        //logger.debug("suggest url : " + ksfUrl.toString());

        StringBuffer sb = dc.getUrlData(ksfUrl.toString(), charset);


        // 결과 파싱
        try {

            JSONParser parser = new JSONParser();
            Object obj = parser.parse(sb.toString());
            JSONObject jsonObj = (JSONObject) obj;
            JSONArray arr = (JSONArray) jsonObj.get("suggestions");
            JSONArray arr2 = (JSONArray) arr.get(0);
            int autosize = arr2.size();
            String[] a = new String[autosize];
            JSONArray arr3;
            int i = 0;
            List<String> list = new ArrayList<>();
//	        System.out.println("a.arr3() " + arr2);
            for (Object o : arr2) {
                arr3 = (JSONArray) o;
                a[i] = arr3.get(0).toString();
                //list.add(o.toString());
                i++;
            }
            return a;

        } catch (ParseException e) {
            KS_LOGGER.error("konan search engine search error...", e);
            return null;
        }
//        return sb.toString();

    }


    /**
     * 인기검색어를 조회하
     *
     * @param domainNo  도메인
     * @param maxResult 검색결과 수
     * @return
     */
    public List<LinkedHashMap<String, String>> getPopularKwd(int domainNo, int maxResult) {
        int i = 1;
        StringBuffer ksfUrl = new StringBuffer();
        ksfUrl.append(konanPropertiesService.getString("ksfUrl"));
        ksfUrl.append("rankings");
        ksfUrl.append("?realtime=true");
        String param1 = "domain_no=" + domainNo;
        ksfUrl.append(param1);
        String param2 = "&max_count=" + maxResult;
        ksfUrl.append(param2);

        //logger.debug("rankings url : " + ksfUrl.toString());
        String charset = konanPropertiesService.getString("charset");
        StringBuffer sb = dc.getUrlData(ksfUrl.toString(), charset);

        // 결과 파싱
        try {

            JSONParser parser = new JSONParser();
            Object obj = parser.parse(sb.toString());

            JSONArray arr = (JSONArray) obj;

            List<LinkedHashMap<String, String>> list = new ArrayList<>();
            LinkedHashMap<String, String> map;
            JSONArray ppk;
            for (Object o : arr) {

                map = new LinkedHashMap<>();
                ppk = (JSONArray) o;

                map.put("ppk", ppk.get(0).toString());
                map.put("meta", Integer.toString(i));


                list.add(map);
                map = null;
                i++;
            }

            return list;

        } catch (ParseException e) {
            KS_LOGGER.error("konan search engine search error...", e);
            return null;
        }

    }


    /**
     * 오타교정
     *
     * @param term 키워드
     * @return String
     */
    public String getSpellChek(String term) {
        String charset = konanPropertiesService.getString("charset");
        StringBuffer ksfUrl = new StringBuffer();
        ksfUrl.append(konanPropertiesService.getString("ksfUrl"));
        ksfUrl.append("suggest");
        ksfUrl.append("?target=spell");
        String param1 = "&term=" + dc.urlEncode(term, charset); 
        ksfUrl.append(param1);

        KS_LOGGER.debug("spell url : " + ksfUrl.toString());

        StringBuffer sb = dc.getUrlData(ksfUrl.toString(), charset);
        return sb.toString();
    }

    /**
     * 금칙어
     *
     * @param term 키워드
     * @return String
     */
    public boolean getCensored(String term) {
        String charset = konanPropertiesService.getString("charset");
        StringBuffer ksfUrl = new StringBuffer();
        ksfUrl.append(konanPropertiesService.getString("ksfUrl"));
        ksfUrl.append("censored");
        ksfUrl.append("?domain_no=1");
        String param1 = "&term=" + dc.urlEncode(term, charset); 
        ksfUrl.append(param1);

        KS_LOGGER.debug("censored url : " + ksfUrl.toString());
        //http://10.10.20.145:8080/ksf/api/censored?domain_no=1&term=%EC%84%B1%EC%9D%B8

        StringBuffer sb = dc.getUrlData(ksfUrl.toString(), charset);

        return sb.toString().contains(term);
        //return sb.toString();
    }

    /**
     * 연관검색어를 조회
     *
     * @param domainNo  도메인번호
     * @param maxResult 검색결과 수
     * @return
     */
    public List getSuggestionKwd(int domainNo, int maxResult, String kwd) {
        String kwd1 = "";
		try {
			kwd1 = URLEncoder.encode(kwd, konanPropertiesService.getString("charset"));
		} catch (UnsupportedEncodingException e1) {
			KS_LOGGER.error("[" + e1.getClass() +"] :" + e1.getMessage());
		}
        StringBuffer ksfUrl = new StringBuffer();
        ksfUrl.append(konanPropertiesService.getString("ksfUrl"));
        ksfUrl.append("suggest");
        ksfUrl.append("?target=related");
        String param1 = "&domain_no=" + domainNo; 
        ksfUrl.append(param1);
        String param2 = "&term=" + kwd1; 
        ksfUrl.append(param2);
        String param3 = "&max_count=" + maxResult; 
        ksfUrl.append(param3);

        //logger.debug("rankings url : " + ksfUrl.toString());
        String charset = konanPropertiesService.getString("charset");
        StringBuffer sb = dc.getUrlData(ksfUrl.toString(), charset);

        // 결과 파싱
        try {

            JSONParser parser = new JSONParser();
            Object obj = parser.parse(sb.toString());
            JSONArray arr = (JSONArray) obj;
            List<String> list = new ArrayList<>();
            for (Object o : arr) {
                list.add(o.toString());
            }
            return list;

        } catch (ParseException e) {
            KS_LOGGER.error("konan search engine search error...", e);
            return null;
        }


    }
}
