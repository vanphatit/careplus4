package gr.careplus4.services;

import jakarta.servlet.http.HttpSession;

public interface IBillService {
    void handlePlaceOrder(HttpSession session, String receiverName,String receiverAddress, String receiverPhone, int usedPoint, String eventCode, boolean accumulate);
}
