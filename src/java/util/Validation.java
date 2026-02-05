/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

/**
 *
 * @author qp
 */
public class Validation {

    private List<String> errors;
    private static final String PHONE_PATTERN = "^[0-9]{10,11}$";
    private static final String TAXID_PATTERN = "^\\d{10}(-\\d{3})?$";
    private static final String WEBSITE_PATTERN = "^(https?:\\/\\/)?(www\\.)?[a-zA-Z0-9-]+(\\.[a-zA-Z]{2,})+$";
    private static final String EMAIL_PATTERN = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$";
    // Giải thích:
    // ^(https?:\/\/)? : Có thể có http:// hoặc https:// hoặc không
    // (www\.)?        : Có thể có www. hoặc không
    // [a-zA-Z0-9-]+   : Tên miền (chữ, số, gạch ngang)
    // (\.[a-zA-Z]{2,})+: Đuôi tên miền (.com, .vn, .com.vn...)      

    // Giải thích MST Việt Nam:
    // Dạng 1 (Doanh nghiệp): 10 chữ số (VD: 0101234567)
    // Dạng 2 (Chi nhánh): 10 số + gạch ngang + 3 số (VD: 0101234567-001)   
    public Validation() {
        errors = new ArrayList<>();
    }

    //minLength
    public Validation minLength(String fieldName, String value, int minLength) {
        if (value == null || value.trim().length() < minLength) {
            errors.add(fieldName + " phải có ít nhất " + minLength + " ký tự.");
        }
        return this;
    }

    //maxLength
    public Validation maxLength(String fieldName, String value, int maxLength) {
        if (value == null || value.trim().length() > maxLength) {
            errors.add(fieldName + " không được vượt quá " + maxLength + " ký tự.");
        }
        return this;
    }

    //required field
    public Validation required(String fieldName, String value) {
        if (value == null || value.trim().isEmpty()) {
            errors.add(fieldName + " không được để trống.");
        }
        return this;//method chaining 
    }

    //cho phep null
    private void validatePattern(String fieldName, String value, String pattern, String errorMsg) {
        if (value != null && !value.trim().isEmpty()) {
            if (!Pattern.matches(pattern, value)) {
                errors.add(fieldName + " " + errorMsg);
            }
        }
    }

    public Validation email(String fieldName, String value) {
        validatePattern(fieldName, value, EMAIL_PATTERN, "không đúng định dạng.");
        return this;
    }

    //phone
    public Validation phone(String fieldName, String value) {
        validatePattern(fieldName, value, PHONE_PATTERN, "không đúng định dạng (phải bắt đầu bằng 0 và có 10-11 số).");
        return this;
    }

    //website
    public Validation website(String fieldName, String value) {
        validatePattern(fieldName, value, WEBSITE_PATTERN, "không đúng định dạng (VD: nxbkimdong.com.vn).");
        return this;
    }

    //taxId;
    public Validation taxID(String fieldName, String value) {
        validatePattern(fieldName, value, TAXID_PATTERN, "không đúng định dạng (10 số hoặc 10 số kèm chi nhánh -001).");
        return this;
    }

    public boolean isValid() {
        return errors.isEmpty();
    }

    public String getFirstError() {
        return errors.isEmpty() ? "" : errors.get(0);
    }

    public List<String> getErrors() {
        return errors;
    }
}
