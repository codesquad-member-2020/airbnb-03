package com.airbnb3.codesquad.airbnb3.dto.composition;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
public class PriceDtoHamill {
    private Double price;
    private Double serviceFee;
    private Double cleaningFee;
    private Double tax;
}
