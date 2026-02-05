/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;

import java.util.Scanner;

/**
 *
 * @author qp
 */
public class Util {

    static Scanner sc = new Scanner(System.in);

   
      public static String generatePurchaseOrderId(int currentListSize) {
        //currentListSize la so luong NCC dang co
        return String.format("PO%04d", currentListSize + 1);
        //PO0001,...
    }
      
    

}
