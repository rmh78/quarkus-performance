package de.harald.test.demo;

import javax.annotation.sql.DataSourceDefinition;

@DataSourceDefinition(
    databaseName = "postgres",
    name = "java:global/jdbc/demo",
    className = "org.postgresql.ds.PGSimpleDataSource",
    portNumber = 5432,
    serverName = "testdb",
    user = "postgres",
    password = "postgres")
public class DemoDataSource {

}
