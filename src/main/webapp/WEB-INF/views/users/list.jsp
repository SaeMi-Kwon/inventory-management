<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <!-- 제목 영역 -->
    <div class="d-flex justify-content-between align-items-center mb-4">

        <h3>사용자 목록</h3>

        <a href="/users/register" class="btn btn-primary">
            사용자 등록
        </a>

    </div>


    <!-- 검색 영역 -->
    <form action="/users/list" method="get" class="row g-2 mb-4">

        <!-- 이름 검색 -->
        <div class="col-md-3">

            <input type="text" name="name" class="form-control" placeholder="이름 검색" value="${searchDTO.name}">

        </div>


        <!-- 권한 검색 -->
        <div class="col-md-2">

            <select name="authId" class="form-select">

                <option value="">
                    권한 전체
                </option>

                <c:forEach var="authority" items="${authorityList}">

                    <option value="${authority.authId}" ${searchDTO.authId == authority.authId ? 'selected' : ''}>
                            ${authority.authName}
                    </option>

                </c:forEach>

            </select>

        </div>


        <!-- 상태 검색 -->
        <div class="col-md-2">

            <select name="status" class="form-select">

                <option value="">
                    상태 전체
                </option>

                <option value="WORKING" ${searchDTO.status == 'WORKING' ? 'selected' : ''}>
                    재직
                </option>

                <option value="RETIRE" ${searchDTO.status == 'RETIRE' ? 'selected' : ''}>
                    퇴사
                </option>

            </select>

        </div>


        <!-- 사용여부 검색 -->
        <div class="col-md-2">

            <select name="useYn" class="form-select">

                <option value="">
                    사용여부 전체
                </option>

                <option value="Y" ${searchDTO.useYn == 'Y' ? 'selected' : ''}>
                    사용
                </option>

                <option value="N" ${searchDTO.useYn == 'N' ? 'selected' : ''}>
                    미사용
                </option>

            </select>

        </div>


        <!-- 검색 버튼 -->
        <div class="col-md-1">

            <button type="submit" class="btn btn-primary w-100">
                검색
            </button>

        </div>


        <!-- 초기화 버튼 -->
        <div class="col-md-1">

            <a href="/users/list" class="btn btn-secondary w-100">
                초기화
            </a>

        </div>

    </form>


    <!-- 목록 테이블 -->
    <div class="card">

        <div class="card-body">

            <table class="table table-bordered table-hover align-middle text-center">

                <thead class="table-light">

                    <tr>

                        <th>번호</th>
                        <th>사번</th>
                        <th>이름</th>
                        <th>권한</th>
                        <th>부서</th>
                        <th>연락처</th>
                        <th>이메일</th>
                        <th>상태</th>
                        <th>사용여부</th>
                        <th>등록일시</th>

                    </tr>

                </thead>


                <tbody>

                    <!-- 데이터 없을 때 -->
                    <c:if test="${empty userList}">

                        <tr>

                            <td colspan="10">
                                등록된 사용자가 없습니다.
                            </td>

                        </tr>

                    </c:if>


                    <!-- 데이터 있을 때 -->
                    <c:forEach var="user" items="${userList}" varStatus="status">

                        <tr style="cursor:pointer;" onclick="location.href='/users/detail/${user.userId}'">

                            <td>${status.count}</td>
                            <td>${user.employeeId}</td>
                            <td>${user.name}</td>
                            <td>${user.authName}</td>
                            <td>${user.department}</td>
                            <td>${user.phone}</td>
                            <td>${user.email}</td>
                            <td>${user.status}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${user.useYn == 'Y'}">
                                        사용
                                    </c:when>

                                    <c:otherwise>
                                        미사용
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>${user.createdAt}</td>

                        </tr>

                    </c:forEach>

                </tbody>

            </table>

        </div>

    </div>

</div>