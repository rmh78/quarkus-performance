package de.harald.test.demospringboot;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

public interface CustomerRepository extends CrudRepository<Customer, Long> {
    List<Customer> findAll();
    Customer findById(long id);
}