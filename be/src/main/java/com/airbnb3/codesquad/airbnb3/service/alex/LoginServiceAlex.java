package com.airbnb3.codesquad.airbnb3.service.alex;

import com.airbnb3.codesquad.airbnb3.dao.alex.UserDaoAlex;
import com.airbnb3.codesquad.airbnb3.oauth.GithubAlex;
import com.airbnb3.codesquad.airbnb3.oauth.GithubUserAlex;
import com.airbnb3.codesquad.airbnb3.oauth.RequestBodyAlex;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsOAuthAlex.*;

@Service
public class LoginServiceAlex {
    private static final Logger logger = LoggerFactory.getLogger(LoginServiceAlex.class);

    @Autowired
    private UserDaoAlex userDaoAlex;

    @Value("${GITHUB_CLIENT_ID}")
    private String GITHUB_CLIENT_ID;

    @Value("${GITHUB_CLIENT_SECRET}")
    private String GITHUB_CLIENT_SECRET;

    public GithubAlex requestAccessToken(String code) {
        RequestBodyAlex requestBody = RequestBodyAlex.builder()
                .clientId(GITHUB_CLIENT_ID)
                .clientSecret(GITHUB_CLIENT_SECRET)
                .code(code)
                .build();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<?> httpEntity = new HttpEntity<>(requestBody, headers);
        ResponseEntity<GithubAlex> responseEntity = new RestTemplate().postForEntity(GITHUB_ACCESS_TOKEN_URL, httpEntity, GithubAlex.class);
        return responseEntity.getBody();
    }

    public GithubUserAlex requestUserInfo(String accessToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(accessToken);
        HttpEntity<?> httpEntity = new HttpEntity<>(headers);
        ResponseEntity<GithubUserAlex> responseEntity = new RestTemplate().exchange(GITHUB_USER_INFO_URL, HttpMethod.GET, httpEntity, GithubUserAlex.class);
        return responseEntity.getBody();
    }

    public void saveUserInfo(GithubUserAlex userInfo) {
        if (!userDaoAlex.checkUserInfo(userInfo.getGithubId())) userDaoAlex.saveUserInfo(userInfo);
    }
}
