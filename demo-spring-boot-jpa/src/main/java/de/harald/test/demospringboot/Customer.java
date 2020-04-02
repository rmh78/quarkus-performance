package de.harald.test.demospringboot;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Customer {
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