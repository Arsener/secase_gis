package com.mucfc.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mucfc.mapper.LevelMapper;
import com.mucfc.model.*;

@Component
public class LevelDaoImpl implements LevelDao{
	@Autowired
	private LevelMapper levelMapper;
	@Override
	public List<Level> selectByLevel() {
		List<Level> levels = levelMapper.selectByLevel();
		return  levels; 
	}
}
