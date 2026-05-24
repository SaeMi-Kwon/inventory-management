<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <!-- 제목 영역 -->
    <div class="d-flex justify-content-between align-items-center mb-4">

        <h3>사용자 수정</h3>

        <div>
            <a href="/users/detail/${user.userId}" class="btn btn-secondary">
                상세보기
            </a>

            <a href="/users/list" class="btn btn-dark">
                목록
            </a>
        </div>

    </div>


    <!-- 수정 폼 -->
    <form action="/users/edit/${user.userId}" method="post">

        <div class="card">

            <div class="card-body">

                <div class="row">

                    <div class="col-md-6 mb-3">
                        <label class="form-label">사번</label>
                        <input type="text" class="form-control" value="${user.employeeId}" readonly>
                    </div>


                    <div class="col-md-6 mb-3">
                        <label class="form-label">이름</label>
                        <input type="text" name="name" class="form-control" value="${user.name}" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">권한</label>
                        <select name="authId" class="form-select" required>
                            <c:forEach var="authority" items="${authorityList}">
                                <option value="${authority.authId}" ${user.authId == authority.authId ? 'selected' : ''}>
                                        ${authority.authName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">부서</label>
                        <input type="text" name="department" class="form-control" value="${user.department}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">생년월일</label>
                        <input type="date" name="birth" class="form-control" value="${user.birth}" readonly>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">연락처</label>
                        <input type="text" name="phone" class="form-control" value="${user.phone}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">이메일</label>
                        <input type="email" name="email" class="form-control" value="${user.email}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">주소</label>
                        <input type="text" name="address" class="form-control" value="${user.address}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">입사일</label>
                        <input type="date" name="hireDate" class="form-control"value="${user.hireDate}" readonly>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">퇴사일</label>
                        <input type="date" name="retireDate" class="form-control" value="${user.retireDate}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">상태</label>
                        <select name="status" class="form-select">
                            <option value="WORKING" ${user.status == 'WORKING' ? 'selected' : ''}>
                                재직
                            </option>
                            <option value="RETIRE" ${user.status == 'RETIRE' ? 'selected' : ''}>
                                퇴사
                            </option>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">사용여부</label>
                        <select name="useYn" class="form-select">
                            <option value="Y" ${user.useYn == 'Y' ? 'selected' : ''}>
                                사용
                            </option>
                            <option value="N" ${user.useYn == 'N' ? 'selected' : ''}>
                                미사용
                            </option>
                        </select>
                    </div>

                    <div class="col-md-12 mb-3">
                        <label class="form-label">비고</label>
                        <textarea name="remark" class="form-control" rows="4">${user.remark}</textarea>
                    </div>

                </div>

            </div>

        </div>


        <div class="mt-4 text-end">

            <button type="submit" class="btn btn-primary">
                수정
            </button>

            <a href="/users/detail/${user.userId}" class="btn btn-secondary">
                취소
            </a>

        </div>

    </form>

</div>