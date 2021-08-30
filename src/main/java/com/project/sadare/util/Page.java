package com.project.sadare.util;

public class Page {

	private int currentPage, range, listCnt, maxPage, startPage, endPage;
	private boolean prev, next;

//	각 페이지에 표시할 제품의 개수 / 페이지 목록의 개수
	private int listSize = 10, rangeSize = 10, startList;

	public Page() {
	}

	public Page(int currentPage, int listCnt) {
		super();
		this.currentPage = currentPage;
		this.listCnt = listCnt;
	}

	public Page(int currentPage, int range, int listCnt, int maxPage, int startPage, int endPage, boolean prev,
			boolean next, int listSize, int rangeSize, int startList) {
		super();
		this.currentPage = currentPage;
		this.range = range;
		this.listCnt = listCnt;
		this.maxPage = maxPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.prev = prev;
		this.next = next;
		this.listSize = listSize;
		this.rangeSize = rangeSize;
		this.startList = startList;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getRange() {
		return range;
	}

	public void setRange(int range) {
		this.range = range;
	}

	public int getListCnt() {
		return listCnt;
	}

	public void setListCnt(int listCnt) {
		this.listCnt = listCnt;
	}

	public int getMaxPage() {
		return maxPage;
	}

	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getListSize() {
		return listSize;
	}

	public void setListSize(int listSize) {
		this.listSize = listSize;
	}

	public int getRangeSize() {
		return rangeSize;
	}

	public void setRangeSize(int rangeSize) {
		this.rangeSize = rangeSize;
	}

	public int getStartList() {
		return startList;
	}

	public void setStartList(int startList) {
		this.startList = startList;
	}

	@Override
	public String toString() {
		return "Page [currentPage=" + currentPage + ", range=" + range + ", listCnt=" + listCnt + ", maxPage=" + maxPage
				+ ", startPage=" + startPage + ", endPage=" + endPage + ", prev=" + prev + ", next=" + next
				+ ", listSize=" + listSize + ", rangeSize=" + rangeSize + ", startList=" + startList + "]";
	}

	public void pageInfo() {
		range = currentPage % listSize;
		maxPage = (listCnt % listSize) == 0 ? listCnt / listSize : listCnt / listSize + 1;
		startPage = currentPage / rangeSize * rangeSize + 1;
		if (currentPage % rangeSize == 0) {
			startPage -= 10;
		}
		endPage = startPage + rangeSize - 1;
		startList = (currentPage - 1) * listSize;
		prev = currentPage < 11 ? false : true;
		next = endPage > maxPage ? false : true;
		if (endPage > maxPage) {
			endPage = maxPage;
			next = false;
		}

//		// 전체 페이지수
//		this.pageCnt = (int) Math.ceil(listCnt / listSize);
//		// 시작 페이지
//		this.startPage = (range - 1) * rangeSize + 1;
//		// 끝 페이지
//		this.endPage = range * rangeSize;
//		// 게시판 시작번호
//		this.startList = (currentPage - 1) * listSize;
//		// 이전 버튼 상태
//		this.prev = range == 1 ? false : true;
//		// 다음 버튼 상태
//		this.next = endPage > pageCnt ? false : true;
//		if (this.endPage > this.pageCnt) {
//			this.endPage = this.pageCnt;
//			this.next = false;
//		}
	}

}
