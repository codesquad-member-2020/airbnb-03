package com.airbnb3.codesquad.airbnb3.dao;

import com.airbnb3.codesquad.airbnb3.dao.hamill.PropertiesDaoHamill;
import com.airbnb3.codesquad.airbnb3.dto.hamill.BookingsDtoHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@Repository
public class ReservationDao {

        private final Logger logger = LoggerFactory.getLogger(ReservationDao.class);

        private JdbcTemplate jdbcTemplate;

        public ReservationDao(JdbcTemplate jdbcTemplate) {
            this.jdbcTemplate = jdbcTemplate;
        }

    //    public List<BookingsDtoHamill> findAllReservations() {
//        String sql =
//                "SELECT b.id\n" +
//                        "     , b.properties_id\n" +
//                        "     , GROUP_CONCAT(i.image_url) AS image\n" +
//                        "     , p.place_type\n" +
//                        "     , p.number_of_reviews\n" +
//                        "     , p.review_average\n" +
//                        "     , b.check_in_date\n" +
//                        "     , b.check_out_date\n" +
//                        "     , b.guests\n" +
//                        "     , b.nights\n" +
//                        "     , p.price\n" +
//                        "     , b.service_fee\n" +
//                        "     , b.cleaning_fee\n" +
//                        "     , b.tax\n" +
//                        "     , b.price_for_stay\n" +
//                        "     , b.total_price\n" +
//                        "FROM bookings b\n" +
//                        "         JOIN properties p ON b.properties_id = p.id\n" +
//                        "         JOIN images i ON p.id = i.properties_id\n" +
//                        "GROUP BY b.id;";
//
//        return jdbcTemplate.query(
//                sql,
//                (rs, rowNum) ->
//                        BookingsDtoHamill.builder()
//                                         .id(rs.getLong("id"))
//                                         .propertiesId(rs.getLong("properties_id"))
//                                         .images(Arrays.asList(rs.getString("image").split(",")))
//                                         .placeType(rs.getString("place_type"))
//                                         .numberOfReviews(rs.getInt("number_of_reviews"))
//                                         .reviewAverage(rs.getDouble("review_average"))
//                                         .checkIn(rs.getDate("check_in_date"))
//                                         .checkOut(rs.getDate("check_out_date"))
//                                         .guests(rs.getInt("guests"))
//                                         .nights(rs.getInt("nights"))
//                                         .bookingPriceInfo(BookingPriceDto.builder()
//                                                                          .price(rs.getDouble("price"))
//                                                                          .serviceFee(rs.getDouble("service_fee"))
//                                                                          .cleaningFee(rs.getDouble("cleaning_fee"))
//                                                                          .tax(rs.getDouble("tax"))
//                                                                          .priceForStay(rs.getDouble("price_for_stay"))
//                                                                          .totalPrice(rs.getDouble("total_price"))
//                                                                          .build())
//                                         .build()
//        );
//    }
//
    public void insertReservationInformation(Long reservationsId, Date checkIn, Date checkOut,
                                             Integer guests, Integer nights, String name) {
        String sql =
                "INSERT INTO bookings(check_in_date, check_out_date, booking_date, guests, cleaning_fee, service_fee, tax, price,\n" +
                        "                     price_per_stay, total_price, nights, properties_id)\n" +
                        "SELECT ?,\n" +
                        "       ?,\n" +
                        "       ?,\n" +
                        "       ?,\n" +
                        "       d.cleaning_fee,\n" +
                        "       d.service_fee,\n" +
                        "       d.tax,\n" +
                        "       p.price,\n" +
                        "       (p.price + d.cleaning_fee + d.service_fee + d.tax),\n" +
                        "       (p.price * ? + d.cleaning_fee + d.service_fee + d.tax),\n" +
                        "       ?,\n" +
                        "       p.id\n" +
                        "FROM properties p\n" +
                        "         JOIN detail d ON p.id = d.id " +
                        "WHERE p.id = ?";

        jdbcTemplate.update(sql, checkIn, checkOut, Timestamp.valueOf(LocalDateTime.now()), guests, nights, nights, reservationsId);
    }
//
//    public void deleteReservationInformation(Long propertiesId) {
//
//        String sql = "DELETE FROM bookings WHERE id = ?";
//        jdbcTemplate.update(sql, propertiesId);
//    }
}
