<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>창고 목록</h3>

        <a href="/warehouses/register" class="btn btn-primary">
            창고 등록
        </a>
    </div>

    <form action="/warehouses/list" method="get" class="row g-2 mb-4">

        <div class="col-md-2">
            <input type="text" name="warehouseCode" class="form-control" placeholder="창고코드" value="${searchDTO.warehouseCode}">
        </div>

        <div class="col-md-3">
            <input type="text" name="warehouseName" class="form-control" placeholder="창고명" value="${searchDTO.warehouseName}">
        </div>

        <div class="col-md-2">
            <select name="useYn" class="form-select">
                <option value="">사용여부 전체</option>
                <option value="Y" ${searchDTO.useYn == 'Y' ? 'selected' : ''}>
                    사용
                </option>
                <option value="N" ${searchDTO.useYn == 'N' ? 'selected' : ''}>
                    미사용
                </option>
            </select>
        </div>

        <div class="col-auto">
            <button type="submit" class="btn btn-primary">
                검색
            </button>
        </div>

        <div class="col-auto">
            <a href="/warehouses/list" class="btn btn-secondary">
                초기화
            </a>
        </div>

    </form>

    <div class="card">
        <div class="card-body">

            <table class="table table-bordered table-hover align-middle text-center">
                <thead class="table-light">
                    <tr>
                        <th>번호</th>
                        <th>창고코드</th>
                        <th>창고명</th>
                        <th>위치</th>
                        <th>사용여부</th>
                        <th>비고</th>
                        <th>등록일시</th>
                    </tr>
                </thead>

                <tbody>
                    <c:if test="${empty warehouseList}">
                        <tr>
                            <td colspan="7">
                                등록된 창고가 없습니다.
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach var="warehouse"
                               items="${warehouseList}"
                               varStatus="status">
                        <tr style="cursor:pointer;" onclick="location.href='/warehouses/edit/${warehouse.warehouseId}'">
                            <td>${status.count}</td>
                            <td>${warehouse.warehouseCode}</td>
                            <td>${warehouse.warehouseName}</td>
                            <td>${warehouse.location}</td>
                            <td>${warehouse.useYn}</td>
                            <td>${warehouse.remark}</td>
                            <td>${warehouse.createdAt}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
    </div>

</div>