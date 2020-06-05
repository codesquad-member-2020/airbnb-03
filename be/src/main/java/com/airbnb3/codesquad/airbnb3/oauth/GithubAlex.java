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
public class GithubAlex {

    // GITHUB에 사용자의 데이터 요청을 보낼때 사용하는 객체

    // 인증에 필요한 발급받은 Token을 저장하는 변수
    @JsonProperty("access_token")
    private String accessToken;

    // Token의 Type을 저장하는 변수
    @JsonProperty("token_type")
    private String tokenType;

    // 내가 필요한 데이터의 범위를 지정하는 변수 (CommonStaticsOAuth에서 Scope를 변경할 수 있다)
    @JsonProperty("scope")
    private String scope;
}
