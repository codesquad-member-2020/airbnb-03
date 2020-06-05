package com.airbnb3.codesquad.airbnb3.dto.composition;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class LocationDto {
    private String address;
    private String description;
    private String transit;
    private Double latitude;
    private Double longitude;
}
