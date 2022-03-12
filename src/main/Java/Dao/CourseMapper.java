package Dao;

import Entity.ChooseCourse;
import Entity.Course;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Repository
public interface CourseMapper {
    int deleteByPrimaryKey(String courseId);

    int insert(Course record);

    int insertSelective(Course record);

    Course selectByPrimaryKey(String courseId);

    int updateByPrimaryKeySelective(Course record);

    int updateByPrimaryKey(Course record);

    List<Course> findAll(Map<String, Object> params);

    List<Course> findAll2(Map<String, Object> params);

    List<Course> queryAllChooseCourseByCourseId(Map<String, Object> params);

    void updateAll(HashMap<String, Object> stringObjectHashMap);
}