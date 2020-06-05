package com.airbnb3.codesquad.airbnb3.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface GitHubOauthService {

    void login(HttpServletRequest request, HttpServletResponse response, String url, String authorizationCode) throws IOException;
}
