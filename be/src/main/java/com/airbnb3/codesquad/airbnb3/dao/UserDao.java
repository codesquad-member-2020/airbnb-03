package com.airbnb3.codesquad.airbnb3.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class UserDao {
    private static final Logger logger = LoggerFactory.getLogger(UserDao.class);

    private final NamedParameterJdbcTemplate jdbcTemplate;

    public UserDao(NamedParameterJdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public Long findUserIdByUserName(String name) {
        String sql = "SELECT id FROM user WHERE name = :name";
        MapSqlParameterSource parameterSource = new MapSqlParameterSource("name",name);
        try {
            return jdbcTemplate.queryForObject(sql,parameterSource,(rs, rowNum) -> rs.getLong("id"));
        } catch (EmptyResultDataAccessException e) {
            return -1L;
        }
    }

}
