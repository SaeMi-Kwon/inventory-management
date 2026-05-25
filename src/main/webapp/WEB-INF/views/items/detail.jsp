<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>품목 상세보기</h3>

        <div class="d-flex gap-2">
            <a href="/items/edit/${item.itemId}" class="btn btn-primary">
                수정
            </a>

            <a href="/items/list" class="btn btn-secondary">
                목록
            </a>
        </div>
    </div>

    <div class="card">
        <div class="card-body">

            <table class="table table-bordered align-middle">

                <tr>
                    <th style="width: 180px;">품목코드</th>
                    <td>${item.itemCode}</td>
                </tr>

                <tr>
                    <th>품목명</th>
                    <td>${item.itemName}</td>
                </tr>

                <tr>
                    <th>품목유형</th>
                    <td>
                        <c:choose>
                            <c:when test="${item.itemType eq 'MATERIAL'}">자재</c:when>
                            <c:when test="${item.itemType eq 'PRODUCT'}">판매품목</c:when>
                            <c:otherwise>${item.itemType}</c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr>
                    <th>카테고리</th>
                    <td>${item.category}</td>
                </tr>

                <tr>
                    <th>규격</th>
                    <td>${item.spec}</td>
                </tr>

                <tr>
                    <th>단위</th>
                    <td>${item.unit}</td>
                </tr>

                <tr>
                    <th>구매단가</th>
                    <td>${item.purchasePrice}</td>
                </tr>

                <tr>
                    <th>판매단가</th>
                    <td>${item.salePrice}</td>
                </tr>

                <tr>
                    <th>사용여부</th>
                    <td>
                        <c:choose>
                            <c:when test="${item.useYn eq 'Y'}">사용</c:when>
                            <c:otherwise>미사용</c:otherwise>
                        </c:choose>
                    </td>
                </tr>

                <tr>
                    <th>비고</th>
                    <td>${item.remark}</td>
                </tr>

                <tr>
                    <th>등록일시</th>
                    <td>${item.createdAt}</td>
                </tr>

                <tr>
                    <th>수정일시</th>
                    <td>${item.updatedAt}</td>
                </tr>

            </table>

        </div>
    </div>

</div>