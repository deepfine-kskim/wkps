package egovframework.com.cmm;


public class PageInfo {
	private int totalItem;
	private final int pageItemSize;
	private final int groupSize;
	
	private int currentPage;
	private int[] currentPageGroup;
	private int totalPage;
	
	private boolean havePrev;
	private boolean haveNext;
	
	public PageInfo(int totalItem, int pageItemSize)
	{
		this(totalItem, pageItemSize, 10, 1);
	}
	
	public PageInfo(int totalItem, int pageItemSize, int groupSize)
	{
		this(totalItem, pageItemSize, groupSize, 1);
	}
	
	public PageInfo(int totalItem, int pageSize, int groupSize, int currentPage)
	{
		this.totalItem = totalItem;
		this.pageItemSize = pageSize;
		this.groupSize = groupSize;
		havePrev = false;
		haveNext = false;
		setCurrentPage(currentPage);
	}
	
	public void setCurrentPage(int page)
	{
		if(page < 1)
			this.currentPage = 1;
		else
			this.currentPage = page;
		
		calculate();
	}
	
	public void setCurrentPage(int totalItem, int page)
	{
		this.totalItem = totalItem;
		setCurrentPage(page);
	}
	
	public int getTotalItem() {
		return totalItem;
	}

	public int getPageItemSize() {
		return pageItemSize;
	}

	public int getGroupSize() {
		return groupSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public int[] getCurrentPageGroup() {
		int[] currentPageGroup = new int[this.currentPageGroup.length];
		for(int i = 0; i < this.currentPageGroup.length; i++) {
			currentPageGroup[i] = this.currentPageGroup.clone()[i];
		}
		return currentPageGroup;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public boolean isHavePrev() {
		return havePrev;
	}

	public boolean isHaveNext() {
		return haveNext;
	}
	
	private void calculate()
	{
		int mod = pageItemSize == 0 ? 0 : totalItem % pageItemSize;
		int quotient = pageItemSize == 0 ? 0 : (totalItem - mod) / pageItemSize;

		this.totalPage = quotient + (mod == 0 ? 0 : 1);

		if (this.totalPage < this.currentPage)
			this.currentPage = this.totalPage;

		int sg = (int) (this.currentPage / this.groupSize);

		int sIdx = sg * groupSize + 1;
		int eIdx = sIdx + groupSize - 1;

		if (eIdx > totalPage)
			eIdx = totalPage;

		int pgCount = eIdx - sIdx + 1;

		this.currentPageGroup = new int[pgCount];
		for (int i = 0; i < this.currentPageGroup.length; ++i)
		{
			currentPageGroup[i] = sIdx + i;
		}

		if (pgCount == 0)
		{
			havePrev = haveNext = false;
		} else
		{
			havePrev = currentPageGroup[0] > groupSize;
			haveNext = currentPageGroup[currentPageGroup.length - 1] < totalPage;
		}
	}

	public int getStartItemIndex(int pageNumber)
	{
		int page = pageNumber;
		if (page < 0)
			page = 1;

		return ((page - 1) * pageItemSize) + 1;
	}

	public int getEndItenIndex(int pageNumber, int recCnt)
	{
		int page = pageNumber;
		if (page <= 0)
			page = 1;

		return recCnt - ((page - 1) * pageItemSize);
	}
	
	public String htmlPage(){
	   String page = "";
	   if(havePrev){
	      page += "<a href='#' onclick='changePage("+(currentPageGroup[0]-1)+");' class='prev-page'>이전페이지</a>";
	   }
	   //page += "<a href='#' ng-click='changePage();' class='prev'>이전</a>";
	   
	   for(int i = 0; i < currentPageGroup.length; i++){
	      if(currentPageGroup[i] == currentPage){
	         page += "<a href='#' onclick='changePage("+currentPageGroup[i]+");' class='num on'>"+currentPageGroup[i]+"</a>";
	      }else{
	         page += "<a href='#' onclick='changePage("+currentPageGroup[i]+");' class='num'>"+currentPageGroup[i]+"</a>";
	      }
	   }
	   
	   //page += "<a href='#' ng-click='changePage();' class='next'>다음</a>";
	   if(haveNext){
	      page += "<a href='#' onclick='changePage("+(currentPageGroup[groupSize-1]+1)+");' class='next-page'>다음페이지</a>";
	   }	   
	   return page;
	}
	public String htmlPage(String funcName){
      String page = "";
      if(havePrev){
         page += "<a href='#' onclick='"+funcName+"("+(currentPageGroup[0]-1)+");' class='prev-page'>이전페이지</a>";
      }
      //page += "<a href='#' ng-click='changePage();' class='prev'>이전</a>";
      
      for(int i = 0; i < currentPageGroup.length; i++){
         if(currentPageGroup[i] == currentPage){
            page += "<a href='#' onclick='"+funcName+"("+currentPageGroup[i]+");' class='num on'>"+currentPageGroup[i]+"</a>";
         }else{
            page += "<a href='#' onclick='"+funcName+"("+currentPageGroup[i]+");' class='num'>"+currentPageGroup[i]+"</a>";
         }
      }
      
      //page += "<a href='#' ng-click='changePage();' class='next'>다음</a>";
      if(haveNext){
         page += "<a href='#' onclick='"+funcName+"("+(currentPageGroup[groupSize-1]+1)+");' class='next-page'>다음페이지</a>";
      }     
      return page;
   }
}
