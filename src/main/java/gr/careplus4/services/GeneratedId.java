package gr.careplus4.services;

import org.springframework.stereotype.Service;

import static java.lang.Math.pow;

@Service
public class GeneratedId {
    public static final int ID_LENGTH = 6; // Độ dài cố định của phần số

    public static String getGeneratedId(String previousID) {
        for (int i = 0; i < previousID.length(); i++) {
            if (Character.isDigit(previousID.charAt(i))) { // Tìm phần số đầu tiên
                String prefix = previousID.substring(0, i);
                String suffix = previousID.substring(i);

                // Tăng giá trị phần số
                int number = Integer.parseInt(suffix);
                number++;

                // Đảm bảo độ dài phần số
                String newSuffix = String.format("%0" + suffix.length() + "d", number);

                return prefix + newSuffix;
            }
        }

        throw new IllegalArgumentException("ID không chứa phần số để tăng giá trị");
    }

    public static void main(String[] args) {
        System.out.println(new GeneratedId().getGeneratedId("C000103"));
    }
}
