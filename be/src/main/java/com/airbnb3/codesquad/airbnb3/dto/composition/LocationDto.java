package com.airbnb3.codesquad.airbnb3.dto.composition;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LocationDto {
    private String address;
    private String cityOverView;
    private String transit;
    private Double latitude;
    private Double longitude;

    @Builder
    public LocationDto(String address, String cityOverView, String transit, Double latitude, Double longitude) {
        this.address = address;
        this.cityOverView = cityOverView;
        this.transit = transit;
        this.latitude = latitude;
        this.longitude = longitude;
    }
}
