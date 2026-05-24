<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <!-- 제목 -->
    <div class="d-flex justify-content-between align-items-center mb-4">

        <h3>창고 등록</h3>

        <a href="/warehouses/list" class="btn btn-secondary">
            창고 목록
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
            창고 등록이 완료되었습니다.
        </div>
    </c:if>


    <!-- 등록 폼 -->
    <form action="/warehouses/register" method="post">

        <div class="card">

            <div class="card-body">

                <div class="row">

                    <!-- 창고코드 -->
                    <div class="col-md-12 mb-3">
                        <label class="form-label">창고코드</label>
                        <input type="text" name="warehouseCode" class="form-control" value="${warehouse.warehouseCode}" required>
                    </div>

                    <!-- 창고명 -->
                    <div class="col-md-12 mb-3">
                        <label class="form-label">창고명</label>
                        <input type="text" name="warehouseName" class="form-control" value="${warehouse.warehouseName}" required>
                    </div>

                    <!-- 위치 -->
                    <div class="col-md-12 mb-3">
                        <label class="form-label">위치</label>
                        <input type="text" name="location" class="form-control" value="${warehouse.location}">
                    </div>

                    <!-- 비고 -->
                    <div class="col-md-12 mb-3">
                        <label class="form-label">비고</label>
                        <textarea name="remark" class="form-control" rows="4">${warehouse.remark}</textarea>
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