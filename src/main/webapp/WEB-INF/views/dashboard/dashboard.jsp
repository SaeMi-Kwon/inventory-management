<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <div class="mb-4">
        <h3>대시보드</h3>
    </div>

    <div class="row g-3 mb-4">

        <div class="col-md-2">
            <a href="/items/list" class="text-decoration-none text-dark">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h6>전체 품목 수</h6>
                        <h3>${dashboard.totalItemCount}</h3>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-2">
            <a href="/warehouses/list" class="text-decoration-none text-dark">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h6>전체 창고 수</h6>
                        <h3>${dashboard.totalWarehouseCount}</h3>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-2">
            <a href="/stocks/list" class="text-decoration-none text-dark">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h6>재고 부족 품목</h6>
                        <h3>${dashboard.lowStockCount}</h3>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-2">
            <a href="/inbounds/list" class="text-decoration-none text-dark">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h6>오늘 입고 건수</h6>
                        <h3>${dashboard.todayInboundCount}</h3>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-md-2">
            <a href="/outbounds/list" class="text-decoration-none text-dark">
                <div class="card text-center h-100">
                    <div class="card-body">
                        <h6>오늘 출고 건수</h6>
                        <h3>${dashboard.todayOutboundCount}</h3>
                    </div>
                </div>
            </a>
        </div>
        
    </div>

    <div class="card">
        <div class="card-body">

            <h5 class="mb-3">최근 재고이력</h5>

            <table class="table table-bordered table-hover align-middle text-center">
                <thead class="table-light">
                <tr>
                    <th>유형</th>
                    <th>품목코드</th>
                    <th>품목명</th>
                    <th>창고</th>
                    <th>변경전</th>
                    <th>변경수량</th>
                    <th>변경후</th>
                    <th>처리자</th>
                    <th>처리일시</th>
                </tr>
                </thead>

                <tbody>
                <c:if test="${empty dashboard.recentHistoryList}">
                    <tr>
                        <td colspan="9">최근 재고이력이 없습니다.</td>
                    </tr>
                </c:if>

                <c:forEach var="history" items="${dashboard.recentHistoryList}">
                    <tr>
                        <td>${history.historyType}</td>
                        <td>${history.itemCode}</td>
                        <td>${history.itemName}</td>
                        <td>${history.warehouseName}</td>
                        <td>${history.beforeQuantity}</td>

                        <td>
                            <c:choose>
                                <c:when test="${history.changeQuantity > 0}">
                                    <span class="text-primary">
                                        +${history.changeQuantity}
                                    </span>
                                </c:when>
                                <c:when test="${history.changeQuantity < 0}">
                                    <span class="text-danger">
                                        ${history.changeQuantity}
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    ${history.changeQuantity}
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>${history.afterQuantity}</td>
                        <td>${history.processUserName}</td>
                        <td>${history.createdAt}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>
    </div>

</div>