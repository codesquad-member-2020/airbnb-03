package com.airbnb3.codesquad.airbnb3.dao;

import com.airbnb3.codesquad.airbnb3.dto.ReservationDto;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.util.Map;

@Repository
public class ReservationDaoAlex {

    private static final Logger logger = LoggerFactory.getLogger(ReservationDaoAlex.class);

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    public ReservationDto reservationProperties(ReservationDto reservationDto) {
        String sql = "INSERT INTO bookings (check_in_date, check_out_date, booking_date, cleaning_fee, service_fee, tax, room_price, room_total_price, total_price, nights, properties_id, user_id) " +
                "VALUES ( :checkInDate, :checkOutDate, :bookingDate, :cleaningFee, :serviceFee, :tax, :roomPrice, :roomTotalPrice, :totalPrice, :nights, :propertiesId, :userId)";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource()
                .addValue("bookingDate", reservationDto.getBookingDate())
                .addValue("checkInDate", reservationDto.getCheckInDate())
                .addValue("checkOutDate", reservationDto.getCheckOutDate())
                .addValue("nights", reservationDto.getNights())
                .addValue("cleaningFee", reservationDto.getCleaningFee())
                .addValue("serviceFee", reservationDto.getServiceFee())
                .addValue("tax", reservationDto.getTax())
                .addValue("roomPrice", reservationDto.getRoomPrice())
                .addValue("roomTotalPrice", reservationDto.getRoomTotalPrice())
                .addValue("guests", reservationDto.getGuests())
                .addValue("totalPrice", reservationDto.getTotalPrice())
                .addValue("propertiesId", reservationDto.getPropertiesId())
                .addValue("userId", reservationDto.getUserId());

        jdbcTemplate.update(sql, parameterSource);
        return reservationDto;
//      parameter 설정하는 새로운 방법!!!(질문 남기고 잊지 않기 위해서 주석 처리!!)
//      MapSqlParameterSource parameterSource = new MapSqlParameterSource();
//      parameterSource.addValues(new ObjectMapper().convertValue(reservationDto,Map.class));
    }

    public Date reservationCalender(Long id, Date reservationDate) {
        String sql = "INSERT INTO calender(properties_id,reservation_date) VALUES(:id,:reservationDate)";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("reservationDate", reservationDate);
        jdbcTemplate.update(sql, parameterSource);
        return reservationDate;
    }
}
