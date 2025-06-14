
package com.model;

/**
 *
 * @author Raissa
 */
import java.sql.Connection;
import java.sql.DriverManager;

public class ConexaoBD {

    private static final String URL = "jdbc:mysql://localhost:3306/brain";
    private static final String USUARIO = "root";
    private static final String SENHA = ""; 

    public static Connection conectar() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USUARIO, SENHA);
    }
}
