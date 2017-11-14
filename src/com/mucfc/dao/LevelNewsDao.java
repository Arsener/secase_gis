package com.mucfc.dao;

import java.util.List;

import com.mucfc.model.News;

public interface LevelNewsDao {
	public List<News> showLevelNews(String case_level);
}
