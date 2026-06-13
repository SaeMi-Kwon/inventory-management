<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>출고 목록</h3>

        <a href="/outbounds/register" class="btn btn-primary">
            출고 등록
        </a>
    </div>

    <form action="/outbounds/list" method="get" class="card card-body mb-4">
        <div class="row g-3">

            <div class="col-md-3">
                <label class="form-label">출고번호</label>
                <input type="text" name="outboundNo" class="form-control" value="${searchDTO.outboundNo}">
            </div>

            <div class="col-md-3">
                <label class="form-label">출고유형</label>
                <select name="outboundType" class="form-select">
                    <option value="">전체</option>
                    <option value="SALE" ${searchDTO.outboundType == 'SALE' ? 'selected' : ''}>판매출고</option>
                    <option value="ADJUST" ${searchDTO.outboundType == 'ADJUST' ? 'selected' : ''}>조정출고</option>
                    <option value="DISPOSAL" ${searchDTO.outboundType == 'DISPOSAL' ? 'selected' : ''}>폐기출고</option>
                    <option value="TRANSFER" ${searchDTO.outboundType == 'TRANSFER' ? 'selected' : ''}>이동출고</option>
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
                <a href="/outbounds/list" class="btn btn-secondary">초기화</a>
            </div>

        </div>
    </form>

    <div class="card">
        <div class="card-body">

            <table class="table table-bordered table-hover align-middle text-center">
                <thead class="table-light">
                <tr>
                    <th>출고번호</th>
                    <th>출고유형</th>
                    <th>거래처</th>
                    <th>창고</th>
                    <th>출고일자</th>
                    <th>상태</th>
                    <th>등록자</th>
                    <th>등록일시</th>
                </tr>
                </thead>

                <tbody>
                <c:if test="${empty outboundList}">
                    <tr>
                        <td colspan="8">등록된 출고가 없습니다.</td>
                    </tr>
                </c:if>

                <c:forEach var="outbound" items="${outboundList}">
                    <tr style="cursor:pointer;" onclick="location.href='/outbounds/detail/${outbound.outboundId}'">

                        <td>${outbound.outboundNo}</td>
                        
                        <td>
                            <c:choose>
                                <c:when test="${outbound.outboundType == 'SALE'}">판매출고</c:when>
                                <c:when test="${outbound.outboundType == 'ADJUST'}">조정출고</c:when>
                                <c:when test="${outbound.outboundType == 'DISPOSAL'}">폐기출고</c:when>
                                <c:when test="${outbound.outboundType == 'TRANSFER'}">이동출고</c:when>
                                <c:otherwise>${outbound.outboundType}</c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <c:choose>
                                <c:when test="${empty outbound.customerName}">-</c:when>
                                <c:otherwise>${outbound.customerName}</c:otherwise>
                            </c:choose>
                        </td>

                        <td>${outbound.warehouseName}</td>
                        <td>${outbound.outboundDate}</td>

                        <td>
                            <c:choose>
                                <c:when test="${outbound.status == 'DRAFT'}">임시저장</c:when>
                                <c:when test="${outbound.status == 'COMPLETED'}">완료</c:when>
                                <c:when test="${outbound.status == 'CANCELED'}">취소</c:when>
                                <c:otherwise>${outbound.status}</c:otherwise>
                            </c:choose>
                        </td>


                        <td>${outbound.createdUserName}</td>
                        <td>${outbound.createdAtText}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

        </div>
    </div>

</div>