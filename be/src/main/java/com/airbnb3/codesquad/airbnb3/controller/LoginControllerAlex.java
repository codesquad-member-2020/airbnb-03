package com.airbnb3.codesquad.airbnb3.controller;

import com.airbnb3.codesquad.airbnb3.oauth.GithubAlex;
import com.airbnb3.codesquad.airbnb3.oauth.GithubUserAlex;
import com.airbnb3.codesquad.airbnb3.service.LoginServiceAlex;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.repository.query.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticsOAuthAlex.*;

@RestController
public class LoginControllerAlex {

    private static final Logger logger = LoggerFactory.getLogger(LoginControllerAlex.class);

    @Autowired
    private LoginServiceAlex loginService;

    @GetMapping("/callback")
    public ResponseEntity oauthCallback(@Param("code") String code, HttpServletResponse response) {
        GithubAlex github = loginService.requestAccessToken(code);
        logger.info("Github AccessToekn, TokenType, Scope Data : {}", github.toString());
        GithubUserAlex githubUser = loginService.requestUserInfo(github.getAccessToken());
        logger.info("Github User Id : {}", githubUser.toString());
        loginService.saveUserInfo(githubUser);

        Cookie cookie = new Cookie(USER_ID, githubUser.getUserId());
        cookie.setMaxAge(EXPIRE_TIME);
        response.addCookie(cookie);
        response.setHeader(HEADER_LOCATION, REDIRECT_URL);
        return new ResponseEntity(HttpStatus.FOUND);
    }

    @CrossOrigin(origins = "https://github.com/login/oauth/authorize?client_id=91882bf66676085caab9&scope=user",allowCredentials = "true")
    @GetMapping("/github/login")
    public RedirectView loginGithubOauth() {
        return new RedirectView(OAUTH_URL);
    }
}
