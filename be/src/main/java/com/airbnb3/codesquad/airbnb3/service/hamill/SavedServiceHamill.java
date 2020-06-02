package com.airbnb3.codesquad.airbnb3.service.hamill;

import com.airbnb3.codesquad.airbnb3.dao.hamill.SavedDaoHamill;
import com.airbnb3.codesquad.airbnb3.dto.hamill.PropertiesDtoHamill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SavedServiceHamill {

    private static final Logger logger = LoggerFactory.getLogger(AirbnbServiceHamill.class);

    private final SavedDaoHamill savedDaoHamill;

    public SavedServiceHamill(SavedDaoHamill savedDaoHamill) {
        this.savedDaoHamill = savedDaoHamill;
    }

    // 즐겨찾기 추가
    public void savedTheProperties(Long propertyId, Long userId) {

        savedDaoHamill.savedTheProperties(propertyId, userId);
        savedDaoHamill.updatedSavedIsTrue(propertyId);
    }

    // 즐겨찾기 목록 출력
    public List<PropertiesDtoHamill> findAllSaved(Long userId) {

        return savedDaoHamill.findAllSaved(userId);
    }

    // 즐겨찾기 삭제
    public void cancelThePropertiesSaved(Long propertyId) {

        savedDaoHamill.cancelThePropertiesSaved(propertyId);
        savedDaoHamill.updatedSavedIsFalse(propertyId);
    }
}
