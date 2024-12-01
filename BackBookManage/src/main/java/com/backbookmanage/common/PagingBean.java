package com.backbookmanage.common;

public class PagingBean {
	private int pageno; // 현재 페이지
    private int totalRecord; // 총 레코드 수
    private int pagePerRecordCnt; // 페이지 당 레코드 수
    private int groupPerPageCnt; // 페이지 당 보여줄 번호 수
    private int recordStartNo;
    private int recordEndNo;
    private int totalPage;
    private int groupNo;
    private int pageSno;
    private int pageEno;
    private int prevPageno;
    private int nextPageno;

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
