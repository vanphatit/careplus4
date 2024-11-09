package gr.careplus4.services.impl;

import gr.careplus4.entities.User;
import gr.careplus4.repositories.UserRepository;
import gr.careplus4.services.iRoleService;
import gr.careplus4.services.iUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements iUserService {
    @Autowired
    UserRepository userRepository;

    private final BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();

    public UserServiceImpl(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Autowired
    iRoleService roleService;

    
    @Override
    public boolean checkLogin(String phone, String password) {
        // Tìm kiếm người dùng bằng email
        Optional<User> optionalUser = userRepository.findByPhoneNumber(phone);

        if (optionalUser.isPresent()) {
            User user = optionalUser.get();
            boolean matches = bCryptPasswordEncoder.matches(password, user.getPassword());
            // So sánh mật khẩu đã mã hóa trong cơ sở dữ liệu với mật khẩu người dùng nhập vào
            return matches;
        }
        return false;
    }

    // Phương thức kiểm tra xem email đã tồn tại chưa
    
    @Override
    public boolean emailExists(String email) {
        return userRepository.existsByEmail(email);
    }

    // Phương thức tạo người dùng mới
    
    @Override
    public User createUser(User user) {
        user.setRole(roleService.findById(2).get());// Mặc định là người dùng
        user.setActive(true);
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        return userRepository.save(user);
    }

    @Override
    public Optional<User> findByPhoneNumber(String phoneNumber) {
        return userRepository.findByPhoneNumber(phoneNumber);
    }

    @Override
    public void delete(User entity) {
        userRepository.delete(entity);
    }

    @Override
    public <S extends User> List<S> findAll(Example<S> example) {
        return userRepository.findAll(example);
    }

    @Override
    public <S extends User> Page<S> findAll(Example<S> example, Pageable pageable) {
        return userRepository.findAll(example, pageable);
    }

    @Override
    public long count() {
        return userRepository.count();
    }

    @Override
    public <S extends User> List<S> saveAll(Iterable<S> entities) {
        return userRepository.saveAll(entities);
    }

    @Override
    public Page<User> findByUserNameContaining(String name, Pageable pageable) {
        return userRepository.findByNameContaining(name, pageable);
    }

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public <S extends User> S save(S entity) {
        return userRepository.save(entity);
    }

    @Override
    public void deleteAll() {
        userRepository.deleteAll();
    }

    @Override
    public Page<User> findAll(Pageable pageable) {
        return userRepository.findAll(pageable);
    }
}
