package com.airbnb3.codesquad.airbnb3.common;

public class CommonStaticsProperties {

    // AirBnbService.Class

    // 기본 적으로 보여 지는 Item 의 갯수 (Offset 변수에 따라서 보여 지는 값이 변하게 하였다)
    public static final Integer DEFAULT_PAGE_NUM = 1;
    public static final Integer PAGE_VIEW_ITEM_COUNT = 20;

    // 좌표 기본값 세팅
    public static final String DEFAULT_MIN_LATITUDE = "47.50508834";
    public static final String DEFAULT_MAX_LATITUDE = "47.72741971";
    public static final String DEFAULT_MIN_LONGITUDE = "-122.4129798";
    public static final String DEFAULT_MAX_LONGITUDE = "-122.2604426";

    // 손님 기본값 세팅
    public static final Integer DEFAULT_GUESTS_NUM = 1;

    // 하루 기본값
    public static final Long DEFAULT_ONE_DAY = 24*60*60*1000L;
    //-----------------------------------------------------------------------------
}
