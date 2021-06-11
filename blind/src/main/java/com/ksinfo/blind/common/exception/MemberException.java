package com.ksinfo.blind.common.exception;

public class MemberException extends RuntimeException {

    private static final long serialVersionUID = 1L;

    private String            message;

    public MemberException(String message) {
        super();
        this.message = message;
    }

    @Override
    public String getMessage() {
        return message;
    }
}
