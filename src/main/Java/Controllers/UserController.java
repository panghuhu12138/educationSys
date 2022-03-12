package Controllers;

import Entity.User;
import Service.IUserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import Utils.ApiResult;
import Utils.UUIDUtils;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.ResourceBundle;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private IUserService userService;

    //首页
    @RequestMapping("/index")
    public String index(){
        return "first";
    }

    //用户管理页面
    @RequestMapping("/toUserManager")
    public String toUserManager(){
        return "user/user";
    }

    /**
     * 跳转到用户管理修改页面
     */
    @RequestMapping("toUserEdit")
    public String toUserEdit(){
        return "user/userEdit";
    }

    //用户管理页面
    @RequestMapping("/getUserInfo")
    @ResponseBody
    public ApiResult getUserInfo(User user, HttpServletRequest request){
        PageHelper.startPage(request);
        List<User> userList = userService.findAllExcludeSessionUser(user);
        PageInfo page = new PageInfo(userList);
        return ApiResult.success(page);
    }

    //用户管理页面
    @RequestMapping("/getUserEditData")
    @ResponseBody
    public ApiResult getUserEditData(User user){
        User oldUser = userService.find(user);
        return ApiResult.success(oldUser);
    }

    //更新用户信息
    @RequestMapping("/editUser")
    @ResponseBody
    public ApiResult editUser(@RequestBody final User user){
        if(user.getUserId() != null && (!"".equals(user.getUserId()))) {
            userService.update(user);
        } else {
            User exitUser = userService.find(new User() {{
                this.setUserNum(user.getUserNum());
            }});
            if (exitUser != null) {
                return ApiResult.failed("新增学号已存在！");
            }
            user.setUserId(UUIDUtils.getUUID());
            user.setPassword(ResourceBundle.getBundle("system").getString("initPwd"));
            userService.insert(user);
        }
        return ApiResult.success();
    }

    //重置密码
    @RequestMapping("/resetPassword")
    @ResponseBody
    public ApiResult resetPassword(String ids){
        ResourceBundle resource = ResourceBundle.getBundle("system");
        String initPassword = resource.getString("initPwd");
        String[] initUserIds = ids.split(",");
        List<User> users = new ArrayList<User>(10);
        for (String userId : initUserIds
             ) {
            User user = new User();
            user.setUserId(userId);
            user.setPassword(initPassword);
            users.add(user);
        }
        userService.updateAll(users);
        return ApiResult.success(initPassword);
    }

    //删除用户
    @RequestMapping("/deleteUser")
    @ResponseBody
    public ApiResult deleteUser(String ids){
        String[] deleteIds = ids.split(",");
        List<String> list = Arrays.asList(deleteIds);
        userService.deleteAll(list);
        return ApiResult.success();
    }

    /*修改密码*/
    @RequestMapping("/modifyPassword")
    @ResponseBody
    public ApiResult modifyPassword(HttpServletRequest request) {
        User currentUser = (User) request.getSession().getAttribute("user");
        String oldPassword = request.getParameter("password");
        String newPassword = request.getParameter("newPassword");
        try {
            User user = userService.find(currentUser);
            if (!user.getPassword().equals(oldPassword)){
                return ApiResult.failed("原密码输入错误，请重新输入！");
            } else if (user.getPassword().equals(newPassword)) {
                return ApiResult.failed("原密码与新密码相同，请重新输入！");
            } else {
                user.setPassword(newPassword);
                userService.update(user);
                return ApiResult.success();
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ApiResult.failed("系统异常！请联系管理员！");
        }
    }
}
