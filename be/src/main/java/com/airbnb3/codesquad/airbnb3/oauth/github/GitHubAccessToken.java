package com.airbnb3.codesquad.airbnb3.oauth.github;

import org.springframework.data.annotation.Id;

public class GitHubAccessToken {

    @Id
    private Long id;

    private String tokenType;

    private String token;

    public GitHubAccessToken() {

    }

    public GitHubAccessToken(String tokenType, String token) {
        this.tokenType = tokenType;
        this.token = token;
    }

    public GitHubAccessToken(Long id, String tokenType, String token) {
        this.id = id;
        this.tokenType = tokenType;
        this.token = token;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTokenType() {
        return tokenType;
    }

    public void setTokenType(String tokenType) {
        this.tokenType = tokenType;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
