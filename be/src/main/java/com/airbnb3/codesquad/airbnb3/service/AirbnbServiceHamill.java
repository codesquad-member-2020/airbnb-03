package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.PropertiesDaoHamill;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDtoHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AirbnbServiceHamill {

    private static final Logger logger = LoggerFactory.getLogger(AirbnbServiceHamill.class);

    private final PropertiesDaoHamill propertiesDaoHamill;

    public AirbnbServiceHamill(PropertiesDaoHamill propertiesDaoHamill) {
        this.propertiesDaoHamill = propertiesDaoHamill;
    }

    public List<PropertiesDtoHamill> findAllProperties(int page) {
        return propertiesDaoHamill.findAllProperties(page);
    }
}
