package Controllers;

import Entity.Student;
import Service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private IUserService service;

    //首页
    @RequestMapping("/index")
    public String index(){
        return "first";
    }
}
