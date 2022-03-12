package Service.impl;

import Dao.CourseMapper;
import Entity.Course;
import Service.ICourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Service
public class CourseServiceImpl implements ICourseService {
    @Autowired
    private CourseMapper courseMapper;

    public List<Course> findAll(Map<String, Object> params) {
        return courseMapper.findAll(params);
    }

    @Override
    public List<Course> findAll2(Map<String, Object> params) {
        return courseMapper.findAll2(params);
    }

    @Override
    public List<Course> queryAllChooseCourseByCourseId(Map<String, Object> params) {
        return courseMapper.queryAllChooseCourseByCourseId(params);
    }

    @Override
    public void updateAll(HashMap<String, Object> stringObjectHashMap) {
        courseMapper.updateAll(stringObjectHashMap);
    }
}
