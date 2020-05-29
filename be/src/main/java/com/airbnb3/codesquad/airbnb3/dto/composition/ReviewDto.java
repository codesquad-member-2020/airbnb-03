package com.airbnb3.codesquad.airbnb3.dto.composition;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class ReviewDto {
    private Double average;
    private Integer numberOfReviews;
    private Double scoresAccuracy;
    private Double scoresCleanliness;
    private Double scoresCheckin;
    private Double scoresCommunication;
    private Double scoresLocation;
    private Double scoresValue;
}
