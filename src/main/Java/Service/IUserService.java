package Service;

import Entity.Student;
import Entity.User;

import java.util.List;

public interface IUserService {

    User find(User user);

    void insert(User user);

    List<User> findAll(User user);

    void update(User user);

    void updateAll(List<User> users);

    List<User> findAllExcludeSessionUser(User user);

    void deleteAll(List<String> list);
}
