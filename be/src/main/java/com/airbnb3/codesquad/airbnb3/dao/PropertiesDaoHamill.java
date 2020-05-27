package com.airbnb3.codesquad.airbnb3.dao;

import com.airbnb3.codesquad.airbnb3.dto.DetailDtoHamill;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoHamill;
import com.airbnb3.codesquad.airbnb3.dto.composition.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Date;
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
            Integer offset, Double priceMin, Double priceMax, Date checkIn, Date checkOut, Integer accommodates) {
        logger.info("#### offset: {}", offset);
        logger.info("#### priceMin: {}", priceMin);
        logger.info("#### priceMax: {}", priceMax);
        logger.info("#### checkIn: {}", checkIn);
        logger.info("#### checkOut: {}", checkOut);
        logger.info("#### accommodates: {}", accommodates);
        String sql =
                "SELECT p.id,\n" +
                        "       p.title,\n" +
                        "       p.state,\n" +
                        "       p.city,\n" +
                        "       p.latitude,\n" +
                        "       p.longitude,\n" +
                        "       p.reservable,\n" +
                        "       p.saved,\n" +
                        "       p.host_type,\n" +
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
                                           .hostType(rs.getString("host_type"))
                                           .price(rs.getDouble("price"))
                                           .placeType(rs.getString("place_type"))
                                           .reviewAverage(rs.getDouble("review_average"))
                                           .numberOfReviews(rs.getInt("number_of_reviews"))
                                           .images(imageParser(rs.getString("image")))
                                           .build()
                , priceMin, priceMax, checkIn, checkOut, accommodates, offset);
    }

    public DetailDtoHamill findByPropertiesId(int propertiesId) {

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
                                       .images(imageParser(rs.getString("image")))
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

    private List<String> imageParser(String images) {
        String[] image = images.split(",");
        return Arrays.asList(image);
    }
}
