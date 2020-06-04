package com.airbnb3.codesquad.airbnb3.dao;

import com.airbnb3.codesquad.airbnb3.dto.DetailDto;
import com.airbnb3.codesquad.airbnb3.dto.composition.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Arrays;

@Repository
public class DetailDao {

    private static final Logger logger = LoggerFactory.getLogger(DetailDao.class);

    private final NamedParameterJdbcTemplate jdbcTemplate;

    public DetailDao(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public DetailDto getDetailProperties(Long id) {
        String sql = "SELECT p.id,p.city,p.state,p.title,p.state,p.city,p.latitude,p.longitude,p.reservable,p.saved,CASE p.host_type WHEN 'super' THEN 1 ELSE 0 END AS is_super_host,p.price,p.place_type,p.review_average,p.number_of_reviews,GROUP_CONCAT(i.image_url) AS image," +
                "d.summary,d.space,d.city_overview,d.notes,d.transit,d.host_name,d.host_since,d.host_location,d.host_about,d.address,d.accommodates,d.bathrooms,d.bedrooms,d.beds,d.bed_type,REPLACE(d.amenities,'\"','') AS amenity,d.service_fee,d.cleaning_fee,d.tax,d.review_scores_accuracy,d.review_scores_cleanliness,d.review_scores_checkin,d.review_scores_communication,d.review_scores_location,d.review_scores_value " +
                "FROM properties p LEFT JOIN detail d ON p.id = d.id LEFT JOIN images i ON p.id = i.properties_id WHERE p.id = :id";

        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("id", id);
        return jdbcTemplate.queryForObject(sql, parameterSource, (rs, rowNum) ->
                DetailDto.builder()
                        .id(rs.getLong("id"))
                        .title(rs.getString("title"))
                        .reservable(rs.getBoolean("reservable"))
                        .saved(rs.getBoolean("saved"))
                        .images(Arrays.asList(rs.getString("image").split(",")))
                        .hostInfo(hostDtoBuilder(rs))
                        .locationInfo(locationDtoBuilder(rs))
                        .priceInfo(priceDtoBuilder(rs))
                        .reviewInfo(reviewDtoBuilder(rs))
                        .roomInfo(roomDtoBuilder(rs))
                        .build());
    }

    public PriceDto getPrices(Long id) {
        String sql = "SELECT d.cleaning_fee,d.service_fee,d.tax,p.price FROM detail d LEFT JOIN properties p ON d.id = p.id WHERE p.id = :id";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("id", id);
        return jdbcTemplate.queryForObject(sql, parameterSource, ((rs, rowNum) ->
                PriceDto.builder()
                        .cleaningFee(rs.getDouble("cleaning_fee"))
                        .price(rs.getDouble("price"))
                        .serviceFee(rs.getDouble("service_fee"))
                        .tax(rs.getDouble("tax"))
                        .build()));
    }

    private RoomDto roomDtoBuilder(ResultSet rs) throws SQLException {
        return RoomDto.builder()
                .accommodates(rs.getInt("accommodates"))
                .amenities(rs.getString("amenity"))
                .bathrooms(rs.getInt("bathrooms"))
                .bedrooms(rs.getInt("bedrooms"))
                .beds(rs.getInt("beds"))
                .bedType(rs.getString("bed_type"))
                .placeType(rs.getString("place_type"))
                .space(rs.getString("space"))
                .summary(rs.getString("summary"))
                .build();
    }

    private ReviewDto reviewDtoBuilder(ResultSet rs) throws SQLException {
        return ReviewDto.builder()
                .average(rs.getDouble("review_average"))
                .numberOfReviews(rs.getInt("number_of_reviews"))
                .scoresAccuracy(rs.getDouble("review_scores_accuracy"))
                .scoresCheckin(rs.getDouble("review_scores_checkin"))
                .scoresCleanliness(rs.getDouble("review_scores_cleanliness"))
                .scoresCommunication(rs.getDouble("review_scores_communication"))
                .scoresLocation(rs.getDouble("review_scores_location"))
                .scoresValue(rs.getDouble("review_scores_value"))
                .build();
    }

    private PriceDto priceDtoBuilder(ResultSet rs) throws SQLException {
        return PriceDto.builder()
                .cleaningFee(rs.getDouble("cleaning_fee"))
                .price(rs.getDouble("price"))
                .serviceFee(rs.getDouble("service_fee"))
                .tax(rs.getDouble("tax"))
                .build();
    }

    private LocationDto locationDtoBuilder(ResultSet rs) throws SQLException {
        return LocationDto.builder()
                .address(rs.getString("address"))
                .description(rs.getString("city_overview"))
                .latitude(rs.getDouble("latitude"))
                .longitude(rs.getDouble("longitude"))
                .transit(rs.getString("transit"))
                .build();
    }

    private HostDto hostDtoBuilder(ResultSet rs) throws SQLException {
        return HostDto.builder()
                .about(rs.getString("host_about"))
                .location(rs.getString("host_location"))
                .name(rs.getString("host_name"))
                .since(rs.getString("host_since"))
                .isSuperHost(rs.getBoolean("is_super_host"))
                .notes(rs.getString("notes"))
                .build();
    }
}
