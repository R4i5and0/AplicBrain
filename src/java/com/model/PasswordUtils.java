package com.model;

import java.security.MessageDigest;
import java.util.Base64;

/**
 * Classe utilitária para criptografar senhas usando SHA-256 e padrão UTF-8.
 */
public class PasswordUtils {

    /**
     * Gera um hash de uma senha, garantindo o padrão UTF-8.
     */
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            // FORÇA O USO DE UTF-8 para consistência em qualquer sistema
            byte[] hashedBytes = md.digest(password.getBytes("UTF-8"));
            return Base64.getEncoder().encodeToString(hashedBytes);
        } catch (Exception e) {
            throw new RuntimeException("Erro ao gerar hash da senha", e);
        }
    }

    /**
     * Verifica se uma senha corresponde a um hash.
     */
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        // Se a senha ou o hash forem nulos, a verificação falha.
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        String hashDaSenhaDigitada = hashPassword(plainPassword);
        return hashDaSenhaDigitada.equals(hashedPassword);
    }
}
