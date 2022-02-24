package Dao;

import Entity.Student;
import Entity.User;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserMapper {

    User queryById(String userId);

    User find(User user);
}