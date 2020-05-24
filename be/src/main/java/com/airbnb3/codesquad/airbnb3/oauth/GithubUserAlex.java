package com.airbnb3.codesquad.airbnb3.oauth;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

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

}
