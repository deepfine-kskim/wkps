package egovframework.com.utl.wed.comm;

public class PageNavigation {

	private int maxNumber;
	private int numberStart;
	private int numberEnd;
	private boolean canPreviousSection;
	private boolean canNextSection;
	private int dbOffset;
	private int dbLimit;
	private int totalItemCount;
	private int pageIndex = 1;
	private int itemCountPerPage = 10;
	private int countPagePrint = 5;

	public PageNavigation(int totalItemCount, Integer pageIndex,
                          Integer itemCountPerPage, Integer countPagePrint) {
		calc(totalItemCount, pageIndex, itemCountPerPage, countPagePrint);
	}

	public void calc(int totalItemCount, Integer pageIndex,
			Integer itemCountPerPage, Integer countPagePrint) {
		this.totalItemCount = totalItemCount;

		if (pageIndex != null && pageIndex.intValue() > 0) {
			this.pageIndex = pageIndex.intValue();
		}
		if (itemCountPerPage != null) {
			this.itemCountPerPage = itemCountPerPage.intValue();
		}
		if (countPagePrint != null) {
			this.countPagePrint = countPagePrint.intValue();
		}

		calc();
	}

	private void calc() {
		maxNumber = (int) (Math
				.ceil(((float) totalItemCount / (float) itemCountPerPage) * 1.0) / 1.0);

		if (pageIndex > maxNumber) {
			pageIndex = maxNumber;
		}

		numberStart = (countPagePrint * (int) (Math
				.floor(((float) (pageIndex - 1) / (float) countPagePrint) * 1.0) / 1.0)) + 1;
		numberEnd = numberStart + countPagePrint - 1;

		canPreviousSection = numberStart > 1;
		canNextSection = (maxNumber - numberEnd) > 0;

		if (numberEnd > maxNumber) {
			numberEnd = maxNumber;
		}

		dbOffset = (pageIndex - 1) * itemCountPerPage;
		dbLimit = itemCountPerPage;
	}

	public int getDbOffset() {
		return dbOffset;
	}

	public int getDbLimit() {
		return dbLimit;
	}

	public int getNumberStart() {
		return numberStart;
	}

	public int getNumberEnd() {
		return numberEnd;
	}

	public int getMaxNumber() {
		return maxNumber;
	}

	public boolean isCanPreviousSection() {
		return canPreviousSection;
	}

	public boolean isCanNextSection() {
		return canNextSection;
	}

	public int getTotalItemCount() {
		return totalItemCount;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public int getItemCountPerPage() {
		return itemCountPerPage;
	}

	public int getCountPagePrint() {
		return countPagePrint;
	}

}
