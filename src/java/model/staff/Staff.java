/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.staff;

/**
 *
 * @author yq
 */
public class Staff {
  private String staffId;        // 私有字段
    private String staffPassword;  // 私有字段

    // Getter 方法
    public String getStaffId() {
        return staffId;
    }

    // Setter 方法
    public void setStaffId(String staffId) {
        this.staffId = staffId;
    }

    // Getter 方法
    public String getStaffPassword() {
        return staffPassword;
    }

    // Setter 方法
    public void setStaffPassword(String staffPassword) {
        this.staffPassword = staffPassword;
    }
}