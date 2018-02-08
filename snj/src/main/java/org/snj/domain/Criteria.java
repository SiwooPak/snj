package org.snj.domain;

//페이징
public class Criteria {

	private int page;	// 페이지 번호
	private int perPageNum; // 페이지당 출력 갯수
	
	public Criteria(){
		this.page = 1;
		this.perPageNum = 12;
	}
	
	//페이지 번호가 0보다 작거나 같을시 1페이지로 기본.
	public void setPage(int page){
		
		if(page <= 0){
			this.page = 1;
			return;
		}
		
		this.page = page;
	}
	
	//페이지당 출력 갯수를 잘못 지정한 경우 강제로 10개씩.
	public void setPerPageNum(int perPageNum){
		
		if(perPageNum <= 0 || perPageNum > 100){
			this.perPageNum = 10;
			return;
		}
		
		this.perPageNum = perPageNum;
	}
	
	public int getPage() {
		return page;
	}	
	
	//method for MyBatis SQL Mapper - 
	public int getPageStart() {
		
		return (this.page -1)* perPageNum;
	}
	
	//method for MyBatis SQL Mapper 
	public int getPerPageNum(){
		
		return this.perPageNum;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + "]";
	}
}
