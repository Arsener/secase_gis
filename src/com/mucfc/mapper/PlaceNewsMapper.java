package com.mucfc.mapper;

import java.util.List;

import com.mucfc.model.News;

public interface PlaceNewsMapper {
	public List<News> showPlaceNews(String case_place);
}
