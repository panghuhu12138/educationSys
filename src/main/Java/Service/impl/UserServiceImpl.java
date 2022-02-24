package Service.impl;

import Dao.UserMapper;
import Entity.User;
import Service.IUserService;
import Entity.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements IUserService {
    @Autowired
    private UserMapper userMapper;


    @Override
    public User find(User user) {
        return userMapper.find(user);
    }
}
