package Dao;

import Entity.Grade;

public interface GradeMapper {
    int deleteByPrimaryKey(String gradeId);

    int insert(Grade record);

    int insertSelective(Grade record);

    Grade selectByPrimaryKey(String gradeId);

    int updateByPrimaryKeySelective(Grade record);

    int updateByPrimaryKey(Grade record);
}