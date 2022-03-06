package Controllers;

import Entity.ChooseCourse;
import Entity.Course;
import Entity.User;
import Service.IChooseCourseService;
import Service.ICourseService;
import Utils.*;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/chooseCourse")
public class ChooseCourseController {
    @Autowired
    private IChooseCourseService iChooseCourseService;
    @Autowired
    private ICourseService iCourseService;

    /*跳转到选课展示页*/
    @RequestMapping("/toChooseCourseInfo")
    public String toChooseCourseInfo() {
        return "course/chooseCourseInfo";
    }

    /*跳转到选课展示页*/
    @RequestMapping("/toChooseCourse")
    public String toChooseCourse() {
        return "/course/chooseCourse";
    }

    /*获取当前用户的所有选课*/
    @RequestMapping("/queryAllChooseCourseByUser")
    @ResponseBody
    public ApiResult queryAllChooseCourseByUser(HttpServletRequest request) {
        PageHelper.startPage(request);
        Map<String, Object> params = Util.paramToMapNew(request);
        final User user = (User) request.getSession().getAttribute("user");
        params.put("userId", user.getUserId());
        List<ChooseCourse> chooseCourseList = iChooseCourseService.findAll(params);
        PageInfo page = new PageInfo(chooseCourseList);
        return ApiResult.success(page);
    }

    /*获取所有课程*/
    @RequestMapping("/queryAllCourse")
    @ResponseBody
    public ApiResult queryAllCourse(HttpServletRequest request) {
        final User user = (User) request.getSession().getAttribute("user");
        List<String> chosenCourses = iChooseCourseService.findAllChosenCourses(user.getUserId());
        Map<String, Object> params = Util.paramToMapNew(request);
        if (chosenCourses != null) {
            params.put("chosenCourseIds", chosenCourses);
        }
        PageHelper.startPage(request);
        List<Course> courseList = iCourseService.findAll(params);
//        final List<Course> collect = courseList.stream().filter(course ->
//                !chooseCourseList.stream().map(chooseCourse -> chooseCourse.getCourseId()).collect(Collectors.toList()).contains(course.getCourseId())
//        ).collect(Collectors.toList());

        PageInfo page = new PageInfo(courseList);
        return ApiResult.success(page);
    }

    /*获取所有课程*/
    @RequestMapping("/addChooseCourses")
    @ResponseBody
    public ApiResult addChooseCourses(String ids,HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        List<String> courseIds = Arrays.asList(ids.split(","));
        List<ChooseCourse> chooseCourses = new ArrayList<>(courseIds.size());
        for (String courseId : courseIds
             ) {
            ChooseCourse chooseCourse = new ChooseCourse();
            chooseCourse.setChooseCourseId(UUIDUtils.getUUID());
            chooseCourse.setUserId(user.getUserId());
            chooseCourse.setCourseId(courseId);
            chooseCourse.setStatus(1);
            chooseCourse.setInsertTime(new Date());
            chooseCourses.add(chooseCourse);
        }
        iChooseCourseService.insertAll(chooseCourses);
        return ApiResult.success();
    }
}
