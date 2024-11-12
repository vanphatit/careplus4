package gr.careplus4.services;

import org.springframework.stereotype.Service;

import static java.lang.Math.pow;

@Service
public class GeneratedId {
    public String getGeneratedId(String lastId) {
        StringBuilder generatedId = new StringBuilder();
        String prefix =  lastId.trim().substring(0, 1).toUpperCase();
        String currentId = lastId.trim().substring(1, lastId.length());
        long numbers = 0;
        for (int i = 0; i < currentId.length(); i++) {
            char c = currentId.charAt(i);
            long number = c - '0';
            if (number >= 0 && number <= 9) {
                numbers += (long) (number * pow(10, currentId.length() - i - 1));
            }
        }
        numbers++;
        generatedId = new StringBuilder(String.valueOf(numbers));
        for (int i = 0; i <= currentId.length() - generatedId.length() + 1; i++) {
            generatedId.insert(0, '0');
        }
        generatedId.insert(0, prefix);
        
        return String.valueOf(generatedId);
    }

    public static void main(String[] args) {
        System.out.println(new GeneratedId().getGeneratedId("C000103"));
    }
}
