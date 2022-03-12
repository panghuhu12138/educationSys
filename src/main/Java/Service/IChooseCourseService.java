package Service;

import Entity.ChooseCourse;
import Entity.Course;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface IChooseCourseService {
    List<ChooseCourse> findAll(Map<String, Object> params);

    List<String> findAllChosenCourses(String userId);

    int insertAll(List<ChooseCourse> chooseCourses);

    void checkChooseCourse(Map<String, Object> map);
}
