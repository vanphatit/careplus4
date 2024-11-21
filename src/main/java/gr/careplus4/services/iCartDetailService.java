package gr.careplus4.services;

import jakarta.servlet.http.HttpSession;

public interface iCartDetailService {
    void handleRemoveCartDetail(long cartDetailId, HttpSession session);
}
