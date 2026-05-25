<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <!-- 제목 -->
    <div class="d-flex justify-content-between align-items-center mb-4">

        <h3>재고 등록</h3>

    </div>


    <!-- 에러 메시지 -->
    <c:if test="${not empty errorMessage}">

        <div class="alert alert-danger">
            ${errorMessage}
        </div>

    </c:if>


    <!-- 성공 메시지 -->
    <c:if test="${param.success eq 'true'}">

        <div class="alert alert-success">
            재고 등록이 완료되었습니다.
        </div>

    </c:if>


    <!-- 등록 폼 -->
    <form action="/stocks/register"
          method="post">

        <div class="card">

            <div class="card-body">

                <div class="row">

                    <!-- 품목 -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">품목</label>

                        <select name="itemId" class="form-select" required>

                            <option value="">
                                선택하세요
                            </option>

                            <c:forEach var="item" items="${itemList}">

                                <option value="${item.itemId}" ${stock.itemId == item.itemId ? 'selected' : ''}>
                                    ${item.itemCode} - ${item.itemName}
                                </option>

                            </c:forEach>

                        </select>

                    </div>


                    <!-- 창고 -->
                    <div class="col-md-6 mb-3">

                        <label class="form-label">창고</label>

                        <select name="warehouseId" class="form-select" required>

                            <option value="">
                                선택하세요
                            </option>

                            <c:forEach var="warehouse" items="${warehouseList}">

                                <option value="${warehouse.warehouseId}" ${stock.warehouseId == warehouse.warehouseId ? 'selected' : ''}>
                                    ${warehouse.warehouseCode} - ${warehouse.warehouseName}
                                </option>

                            </c:forEach>

                        </select>

                    </div>


                    <!-- 재고 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">재고</label>
                        <input type="number" name="quantity" class="form-control" min="0"
                            value="${empty stock.quantity ? 0 : stock.quantity}">
                    </div>


                    <!-- 안전재고 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">안전재고</label>
                        <input type="number" name="safetyStock" class="form-control" min="0"
                            value="${empty stock.safetyStock ? 0 : stock.safetyStock}">
                    </div>

                </div>

            </div>

        </div>


        <!-- 버튼 -->
        <div class="mt-4 text-end">

            <button type="submit" class="btn btn-primary">
                등록
            </button>

            <a href="/" class="btn btn-secondary">
                취소
            </a>

        </div>

    </form>

</div>