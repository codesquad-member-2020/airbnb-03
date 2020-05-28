package com.airbnb3.codesquad.airbnb3.dto;

import com.airbnb3.codesquad.airbnb3.dto.composition.*;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;
import java.util.List;

@Getter
@Setter
@ToString
@Builder
public class BookingsDtoHamill {
    private Long id;
    private Long propertiesId;
    private List<String> images;
    private String placeType;
    private Integer numberOfReviews;
    private Double reviewAverage;
    private Date checkIn;
    private Date checkOut;
    private Integer guests;
    private Integer nights;
    private BookingPriceDto bookingPriceInfo;

}
