package com.example.Loc.Responsitory;

import com.example.Loc.Modal.Account;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface AccountRepository extends JpaRepository<Account,Long> {
    Optional<Account> findByEmail(String email);
    Optional<Account> findByEmailAndPassword(String email,String password);
    Optional<Account> findByUnameAndPassword(String Uname,String password);
}
