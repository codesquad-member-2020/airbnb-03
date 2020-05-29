package com.airbnb3.codesquad.airbnb3.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.sql.Date;

@Getter
@Setter
@ToString
public class ReservationDto {
    private Date checkInDate;
    private Date checkOutDate;
    private Date bookingDate;
    private Integer nights;

    private Double serviceFee;
    private Double cleaningFee;
    private Double tax;

    private Double roomPrice;
    private Double roomTotalPrice;
    private Double totalPrice;
    private Integer guests;

    private Long propertiesId;
    private Long userId;

    @Builder
    private ReservationDto(Date checkInDate, Date checkOutDate, Date bookingDate, Integer nights, Double serviceFee, Double cleaningFee, Double tax, Double roomPrice, Double roomTotalPrice, Double totalPrice, Integer guests, Long propertiesId, Long userId) {
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.bookingDate = bookingDate;
        this.nights = nights;
        this.serviceFee = serviceFee;
        this.cleaningFee = cleaningFee;
        this.tax = tax;
        this.roomPrice = roomPrice;
        this.roomTotalPrice = roomTotalPrice;
        this.totalPrice = totalPrice;
        this.guests = guests;
        this.propertiesId = propertiesId;
        this.userId = userId;
    }
}
