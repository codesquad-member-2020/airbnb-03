package com.airbnb3.codesquad.airbnb3.dto.composition;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
public class ReviewDtoHamill {
    private Double reviewAverage;
    private Integer numberOfReviews;
    private Double reviewScoresAccuracy;
    private Double reviewScoresCleanliness;
    private Double reviewScoresCheckin;
    private Double reviewScoresCommunication;
    private Double reviewScoresLocation;
    private Double reviewScoresValue;
}
