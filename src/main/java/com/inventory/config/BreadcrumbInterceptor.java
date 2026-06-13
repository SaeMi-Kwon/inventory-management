package com.inventory.config;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class BreadcrumbInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String uri = request.getRequestURI();

        String menuName = "";
        String pageName = "";

        if (uri.startsWith("/dashboard")) {
            menuName = "대시보드";
        }

        else if (uri.startsWith("/items")) {
            menuName = "품목관리";
            pageName = getPageName(uri, "품목");
        }

        else if (uri.startsWith("/stocks")) {
            menuName = "재고관리";
            pageName = getPageName(uri, "재고");
        }

        else if (uri.startsWith("/stockHistories")) {
            menuName = "재고관리";
            pageName = "재고이력조회";
        }

        else if (uri.startsWith("/inbounds")) {
            menuName = "입고관리";
            pageName = getPageName(uri, "입고");
        }

        else if (uri.startsWith("/outbounds")) {
            menuName = "출고관리";
            pageName = getPageName(uri, "출고");
        }

        else if (uri.startsWith("/warehouses")) {
            menuName = "창고관리";
            pageName = getPageName(uri, "창고");
        }

        else if (uri.startsWith("/customers")) {
            menuName = "거래처관리";
            pageName = getPageName(uri, "거래처");
        }

        else if (uri.startsWith("/users")) {
            menuName = "사용자관리";
            pageName = getPageName(uri, "사용자");
        }

        request.setAttribute("menuName", menuName);
        request.setAttribute("pageName", pageName);

        return true;
    }

    private String getPageName(String uri, String name) {

        if (uri.contains("/register")) {
            return name + "등록";
        }

        if (uri.contains("/list")) {
            return name + "목록";
        }

        if (uri.contains("/detail")) {
            return name + "상세";
        }

        if (uri.contains("/edit")) {
            return name + "수정";
        }

        return "";
    }
}
