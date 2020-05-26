package com.airbnb3.codesquad.airbnb3.dao;

import com.airbnb3.codesquad.airbnb3.dto.PropertiesDetailDtoHamill;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoHamill;
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

        return jdbcTemplate.query(
                "SELECT p.id, p.title, p.state, p.city, p.latitude, p.longitude, p.reservable," +
                        "p.saved,p.host_type,p.price,p.place_type,p.review_average,p.number_of_reviews, GROUP_CONCAT(i.image_url) AS image " +
                        "FROM properties p LEFT JOIN images i ON p.id = i.properties_id LEFT JOIN detail d ON p.id = d.id " +
                        "WHERE p.price <= ? AND p.price >= ? AND d.accommodates >= ? GROUP BY p.id LIMIT ?",
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
                , priceMax, priceMin, accommodates, offset);
    }

    private List<String> imageParser(String images) {
        String[] image = images.split(",");
        return Arrays.asList(image);
    }

    public PropertiesDetailDtoHamill findByPropertiesId(int propertiesId) {

        return jdbcTemplate.queryForObject(
                "SELECT p.id, p.title,p.latitude, p.longitude, p.reservable,p.saved,p.host_type," +
                        " p.price,p.place_type,p.review_average,p.number_of_reviews," +
                        " GROUP_CONCAT(i.image_url) AS image, d.summary, d.space, d.city_overview, d.address," +
                        " d.notes, d.transit, d.host_name, d.host_since, d.host_location, d.host_about," +
                        " d.accommodates, d.bathrooms, d.bedrooms, d.beds, d.bed_type, d.amenities," +
                        " d.service_fee, d.cleaning_fee, d.tax, d.review_scores_accuracy," +
                        " d.review_scores_cleanliness, d.review_scores_checkin, d.review_scores_communication," +
                        " d.review_scores_location, d.review_scores_value FROM properties p" +
                        "    LEFT JOIN images i ON p.id = i.properties_id" +
                        "    LEFT JOIN detail d ON p.id = d.id" +
                        " WHERE p.id = ?" +
                        " GROUP BY p.id;",
                ((rs, rowNum) ->
                        PropertiesDetailDtoHamill.builder()
                                                 .id(rs.getLong("id"))
                                                 .title(rs.getString("title"))
                                                 .address(rs.getString("address"))
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
                                                 .summary(rs.getString("summary"))
                                                 .space(rs.getString("space"))
                                                 .cityOverview(rs.getString("city_overview"))
                                                 .notes(rs.getString("notes"))
                                                 .transit(rs.getString("transit"))
                                                 .hostName(rs.getString("host_name"))
                                                 .hostSince(rs.getString("host_since"))
                                                 .hostLocation(rs.getString("host_location"))
                                                 .hostAbout(rs.getString("host_about"))
                                                 .accommodates(rs.getInt("accommodates"))
                                                 .bathrooms(rs.getInt("bathrooms"))
                                                 .bedrooms(rs.getInt("bedrooms"))
                                                 .beds(rs.getInt("beds"))
                                                 .bedType(rs.getString("bed_type"))
                                                 .amenities(rs.getString("amenities"))
                                                 .serviceFee(rs.getDouble("service_fee"))
                                                 .cleaningFee(rs.getDouble("cleaning_fee"))
                                                 .tax(rs.getDouble("tax"))
                                                 .reviewScoresAccuracy(rs.getDouble("review_scores_accuracy"))
                                                 .reviewScoresCleanliness(rs.getDouble("review_scores_cleanliness"))
                                                 .reviewScoresCheckin(rs.getDouble("review_scores_checkin"))
                                                 .reviewScoresCommunication(rs.getDouble("review_scores_communication"))
                                                 .reviewScoresLocation(rs.getDouble("review_scores_location"))
                                                 .reviewScoresValue(rs.getDouble("review_scores_value"))
                                                 .build()
                )
                , propertiesId);
    }
}
