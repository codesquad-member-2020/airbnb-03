package com.airbnb3.codesquad.airbnb3.dao.alex;

import com.airbnb3.codesquad.airbnb3.dto.ReservationDto;
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

//        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
//        parameterSource.addValues(new ObjectMapper().convertValue(reservationDto,Map.class));

        MapSqlParameterSource parameterSource = new MapSqlParameterSource()
                .addValue("bookingDate", reservationDto.getBookingDate())
                .addValue("checkInDate", reservationDto.getCheckInDate())
                .addValue("checkOutDate", reservationDto.getCheckOutDate())
                .addValue("nights", reservationDto.getNights())
                .addValue("cleaningFee", reservationDto.getCleaningFee())
                .addValue("serviceFee", reservationDto.getServiceFee())
                .addValue("tax", reservationDto.getTax())
                .addValue("roomPrice", reservationDto.getPrice())
                .addValue("roomTotalPrice", reservationDto.getTotalPrice())
                .addValue("guests", reservationDto.getGuests())
                .addValue("totalPrice", reservationDto.getTotalPrice())
                .addValue("propertiesId", reservationDto.getPropertiesId())
                .addValue("userId", reservationDto.getUserId());

        jdbcTemplate.update(sql, parameterSource);
        return reservationDto;

    }

    public Date reservationCalender(Long id, Date reservationDate) {
        String sql = "INSERT INTO calender(properties_id,reservation_date) VALUES(:id,:reservationDate)";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("reservationDate", reservationDate);
        jdbcTemplate.update(sql, parameterSource);
        return reservationDate;
    }

    public String[] deleteReservation(Long reservationId) {
        String sql_date = "SELECT CONCAT_WS(',',check_in_date,check_out_date) AS reservation_date FROM bookings WHERE id = :reservationId";
        String sql = "DELETE FROM bookings WHERE id = :reservationId";

        MapSqlParameterSource parameterSource = new MapSqlParameterSource().addValue("reservationId", reservationId);
        String[] result = jdbcTemplate.queryForObject(sql_date, parameterSource, (rs, rowNum) -> rs.getString("reservation_date").split(","));
        jdbcTemplate.update(sql, parameterSource);
        return result;
    }

    public void deleteCalender(Long propertiesId, Date checkInDate, Date checkOutDate) {
        String sql = "DELETE FROM calender WHERE reservation_date BETWEEN :checkInDate AND :checkOutDate AND properties_id = :propertiesId";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource()
                .addValue("propertiesId", propertiesId)
                .addValue("checkInDate", checkInDate)
                .addValue("checkOutDate", checkOutDate);
        jdbcTemplate.update(sql, parameterSource);
    }

    public boolean checkReservation(Map<String, Date> reservationDates) {
        Date checkInDate = reservationDates.get("checkInDate");
        Date checkOutDate = reservationDates.get("checkOutDate");
        String sql = "SELECT EXISTS(SELECT * FROM calender WHERE reservation_date BETWEEN :checkInDate AND :checkOutDate) as reservationed;";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource()
                .addValue("checkInDate", checkInDate)
                .addValue("checkOutDate", checkOutDate);
        return jdbcTemplate.queryForObject(sql, parameterSource, (rs, rowNum) -> rs.getBoolean("reservationed"));

    }
}
