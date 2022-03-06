package Service.impl;

import Dao.CourseMapper;
import Entity.Course;
import Service.ICourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;
@Service
public class CourseServiceImpl implements ICourseService {
    @Autowired
    private CourseMapper courseMapper;

    public List<Course> findAll(Map<String, Object> params) {
        return courseMapper.findAll(params);
    }
}
