package com.airbnb3.codesquad.airbnb3;

import com.airbnb3.codesquad.airbnb3.dao.alex.UserDaoAlex;
import com.airbnb3.codesquad.airbnb3.oauth.GithubUserAlex;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class UserTest {

    private static final Logger logger = LoggerFactory.getLogger(UserTest.class);

    @Autowired
    private UserDaoAlex userDaoAlex;

    @Test
    public void userIdCheck() throws Exception{
        logger.info("User Check Test!!!!");
        String testId = "12345";
        GithubUserAlex testUser = GithubUserAlex.builder().githubId(testId).userId("testUser").email("testEmail@mail.com").build();
        logger.info("Before TEST ID : {} RESULT : {}",testId,userDaoAlex.checkUserInfo(testId));
        userDaoAlex.saveUserInfo(testUser);
        logger.info("After TEST ID : {} RESULT : {}", testId, userDaoAlex.checkUserInfo(testId));
    }
}
