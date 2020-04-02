package de.harald.test.demospringboot;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class CustomerResource {

    @Autowired
    CustomerRepository repository;

	@GetMapping("/hello")
	public List<Customer> findAll() {
        return repository.findAll(); 
	}
}