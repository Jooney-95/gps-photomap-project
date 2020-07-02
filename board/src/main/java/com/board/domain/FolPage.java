package com.board.domain;

public class FolPage {
	
	// �쁽�옱 �럹�씠吏� 踰덊샇
	private int num;
	
	// 寃뚯떆臾� 珥� 媛��닔
	private int count;
	
	// �븳 �럹�씠吏��뿉 異쒕젰�븷 寃뚯떆臾� 媛��닔
	private int postNum = 20;
	
	// �븯�떒 �럹�씠吏� 踰덊샇 ([ 寃뚯떆臾� 珥� 媛��닔 첨 �븳 �럹�씠吏��뿉 異쒕젰�븷 媛��닔 ]�쓽 �삱由�)
	private int pageNum;
	
	// 異쒕젰�븷 寃뚯떆臾�
	private int displayPost;
	
	// �븳踰덉뿉 �몴�떆�븷 �럹�씠吏� 踰덊샇�쓽 媛��닔
	private int pageNumCnt = 10;
	
	// �몴�떆�릺�뒗 �럹�씠吏� 踰덊샇 以� 留덉�留� 踰덊샇
	private int endPageNum;
	
	// �몴�떆�릺�뒗 �럹�씠吏� 踰덊샇 以� 泥ル쾲吏� 踰덊샇
	private int startPageNum;
	
	// �떎�쓬/�씠�쟾 �몴�떆 �뿬遺�
	private boolean prev;
	private boolean next;
	
	
	public void setNum(int num) {
		this.num = num;
	}
	
	public void setCount(int count) {
		this.count = count;
		
		dataCalc();
	}
	
	public int getCount() {
		return count;
	}
	
	public int getPostNum() {
		return postNum;
	}
	
	public int getPageNum() {
		return pageNum;
	}
	
	public int getDisplayPost() {
		return displayPost;
	}
	
	public int getPageNumCnt() {
		return pageNumCnt;
	}
	
	public int getEndPageNum() {
		return endPageNum;
	}
	
	public int getStartPageNum() {
		return startPageNum;
	}
	
	public boolean getPrev() {
		return prev;
	}	
	
	public boolean getNext() {
		return next;
	}
		
	private void dataCalc() {
		
		// 留덉�留� 踰덊샇
		endPageNum = (int)(Math.ceil((double)num / (double)pageNumCnt) * pageNumCnt);
		
		// �떆�옉 踰덊샇
		startPageNum = endPageNum - (pageNumCnt - 1);
		
		// 留덉�留� 踰덊샇 �옱怨꾩궛
		int endPageNum_tmp = (int)(Math.ceil((double)count / (double)pageNumCnt));
		
		if(endPageNum > endPageNum_tmp) {
			endPageNum = endPageNum_tmp;
		}
		
		prev = startPageNum == 1 ? false : true;
		next = endPageNum * pageNumCnt >= count ? false : true;
		
		displayPost = (num - 1) * postNum;
		
	}
}