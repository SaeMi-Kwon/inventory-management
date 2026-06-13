<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">

    <title>로그인</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

</head>

<body class="bg-light">

<div class="container">

    <div class="row justify-content-center align-items-center" style="min-height: 100vh;">

        <div class="col-md-4">

            <div class="card shadow-sm">

                <div class="card-body p-4">

                    <!-- 제목 -->
                    <div class="text-center mb-4">
                        <h3>재고관리 시스템</h3>
                    </div>


                    <!-- 에러메시지 -->
                    <c:if test="${not empty errorMessage}">

                        <div class="alert alert-danger">
                            ${errorMessage}
                        </div>

                    </c:if>

                    <!-- 비밀번호 변경 후 -->
                    <c:if test="${param.reset == 'true'}">
                        <div class="alert alert-success">
                            비밀번호가 변경되었습니다. 새 비밀번호로 로그인해주세요.
                        </div>
                    </c:if>


                    <!-- 로그인 폼 -->
                    <form action="/login" method="post">

                        <!-- 사번 -->
                        <div class="mb-3">
                            <label class="form-label">사번</label>
                            <input type="text" name="employeeId" class="form-control" required>
                        </div>

                        <!-- 비밀번호 -->
                        <div class="mb-4">
                            <label class="form-label">비밀번호</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>


                        <!-- 버튼 -->
                        <div class="d-grid">
                            <button type="submit" class="btn btn-primary">
                                로그인
                            </button>
                        </div>

                        <div class="text-end mt-3">
                            <a href="/users/password/reset" class="text-decoration-none text-secondary">
                                비밀번호 재설정
                            </a>
                        </div>

                    </form>

                </div>

            </div>

        </div>

    </div>

</div>

</body>

</html>