package com.ncncn.mapper;

import org.mybatis.spring.annotation.MapperScan;

@MapperScan
public interface TestMapper {

	String getVersion();

}
