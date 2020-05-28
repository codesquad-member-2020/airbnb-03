package com.airbnb3.codesquad.airbnb3.dao;

import com.airbnb3.codesquad.airbnb3.oauth.GithubUserAlex;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class UserDaoAlex {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public void saveUserInfo(GithubUserAlex userInfo) {
        String sql = "INSERT INTO user (id, name, email) VALUES (?, ?, ?)";
        Object[] parameter = new Object[]{userInfo.getGithubId(), userInfo.getUserId(), userInfo.getEmail()};
        jdbcTemplate.update(sql, parameter);
    }

    public boolean checkUserInfo(String githubId) {
        String sql = "SELECT EXISTS(SELECT id FROM user WHERE id = ?) AS id_check";
        return jdbcTemplate.queryForObject(sql, new Object[]{githubId}, (rs, rowNum) -> rs.getBoolean("id_check"));
    }

}
