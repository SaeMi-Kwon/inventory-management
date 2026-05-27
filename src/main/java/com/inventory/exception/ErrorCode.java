package com.inventory.exception;

public enum ErrorCode {

    DUPLICATE_EMPLOYEE_ID("이미 사용 중인 사번입니다."),
    DUPLICATE_EMAIL("이미 사용 중인 이메일입니다."),
    USER_NOT_FOUND("사용자를 찾을 수 없습니다."),
    LOGIN_FAIL("사번 또는 비밀번호가 일치하지 않습니다."),
    NOT_ACTIVE_USER("사용할 수 없는 계정입니다."),
    DUPLICATE_CUSTOMER_CODE("이미 사용 중인 거래처 코드입니다."),
    DUPLICATE_WAREHOUSE_CODE("이미 사용 중인 창고 코드입니다."),
    DUPLICATE_ITEM_CODE("이미 사용 중인 품목 코드입니다."),
    DUPLICATE_STOCK("이미 해당 창고에 등록된 품목입니다."),
    INVALID_INBOUND_DETAIL("입고 상세 정보가 올바르지 않습니다."),
    INVALID_INBOUND_QUANTITY("입고 수량은 0보다 커야 합니다."),
    INVALID_INBOUND_PRICE("입고 단가는 0 이상이어야 합니다."),
    INBOUND_SAVE_FAIL("입고 등록에 실패했습니다."),
    INBOUND_ID_NOT_GENERATED("입고 ID 생성에 실패했습니다."),
    INVALID_INBOUND_STATUS("입고 완료 처리할 수 없는 상태입니다."),
    INVALID_OUTBOUND_DETAIL("출고 상세 정보가 올바르지 않습니다."),
    INVALID_OUTBOUND_QUANTITY("출고 수량은 0보다 커야 합니다."),
    INVALID_OUTBOUND_PRICE("출고 단가는 0 이상이어야 합니다."),
    INVALID_OUTBOUND_STATUS("출고 완료 처리할 수 없는 상태입니다."),
    NOT_ENOUGH_STOCK("현재고가 부족합니다.");


    private final String message;

    ErrorCode(String message){
        this.message=message;
    }

    public String getMessage(){
        return message;
    }
}
