/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.model;


import java.sql.Connection;
import javax.swing.JOptionPane;

public class TesteConexao {

    public static void main(String[] args) {
        try {
            Connection conn = ConexaoBD.conectar();
            JOptionPane.showMessageDialog(null, "✅ Conexão com o banco de dados estabelecida com sucesso!");
            conn.close();
        } catch (Exception e) {
           JOptionPane.showMessageDialog(null, "❌ Erro ao conectar com o banco de dados:");
    }
    }
}