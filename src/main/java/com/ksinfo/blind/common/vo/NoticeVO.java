package com.ksinfo.blind.common.vo;


public final class NoticeVO {
    private final String noticeTitle;
    private final String noticeTypeName;
    private final String userNickname;
    private final String noticeContents;

    private final String noticeWebsiteUrl;
    private final long   postFileId;
    private final String noticeCreateDate;
    private final String noticeUpdateDate;

    public NoticeVO(String noticeTitle, String noticeTypeName,
                    String noticeContents, String userNickname, String noticeWebsiteUrl,
                    long postFileId, String noticeCreateDate, String noticeUpdateDate){
        this.noticeTitle = noticeTitle;
        this.noticeTypeName = noticeTypeName;
        this.userNickname = userNickname;
        this.noticeContents = noticeContents;

        this.noticeWebsiteUrl = noticeWebsiteUrl;
        this.postFileId = postFileId;
        this.noticeCreateDate = noticeCreateDate;
        this.noticeUpdateDate = noticeUpdateDate;
    }

    public String getNoticeTitle(){ return noticeTitle;}
    public String getNoticeTypeName(){return noticeTypeName;}
    public String getuserNickname(){return userNickname;}
    public String getNoticeContents(){return noticeContents;}

    public String getNoticeWebsiteUrl(){ return noticeWebsiteUrl; }
    public long getPostFileId() { return postFileId; }
    public String getNoticeCreateDate(){return noticeCreateDate;}
    public String getNoticeUpdateDate(){return noticeUpdateDate;}

}
