package com.airbnb3.codesquad.airbnb3.dto.composition;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
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
}
