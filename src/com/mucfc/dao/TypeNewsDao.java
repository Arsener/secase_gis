package com.mucfc.dao;

import java.util.List;

import com.mucfc.model.News;

public interface TypeNewsDao {
	public List<News> showTypeNews(String case_type);
}
