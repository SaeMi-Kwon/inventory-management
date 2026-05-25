<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <!-- 제목 -->
    <div class="d-flex justify-content-between align-items-center mb-4">

        <h3>품목 등록</h3>

        <a href="/items/list"class="btn btn-secondary">
            품목 목록
        </a>

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
            품목 등록이 완료되었습니다.
        </div>

    </c:if>


    <!-- 등록 폼 -->
    <form action="/items/register" method="post">

        <div class="card">

            <div class="card-body">

                <div class="row">

                    <!-- 품목코드 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">품목코드</label>
                        <input type="text" name="itemCode" class="form-control" value="${item.itemCode}" required>
                    </div>

                    <!-- 품목명 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">품목명</label>
                        <input type="text" name="itemName" class="form-control" value="${item.itemName}" required>
                    </div>

                    <!-- 품목유형 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">품목유형</label>
                        <select name="itemType" class="form-select" required>
                            <option value="">
                                선택하세요
                            </option>
                            <option value="MATERIAL" ${item.itemType == 'MATERIAL' ? 'selected' : ''}>
                                자재
                            </option>
                            <option value="PRODUCT" ${item.itemType == 'PRODUCT' ? 'selected' : ''}>
                                판매품목
                            </option>
                        </select>
                    </div>


                    <!-- 카테고리 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">카테고리</label>
                        <input type="text" name="category" class="form-control" value="${item.category}">
                    </div>


                    <!-- 규격 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">규격</label>
                        <input type="text" name="spec" class="form-control" value="${item.spec}">
                    </div>


                    <!-- 단위 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">단위</label>
                        <select name="unit" class="form-select" required>

                            <option value="EA" ${item.unit == 'EA' ? 'selected' : ''}>
                                EA
                            </option>

                            <option value="KG" ${item.unit == 'KG' ? 'selected' : ''}>
                                KG
                            </option>

                            <option value="BOX" ${item.unit == 'BOX' ? 'selected' : ''}>
                                BOX
                            </option>

                            <option value="SET" ${item.unit == 'SET' ? 'selected' : ''}>
                                SET
                            </option>

                            <option value="PACK" ${item.unit == 'PACK' ? 'selected' : ''}>
                                PACK
                            </option>

                        </select>

                    </div>


                    <!-- 구매단가 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">구매단가</label>
                        <input type="number" step="0.01" name="purchasePrice" class="form-control" value="${item.purchasePrice}">
                    </div>


                    <!-- 판매단가 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">판매단가</label>
                        <input type="number" step="0.01" name="salePrice" class="form-control" value="${item.salePrice}">
                    </div>


                    <!-- 비고 -->
                    <div class="col-md-12 mb-3">
                        <label class="form-label">비고</label>
                        <textarea name="remark" class="form-control" rows="4">${item.remark}</textarea>
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