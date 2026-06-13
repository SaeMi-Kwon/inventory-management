<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>재고관리 시스템</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 앞에 breadcrumb-item 형제가 하나 있는 breadcrumb-item */
        .breadcrumb-item + .breadcrumb-item::before {
            content: "›";
            padding: 0 8px;
        }
    </style>
</head>

<body>

<div class="d-flex">

    <!-- Sidebar -->
    <div class="bg-dark text-white p-3" style="width: 240px; min-height: 100vh;">
        <h4 class="mb-4"><a href="/dashboard" class="text-decoration-none text-white">재고관리</a></h4>

        <ul class="nav flex-column">

            <!-- 대시보드 -->
            <li class="nav-item">
                <a href="/dashboard" class="nav-link text-white">대시보드</a>
            </li>

            <!-- 품목관리 -->
            <li class="nav-item">
                <button class="nav-link text-white" data-bs-toggle="collapse" href="#itemMenu">품목관리</button>

                <div class="collapse" id="itemMenu">
                    <ul class="nav flex-column ms-3">
                        <li class="nav-item">
                             <a href="${sessionScope.loginUser.authCode == 'MANAGER' ? '/items/register' : '#'}"
                                   class="nav-link text-white ${sessionScope.loginUser.authCode == 'STAFF' ? 'disabled opacity-50' : ''}"
                                ${sessionScope.loginUser.authCode == 'STAFF' ? 'aria-disabled="true" tabindex="-1"' : ''}>
                                품목등록
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="/items/list" class="nav-link text-white">품목목록</a>
                        </li>
                    </ul>
                </div>
            </li>

            <!-- 재고관리 -->
            <li class="nav-item">
                <a class="nav-link text-white" data-bs-toggle="collapse" href="#stockMenu" role="button">
                    재고관리
                </a>

                <div class="collapse" id="stockMenu">
                    <ul class="nav flex-column ms-3">
                        <!-- <li class="nav-item">
                            <a href="/stocks/register" class="nav-link text-white">재고등록</a>
                        </li> -->
                        <li class="nav-item">
                            <a href="/stocks/list" class="nav-link text-white">재고목록</a>
                        </li>
                        <li class="nav-item">
                            <a href="/stockHistories/list" class="nav-link text-white">재고이력조회</a>
                        </li>
                    </ul>
                </div>
            </li>

            <!-- 입고관리 -->
            <li class="nav-item">
                <a class="nav-link text-white" data-bs-toggle="collapse" href="#inboundMenu" role="button">
                    입고관리
                </a>

                <div class="collapse" id="inboundMenu">
                    <ul class="nav flex-column ms-3">
                        <li class="nav-item">
                            <a href="${sessionScope.loginUser.authCode == 'MANAGER' ? '/inbounds/register' : '#'}"
                                   class="nav-link text-white ${sessionScope.loginUser.authCode == 'STAFF' ? 'disabled opacity-50' : ''}"
                                ${sessionScope.loginUser.authCode == 'STAFF' ? 'aria-disabled="true" tabindex="-1"' : ''}>
                                입고등록
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="/inbounds/list" class="nav-link text-white">입고목록</a>
                        </li>
                    </ul>
                </div>
            </li>

            <!-- 출고관리 -->
            <li class="nav-item">
                <a class="nav-link text-white" data-bs-toggle="collapse" href="#outboundMenu" role="button">
                    출고관리
                </a>

                <div class="collapse" id="outboundMenu">
                    <ul class="nav flex-column ms-3">
                        <li class="nav-item">
                            <a href="${sessionScope.loginUser.authCode == 'MANAGER' ? '/outbounds/register' : '#'}"
                                   class="nav-link text-white ${sessionScope.loginUser.authCode == 'STAFF' ? 'disabled opacity-50' : ''}"
                                ${sessionScope.loginUser.authCode == 'STAFF' ? 'aria-disabled="true" tabindex="-1"' : ''}>
                                출고등록
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="/outbounds/list" class="nav-link text-white">출고목록</a>
                        </li>
                    </ul>
                </div>
            </li>

            <!-- 창고관리 -->
            <li class="nav-item">
                <a class="nav-link text-white" data-bs-toggle="collapse" href="#warehouseMenu" role="button">
                    창고관리
                </a>

                <div class="collapse" id="warehouseMenu">
                    <ul class="nav flex-column ms-3">
                        <li class="nav-item">
                            <a href="${sessionScope.loginUser.authCode == 'MANAGER' ? '/warehouses/register' : '#'}"
                                   class="nav-link text-white ${sessionScope.loginUser.authCode == 'STAFF' ? 'disabled opacity-50' : ''}"
                                ${sessionScope.loginUser.authCode == 'STAFF' ? 'aria-disabled="true" tabindex="-1"' : ''}>
                                창고등록
                            </a>
                        </li>
                        <li class="nav-item">
                            <a href="/warehouses/list" class="nav-link text-white">창고목록</a>
                        </li>
                    </ul>
                </div>
            </li>

            <!-- 거래처관리 -->
            <li class="nav-item">
                <a class="nav-link text-white" data-bs-toggle="collapse" href="#customerMenu" role="button">
                    거래처관리
                </a>

                <div class="collapse" id="customerMenu">
                    <ul class="nav flex-column ms-3">
                        <li class="nav-item">
                            <a href="/customers/register" class="nav-link text-white">거래처등록</a>
                        </li>
                        <li class="nav-item">
                            <a href="/customers/list" class="nav-link text-white">거래처목록</a>
                        </li>
                    </ul>
                </div>
            </li>

            <!-- 사용자관리 -->
            <c:if test="${sessionScope.loginUser.authCode == 'MANAGER'}">
            <li class="nav-item">
                <a class="nav-link text-white" data-bs-toggle="collapse" href="#userMenu" role="button">
                    사용자관리
                </a>

                <div class="collapse" id="userMenu">
                    <ul class="nav flex-column ms-3">
                        <li class="nav-item">
                            <a href="/users/register" class="nav-link text-white">사용자등록</a>
                        </li>
                        <li class="nav-item">
                            <a href="/users/list" class="nav-link text-white">사용자목록</a>
                        </li>
                    </ul>
                </div>
            </li>
            </c:if>

        </ul>
    </div>

    <!-- Main -->
    <div class="flex-grow-1">

        <!-- Header -->
        <div class="border-bottom p-3 d-flex justify-content-between align-items-center">

            <nav aria-label="breadcrumb">
                <ol class="breadcrumb mb-0">

                    <li class="breadcrumb-item">
                        <a href="/dashboard" class="text-decoration-none">
                            홈
                        </a>
                    </li>

                    <c:if test="${not empty menuName}">
                        <li class="breadcrumb-item">
                            ${menuName}
                        </li>
                    </c:if>

                    <c:if test="${not empty pageName}">
                        <li class="breadcrumb-item active" aria-current="page">
                            ${pageName}
                        </li>
                    </c:if>

                </ol>
            </nav>

            <div class="d-flex align-items-center">

            <span class="me-3">
                ${sessionScope.loginUser.name} 님
            </span>

            <a href="/logout" class="btn btn-outline-danger btn-sm">
                로그아웃
            </a>

        </div>

    </div>

        <!-- Content -->
        <div class="p-4">
            <jsp:include page="${contentPage}" />
        </div>

    </div>
</div>

<!-- Bootstrap JS: Collapse 메뉴 작동용 -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>