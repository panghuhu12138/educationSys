package Service;

import Entity.Course;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface ICourseService {

    public List<Course> findAll(Map<String, Object> params);

    List<Course> findAll2(Map<String, Object> params);

    List<Course> queryAllChooseCourseByCourseId(Map<String, Object> params);

    void updateAll(HashMap<String, Object> stringObjectHashMap);
}
