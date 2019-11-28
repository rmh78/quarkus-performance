package de.harald.test.demo;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;

@Entity
@NamedQuery(name = Customer.FIND_ALL_CUSTOMERS, query = "select c from Customer c")
public class Customer {
    public static final String FIND_ALL_CUSTOMERS = "Customer.FIND_ALL_CUSTOMERS";

    public Customer() {}
    public Customer(long id, String name, int age) {
        this.id = id;
        this.name = name;
        this.age = age;
    }

    @Id
    public long id;
    public String name;
    public int age;
}