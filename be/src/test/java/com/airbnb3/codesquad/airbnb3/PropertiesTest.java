package com.airbnb3.codesquad.airbnb3;

import com.airbnb3.codesquad.airbnb3.dao.PropertiesDaoAlex;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoAlex;
import com.airbnb3.codesquad.airbnb3.service.LoginServiceAlex;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class PropertiesTest {

    private static final Logger logger = LoggerFactory.getLogger(PropertiesTest.class);

    @Autowired
    private PropertiesDaoAlex propertiesDao;

    @Test
    public void getPropertiesList() {
        logger.info("Properties is OK Test");
        for (PropertiesDtoAlex p : propertiesDao.getStayedProperties(5)) {
            logger.info("Properties ID : {}, Properties ID : {}",p.getId(),p.toString());
        }
    }
}