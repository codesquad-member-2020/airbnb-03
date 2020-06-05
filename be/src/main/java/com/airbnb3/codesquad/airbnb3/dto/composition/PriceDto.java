package com.airbnb3.codesquad.airbnb3.dto.composition;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
public class PriceDto {
    private Double price;
    private Double serviceFee;
    private Double cleaningFee;
    private Double tax;
}
