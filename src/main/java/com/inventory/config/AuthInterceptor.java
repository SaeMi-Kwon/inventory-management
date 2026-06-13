package com.inventory.config;

import com.inventory.dto.UserDTO;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class AuthInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //사용자가 요청한 주소를 가져오기
        String uri = request.getRequestURI();

        // 비로그인 허용 URL
        if (uri.equals("/login") || uri.equals("/users/password/reset")) {
            return true;
        }

        //기존 세션을 가져오기
        HttpSession session = request.getSession(false);

        // 세션이 없거나 로그인 정보가 없으면 로그인 안 된 상태
        if (session == null || session.getAttribute("loginUser") == null) {
            //로그인 페이지로 보내고 요청을 중단
            response.sendRedirect("/login");
            return false;
        }

        UserDTO loginUser = (UserDTO) session.getAttribute("loginUser");
        String authCode = loginUser.getAuthCode();

        if (uri.equals("/logout")) {
            return true;
        }


        // MANAGER는 전부 허용
        if ("MANAGER".equals(authCode)) {
            return true;
        }

        // STAFF 권한
        if ("STAFF".equals(authCode)) {

            if (uri.equals("/dashboard")) {
                return true;
            }

            // 품목 목록/상세 조회만 허용
            if (uri.equals("/items/list") || uri.startsWith("/items/detail/")) {
                return true;
            }

            // 입고 목록/상세 조회만 허용
            if (uri.equals("/inbounds/list") || uri.startsWith("/inbounds/detail/")) {
                return true;
            }

            // 출고 목록/상세 조회만 허용
            if (uri.equals("/outbounds/list") || uri.startsWith("/outbounds/detail/")) {
                return true;
            }

            // 재고 목록/이력 조회 허용
            if (uri.equals("/stocks/list") || uri.equals("/stockHistories/list")) {
                return true;
            }

            // 창고 목록 조회만 허용
            if (uri.equals("/warehouses/list")) {
                return true;
            }

            // 거래처 등록/목록/상세 허용
            if (uri.equals("/customers/register") || uri.equals("/customers/list") || uri.startsWith("/customers/detail/")) {
                return true;
            }

            response.sendRedirect("/dashboard");

            return false;
        }

        response.sendRedirect("/login");
        return false;
    }
}
