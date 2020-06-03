package com.airbnb3.codesquad.airbnb3.oauth.github;

public class User {

    private String githubId;
    private String nickname;
    private String name;
    private String email;

    public User() {
    }

    public User(String githubId, String nickname, String name, String email) {
        this.githubId = githubId;
        this.nickname = nickname;
        this.name = name;
        this.email = email;
    }

    public String getGithubId() {
        return githubId;
    }

    public void setGithubId(String githubId) {
        this.githubId = githubId;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "User{" +
                "githubId='" + githubId + '\'' +
                ", nickname='" + nickname + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
