package com.mucfc.dao;

import java.util.List;

import com.mucfc.model.News;

public interface IndexNewsDao {
	public List<News> selectNewsByPlace(String case_place);
	public List<News> selectNewsByType(String case_type);
	public List<News> selectNewsByBoth(String case_place, String case_type);
	public List<News> selectNewsByNeither();
}
