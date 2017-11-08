package com.mucfc.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mucfc.mapper.TypeNewsMapper;
import com.mucfc.model.News;

@Component
public class TypeNewsDaoImpl implements TypeNewsDao{

	@Autowired
	private TypeNewsMapper typeNewsMapper;
	@Override
	public List<News> showTypeNews(String case_type) {
		List<News> typeNews = typeNewsMapper.showTypeNews(case_type);
		return typeNews;
	}

}
