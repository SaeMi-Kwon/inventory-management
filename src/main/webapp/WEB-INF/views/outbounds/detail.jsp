<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>출고 상세</h3>

        <div>
            <c:if test="${sessionScope.loginUser.authCode == 'MANAGER'}">
                <c:if test="${outbound.status == 'DRAFT'}">

                    <a href="/outbounds/edit/${outbound.outboundId}" class="btn btn-warning">
                        수정
                    </a>

                    <form action="/outbounds/complete/${outbound.outboundId}" method="post" style="display:inline;">
                        <button type="submit" class="btn btn-success" onclick="return confirm('출고완료 처리하시겠습니까? 완료 후 재고가 차감됩니다.');">
                            출고완료
                        </button>
                    </form>

                    <form action="/outbounds/cancel/${outbound.outboundId}" method="post" style="display:inline;">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('출고를 취소하시겠습니까?');">
                            취소
                        </button>
                    </form>

                </c:if>

                <c:if test="${outbound.status == 'COMPLETED'}">
                    <form action="/outbounds/cancelCompleted/${outbound.outboundId}" method="post" style="display:inline;">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('완료된 출고를 취소하시겠습니까? 취소하면 재고가 다시 증가합니다.');">
                            출고취소
                        </button>
                    </form>
                </c:if>
            </c:if>

            <a href="/outbounds/list" class="btn btn-secondary">
                목록
            </a>
        </div>
    </div>

    <div class="card mb-4">
        <div class="card-body">

            <h5 class="mb-3">출고 기본정보</h5>

            <table class="table table-bordered align-middle">
                <tr>
                    <th style="width: 180px;">출고번호</th>
                    <td>${outbound.outboundNo}</td>

                    <th style="width: 180px;">출고유형</th>
                    <td>
                        <c:choose>
                            <c:when test="${outbound.outboundType eq 'SALE'}">판매출고</c:when>
                            <c:when test="${outbound.outboundType eq 'ADJUST'}">조정출고</c:when>
                            <c:when test="${outbound.outboundType eq 'DISPOSAL'}">폐기출고</c:when>
                            <c:when test="${outbound.outboundType eq 'TRANSFER'}">이동출고</c:when>
                            <c:otherwise>${outbound.outboundType}</c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr>
                    <th>거래처</th>
                    <td>
                        <c:choose>
                            <c:when test="${empty outbound.customerName}">-</c:when>
                            <c:otherwise>${outbound.customerName}</c:otherwise>
                        </c:choose>
                    </td>

                    <th>출고창고</th>
                    <td>${outbound.warehouseName}</td>
                </tr>

                <tr>
                    <th>출고일자</th>
                    <td>${outbound.outboundDate}</td>

                    <th>상태</th>
                    <td>
                        <c:choose>
                            <c:when test="${outbound.status == 'DRAFT'}">임시저장</c:when>
                            <c:when test="${outbound.status == 'COMPLETED'}">완료</c:when>
                            <c:when test="${outbound.status == 'CANCELED'}">취소</c:when>
                            <c:otherwise>${outbound.status}</c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr>
                    <th>등록자</th>
                    <td>${outbound.createdUserName}</td>

                    <th>등록일시</th>
                    <td>${outbound.createdAtText}</td>
                </tr>

                <tr>
                    <th>비고</th>
                    <td colspan="3">${outbound.remark}</td>
                </tr>
            </table>

        </div>
    </div>

    <div class="card">
        <div class="card-body">

            <h5 class="mb-3">출고 상세 품목</h5>

            <table class="table table-bordered align-middle text-center">
                <thead class="table-light">
                <tr>
                    <th>품목코드</th>
                    <th>품목명</th>
                    <th>규격</th>
                    <th>단위</th>
                    <th>수량</th>
                    <th>출고단가</th>
                    <th>출고금액</th>
                    <th>비고</th>
                </tr>
                </thead>

                <tbody>
                <c:if test="${empty outbound.detailList}">
                    <tr>
                        <td colspan="6">출고 상세 품목이 없습니다.</td>
                    </tr>
                </c:if>

                <c:forEach var="detail" items="${outbound.detailList}">
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