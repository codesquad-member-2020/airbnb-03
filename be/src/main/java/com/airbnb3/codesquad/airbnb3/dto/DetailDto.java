package com.airbnb3.codesquad.airbnb3.dto;

import com.airbnb3.codesquad.airbnb3.dto.composition.*;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@Builder
public class DetailDto {
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
}
