package com.airbnb3.codesquad.airbnb3.dao;

import com.airbnb3.codesquad.airbnb3.dto.BookingsDtoHamill;
import com.airbnb3.codesquad.airbnb3.dto.DetailDtoHamill;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoHamill;
import com.airbnb3.codesquad.airbnb3.dto.composition.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

@Repository
public class PropertiesDaoHamill {

    private final Logger logger = LoggerFactory.getLogger(PropertiesDaoHamill.class);

    private final JdbcTemplate jdbcTemplate;

    public PropertiesDaoHamill(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<PropertiesDtoHamill> findAllProperties(
            Integer offset, Double priceMin, Double priceMax, Date checkIn, Date checkOut, Integer guests) {

        logger.debug("#### offset, priceMin, priceMax, checkIn, checkOut, accommodates: {}, {}, {}, {}, {}, {}",
                offset, priceMin, priceMax, checkIn, checkOut, guests);

        String sql =
                "SELECT p.id,\n" +
                        "       p.title,\n" +
                        "       p.state,\n" +
                        "       p.city,\n" +
                        "       p.latitude,\n" +
                        "       p.longitude,\n" +
                        "       p.reservable,\n" +
                        "       p.saved,\n" +
                        "       CASE p.host_type WHEN 'super' THEN 1 ELSE 0 END AS is_super_host,\n" +
                        "       p.price,\n" +
                        "       p.place_type,\n" +
                        "       p.review_average,\n" +
                        "       p.number_of_reviews,\n" +
                        "       GROUP_CONCAT(i.image_url) AS image\n" +
                        "FROM properties p\n" +
                        "         LEFT JOIN images i ON p.id = i.properties_id\n" +
                        "         LEFT JOIN detail d ON p.id = d.id\n" +
                        "         LEFT JOIN calendar c ON p.id = c.properties_id\n" +
                        "WHERE (p.price BETWEEN ? AND ?)\n" +
                        "  AND p.id NOT IN (SELECT DISTINCT properties_id FROM calendar WHERE reservation_date BETWEEN ? AND ?)\n" +
                        "  AND d.accommodates >= ?\n" +
                        "GROUP BY p.id\n" +
                        "LIMIT ?";

        return jdbcTemplate.query(
                sql,
                (rs, rowNum) ->
                        PropertiesDtoHamill.builder()
                                           .id(rs.getLong("id"))
                                           .title(rs.getString("title"))
                                           .state(rs.getString("state"))
                                           .city(rs.getString("city"))
                                           .latitude(rs.getDouble("latitude"))
                                           .longitude(rs.getDouble("longitude"))
                                           .reservable(rs.getBoolean("reservable"))
                                           .saved(rs.getBoolean("saved"))
                                           .isSuperHost(rs.getBoolean("is_super_host"))
                                           .price(rs.getDouble("price"))
                                           .placeType(rs.getString("place_type"))
                                           .reviewAverage(rs.getDouble("review_average"))
                                           .numberOfReviews(rs.getInt("number_of_reviews"))
                                           .images(Arrays.asList(rs.getString("image").split(",")))
                                           .build()
                , priceMin, priceMax, checkIn, checkOut, guests, offset);
    }

    public DetailDtoHamill findByPropertiesId(Long propertiesId) {

        String sql =
                "SELECT p.id,\n" +
                        "       p.city,\n" +
                        "       p.state,\n" +
                        "       p.title,\n" +
                        "       p.state,\n" +
                        "       p.city,\n" +
                        "       p.latitude,\n" +
                        "       p.longitude,\n" +
                        "       p.reservable,\n" +
                        "       p.saved,\n" +
                        "       CASE p.host_type WHEN 'super' THEN 1 ELSE 0 END AS is_super_host,\n" +
                        "       p.price,\n" +
                        "       p.place_type,\n" +
                        "       p.review_average,\n" +
                        "       p.number_of_reviews,\n" +
                        "       GROUP_CONCAT(i.image_url)                       AS image,\n" +
                        "       d.summary,\n" +
                        "       d.space,\n" +
                        "       d.city_overview,\n" +
                        "       d.notes,\n" +
                        "       d.transit,\n" +
                        "       d.host_name,\n" +
                        "       d.host_since,\n" +
                        "       d.host_location,\n" +
                        "       d.host_about,\n" +
                        "       d.address,\n" +
                        "       d.accommodates,\n" +
                        "       d.bathrooms,\n" +
                        "       d.bedrooms,\n" +
                        "       d.beds,\n" +
                        "       d.bed_type,\n" +
                        "       REPLACE(d.amenities, '\"', '')                  AS amenity,\n" +
                        "       d.service_fee,\n" +
                        "       d.cleaning_fee,\n" +
                        "       d.tax,\n" +
                        "       d.review_scores_accuracy,\n" +
                        "       d.review_scores_cleanliness,\n" +
                        "       d.review_scores_checkin,\n" +
                        "       d.review_scores_communication,\n" +
                        "       d.review_scores_location,\n" +
                        "       d.review_scores_value\n" +
                        "FROM properties p\n" +
                        "         LEFT JOIN detail d ON p.id = d.id\n" +
                        "         LEFT JOIN images i ON p.id = i.properties_id\n" +
                        "WHERE p.id = ?";

        return jdbcTemplate.queryForObject(
                sql,
                ((rs, rowNum) ->
                        DetailDtoHamill.builder()
                                       .id(rs.getLong("id"))
                                       .title(rs.getString("title"))
                                       .reservable(rs.getBoolean("reservable"))
                                       .saved(rs.getBoolean("saved"))
                                       .images(Arrays.asList(rs.getString("image").split(",")))
                                       .hostInfo(HostDtoHamill.builder()
                                                              .isSuperHost(rs.getBoolean("is_super_host"))
                                                              .notes(rs.getString("notes"))
                                                              .hostName(rs.getString("host_name"))
                                                              .hostSince(rs.getString("host_since"))
                                                              .hostLocation(rs.getString("host_location"))
                                                              .hostAbout(rs.getString("host_about"))
                                                              .build())
                                       .locationInfo(LocationDtoHamill.builder()
                                                                      .address(rs.getString("address"))
                                                                      .cityOverview(rs.getString("city_overview"))
                                                                      .transit(rs.getString("transit"))
                                                                      .latitude(rs.getDouble("latitude"))
                                                                      .longitude(rs.getDouble("longitude"))
                                                                      .build())
                                       .priceInfo(PriceDtoHamill.builder()
                                                                .price(rs.getDouble("price"))
                                                                .serviceFee(rs.getDouble("service_fee"))
                                                                .cleaningFee(rs.getDouble("cleaning_fee"))
                                                                .tax(rs.getDouble("tax"))
                                                                .build())
                                       .reviewInfo(ReviewDtoHamill.builder()
                                                                  .reviewAverage(rs.getDouble("review_average"))
                                                                  .numberOfReviews(rs.getInt("number_of_reviews"))
                                                                  .reviewScoresAccuracy(rs.getDouble("review_scores_accuracy"))
                                                                  .reviewScoresCheckin(rs.getDouble("review_scores_checkin"))
                                                                  .reviewScoresCleanliness(rs.getDouble("review_scores_cleanliness"))
                                                                  .reviewScoresCommunication(rs.getDouble("review_scores_communication"))
                                                                  .reviewScoresLocation(rs.getDouble("review_scores_location"))
                                                                  .reviewScoresValue(rs.getDouble("review_scores_value"))
                                                                  .build())
                                       .roomInfo(RoomDtoHamill.builder()
                                                              .accommodates(rs.getInt("accommodates"))
                                                              .amenities(rs.getString("amenity"))
                                                              .bathrooms(rs.getInt("bathrooms"))
                                                              .bedrooms(rs.getInt("bedrooms"))
                                                              .beds(rs.getInt("beds"))
                                                              .bedType(rs.getString("bed_type"))
                                                              .placeType(rs.getString("place_type"))
                                                              .space(rs.getString("space"))
                                                              .summary(rs.getString("summary"))
                                                              .build())
                                       .build()
                )
                , propertiesId);
    }

    public List<BookingsDtoHamill> findAllReservations() {
        String sql =
                "SELECT b.id\n" +
                        "     , b.properties_id\n" +
                        "     , GROUP_CONCAT(i.image_url) AS image\n" +
                        "     , p.place_type\n" +
                        "     , p.number_of_reviews\n" +
                        "     , p.review_average\n" +
                        "     , b.check_in_date\n" +
                        "     , b.check_out_date\n" +
                        "     , b.guests\n" +
                        "     , b.nights\n" +
                        "     , p.price\n" +
                        "     , b.service_fee\n" +
                        "     , b.cleaning_fee\n" +
                        "     , b.tax\n" +
                        "     , b.price_for_stay\n" +
                        "     , b.total_price\n" +
                        "FROM bookings b\n" +
                        "         JOIN properties p ON b.properties_id = p.id\n" +
                        "         JOIN images i ON p.id = i.properties_id\n" +
                        "GROUP BY b.id;";

        return jdbcTemplate.query(
                sql,
                (rs, rowNum) ->
                        BookingsDtoHamill.builder()
                                         .id(rs.getLong("id"))
                                         .propertiesId(rs.getLong("properties_id"))
                                         .images(Arrays.asList(rs.getString("image").split(",")))
                                         .placeType(rs.getString("place_type"))
                                         .numberOfReviews(rs.getInt("number_of_reviews"))
                                         .reviewAverage(rs.getDouble("review_average"))
                                         .checkIn(rs.getDate("check_in_date"))
                                         .checkOut(rs.getDate("check_out_date"))
                                         .guests(rs.getInt("guests"))
                                         .nights(rs.getInt("nights"))
                                         .bookingPriceInfo(BookingPriceDto.builder()
                                                                          .price(rs.getDouble("price"))
                                                                          .serviceFee(rs.getDouble("service_fee"))
                                                                          .cleaningFee(rs.getDouble("cleaning_fee"))
                                                                          .tax(rs.getDouble("tax"))
                                                                          .priceForStay(rs.getDouble("price_for_stay"))
                                                                          .totalPrice(rs.getDouble("total_price"))
                                                                          .build())
                                         .build()
        );
    }

    public void insertReservationInformation(Long reservationsId, Date checkIn, Date checkOut,
                                             Integer guests, Integer nights, String name) {
        String sql =
                "INSERT INTO bookings(check_in_date, check_out_date, booking_date, guests, cleaning_fee, service_fee, tax, price,\n" +
                        "                     price_for_stay, total_price, nights, properties_id)\n" +
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

    public void deleteReservationInformation(Long propertiesId) {

        String sql = "DELETE FROM bookings WHERE id = ?";
        jdbcTemplate.update(sql, propertiesId);
    }


}
