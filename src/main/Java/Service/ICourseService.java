package Service;

import Entity.Course;

import java.util.List;
import java.util.Map;

public interface ICourseService {
    public List<Course> findAll(Map<String, Object> params);
}
