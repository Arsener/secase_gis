package com.mucfc.mapper;

import java.util.List;

import com.mucfc.model.News;

public interface LevelNewsMapper {
	public List<News> showLevelNews(String case_level);
}
