package com.airbnb3.codesquad.airbnb3.dto;

import lombok.*;

import java.util.List;

@Getter
@Setter
@ToString
public class PropertiesDtoAlex {

    private Long id;
    private String title;
    private String state;
    private String city;
    private Double latitude;
    private Double longitude;
    private Boolean reservable;
    private Boolean saved;
    private String hostType;
    private Double price;
    private String placeType;
    private Double reviewAverage;
    private Integer numberOfReviews;
    private List<String> images;

    @Builder
    private PropertiesDtoAlex(Long id, String title, String state, String city,
                             Double latitude, Double longitude, Boolean reservable, Boolean saved,
                             String hostType, Double price, String placeType, Double reviewAverage, Integer numberOfReviews, List<String> images) {
        this.id = id;
        this.title = title;
        this.state = state;
        this.city = city;
        this.latitude = latitude;
        this.longitude = longitude;
        this.reservable = reservable;
        this.saved = saved;
        this.hostType = hostType;
        this.price = price;
        this.placeType = placeType;
        this.reviewAverage = reviewAverage;
        this.numberOfReviews = numberOfReviews;
        this.images = images;
    }
}
