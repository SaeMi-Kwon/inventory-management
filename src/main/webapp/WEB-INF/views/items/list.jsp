<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <!-- 제목 -->
    <div class="d-flex justify-content-between align-items-center mb-4">

        <h3>품목 목록</h3>

        <a href="/items/register" class="btn btn-primary">
            품목 등록
        </a>

    </div>


    <!-- 검색 영역 -->
    <form action="/items/list" method="get" class="card card-body mb-4">

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


            <!-- 카테고리 -->
            <div class="col-md-2">
                <label class="form-label">카테고리</label>
                <input type="text" name="category" class="form-control" value="${searchDTO.category}">
            </div>


            <!-- 품목유형 -->
            <div class="col-md-2">
                <label class="form-label">품목유형</label>
                <select name="itemType" class="form-select">
                    <option value="">
                        전체
                    </option>
                    <option value="MATERIAL" ${searchDTO.itemType == 'MATERIAL' ? 'selected' : ''}>
                        자재
                    </option>
                    <option value="PRODUCT" ${searchDTO.itemType == 'PRODUCT' ? 'selected' : ''}>
                        판매품목
                    </option>
                </select>
            </div>


            <!-- 사용여부 -->
            <div class="col-md-2">
                <label class="form-label">사용여부</label>
                <select name="useYn" class="form-select">
                    <option value="">전체</option>
                    <option value="Y" ${searchDTO.useYn eq 'Y' ? 'selected' : ''}>
                        사용
                    </option>
                    <option value="N" ${searchDTO.useYn eq 'N' ? 'selected' : ''}>
                        미사용
                    </option>
                </select>
            </div>


            <!-- 버튼 -->
            <div class="col-md-2 d-flex align-items-end">
                <button type="submit" class="btn btn-primary me-2">
                    검색
                </button>

                <a href="/items/list" class="btn btn-secondary">
                    초기화
                </a>
            </div>

        </div>

    </form>


    <!-- 목록 영역 -->
    <div class="card">

        <div class="card-body">

            <div class="table-responsive">

                <table class="table table-bordered table-hover align-middle text-center">

                    <thead class="table-light">

                    <tr>
                        <th>번호</th>
                        <th>품목코드</th>
                        <th>품목명</th>
                        <th>품목유형</th>
                        <th>카테고리</th>
                        <th>규격</th>
                        <th>단위</th>
                        <th>구매단가</th>
                        <th>판매단가</th>
                        <th>사용여부</th>
                        <th>등록일시</th>
                    </tr>

                    </thead>


                    <tbody>

                    <!-- 데이터 없을 때 -->
                    <c:if test="${empty itemList}">

                        <tr>
                            <td colspan="11">
                                등록된 품목이 없습니다.
                            </td>
                        </tr>

                    </c:if>

                    <!-- 데이터 있을 때 -->
                    <c:forEach var="item" items="${itemList}" varStatus="status">

                        <tr style="cursor:pointer;" onclick="location.href='/items/detail/${item.itemId}'">

                            <td>${status.count}</td>
                            <td>${item.itemCode}</td>
                            <td>${item.itemName}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${item.itemType == 'MATERIAL'}">
                                        자재
                                    </c:when>
                                    <c:when test="${item.itemType == 'PRODUCT'}">
                                        판매품목
                                    </c:when>
                                    <c:otherwise>
                                        ${item.itemType}
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>${item.category}</td>
                            <td>${item.spec}</td>
                            <td>${item.unit}</td>
                            <td>${item.purchasePrice}</td>
                            <td>${item.salePrice}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${item.useYn == 'Y'}">
                                        사용
                                    </c:when>
                                    <c:otherwise>
                                        미사용
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>${item.createdAtText}</td>

                        </tr>

                    </c:forEach>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>