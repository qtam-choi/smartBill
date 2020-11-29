package com.smartbill.common.util;

import java.util.List;

public class Paging {
	private int prevLink;
	private int firstPage;
	private int lastPage;
	private int nextLink;
	private int totalPage;
	private int listNo;
	private int curPage;
	private int startNum;
	private int endNum;
	private int numPerPage;
	private int totalRecord;
	private List list;

	public Paging(int totalRecord, int curPage, int numPerPage,
			int pagePerBlock) {

		this.numPerPage = numPerPage;
		this.curPage = curPage;
		this.totalRecord = totalRecord;
		this.startNum = (curPage - 1) * numPerPage + 1;
		this.endNum = curPage * numPerPage;
		
		if (totalRecord % numPerPage == 0) {
			this.totalPage = totalRecord / numPerPage;
		} else {
			this.totalPage = totalRecord / numPerPage + 1;
		}
		int totalBlock = 1;
		if (totalPage % pagePerBlock == 0) {
			totalBlock = totalPage / pagePerBlock;
		} else {
			totalBlock = totalPage / pagePerBlock + 1;
		}
		int block = 1;
		if (curPage % pagePerBlock == 0) {
			block = curPage / pagePerBlock;
		} else {
			block = curPage / pagePerBlock + 1;
		}

		this.firstPage = (block - 1) * pagePerBlock + 1;
		this.lastPage = block * pagePerBlock;

		if (block >= totalBlock) {
			this.lastPage = totalPage;
		}

		if (block > 1) {
			this.prevLink = firstPage - 1;
		}else{
			this.prevLink = firstPage;
		}

		if (block < totalBlock) {
			this.nextLink = lastPage + 1;
		}else{
			this.nextLink = lastPage;
		}

		this.listNo = totalRecord - (curPage - 1) * numPerPage;
	}

	public int getPrevLink() {
		return prevLink;
	}

	public int getFirstPage() {
		return firstPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public int getNextLink() {
		return nextLink;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public int getListNo() {
		return listNo;
	}

	public List getList() {
		return list;
	}

	public void setList(List list) {
		this.list = list;
	}

	public int getStartNum() {
		return startNum;
	}

	public int getEndNum() {
		return endNum;
	}
	
	public int getNumPerPage() {
		return numPerPage;
	}
	
	public int getCurPage() {
		return curPage;
	}
	
	public int getTotalRecord() {
		return totalRecord;
	}


}
