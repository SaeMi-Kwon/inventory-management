<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>사용자 상세보기</h3>

        <div class="d-flex gap-2">
            <a href="/users/edit/${user.userId}" class="btn btn-primary">
                수정
            </a>

            <!-- 비밀번호 초기화 -->
            <form action="/users/resetPassword/${user.userId}" method="post" style="display:inline;">

                <button type="submit" class="btn btn-warning" onclick="return confirm('비밀번호를 0000으로 초기화하시겠습니까?');">
                    비밀번호 초기화
                </button>
            </form>

            <a href="/users/list" class="btn btn-secondary">
                목록
            </a>
        </div>
    </div>

    <div class="card">
        <div class="card-body">

            <table class="table table-bordered align-middle">
                <tr>
                    <th style="width:180px;">사번</th>
                    <td>${user.employeeId}</td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td>${user.name}</td>
                </tr>
                <tr>
                    <th>권한</th>
                    <td>${user.authName}</td>
                </tr>
                <tr>
                    <th>부서</th>
                    <td>${user.department}</td>
                </tr>
                <tr>
                    <th>생년월일</th>
                    <td>${user.birth}</td>
                </tr>
                <tr>
                    <th>연락처</th>
                    <td>${user.phone}</td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td>${user.email}</td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td>${user.address}</td>
                </tr>
                <tr>
                    <th>입사일</th>
                    <td>${user.hireDate}</td>
                </tr>
                <tr>
                    <th>퇴사일</th>
                    <td>${user.retireDate}</td>
                </tr>
                <tr>
                    <th>상태</th>
                    <td>${user.status}</td>
                </tr>
                <tr>
                    <th>사용여부</th>
                    <td>${user.useYn}</td>
                </tr>
                <tr>
                    <th>비고</th>
                    <td>${user.remark}</td>
                </tr>
                <tr>
                    <th>등록일시</th>
                    <td>${user.createdAt}</td>
                </tr>
                <tr>
                    <th>수정일시</th>
                    <td>${user.updatedAt}</td>
                </tr>
            </table>

        </div>
    </div>

</div>