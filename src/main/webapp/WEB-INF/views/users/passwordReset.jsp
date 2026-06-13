<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>비밀번호 재설정</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<div class="container">

    <div class="row justify-content-center align-items-center" style="min-height: 100vh;">

        <div class="col-md-5">

            <div class="card shadow-sm">

                <div class="card-body p-4">

                    <div class="text-center mb-4">
                        <h3>비밀번호 재설정</h3>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger">
                            ${errorMessage}
                        </div>
                    </c:if>

                    <form action="/users/password/reset" method="post">
                  
                        <div class="mb-3">
                            <label class="form-label">사번</label>
                            <input type="text" name="employeeId" class="form-control" value="${passwordResetDTO.employeeId}" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">기존 비밀번호</label>
                            <input type="password"
                                   name="currentPassword"
                                   class="form-control"
                                   required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">새 비밀번호</label>
                            <input type="password" name="newPassword" class="form-control" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">새 비밀번호 확인</label>
                            <input type="password" name="confirmPassword" class="form-control" required>
                        </div>

                        <div class="d-grid gap-2">

                            <button type="submit" class="btn btn-primary">
                                비밀번호 변경
                            </button>

                            <a href="/login" class="text-end mt-3 text-decoration-none text-secondary">
                                로그인으로
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