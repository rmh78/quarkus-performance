package de.harald.test.demospringboot;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@SpringBootApplication(proxyBeanMethods = false)
public class DemoSpringBootApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoSpringBootApplication.class, args);
	}

    @Autowired
    CustomerRepository repository;

	@GetMapping("/hello")
	public List<Customer> findAll() {
        return repository.findAll(); 
	}
}
