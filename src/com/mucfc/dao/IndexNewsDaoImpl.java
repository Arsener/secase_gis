package com.mucfc.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mucfc.mapper.IndexNewsMapper;
import com.mucfc.model.News;

@Component
public class IndexNewsDaoImpl implements IndexNewsDao {
	@Autowired
	private IndexNewsMapper indexNewsMapper;

	@Override
	public List<News> selectNewsByPlace(String case_place) {
		// TODO Auto-generated method stub
		return indexNewsMapper.selectNewsByPlace(case_place);
	}

	@Override
	public List<News> selectNewsByType(String case_type) {
		// TODO Auto-generated method stub
		return indexNewsMapper.selectNewsByType(case_type);
	}

	@Override
	public List<News> selectNewsByBoth(String case_place, String case_type) {
		// TODO Auto-generated method stub
		return indexNewsMapper.selectNewsByBoth(case_place, case_type);
	}

	@Override
	public List<News> selectNewsByNeither() {
		// TODO Auto-generated method stub
		return indexNewsMapper.selectNewsByNeither();
	}

}
