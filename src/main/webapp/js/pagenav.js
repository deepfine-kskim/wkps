// 페이지 이동 1,2, ... 하는 HTML 코드를 생성해서 돌려준다.
//	funcName : 실제 페이지 이동을 위한 함수이름 (예: gotoPage)
//	pageNum : 현재 페이지 번호
//	pageSize : 한 페이지당 결과 갯수
//	total : 전체 결과 갯수

function navAnchorPage( funcName, pageNo, anchorText )
{
    var font_class = "<li><a href=\"javascript:{" + funcName + "(" + pageNo + ")}\">" + anchorText + "</a></li>";    
	return font_class;
}

function navAnchor( funcName, pageNo, anchorText, title )
{
    var font_class = "<li><a href=\"javascript:" + funcName + "(" + pageNo + ")\" " + title +">" + anchorText + "</a></li>";
	return font_class;
}


function pageNav( funcName, pageNum, pageSize, total, sizeStatus )
{
	if( total < 1 ){
		return "";
	}

	var ret = "";
	var PAGEBLOCK=10;
	
	if(sizeStatus == 0)
		PAGEBLOCK = 1;
	
	var totalPages = Math.floor((total-1)/pageSize) + 1;

	var firstPage = Math.floor((pageNum-1)/PAGEBLOCK) * PAGEBLOCK + 1;
	if( firstPage <= 0 ) // ?
		firstPage = 1;
	
	var prevPage = pageNum - pageSize;
	if( prevPage <= 0 ) 
		prevPage = 1;

	var lastPage = firstPage-1 + PAGEBLOCK;
	if( lastPage > totalPages )
		lastPage = totalPages;
	
	var nextPage = Number(pageNum)+Number(pageSize);
	if( nextPage > totalPages )
		nextPage = totalPages;
	
	ret+="<nav class=\"text-center\"> <ul class=\"pagination pagination-sm\">";
	
	if( pageNum > 1 )
	{
		ret += navAnchor(funcName, 1, "<span aria-hidden=\"true\"><i class=\"fa fa-angle-double-left\" aria-hidden=\"true\"></i></span>", "aria-label=\"Previous\" title=\"처음\"")+" ";
		ret += navAnchor(funcName, prevPage, "<span aria-hidden=\"true\"><i class=\"fa fa-angle-left\" aria-hidden=\"true\"></i></span>", "aria-label=\"Previous\" title=\"이전\"")+" ";
	}
	else{
		ret += "<li><a href=\"#\" aria-label=\"Previous\" title=\"처음\"><span aria-hidden=\"true\"><i class=\"fa fa-angle-double-left\" aria-hidden=\"true\"></i></span></a></li>"+" ";
		ret += "<li><a href=\"#\" aria-label=\"Previous\" title=\"이전\"><span aria-hidden=\"true\"><i class=\"fa fa-angle-left\" aria-hidden=\"true\"></i></span></a></li>"+" ";
	}

//	ret += "<span class=\"nums\">";
	
	for( var i=firstPage; i<=lastPage; i++ )
	{
		if( pageNum == i )
			ret += "<li class=\"active\"><a href=\"#\">"+ i + "</a></li>"+ " ";
		else
			ret += navAnchorPage(funcName, i, i);
	}
	
	ret += "</span>";

	if( pageNum < totalPages )
	{
		ret += navAnchor(funcName, nextPage, "<span aria-hidden=\"true\"><i class=\"fa fa-angle-right\" aria-hidden=\"true\"></i></span>", "aria-label=\"Next\" title=\"다음\"")+" ";
		ret += navAnchor(funcName, totalPages, "<span aria-hidden=\"true\"><i class=\"fa fa-angle-double-right\" aria-hidden=\"true\"></i></span>", "aria-label=\"Next\" title=\"마지막\"")+" ";
	}
	else{
		ret += "<li><a href=\"#\" aria-label=\"Next\" title=\"다음\"><span aria-hidden=\"true\"><i class=\"fa fa-angle-right\" aria-hidden=\"true\"></i></span></a></li>"+" ";
		ret += "<li><a href=\"#\" aria-label=\"Next\" title=\"마지막\"><span aria-hidden=\"true\"><i class=\"fa fa-angle-double-right\" aria-hidden=\"true\"></i></span></a></li>"+" ";
	}
	
	ret+="</ul></nav>"
	return ret;
}
