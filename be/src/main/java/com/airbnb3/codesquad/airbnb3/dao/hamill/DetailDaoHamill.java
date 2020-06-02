package com.airbnb3.codesquad.airbnb3.dao.hamill;

import com.airbnb3.codesquad.airbnb3.dto.composition.*;
import com.airbnb3.codesquad.airbnb3.dto.hamill.DetailDtoHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Arrays;

@Repository
public class DetailDaoHamill {

    private final Logger logger = LoggerFactory.getLogger(DetailDaoHamill.class);

    private final JdbcTemplate jdbcTemplate;

    public DetailDaoHamill(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public DetailDtoHamill findByPropertiesId(Long propertyId) {

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
                                       .hostInfo(HostDto.builder()
                                                        .isSuperHost(rs.getBoolean("is_super_host"))
                                                        .notes(rs.getString("notes"))
                                                        .name(rs.getString("host_name"))
                                                        .since(rs.getString("host_since"))
                                                        .location(rs.getString("host_location"))
                                                        .about(rs.getString("host_about"))
                                                        .build())
                                       .locationInfo(LocationDto.builder()
                                                                .address(rs.getString("address"))
                                                                .description(rs.getString("city_overview"))
                                                                .transit(rs.getString("transit"))
                                                                .latitude(rs.getDouble("latitude"))
                                                                .longitude(rs.getDouble("longitude"))
                                                                .build())
                                       .priceInfo(PriceDto.builder()
                                                          .price(rs.getDouble("price"))
                                                          .serviceFee(rs.getDouble("service_fee"))
                                                          .cleaningFee(rs.getDouble("cleaning_fee"))
                                                          .tax(rs.getDouble("tax"))
                                                          .build())
                                       .reviewInfo(ReviewDto.builder()
                                                            .average(rs.getDouble("review_average"))
                                                            .numberOfReviews(rs.getInt("number_of_reviews"))
                                                            .scoresAccuracy(rs.getDouble("review_scores_accuracy"))
                                                            .scoresCheckin(rs.getDouble("review_scores_checkin"))
                                                            .scoresCleanliness(rs.getDouble("review_scores_cleanliness"))
                                                            .scoresCommunication(rs.getDouble("review_scores_communication"))
                                                            .scoresLocation(rs.getDouble("review_scores_location"))
                                                            .scoresValue(rs.getDouble("review_scores_value"))
                                                            .build())
                                       .roomInfo(RoomDto.builder()
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
                , propertyId);
    }
}
