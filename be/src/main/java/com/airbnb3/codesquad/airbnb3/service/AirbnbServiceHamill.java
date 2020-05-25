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

    public List<PropertiesDtoHamill> findAllProperties(Integer page) {
        return propertiesDaoHamill.findAllProperties(page);
    }
}

//    Integer page, String checkin, String checkout, Integer adults, Integer children,
//        Integer infants, Integer priceMin, Integer priceMax
//, checkin, checkout, adults, children, infants, priceMin, priceMax
