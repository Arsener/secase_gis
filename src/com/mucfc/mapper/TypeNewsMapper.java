package com.mucfc.mapper;

import java.util.List;

import com.mucfc.model.News;

public interface TypeNewsMapper {
	public List<News> showTypeNews(String case_type);
}
