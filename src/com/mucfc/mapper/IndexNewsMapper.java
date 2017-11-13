package com.mucfc.mapper;

import java.util.List;

import com.mucfc.model.News;

public interface IndexNewsMapper {
	public List<News> selectNewsByPlace(String case_place);
	public List<News> selectNewsByType(String case_type);
	public List<News> selectNewsByBoth(String case_place, String case_type);
	public List<News> selectNewsByNeither();
}
