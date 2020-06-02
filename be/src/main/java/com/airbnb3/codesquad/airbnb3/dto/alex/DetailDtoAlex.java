package com.airbnb3.codesquad.airbnb3.dto.alex;

import com.airbnb3.codesquad.airbnb3.dto.composition.*;
import lombok.*;

import java.util.List;

@Getter
@Setter
@ToString
public class DetailDtoAlex {
    private Long id;
    private String title;
    private Boolean reservable;
    private Boolean saved;
    private List<String> images;
    // Composition (비슷한 변수들 별도의 객체로 분류)
    private HostDto hostInfo;
    private LocationDto locationInfo;
    private PriceDto priceInfo;
    private ReviewDto reviewInfo;
    private RoomDto roomInfo;

    @Builder
    private DetailDtoAlex(Long id, String title, Boolean reservable, Boolean saved, List<String> images,
                         HostDto hostInfo, LocationDto locationInfo, PriceDto priceInfo, ReviewDto reviewInfo, RoomDto roomInfo) {
        this.id = id;
        this.title = title;
        this.reservable = reservable;
        this.saved = saved;
        this.images = images;
        this.hostInfo = hostInfo;
        this.locationInfo = locationInfo;
        this.priceInfo = priceInfo;
        this.reviewInfo = reviewInfo;
        this.roomInfo = roomInfo;
    }
}
