package Service.impl;

import Dao.ChooseCourseMapper;
import Entity.ChooseCourse;
import Entity.Course;
import Service.IChooseCourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ChooseCourseServiceImpl implements IChooseCourseService {
    @Autowired
    private ChooseCourseMapper chooseCourseMapper;

    @Override
    public List<ChooseCourse> findAll(Map<String, Object> params) {
        return chooseCourseMapper.findAll(params);
    }

    @Override
    public List<String> findAllChosenCourses(String userId) {
        return chooseCourseMapper.findAllChosenCourses(userId);
    }

    @Override
    public int insertAll(List<ChooseCourse> chooseCourses) {
        return chooseCourseMapper.insertAll(chooseCourses);
    }

    @Override
    public void checkChooseCourse(Map<String, Object> map) {
        chooseCourseMapper.checkChooseCourse(map);
    }

}
