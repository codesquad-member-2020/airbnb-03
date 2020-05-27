package com.airbnb3.codesquad.airbnb3.dto.composition;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
public class LocationDtoHamill {
    private String address;
    private String cityOverview;
    private String transit;
    private Double latitude;
    private Double longitude;
}
