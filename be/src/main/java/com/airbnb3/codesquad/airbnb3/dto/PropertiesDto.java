package com.airbnb3.codesquad.airbnb3.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@Builder
public class PropertiesDto {
    private Long id;
    private String title;
    private String state;
    private String city;
    private Double latitude;
    private Double longitude;
    private Boolean reservable;
    private Boolean saved;
    private Boolean isSuperHost;
    private Double price;
    private String placeType;
    private Double reviewAverage;
    private Integer numberOfReviews;
    private List<String> images;
}
