package Dao;

import Entity.Student;
import Entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {

    void insert(User user);

    User find(User user);

    List<User> findAll(User user);

    void update(User user);

    void updateAll(List<User> users);

    List<User> findAllExcludeSessionUser(User user);

    void deleteAll(List<String> list);
}