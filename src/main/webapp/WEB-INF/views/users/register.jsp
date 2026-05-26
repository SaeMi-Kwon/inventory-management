<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <!-- 제목 -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>사용자 등록</h3>
        
        <a href="/users/list" class="btn btn-secondary">
            사용자 목록
        </a>
    </div>


    <!-- 에러 메시지 -->
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
            ${errorMessage}
        </div>
    </c:if>


    <!-- 성공 메시지 -->
    <c:if test="${param.success eq 'true'}">
        <div class="alert alert-success">
            사용자 등록이 완료되었습니다.
        </div>
    </c:if>


    <!-- 등록 폼 -->
    <form action="/users/register" method="post">

        <div class="card">

            <div class="card-body">

                <div class="row">

                    <!-- 사번 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">사번</label>
                        <input type="text" name="employeeId" class="form-control" required>
                    </div>


                    <!-- 이름 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">이름</label>
                        <input type="text"name="name" class="form-control" required>
                    </div>


                    <!-- 비밀번호 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">비밀번호</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>


                    <!-- 권한 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">권한</label>

                        <select name="authId" class="form-select" required>

                            <option value="">선택하세요</option>
                            <c:forEach var="authority" items="${authorityList}">

                                <option value="${authority.authId}">
                                        ${authority.authName}
                                </option>

                            </c:forEach>

                        </select>
                    </div>


                    <!-- 부서 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">부서</label>
                        <input type="text" name="department" class="form-control">
                    </div>


                    <!-- 생년월일 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">생년월일</label>
                        <input type="date" name="birth" class="form-control">
                    </div>


                    <!-- 연락처 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">연락처</label>
                        <input type="text" name="phone" class="form-control">
                    </div>


                    <!-- 이메일 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">이메일</label>
                        <input type="email" name="email" class="form-control">
                    </div>


                    <!-- 주소 -->
                    <div class="col-md-12 mb-3">
                        <label class="form-label">주소</label>
                        <input type="text" name="address" class="form-control">
                    </div>


                    <!-- 입사일 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">입사일</label>
                        <input type="date" name="hireDate" class="form-control">
                    </div>


                    <!-- 비고 -->
                    <div class="col-md-12 mb-3">
                        <label class="form-label">비고</label>
                        <textarea name="remark" class="form-control" rows="4"></textarea>
                    </div>

                </div>

            </div>

        </div>


        <!-- 버튼 -->
        <div class="mt-4 text-end">

            <button type="submit" class="btn btn-primary">
                등록
            </button>

            <a href="/" class="btn btn-secondary">
                취소
            </a>

        </div>

    </form>

</div>