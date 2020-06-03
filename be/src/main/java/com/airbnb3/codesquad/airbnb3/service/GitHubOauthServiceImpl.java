package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.config.jwt.JwtService;
import com.airbnb3.codesquad.airbnb3.controller.GitHubOauthController;
import com.airbnb3.codesquad.airbnb3.dao.TokenDao;
import com.airbnb3.codesquad.airbnb3.oauth.github.GitHubAccessToken;
import com.airbnb3.codesquad.airbnb3.oauth.github.GitHubTokenInfo;
import com.airbnb3.codesquad.airbnb3.oauth.github.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticOAuthHamill.GITHUB_ACCESS_TOKEN_URL;
import static com.airbnb3.codesquad.airbnb3.common.CommonStaticOAuthHamill.GITHUB_USER_INFO_ACCESS_URL;

@Service
public class GitHubOauthServiceImpl implements GitHubOauthService {

    private static final Logger logger = LoggerFactory.getLogger(GitHubOauthController.class);
    private final TokenDao tokenDao;
    private final JwtService jwtService;

    @Value("${github.client_id}")
    private String clientId;
    @Value("${github.client_secret}")
    private String clientSecret;

    public GitHubOauthServiceImpl(TokenDao tokenDao, JwtService jwtService) {
        this.tokenDao = tokenDao;
        this.jwtService = jwtService;
    }

    public GitHubTokenInfo getAccessToken(String code) {
        MultiValueMap<String, String> headers = new LinkedMultiValueMap<>();
        Map<String, String> header = new HashMap<>();
        header.put("Accept", "application/json");
        headers.setAll(header);

        MultiValueMap<String, String> bodies = new LinkedMultiValueMap<>();
        Map<String, String> body = new HashMap<>();
        body.put("client_id", clientId);
        body.put("client_secret", clientSecret);
        body.put("code", code);
        bodies.setAll(body);

        HttpEntity<?> request = new HttpEntity<>(bodies, headers);
        ResponseEntity<?> response = new RestTemplate().postForEntity(GITHUB_ACCESS_TOKEN_URL, request, GitHubTokenInfo.class);
        return (GitHubTokenInfo) response.getBody();
    }

    @Transactional
    @Override
    public void login(HttpServletRequest request, HttpServletResponse response, String url, String authorizationCode) throws IOException {
        GitHubTokenInfo gitHubTokenInfo = getAccessToken(authorizationCode);
        logger.info("##### Access Token Type: {}, Access Token: {}",gitHubTokenInfo.getTokenType(), gitHubTokenInfo.getAccessToken());

        GitHubAccessToken gitHubAccessToken = new GitHubAccessToken(gitHubTokenInfo.getTokenType(), gitHubTokenInfo.getAccessToken());
        tokenDao.insertToken(gitHubAccessToken);

        this.getUserData(request, response, url, gitHubAccessToken.getToken());

    }

    public void getUserData(HttpServletRequest request, HttpServletResponse response, String url, String accessToken) {
        GitHubAccessToken gitHubAccessToken = tokenDao.findTokenObjectByAccessToken(accessToken);
        try {
            RestTemplate restTemplate = new RestTemplate();

            HttpHeaders header = new HttpHeaders();
            HttpEntity<?> entity = new HttpEntity<>(header);

            UriComponents sendAccessTokenUrl = UriComponentsBuilder.fromHttpUrl(
                    GITHUB_USER_INFO_ACCESS_URL + "?access_token=" + gitHubAccessToken.getToken()).build();

            // 이 한줄의 코드로 API를 호출해 MAP 타입으로 전달 받는다
            ResponseEntity<Map> resultMap = restTemplate.exchange(sendAccessTokenUrl.toString(), HttpMethod.GET, entity, Map.class);

            User user = new User(
                    Objects.requireNonNull(resultMap.getBody()).get("id").toString(),
                    resultMap.getBody().get("login").toString(),
                    resultMap.getBody().get("name").toString(),
                    resultMap.getBody().get("email").toString());

            String jwt = jwtService.makeJwt(user.getNickname(), user.getName(), user.getEmail());
            this.sendUserCookies(response, jwt, url);

        } catch (HttpClientErrorException | HttpServerErrorException e) {
            logger.info("##### HttpErrorException: {}", e.getMessage());
        } catch (Exception e) {
            logger.info("##### Exception: {}", e.getMessage());
        }
    }

    public void sendUserCookies(HttpServletResponse response, String jwt, String url) throws IOException {
        Cookie cookie = new Cookie("token", jwt);
        response.addCookie(cookie);
        response.sendRedirect(url);
    }
}
