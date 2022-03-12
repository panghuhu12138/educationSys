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
import org.springframework.web.bind.annotation.RequestBody;
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

    /*跳转到选课页*/
    @RequestMapping("/toChooseCourse")
    public String toChooseCourse() {
        return "/course/chooseCourse";
    }

    /*跳转到课程管理页*/
    @RequestMapping("/toCourseManager")
    public String toCourseManager() {
        return "/course/courseManager";
    }

    /*跳转到课程管理页*/
    @RequestMapping("/toCourseCheck")
    public String toCourseCheck() {
        return "/course/courseCheck";
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
    @RequestMapping("/queryAllCourse2")
    @ResponseBody
    public ApiResult queryAllCourse2(HttpServletRequest request) {
        Map<String, Object> params = Util.paramToMapNew(request);
        User user = (User) request.getSession().getAttribute("user");
        params.put("teacherId", user.getUserId());
        List<Course> courseList = iCourseService.findAll2(params);
        PageInfo page = new PageInfo(courseList);
        return ApiResult.success(page);
    }

    /*获取所有课程*/
    @RequestMapping("/queryAllChooseCourseByCourseId")
    @ResponseBody
    public ApiResult queryAllChooseCourseByCourseId(HttpServletRequest request) {
        Map<String, Object> params = Util.paramToMapNew(request);
        List<ChooseCourse> courseList = iChooseCourseService.findAll(params);
        return ApiResult.success(courseList);
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

    /*确认或退回学生选课*/
    @RequestMapping("/checkChooseCourse")
    @ResponseBody
    public ApiResult checkChooseCourse(String ids, Integer status, String reason) {
        List<String> chooseCourseIds = Arrays.asList(ids.split(","));
        iChooseCourseService.checkChooseCourse(new HashMap<String, Object>(3){{
            this.put("chooseCourseIds", chooseCourseIds);
            this.put("status", status);
            this.put("reason", reason);
        }});
        return ApiResult.success();
    }


    /*开课或结课*/
    @RequestMapping("/updateCourse")
    @ResponseBody
    public ApiResult updateCourse(String ids, Integer status) {
        List<String> courseIds = Arrays.asList(ids.split(","));
        iCourseService.updateAll(new HashMap<String, Object>(3){{
            this.put("courseIds", courseIds);
            this.put("status", status);
        }});
        return ApiResult.success();
    }
}
