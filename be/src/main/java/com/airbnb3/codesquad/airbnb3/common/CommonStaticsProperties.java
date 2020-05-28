package com.airbnb3.codesquad.airbnb3.common;

public class CommonStaticsProperties {

    // AirBnbService.Class

    // 기본 적으로 보여 지는 Item 의 갯수 (Offset 변수에 따라서 보여 지는 값이 변하게 하였다)
    public static final Integer DEFAULT_PAGE_NUM = 1;
    public static final Integer PAGE_VIEW_ITEM_COUNT = 20;

    // 필터링 기능 에서 가격 정보를 필터링 할 때, 옳지 않은 값이 들어 오는 경우 Default 값을 설정 하였다
    public static final Double DEFAULT_MIN_PRICE = 0D;
    public static final Double DEFAULT_MAX_PRICE = 100000000D;

    // 좌표 기본값 세팅
    public static final Double DEFAULT_MIN_LATITUDE = 47.50508834;
    public static final Double DEFAULT_MAX_LATITUDE = 47.72741971;
    public static final Double DEFAULT_MIN_LONGITUDE = -122.4129798;
    public static final Double DEFAULT_MAX_LONGITUDE = -122.2604426;

    // 손님 기본값 세팅
    public static final Integer DEFAULT_GUESTS_NUM = 1;
    //-----------------------------------------------------------------------------
}
