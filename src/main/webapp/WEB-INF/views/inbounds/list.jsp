<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>입고 목록</h3>

        <a href="/inbounds/register" class="btn btn-primary">
            입고 등록
        </a>
    </div>

    <form action="/inbounds/list" method="get" class="card card-body mb-4">

        <div class="row g-3">

            <div class="col-md-3">
                <label class="form-label">입고번호</label>
                <input type="text" name="inboundNo" class="form-control" value="${searchDTO.inboundNo}">
            </div>

            <div class="col-md-3">
                <label class="form-label">입고유형</label>
                <select name="inboundType" class="form-select">
                    <option value="">전체</option>
                    <option value="PURCHASE" ${searchDTO.inboundType == 'PURCHASE' ? 'selected' : ''}>구매입고</option>
                    <option value="PRODUCTION" ${searchDTO.inboundType == 'PRODUCTION' ? 'selected' : ''}>생산입고</option>
                    <option value="INITIAL" ${searchDTO.inboundType == 'INITIAL' ? 'selected' : ''}>초기재고</option>
                    <option value="ADJUST" ${searchDTO.inboundType == 'ADJUST' ? 'selected' : ''}>조정입고</option>
                </select>
            </div>

            <div class="col-md-3">
                <label class="form-label">거래처명</label>
                <input type="text" name="customerName" class="form-control" value="${searchDTO.customerName}">
            </div>

            <div class="col-md-3">
                <label class="form-label">창고명</label>
                <input type="text" name="warehouseName" class="form-control" value="${searchDTO.warehouseName}">
            </div>

            <div class="col-md-12 text-end">
                <button type="submit" class="btn btn-primary">검색</button>
                <a href="/inbounds/list" class="btn btn-secondary">초기화</a>
            </div>

        </div>

    </form>

    <div class="card">
        <div class="card-body">

            <table class="table table-bordered table-hover align-middle text-center">
                <thead class="table-light">
                    <tr>
                        <th>입고번호</th>
                        <th>입고유형</th>
                        <th>거래처</th>
                        <th>창고</th>
                        <th>입고일자</th>
                        <th>상태</th>
                        <th>등록자</th>
                        <th>등록일시</th>
                    </tr>
                </thead>

                <tbody>
                    <c:if test="${empty inboundList}">
                        <tr>
                            <td colspan="8">등록된 입고가 없습니다.</td>
                        </tr>
                    </c:if>

                    <c:forEach var="inbound" items="${inboundList}">
                        <tr style="cursor:pointer;"
                            onclick="location.href='/inbounds/detail/${inbound.inboundId}'">

                            <td>${inbound.inboundNo}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${inbound.inboundType == 'PURCHASE'}">구매입고</c:when>
                                    <c:when test="${inbound.inboundType == 'PRODUCTION'}">생산입고</c:when>
                                    <c:when test="${inbound.inboundType == 'INITIAL'}">초기재고</c:when>
                                    <c:when test="${inbound.inboundType == 'ADJUST'}">조정입고</c:when>
                                    <c:otherwise>${inbound.inboundType}</c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${empty inbound.customerName}">-</c:when>
                                    <c:otherwise>${inbound.customerName}</c:otherwise>
                                </c:choose>
                            </td>

                            <td>${inbound.warehouseName}</td>
                            <td>${inbound.inboundDate}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${inbound.status == 'DRAFT'}">임시저장</c:when>
                                    <c:when test="${inbound.status == 'COMPLETED'}">완료</c:when>
                                    <c:when test="${inbound.status == 'CANCELED'}">취소</c:when>
                                    <c:otherwise>${inbound.status}</c:otherwise>
                                </c:choose>
                            </td>


                            <td>${inbound.createdUserName}</td>
                            <td>${inbound.createdAt}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
    </div>

</div>