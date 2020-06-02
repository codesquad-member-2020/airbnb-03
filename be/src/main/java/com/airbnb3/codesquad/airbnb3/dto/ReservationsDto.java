package com.airbnb3.codesquad.airbnb3.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.math.BigDecimal;
import java.sql.Date;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.List;

@Getter
@Setter
@ToString
@Builder
public class ReservationsDto {
    private String images;
    private Date checkInDate;
    private Date checkOutDate;
    private Date bookingDate;
    private Integer nights;

    private BigDecimal serviceFee;
    private BigDecimal cleaningFee;
    private BigDecimal tax;

    private BigDecimal price;
    private BigDecimal priceForStay;
    private BigDecimal totalPrice;
    private Integer numberOfReviews;
    private Double reviewAverage;
    private Integer guests;

    private Long propertiesId;
    private Long userId;
}
