package Dao;

import Entity.ChooseCourse;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
@Repository
public interface ChooseCourseMapper {
    int deleteByPrimaryKey(String chooseCourseId);

    int insert(ChooseCourse record);

    int insertSelective(ChooseCourse record);

    ChooseCourse selectByPrimaryKey(String chooseCourseId);

    int updateByPrimaryKeySelective(ChooseCourse record);

    int updateByPrimaryKey(ChooseCourse record);

    List<ChooseCourse> findAll(Map<String, Object> params);

    List<String> findAllChosenCourses(String userId);

    int insertAll(List<ChooseCourse> chooseCourses);

    void checkChooseCourse(Map<String, Object> map);
}