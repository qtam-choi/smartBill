package test;
import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;

public class Encryptor {

    public static void main(String[] args) {

     
        StandardPBEStringEncryptor pbeEnc = new StandardPBEStringEncryptor();
        
        pbeEnc.setAlgorithm("PBEWITHMD5ANDDES");
        pbeEnc.setPassword("test");
 
        String password = pbeEnc.encrypt("db 패드워드");
        
        System.out.println("password=" + password);
    }

}
