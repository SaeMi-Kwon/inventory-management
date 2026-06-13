<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<div class="container-fluid">

    <div class="mb-4">
        <h3>대시보드</h3>
    </div>

    <!-- 요약 카드 -->
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

        <div class="col-md-2">
            <div class="card text-center h-100">
                <div class="card-body">
                    <h6>이번달 매출액</h6>
                    <h3><fmt:formatNumber value="${dashboard.thisMonthSalesAmount}" pattern="#,###"/>원</h3>
                </div>
            </div>
        </div>

    </div>

    <!-- 월별 차트 -->
    <c:if test="${sessionScope.loginUser.authCode == 'MANAGER'}">
    <div class="row g-3 mb-4">

        <div class="col-6">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="mb-3">올해 월별 입고/출고 건수</h5>
                    <canvas id="inOutChart"></canvas>
                </div>
            </div>
        </div>

        <div class="col-6">
            <div class="card h-100">
                <div class="card-body">
                    <h5 class="mb-3">올해 월별 매출액</h5>
                    <canvas id="salesChart"></canvas>
                </div>
            </div>
        </div>

    </div>
    </c:if>

    <!-- TOP5 -->
    <div class="row g-3 mb-4">

        <div class="${sessionScope.loginUser.authCode == 'MANAGER' ? 'col-4' : 'col-6'}">
            <div class="card h-100">
                <div class="card-body">

                    <h5 class="mb-3">재고 수량 TOP5</h5>

                    <table class="table table-bordered table-hover align-middle text-center">
                        <thead class="table-light">
                        <tr>
                            <th>품목코드</th>
                            <th>품목명</th>
                            <th>창고</th>
                            <th>현재고</th>
                            <th>안전재고</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:if test="${empty dashboard.stockQuantityTopList}">
                            <tr>
                                <td colspan="5">재고 데이터가 없습니다.</td>
                            </tr>
                        </c:if>

                        <c:forEach var="stock" items="${dashboard.stockQuantityTopList}">
                            <tr onclick="location.href='/stocks/list'" style="cursor:pointer;">
                                <td>${stock.itemCode}</td>
                                <td>${stock.itemName}</td>
                                <td>${stock.warehouseName}</td>
                                <td class="text-primary fw-bold">${stock.quantity}</td>
                                <td>${stock.safetyStock}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>

        <div class="${sessionScope.loginUser.authCode == 'MANAGER' ? 'col-4' : 'col-6'}">
            <div class="card h-100">
                <div class="card-body">

                    <h5 class="mb-3">재고 부족 TOP5</h5>

                    <table class="table table-bordered table-hover align-middle text-center">
                        <thead class="table-light">
                        <tr>
                            <th>품목코드</th>
                            <th>품목명</th>
                            <th>창고</th>
                            <th>현재고</th>
                            <th>안전재고</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:if test="${empty dashboard.lowStockTopList}">
                            <tr>
                                <td colspan="5">부족 재고가 없습니다.</td>
                            </tr>
                        </c:if>

                        <c:forEach var="stock" items="${dashboard.lowStockTopList}">
                            <tr onclick="location.href='/stocks/list'" style="cursor:pointer;">
                                <td>${stock.itemCode}</td>
                                <td>${stock.itemName}</td>
                                <td>${stock.warehouseName}</td>
                                <td class="text-danger fw-bold">${stock.quantity}</td>
                                <td>${stock.safetyStock}</td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>

        <c:if test="${sessionScope.loginUser.authCode == 'MANAGER'}">

        <div class="col-4">
            <div class="card h-100">
                <div class="card-body">

                    <h5 class="mb-3">이번달 제품별 매출 TOP5</h5>

                    <table class="table table-bordered table-hover align-middle text-center">
                        <thead class="table-light">
                        <tr>
                            <th>품목코드</th>
                            <th>품목명</th>
                            <th>판매수량</th>
                            <th>매출액</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:if test="${empty dashboard.salesTopList}">
                            <tr>
                                <td colspan="4">매출 데이터가 없습니다.</td>
                            </tr>
                        </c:if>

                        <c:forEach var="sale" items="${dashboard.salesTopList}">
                            <tr>
                                <td>${sale.itemCode}</td>
                                <td>${sale.itemName}</td>
                                <td>${sale.salesQuantity}</td>
                                <td class="text-primary fw-bold">
                                    <fmt:formatNumber value="${sale.salesAmount}" pattern="#,###"/>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>

    </c:if>

    </div>

    <!-- 최근 재고이력 -->
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
                    <th>비고</th>
                </tr>
                </thead>

                <tbody>
                <c:if test="${empty dashboard.recentHistoryList}">
                    <tr>
                        <td colspan="10">최근 재고이력이 없습니다.</td>
                    </tr>
                </c:if>

                <c:forEach var="history" items="${dashboard.recentHistoryList}">
                    <tr>
                        
                        <td>
                            <c:choose>
                                <c:when test="${history.historyType == 'INBOUND'}">
                                    <span class="badge bg-primary">
                                        입고
                                    </span>
                                </c:when>
                                <c:when test="${history.historyType == 'OUTBOUND'}">
                                    <span class="badge bg-danger">
                                        출고
                                    </span>
                                </c:when>                               
                                <c:when test="${history.historyType == 'ADJUST'}">
                                    <span class="badge bg-warning text-dark">
                                        조정
                                    </span>
                                </c:when>
                                <c:when test="${history.historyType == 'OUTBOUND_CANCEL'}">
                                    <span class="badge bg-dark">
                                        출고취소
                                    </span>
                                </c:when>
                                <c:when test="${history.historyType == 'INBOUND_CANCEL'}">
                                    <span class="badge bg-secondary">
                                        입고취소
                                    </span>
                                </c:when>
                                <c:when test="${history.historyType == 'INITIAL'}">
                                    <span class="badge bg-success">
                                        초기재고
                                    </span>
                                </c:when>                                  
                                <c:otherwise>
                                    ${history.historyType}
                                </c:otherwise>
                            </c:choose>
                        </td>

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
                        <td>${history.createdAtText}</td>
                        <td>${history.remark}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>
    </div>

</div>

<script>
    const inOutLabels = [
        <c:forEach var="row" items="${dashboard.monthlyInOutList}" varStatus="status">
            "${row.label}"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    const inboundData = [
        <c:forEach var="row" items="${dashboard.monthlyInOutList}" varStatus="status">
            ${row.inboundCount}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    const outboundData = [
        <c:forEach var="row" items="${dashboard.monthlyInOutList}" varStatus="status">
            ${row.outboundCount}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    new Chart(document.getElementById("inOutChart"), {
        type: "bar",
        data: {
            labels: inOutLabels,
            datasets: [
                {
                    label: "입고",
                    data: inboundData
                },
                {
                    label: "출고",
                    data: outboundData
                }
            ]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    //max: 100
                }
            }
        }
    });

    const salesLabels = [
        <c:forEach var="row" items="${dashboard.monthlySalesList}" varStatus="status">
            "${row.label}"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    const salesData = [
        <c:forEach var="row" items="${dashboard.monthlySalesList}" varStatus="status">
            ${row.salesAmount}<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    new Chart(document.getElementById("salesChart"), {
        type: "line",
        data: {
            labels: salesLabels,
            datasets: [
                {
                    label: "매출액",
                    data: salesData
                }
            ]
        }
    });
</script>