package com.airbnb3.codesquad.airbnb3.dto.hamill;

import com.airbnb3.codesquad.airbnb3.dto.composition.*;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
@Builder
public class DetailDtoHamill {
    private Long id;
    private String title;
    private Boolean reservable;
    private Boolean saved;
    private List<String> images;
    // Composition (비슷한 변수들 별도의 객체로 분류)
    private HostDtoHamill hostInfo;
    private LocationDtoHamill locationInfo;
    private PriceDtoHamill priceInfo;
    private ReviewDtoHamill reviewInfo;
    private RoomDtoHamill roomInfo;
}
