package com.airbnb3.codesquad.airbnb3.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.util.List;

@Getter
@Setter
@ToString
@Builder
public class PropertiesDetailDtoHamill {
    private Long id;
    private String title;
    private String address;
    private Double latitude;
    private Double longitude;
    private Boolean reservable;
    private Boolean saved;
    private String hostType;
    private Double price;
    private Double serviceFee;
    private Double cleaningFee;
    private Double tax;
    private String placeType;
    private Double reviewAverage;
    private Integer numberOfReviews;
    private List<String> images;
    private String summary;
    private String space;
    private String cityOverview;
    private String notes;
    private String transit;
    private String hostName;
    private String hostSince;
    private String hostLocation;
    private String hostAbout;
    private Integer accommodates;
    private Integer bathrooms;
    private Integer bedrooms;
    private Integer beds;
    private String bedType;
    private String amenities;
    private Double reviewScoresAccuracy;
    private Double reviewScoresCleanliness;
    private Double reviewScoresCheckin;
    private Double reviewScoresCommunication;
    private Double reviewScoresLocation;
    private Double reviewScoresValue;
}
