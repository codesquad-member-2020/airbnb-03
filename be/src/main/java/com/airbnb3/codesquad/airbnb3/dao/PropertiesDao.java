package com.airbnb3.codesquad.airbnb3.dao;

import com.airbnb3.codesquad.airbnb3.dto.PropertiesDto;
import com.airbnb3.codesquad.airbnb3.dto.alex.PropertiesDtoAlex;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.sql.Date;
import java.util.Arrays;
import java.util.List;

@Repository
public class PropertiesDao {

    private static final Logger logger = LoggerFactory.getLogger(PropertiesDao.class);

    private final NamedParameterJdbcTemplate jdbcTemplate;

    public PropertiesDao(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public List<PropertiesDto> getStayedProperties(Integer propertyRange, Integer accommodates, Date checkInDate, Date checkOutDate,
                                                   Long userId, BigDecimal minPrice, BigDecimal maxPrice,
                                                   BigDecimal minLatitude, BigDecimal maxLatitude, BigDecimal minLongitude, BigDecimal maxLongitude) {

        String sql = "SELECT p.id,p.title,p.state,p.city,p.latitude,p.longitude,p.reservable,CASE WHEN p.id IN (SELECT bookmarks.properties_id FROM bookmarks WHERE bookmarks.user_id = :userId) THEN 1 ELSE 0 END AS is_saved," +
                "CASE p.host_type WHEN 'super' THEN 1 ELSE 0 END AS is_super_host,p.price,p.place_type,p.review_average,p.number_of_reviews, GROUP_CONCAT(DISTINCT i.image_url) AS image " +
                "FROM properties p LEFT JOIN images i ON p.id = i.properties_id " +
                "LEFT JOIN detail t ON t.id = p.id LEFT JOIN calendar c ON c.properties_id = p.id LEFT JOIN bookings b on p.id = b.properties_id LEFT JOIN user u on b.user_id = u.id " +
                "WHERE t.accommodates >= :accommodates " +
                "AND p.id NOT IN (SELECT DISTINCT properties.id FROM properties LEFT JOIN calendar ON properties.id = calendar.properties_id " +
                "WHERE calendar.reservation_date BETWEEN :checkInDate AND :checkOutDate) " +
                "AND p.latitude BETWEEN :minLatitude AND :maxLatitude " +
                "AND p.longitude BETWEEN :minLongitude AND :maxLongitude " +
                "AND p.price BETWEEN :minPrice AND :maxPrice " +
                "GROUP BY p.id LIMIT :propertyRange";

        MapSqlParameterSource parameterSource = new MapSqlParameterSource()
                .addValue("propertyRange", propertyRange)
                .addValue("accommodates", accommodates)
                .addValue("checkInDate", checkInDate)
                .addValue("checkOutDate", checkOutDate)
                .addValue("userId", userId)
                .addValue("minPrice", minPrice)
                .addValue("maxPrice", maxPrice)
                .addValue("minLatitude", minLatitude)
                .addValue("maxLatitude", maxLatitude)
                .addValue("minLongitude", minLongitude)
                .addValue("maxLongitude", maxLongitude);

        return jdbcTemplate.query(sql, parameterSource, (rs, rowNum) -> PropertiesDto.builder()
                .id(rs.getLong("id"))
                .title(rs.getString("title"))
                .state(rs.getString("state"))
                .city(rs.getString("city"))
                .latitude(rs.getDouble("latitude"))
                .longitude(rs.getDouble("longitude"))
                .reservable(rs.getBoolean("reservable"))
                .saved(rs.getBoolean("is_saved"))
                .isSuperHost(rs.getBoolean("is_super_host"))
                .price(rs.getDouble("price"))
                .placeType(rs.getString("place_type"))
                .reviewAverage(rs.getDouble("review_average"))
                .numberOfReviews(rs.getInt("number_of_reviews"))
                .images(Arrays.asList(rs.getString("image").split(",")))
                .build());
    }

    public void saveProperties(Long id, Long userId) {
        String sql = "INSERT INTO bookmarks(user_id, properties_id) VALUES (:userId, :id)";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("userId", userId);
        jdbcTemplate.update(sql, parameterSource);
    }

    public void unSaveProperties(Long id, Long userId) {
        String sql = "DELETE FROM bookmarks WHERE user_id = :userId AND properties_id = :id";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource()
                .addValue("id", id)
                .addValue("userId", userId);
        jdbcTemplate.update(sql, parameterSource);
    }

    public List<PropertiesDto> savedPropertiesList(Long userId) {
        String sql = "SELECT p.id,p.title,p.state,p.city,p.latitude,p.longitude,p.reservable," +
                "CASE p.host_type WHEN 'super' THEN 1 ELSE 0 END AS is_super_host,p.price,p.place_type,p.review_average,p.number_of_reviews," +
                "CASE WHEN p.id IN (SELECT bookmarks.properties_id FROM bookmarks WHERE bookmarks.user_id = :userId) THEN 1 ELSE 0 END AS is_saved," +
                "GROUP_CONCAT(DISTINCT i.image_url) AS image " +
                "FROM properties p LEFT JOIN bookmarks bm ON p.id = bm.properties_id LEFT JOIN images i ON p.id = i.properties_id " +
                "WHERE bm.user_id = :userId GROUP BY p.id";

        MapSqlParameterSource parameterSource = new MapSqlParameterSource()
                .addValue("userId", userId);

        return jdbcTemplate.query(sql, parameterSource, (rs, rowNum) -> PropertiesDto.builder()
                .id(rs.getLong("id"))
                .title(rs.getString("title"))
                .state(rs.getString("state"))
                .city(rs.getString("city"))
                .latitude(rs.getDouble("latitude"))
                .longitude(rs.getDouble("longitude"))
                .reservable(rs.getBoolean("reservable"))
                .saved(rs.getBoolean("is_saved"))
                .isSuperHost(rs.getBoolean("is_super_host"))
                .price(rs.getDouble("price"))
                .placeType(rs.getString("place_type"))
                .reviewAverage(rs.getDouble("review_average"))
                .numberOfReviews(rs.getInt("number_of_reviews"))
                .images(Arrays.asList(rs.getString("image").split(",")))
                .build());
    }
}
