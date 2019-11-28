package de.harald.test.demo;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("/hello")
public class CustomerResource {

	@PersistenceContext(name = "demo")
	EntityManager em;

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Customer> findAll() {
        return em.createNamedQuery(Customer.FIND_ALL_CUSTOMERS, Customer.class).getResultList();
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/{id}")
    public Customer findById(@PathParam("id") Long id) {
        return em.find(Customer.class, id);
    }
    
}