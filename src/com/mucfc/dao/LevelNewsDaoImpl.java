package com.mucfc.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mucfc.mapper.LevelNewsMapper;
import com.mucfc.model.News;

@Component
public class LevelNewsDaoImpl implements LevelNewsDao{

	@Autowired
	private LevelNewsMapper levelNewsMapper;
	@Override
	public List<News> showLevelNews(String case_level) {
		List<News> levelNews = levelNewsMapper.showLevelNews(case_level);
		return levelNews;
	}

}
