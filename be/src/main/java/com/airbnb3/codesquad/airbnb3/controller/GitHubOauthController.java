package com.airbnb3.codesquad.airbnb3.controller;

import com.airbnb3.codesquad.airbnb3.service.GitHubOauthService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;
import java.io.IOException;

import static com.airbnb3.codesquad.airbnb3.common.CommonStaticOAuthHamill.REDIRECT_URL;

@RestController
public class GitHubOauthController {
    private static final Logger logger = LoggerFactory.getLogger(GitHubOauthController.class);

    private final GitHubOauthService gitHubOauthService;

    public GitHubOauthController(GitHubOauthService gitHubOauthService) {
        this.gitHubOauthService = gitHubOauthService;
    }

    @GetMapping("/login/oauth")
    public void login(@PathParam("code") String code, HttpServletRequest request, HttpServletResponse response) throws IOException {
        gitHubOauthService.login( request, response, REDIRECT_URL, code);
    }
}
