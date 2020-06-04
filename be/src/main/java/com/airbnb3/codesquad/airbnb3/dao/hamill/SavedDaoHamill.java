package com.airbnb3.codesquad.airbnb3.dao.hamill;

import com.airbnb3.codesquad.airbnb3.dto.hamill.PropertiesDtoHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.Arrays;
import java.util.List;

@Repository
public class SavedDaoHamill {

    private final Logger logger = LoggerFactory.getLogger(SavedDaoHamill.class);

    private final JdbcTemplate jdbcTemplate;

    public SavedDaoHamill(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public void savedTheProperties(Long propertyId, Long userId) {

        String sql = "INSERT INTO bookmarks (is_bookmarked, user_id, properties_id) VALUES (true, ?, ?)";
        jdbcTemplate.update(sql, userId, propertyId);
    }

    public List<PropertiesDtoHamill> findAllSaved(Long userId) {

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
                        "       GROUP_CONCAT(i.image_url)                       AS image\n" +
                        "FROM properties p\n" +
                        "         LEFT JOIN images i\n" +
                        "                   ON p.id = i.properties_id\n" +
                        "         LEFT JOIN detail d ON p.id = d.id\n" +
                        "         LEFT JOIN calendar c ON p.id = c.properties_id\n" +
                        "         LEFT JOIN bookmarks b on p.id = b.properties_id\n" +
                        "         LEFT JOIN user u on b.user_id = u.id\n" +
                        "WHERE is_bookmarked = 1\n" +
                        "AND u.id = ?\n" +
                        "GROUP BY p.id;";

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
                ,userId);
    }

    public void updatedSavedIsTrue(Long propertyId) {

        String sql = "UPDATE properties SET saved = true WHERE id = ?";
        jdbcTemplate.update(sql, propertyId);
    }

    public void updatedSavedIsFalse(Long propertyId) {

        String sql = "UPDATE properties SET saved = false WHERE id = ?";
        jdbcTemplate.update(sql, propertyId);
    }

    public void cancelThePropertiesSaved(Long propertyId) {

        String sql = "DELETE FROM bookmarks WHERE properties_id = ?";
        jdbcTemplate.update(sql, propertyId);
    }
}
