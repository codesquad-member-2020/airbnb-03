package com.airbnb3.codesquad.airbnb3.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReservationDaoAlex {

    private static final Logger logger = LoggerFactory.getLogger(ReservationDaoAlex.class);

    @Autowired
    private NamedParameterJdbcTemplate jdbcTemplate;

    public void reservationProperties() {

    }



}
