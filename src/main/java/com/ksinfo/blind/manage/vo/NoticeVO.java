package com.ksinfo.blind.manage.vo;

public final class NoticeVO {
    private final String noticeId;
    private final String noticeTitle;
    private final String noticeTypeCode;
    private final String noticeTypeName;
    private final String noticeBlindFlag;
    private final String userNickname;
    private final String noticeContents;

    private final String noticeWebsiteUrl;
    private final long   postFileId;
    private final String noticeCreateDate;
    private final String noticeUpdateDate;

    public NoticeVO(String noticeId, String noticeTitle, String noticeTypeCode, String noticeTypeName,
                    String noticeBlindFlag, String noticeContents, String userNickname, String noticeWebsiteUrl,
                    long postFileId, String noticeCreateDate, String noticeUpdateDate){
        this.noticeId = noticeId;

        this.noticeTitle = noticeTitle;
        this.noticeTypeCode = noticeTypeCode;
        this.noticeTypeName = noticeTypeName;
        this.noticeBlindFlag = noticeBlindFlag;
        this.userNickname = userNickname;
        this.noticeContents = noticeContents;

        this.noticeWebsiteUrl = noticeWebsiteUrl;
        this.postFileId = postFileId;
        this.noticeCreateDate = noticeCreateDate;
        this.noticeUpdateDate = noticeUpdateDate;
    }

    public String getNoticeId(){ return noticeId;}

    public String getNoticeTitle(){
        return noticeTitle;
    }
    public String getNoticeTypeCode(){ return noticeTypeCode; }
    public String getNoticeTypeName(){
        return noticeTypeName;
    }
    public String getNoticeBlindFlag(){
        return noticeBlindFlag;
    }
    public String getuserNickname(){
        return userNickname;
    }

    public String getNoticeContents(){
        return noticeContents;
    }
    public String getNoticeWebsiteUrl(){ return noticeWebsiteUrl; }
    public long getPostFileId() { return postFileId; }
    public String getNoticeCreateDate(){return noticeCreateDate;}
    public String getNoticeUpdateDate(){
        return noticeUpdateDate;
    }

}
