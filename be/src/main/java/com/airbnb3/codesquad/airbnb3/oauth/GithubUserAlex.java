package com.airbnb3.codesquad.airbnb3.oauth;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class GithubUserAlex {

    @JsonProperty("id")
    private String githubId;

    @JsonProperty("login")
    private String userId;

    @JsonProperty("email")
    private String email;

    @Builder
    public GithubUserAlex(String githubId, String userId, String email) {
        this.githubId = githubId;
        this.userId = userId;
        this.email = email;
    }
}
