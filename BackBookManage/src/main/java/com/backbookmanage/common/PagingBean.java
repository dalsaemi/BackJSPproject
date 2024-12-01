package com.backbookmanage.common;

public class PagingBean {
	private int pageno; // 현재 페이지
    private int totalRecord; // 총 레코드 수
    private int pagePerRecordCnt; // 페이지 당 레코드 수
    private int groupPerPageCnt; // 페이지 당 보여줄 번호 수
    private int recordStartNo; // 현재 페이지에서 시작하는 레코드
    private int recordEndNo; // 현재 페이지에서 끝나는 레코드
    private int totalPage; // 맨 끝 페이지
    private int groupNo; // 그룹 개수 groupPerPageCnt 개수가 그룹 1개
    private int pageSno; // 페이지에서 시작하는 번호 1(이거), 2, 3, 4, 5
    private int pageEno; // 페이지에서 끝나는 번호 1, 2, 3, 4, 5(이거)
    private int prevPageno; // 이전 페이지 6~10 -> 1~5
    private int nextPageno; // 다음 페이지 1~5 -> 6~10

    public PagingBean(int pageno, int totalRecord, int pagePerRecordCnt, int groupPerPageCnt) {
        this.pageno = pageno;
        this.totalRecord = totalRecord;
        this.pagePerRecordCnt = pagePerRecordCnt;
        this.groupPerPageCnt = groupPerPageCnt;
        if (pageno < 1) {
            pageno = 1;
        }

        calculatePagination();
    }

    private void calculatePagination() {
        recordEndNo = pageno * pagePerRecordCnt;
        recordStartNo = recordEndNo - (pagePerRecordCnt - 1);
        if (recordEndNo > totalRecord) {
            recordEndNo = totalRecord;
        }

        totalPage = totalRecord / pagePerRecordCnt + (totalRecord % pagePerRecordCnt > 0 ? 1 : 0);
        if (pageno > totalPage) {
            pageno = totalPage;
        }

        groupNo = pageno / groupPerPageCnt + (pageno % groupPerPageCnt > 0 ? 1 : 0);
        pageEno = groupNo * groupPerPageCnt;
        pageSno = pageEno - (groupPerPageCnt - 1);

        if (pageEno > totalPage) {
            pageEno = totalPage;
        }

        prevPageno = pageSno - groupPerPageCnt;
        if (prevPageno < 1) {
            prevPageno = 1;
        }

        nextPageno = pageSno + groupPerPageCnt;
        if (nextPageno > totalPage) {
            nextPageno = totalPage / groupPerPageCnt * groupPerPageCnt + 1;
        }
    }

    // Getters for JSP
    public int getPageno() {
        return pageno;
    }

    public int getTotalRecord() {
        return totalRecord;
    }

    public int getPagePerRecordCnt() {
        return pagePerRecordCnt;
    }

    public int getGroupPerPageCnt() {
        return groupPerPageCnt;
    }

    public int getRecordStartNo() {
        return recordStartNo;
    }

    public int getRecordEndNo() {
        return recordEndNo;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public int getGroupNo() {
        return groupNo;
    }

    public int getPageSno() {
        return pageSno;
    }

    public int getPageEno() {
        return pageEno;
    }

    public int getPrevPageno() {
        return prevPageno;
    }

    public int getNextPageno() {
        return nextPageno;
    }
}
