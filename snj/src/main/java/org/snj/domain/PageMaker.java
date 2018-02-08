package org.snj.domain;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

//화면하단 페이징 처리
public class PageMaker {

	private int totalCount; //게시판의 게시글 총갯수
	private int startPage; //시작페이지
	private int endPage; //끝 페이지
	private boolean prev; // 앞 페이지로
	private boolean next; // 뒷 페이지로
	
	private int displayPageNum = 10; //화면에 표시될 페이지번호
	
	private Criteria cri; //


	public void setCri(Criteria cri) {
		this.cri = cri;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		
		calcData();
	}

	private void calcData() {
		//마지막 페이지 = Math.ceil(현재페이지/페이지 번호의 수)*페이지 번호의 수
		//만약 현재 페이지가 1이고 화면에 보여질 페이지 번호의 수가 10이면 0.1의 올림의 10을 곱하면 10
		endPage = (int) (Math.ceil(cri.getPage() / (double)displayPageNum ) * displayPageNum);
		
		//시작페이지 = (마지막 페이지 - 페이지번호의 수) + 1
		//ex)마지막 페이지가 10이고, 페이지번호의 수가 10이면 시작페이지는 1
		startPage = (endPage - displayPageNum) + 1;
		
		//마지막 페이지는 실제 데이터 갯수와 관련이 있어 재계산
		int tempEndPage = (int)(Math.ceil(totalCount / (double)cri.getPerPageNum()));
		
		if(endPage > tempEndPage){
			endPage = tempEndPage;
		}
		
		//앞페이지로 이동(삼항연산자)
		// 현재페이지가 1이면  false, 아니면 true
		prev = startPage ==1 ? false : true;
		
		//다음페이지로 이동
		//마지막 페이지와 페이지의번호수를 곱한 값이 총갯수보다 작으면 이동
		next = endPage * cri.getPerPageNum() >= totalCount ? false : true;
		
	}

	public int getTotalCount() {
		return totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public boolean isNext() {
		return next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}
	
	public String makeQuery(int page){
		
		UriComponents uriComponents =
	            UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("perPageNum", cri.getPerPageNum())
	            .queryParam("category", ((SearchCriteria)cri).getCategory())
	            .build();	            
		
		return uriComponents.toUriString();
	}

	public String makeSearch(int page){
		
		UriComponents uriComponents =
	            UriComponentsBuilder.newInstance()
	            .queryParam("page", page)
	            .queryParam("perPageNum", cri.getPerPageNum())
	            .queryParam("searchType", ((SearchCriteria)cri).getSearchType())
	            .queryParam("keyword", ((SearchCriteria)cri).getKeyword())
	            .queryParam("category", ((SearchCriteria)cri).getCategory())
	            .build();	            
		
		return uriComponents.toUriString();
	}	
	
	@Override
	public String toString() {
		return "PageMaker [totalCount=" + totalCount + ", startPage="
				+ startPage + ", endPage=" + endPage + ", prev=" + prev
				+ ", next=" + next + ", displayPageNum=" + displayPageNum
				+ ", cri=" + cri + "]";
	}
	
	
}
