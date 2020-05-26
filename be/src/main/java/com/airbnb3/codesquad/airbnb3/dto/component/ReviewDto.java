package com.airbnb3.codesquad.airbnb3.dto.component;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewDto {
    private Double reviewAverage;
    private Integer numberOfReviews;
    private String reviewScoresAccuracy;
    private String reviewScoresCleanliness;
    private String reviewScoresCheckin;
    private String reviewScoresCommunication;
    private String reviewScoresLocation;
    private String reviewScoresValue;

    @Builder
    public ReviewDto(Double reviewAverage, Integer numberOfReviews, String reviewScoresAccuracy, String reviewScoresCleanliness, String reviewScoresCheckin, String reviewScoresCommunication, String reviewScoresLocation, String reviewScoresValue) {
        this.reviewAverage = reviewAverage;
        this.numberOfReviews = numberOfReviews;
        this.reviewScoresAccuracy = reviewScoresAccuracy;
        this.reviewScoresCleanliness = reviewScoresCleanliness;
        this.reviewScoresCheckin = reviewScoresCheckin;
        this.reviewScoresCommunication = reviewScoresCommunication;
        this.reviewScoresLocation = reviewScoresLocation;
        this.reviewScoresValue = reviewScoresValue;
    }
}
