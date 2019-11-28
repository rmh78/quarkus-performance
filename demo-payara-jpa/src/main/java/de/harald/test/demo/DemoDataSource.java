package de.harald.test.demo;

import javax.annotation.sql.DataSourceDefinition;

@DataSourceDefinition(
    databaseName = "testdb",
    name = "java:global/jdbc/demo",
    className = "org.postgresql.ds.PGSimpleDataSource",
    portNumber = 5432,
    serverName = "testdb",
    user = "test",
    password = "test")
public class DemoDataSource {

}
