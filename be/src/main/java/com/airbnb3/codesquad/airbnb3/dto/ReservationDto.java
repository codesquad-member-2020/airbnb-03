package com.airbnb3.codesquad.airbnb3.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;

@Getter
@Setter
@ToString
@Builder
public class ReservationDto {
    private Date checkInDate;
    private Date checkOutDate;
    private Date bookingDate;
    private Integer nights;

    private Double serviceFee;
    private Double cleaningFee;
    private Double tax;

    private Double price;
    private Double pricePerStay;
    private Double totalPrice;
    private Integer guests;

    private Long propertiesId;
    private Long userId;
}
