package com.airbnb3.codesquad.airbnb3.dto.component;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PriceDto {
    private Double price;
    private Double serviceFee;
    private Double cleaningFee;
    private Double tax;

    @Builder
    public PriceDto(Double price, Double serviceFee, Double cleaningFee, Double tax) {
        this.price = price;
        this.serviceFee = serviceFee;
        this.cleaningFee = cleaningFee;
        this.tax = tax;
    }
}
