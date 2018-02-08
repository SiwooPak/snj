package org.snj.domain;

//게시판 검색
public class SearchCriteria extends Criteria{

	private String searchType; //검색의 종류
	private String keyword; //검색 단어
	private String category; //검색하는 게시판의 종류
	
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + ", category=" + category + "]";
	}
}
