package Service;

import Entity.ChooseCourse;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface IChooseCourseService {
    public List<ChooseCourse> findAll(Map<String, Object> params);

    List<String> findAllChosenCourses(String userId);

    int insertAll(List<ChooseCourse> chooseCourses);
}
