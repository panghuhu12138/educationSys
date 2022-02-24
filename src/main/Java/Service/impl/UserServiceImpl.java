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

    @Override
    public void insert(User user) {
        userMapper.insert(user);
    }

    @Override
    public List<User> findAll(User user) {
        return userMapper.findAll(user);
    }

    @Override
    public void update(User user) {
        userMapper.update(user);
    }

    @Override
    public void updateAll(List<User> users) {
        userMapper.updateAll(users);
    }

    @Override
    public List<User> findAllExcludeSessionUser(User user) {
        return userMapper.findAllExcludeSessionUser(user);
    }

    @Override
    public void deleteAll(List<String> list) {
        userMapper.deleteAll(list);
    }
}
