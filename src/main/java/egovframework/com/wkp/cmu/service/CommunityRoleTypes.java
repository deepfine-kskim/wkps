
package egovframework.com.wkp.cmu.service;

public enum CommunityRoleTypes {
	owner(0, "00", "운영자"),
	board(1, "01", "게시판관리"),
	member(2, "02", "회원관리");
	
	private final int index;
	
	private final String code;
	private final String name;
	
	private CommunityRoleTypes(int index, String code, String name){
		this.index = index;
	
		this.code = code;
		this.name = name;
	}
	
	public int getIndex() {
		return index;
	}

	public String getCode() {
		return code;
	}

	public String getName() {
		return name;
	}

	public static CommunityRoleTypes find(String code){
		if(code == null) return null;
		
		for(CommunityRoleTypes type : CommunityRoleTypes.values()){
			if(code.equals(type.code)){
				return type;
			}
		}
		
		return null;
	}
	

}
