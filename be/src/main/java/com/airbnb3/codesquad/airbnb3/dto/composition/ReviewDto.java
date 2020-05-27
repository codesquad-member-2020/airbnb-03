package com.airbnb3.codesquad.airbnb3.dto.composition;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReviewDto {
    private Double reviewAverage;
    private Integer numberOfReviews;
    private Double reviewScoresAccuracy;
    private Double reviewScoresCleanliness;
    private Double reviewScoresCheckin;
    private Double reviewScoresCommunication;
    private Double reviewScoresLocation;
    private Double reviewScoresValue;

    @Builder
    public ReviewDto(Double reviewAverage, Integer numberOfReviews, Double reviewScoresAccuracy, Double reviewScoresCleanliness, Double reviewScoresCheckin, Double reviewScoresCommunication, Double reviewScoresLocation, Double reviewScoresValue) {
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
