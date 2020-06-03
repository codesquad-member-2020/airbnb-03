package com.airbnb3.codesquad.airbnb3.dao;

import com.airbnb3.codesquad.airbnb3.oauth.github.GitHubAccessToken;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;

@Repository
public class TokenDao {

    private static final Logger logger = LoggerFactory.getLogger(TokenDao.class);

    private final JdbcTemplate jdbcTemplate;
    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    public TokenDao(JdbcTemplate jdbcTemplate, NamedParameterJdbcTemplate namedParameterJdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
        this.namedParameterJdbcTemplate = namedParameterJdbcTemplate;
    }

    public void insertToken(GitHubAccessToken gitHubAccessToken) {
        String sql = "INSERT INTO token (token_type, token) VALUES (:token_type, :token)";
        SqlParameterSource namedParameters = new MapSqlParameterSource()
                .addValue("id", gitHubAccessToken.getId())
                .addValue("token_type", gitHubAccessToken.getTokenType())
                .addValue("token", gitHubAccessToken.getToken());
        namedParameterJdbcTemplate.update(sql, namedParameters);
    }

    public GitHubAccessToken findTokenObjectByAccessToken(String accessToken) {
        String sql = "SELECT * FROM token t WHERE t.token = ?";
        return jdbcTemplate.query(sql, new ResultSetExtractor<GitHubAccessToken>() {
            @Override
            public GitHubAccessToken extractData(ResultSet rs) throws SQLException, DataAccessException {
                GitHubAccessToken gitHubAccessToken = new GitHubAccessToken();
                while (rs.next()) {
                    gitHubAccessToken.setId(rs.getLong("id"));
                    gitHubAccessToken.setTokenType(rs.getString("token_type"));
                    gitHubAccessToken.setToken(rs.getString("token"));
                }
                return gitHubAccessToken;
            }
        }, accessToken);
    }


}
