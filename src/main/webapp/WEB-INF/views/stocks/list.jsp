<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <!-- 제목 -->
    <div class="d-flex justify-content-between align-items-center mb-4">

        <h3>현재고 목록</h3>

        <a href="/stocks/register" class="btn btn-primary">
            현재고 등록
        </a>

    </div>


    <!-- 검색 -->
    <form action="/stocks/list" method="get" class="card card-body mb-4">

        <div class="row g-3">

            <!-- 품목코드 -->
            <div class="col-md-2">
                <label class="form-label">품목코드</label>
                <input type="text" name="itemCode" class="form-control" value="${searchDTO.itemCode}">
            </div>

            <!-- 품목명 -->
            <div class="col-md-2">
                <label class="form-label">품목명</label>
                <input type="text" name="itemName" class="form-control" value="${searchDTO.itemName}">
            </div>

            <!-- 창고명 -->
            <div class="col-md-2">
                <label class="form-label">창고명</label>
                <input type="text" name="warehouseName" class="form-control" value="${searchDTO.warehouseName}">
            </div>

            <!-- 재고상태 -->
            <div class="col-md-2">
                <label class="form-label">재고상태</label>
                <select name="stockStatus" class="form-select">
                    <option value="">
                        전체
                    </option>
                    <option value="NORMAL" ${searchDTO.stockStatus == 'NORMAL' ? 'selected' : ''}>
                        정상
                    </option>
                    <option value="LOW" ${searchDTO.stockStatus == 'LOW' ? 'selected' : ''}>
                        부족
                    </option>
                    <option value="SOLD_OUT" ${searchDTO.stockStatus == 'SOLD_OUT' ? 'selected' : ''}>
                        품절
                    </option>
                </select>
            </div>


            <!-- 버튼 -->
            <div class="col-md-4 d-flex align-items-end">

                <button type="submit" class="btn btn-primary me-2">
                    검색
                </button>
                <a href="/stocks/list"class="btn btn-secondary">
                    초기화
                </a>

            </div>

        </div>

    </form>


    <!-- 목록 -->
    <div class="card">

        <div class="card-body">

            <div class="table-responsive">

                <table class="table table-bordered table-hover align-middle text-center">

                    <thead class="table-light">

                    <tr>

                        <th>품목코드</th>
                        <th>품목명</th>
                        <th>창고</th>
                        <th>현재재고</th>
                        <th>안전재고</th>
                        <th>상태</th>

                    </tr>

                    </thead>

                    <tbody>

                    <!-- 데이터 없을 때 -->
                    <c:if test="${empty stockList}">

                        <tr>
                            <td colspan="6">
                                등록된 현재고가 없습니다.
                            </td>
                        </tr>

                    </c:if>


                    <!-- 데이터 있을 때 -->
                    <c:forEach var="stock" items="${stockList}">

                        <tr>

                            <td>${stock.itemCode}</td>
                            <td>${stock.itemName}</td>
                            <td>${stock.warehouseName}</td>
                            <td>${stock.quantity}</td>
                            <td>${stock.safetyStock}</td>

                            <td>
                                <c:choose>                            
                                    <c:when test="${stock.quantity == 0}">
                                        <span class="badge bg-dark">
                                            품절
                                        </span>
                                    </c:when>
        
                                    <c:when test="${stock.quantity <= stock.safetyStock}">
                                        <span class="badge bg-danger">
                                            부족
                                        </span>
                                    </c:when>

                                    <c:otherwise>
                                        <span class="badge bg-success">
                                            정상
                                        </span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                        </tr>

                    </c:forEach>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>