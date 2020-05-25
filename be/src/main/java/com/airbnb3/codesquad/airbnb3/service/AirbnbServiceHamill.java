package com.airbnb3.codesquad.airbnb3.service;

import com.airbnb3.codesquad.airbnb3.dao.PropertiesDaoHamill;
import com.airbnb3.codesquad.airbnb3.dto.PropertiesDetailDtoHamill;
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

    public List<PropertiesDtoHamill> findAllProperties(Integer offset, Double priceMin, Double priceMax,
                                                       Integer adults, Integer children) {
        return propertiesDaoHamill.findAllProperties(offset, priceMin, priceMax, adults, children);
    }

    public PropertiesDetailDtoHamill findByPropertiesId(int propertiesId) {
        return propertiesDaoHamill.findByPropertiesId(propertiesId);
    }
}

//    Integer page, String checkin, String checkout, Integer adults, Integer children,
//        Integer infants,
//, checkin, checkout, adults, children, infants, priceMin, priceMax
