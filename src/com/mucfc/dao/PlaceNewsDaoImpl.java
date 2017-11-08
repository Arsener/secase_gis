package com.mucfc.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mucfc.mapper.PlaceNewsMapper;
import com.mucfc.model.News;

@Component
public class PlaceNewsDaoImpl implements PlaceNewsDao{

	@Autowired
	private PlaceNewsMapper placeNewsMapper;
	@Override
	public List<News> showPlaceNews(String case_place) {
		List<News> placeNews = placeNewsMapper.showPlaceNews(case_place);
		return placeNews;
	}

}
