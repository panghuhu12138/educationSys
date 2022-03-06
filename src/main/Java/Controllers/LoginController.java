package Controllers;

import Entity.User;
import Service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import Utils.ApiResult;
import Utils.ImgCheckCode;
import Utils.UUIDUtils;

import javax.servlet.http.HttpServletRequest;


@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private IUserService userService;

    ImgCheckCode imgCheckCode=new ImgCheckCode();

    //验证码存放session 名
    private static String CODE_SESSION_NAME = "imgCode";
    /*跳转到登录页面*/
    @RequestMapping("/loginpage")
    public String login(HttpServletRequest request, ModelMap modelMap) {
        modelMap.addAttribute("userNum", request.getParameter("userNum"));
        return "login/login";
    }

    /*跳转到主页面*/
    @RequestMapping("/toMainPage")
    public String toMainPage() {
        return "login/main";
    }

    /*刷新验证码*/
    @RequestMapping("/getCodeImg")
    public String executeImage() {
        return "login/image";
    }

    /*校验验证码*/
    @RequestMapping("/checkCaptcha")
    @ResponseBody
    public ApiResult checkCaptcha(HttpServletRequest request) {
        String code = request.getParameter("code");
        boolean codeCheck = imgCheckCode.checkCode(request, code, CODE_SESSION_NAME);
        if (codeCheck) {
            return ApiResult.success();
        } else {
            return ApiResult.failed();
        }
    }

    /*登录*/
    @RequestMapping("/loginIn")
    @ResponseBody
    public ApiResult logIn(HttpServletRequest request) {
        try {
            User user = new User();
            String userNum = request.getParameter("userNum");
            String password = request.getParameter("password");
            user.setUserNum(userNum);
            user.setPassword(password);
            user = userService.find(user);
            if (user != null) {
                if (user.getStatus() == 2) {
                    return ApiResult.failed("该账号已被禁用！");
                }
                request.getSession().setAttribute("user", user);
                return ApiResult.success();
            } else {
                return ApiResult.failed("账号或密码错误！");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return ApiResult.failed("系统异常！请联系管理员！");
        }
    }

    /*注册*/
    @RequestMapping("/register")
    @ResponseBody
    public ApiResult register(HttpServletRequest request) {
        try {
            User user = new User();
            String userNum = request.getParameter("userNum");
            String password = request.getParameter("password");
            String username = request.getParameter("username");
            user.setUserNum(userNum);
            user.setIdentity(1);
            User result = userService.find(user);
            if (result != null) {
                return ApiResult.failed("该学号已存在！");
            } else {
                user.setUserId(UUIDUtils.getUUID());
                user.setPassword(password);
                user.setUsername(username);
                user.setStatus(1);
                userService.insert(user);
            }
            return ApiResult.success();
        } catch (Exception e) {
            e.printStackTrace();
            return ApiResult.failed("系统异常！请联系管理员！");
        }
    }
    /*单点退出*/
    @RequestMapping("/loginOut")
    public String loginOut(HttpServletRequest request) {
        System.out.println(request.getSession().getAttribute("user"));
        request.getSession().removeAttribute("user");
        return "login/login";
    }
}
