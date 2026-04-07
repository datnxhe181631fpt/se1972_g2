package entity;

import java.time.LocalDateTime;

public class CustomerAccount {
    private String customerID;
    private String password;
    private LocalDateTime lastLogin;

    public CustomerAccount() {
    }

    public CustomerAccount(String customerID, String password, LocalDateTime lastLogin) {
        this.customerID = customerID;
        this.password = password;
        this.lastLogin = lastLogin;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public LocalDateTime getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(LocalDateTime lastLogin) {
        this.lastLogin = lastLogin;
    }
}
