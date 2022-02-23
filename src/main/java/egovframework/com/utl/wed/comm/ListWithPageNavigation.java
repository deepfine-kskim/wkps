package egovframework.com.utl.wed.comm;

import java.util.List;

public class ListWithPageNavigation<T> {

	private List<T> list;
	private PageNavigation pageNavigation;

	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}

	public PageNavigation getPageNavigation() {
		return pageNavigation;
	}

	public void setPageNavigation(PageNavigation pageNavigation) {
		this.pageNavigation = pageNavigation;
	}
}