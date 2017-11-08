package com.mucfc.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mucfc.mapper.TypeMapper;
import com.mucfc.model.*;

@Component
public class TypeDaoImpl implements TypeDao{
	@Autowired
	private TypeMapper typeMapper;
	@Override
	public List<Type> selectByType() {
		List<Type> types = typeMapper.selectByType();
		return types; 
	}
}
