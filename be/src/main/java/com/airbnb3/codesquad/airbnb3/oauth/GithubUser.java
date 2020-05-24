package com.airbnb3.codesquad.airbnb3.oauth;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class GithubUser {

    @JsonProperty("login")
    private String userId;
}
