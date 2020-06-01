package com.airbnb3.codesquad.airbnb3.dto.hamill;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
public class BookingPriceDtoHamill {

    private Double price;
    private Double serviceFee;
    private Double cleaningFee;
    private Double tax;
    private Double priceForStay;
    private Double totalPrice;
}
