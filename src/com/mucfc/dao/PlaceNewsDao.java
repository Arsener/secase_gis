package com.mucfc.dao;

import java.util.List;

import com.mucfc.model.News;

public interface PlaceNewsDao {
	public List<News> showPlaceNews(String case_place);
}
