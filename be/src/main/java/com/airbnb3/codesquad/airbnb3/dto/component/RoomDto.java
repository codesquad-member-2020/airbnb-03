package com.airbnb3.codesquad.airbnb3.dto.component;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class RoomDto {
    private String placeType;
    private String summary;
    private String space;
    private Integer accommodates;
    private Integer bathrooms;
    private Integer bedrooms;
    private Integer beds;
    private String bedType;
    private String amenities;

    @Builder
    public RoomDto(String placeType, String summary, String space, Integer accommodates, Integer bathrooms, Integer bedrooms, Integer beds, String bedType, String amenities) {
        this.placeType = placeType;
        this.summary = summary;
        this.space = space;
        this.accommodates = accommodates;
        this.bathrooms = bathrooms;
        this.bedrooms = bedrooms;
        this.beds = beds;
        this.bedType = bedType;
        this.amenities = amenities;
    }
}
