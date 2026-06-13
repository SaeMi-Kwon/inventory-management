<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>입고 상세</h3>

        <div>
            <c:if test="${sessionScope.loginUser.authCode == 'MANAGER'}">
                <c:if test="${inbound.status == 'DRAFT'}">

                    <a href="/inbounds/edit/${inbound.inboundId}" class="btn btn-warning">
                        수정
                    </a>

                    <form action="/inbounds/complete/${inbound.inboundId}" method="post" style="display:inline;">
                        <button type="submit" class="btn btn-success" onclick="return confirm('입고완료 처리하시겠습니까? 완료 후 재고에 반영됩니다.');">
                            입고완료
                        </button>
                    </form>

                    <form action="/inbounds/cancel/${inbound.inboundId}" method="post" style="display:inline;">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('입고를 취소하시겠습니까?');">
                            취소
                        </button>
                    </form>
                </c:if>

                <c:if test="${inbound.status == 'COMPLETED'}">
                    <form action="/inbounds/cancelCompleted/${inbound.inboundId}" method="post" style="display:inline;">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('완료된 입고를 취소하시겠습니까? 취소하면 재고가 다시 감소합니다.');">
                            입고취소
                        </button>
                    </form>
                </c:if>
            </c:if>

            <a href="/inbounds/list" class="btn btn-secondary">
                목록
            </a>
        </div>

    </div>

    <div class="card mb-4">
        <div class="card-body">

            <h5 class="mb-3">입고 기본정보</h5>

            <table class="table table-bordered align-middle">
                <tr>
                    <th style="width: 180px;">입고번호</th>
                    <td>${inbound.inboundNo}</td>

                    <th style="width: 180px;">입고유형</th>
                    <td>
                        <c:choose>
                            <c:when test="${inbound.inboundType eq 'PURCHASE'}">구매입고</c:when>
                            <c:when test="${inbound.inboundType eq 'INITIAL'}">초기재고</c:when>
                            <c:when test="${inbound.inboundType eq 'ADJUST'}">조정입고</c:when>
                            <c:otherwise>${inbound.inboundType}</c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr>
                    <th>거래처</th>
                    <td>
                        <c:choose>
                            <c:when test="${empty inbound.customerName}">-</c:when>
                            <c:otherwise>${inbound.customerName}</c:otherwise>
                        </c:choose>
                    </td>

                    <th>입고창고</th>
                    <td>${inbound.warehouseName}</td>
                </tr>

                <tr>
                    <th>입고일자</th>
                    <td>${inbound.inboundDate}</td>

                    <th>상태</th>
                    <td>
                        <c:choose>
                            <c:when test="${inbound.status == 'DRAFT'}">임시저장</c:when>
                            <c:when test="${inbound.status == 'COMPLETED'}">완료</c:when>
                            <c:when test="${inbound.status == 'CANCELED'}">취소</c:when>
                            <c:otherwise>${inbound.status}</c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr>
                    <th>등록자</th>
                    <td>${inbound.createdUserName}</td>
                    
                    <th>등록일시</th>
                    <td>${inbound.createdAtText}</td>
                </tr>

                <tr>
                    <th>비고</th>
                    <td colspan="3">${inbound.remark}</td>
                </tr>
            </table>

        </div>
    </div>

    <div class="card">
        <div class="card-body">

            <h5 class="mb-3">입고 상세 품목</h5>

            <table class="table table-bordered align-middle text-center">
                <thead class="table-light">
                    <tr>
                        <th>품목코드</th>
                        <th>품목명</th>
                        <th>규격</th>
                        <th>단위</th>
                        <th>수량</th>
                        <th>입고단가</th>
                        <th>입고금액</th>
                        <th>비고</th>
                    </tr>
                </thead>

                <tbody>
                    <c:if test="${empty inbound.detailList}">
                        <tr>
                            <td colspan="6">입고 상세 품목이 없습니다.</td>
                        </tr>
                    </c:if>

                    <c:forEach var="detail" items="${inbound.detailList}">
                        <tr>
                            <td>${detail.itemCode}</td>
                            <td>${detail.itemName}</td>
                            <td>${detail.spec}</td>
                            <td>${detail.unit}</td>
                            <td>${detail.quantity}</td>
                            <td>${detail.unitPrice}</td>
                            <td>${detail.totalPrice}</td>
                            <td>${detail.remark}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

        </div>
    </div>

</div>