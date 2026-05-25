package com.inventory.exception;

public enum ErrorCode {

    DUPLICATE_EMPLOYEE_ID("이미 사용 중인 사번입니다."),
    DUPLICATE_EMAIL("이미 사용 중인 이메일입니다."),
    USER_NOT_FOUND("사용자를 찾을 수 없습니다."),
    LOGIN_FAILED("아이디 또는 비밀번호가 일치하지 않습니다."),
    DUPLICATE_CUSTOMER_CODE("이미 사용 중인 거래처 코드입니다."),
    DUPLICATE_WAREHOUSE_CODE("이미 사용 중인 창고 코드입니다."),
    DUPLICATE_ITEM_CODE("이미 사용 중인 품목 코드입니다."),
    DUPLICATE_STOCK("이미 해당 창고에 등록된 품목입니다.");


    private final String message;

    ErrorCode(String message){
        this.message=message;
    }

    public String getMessage(){
        return message;
    }
}
