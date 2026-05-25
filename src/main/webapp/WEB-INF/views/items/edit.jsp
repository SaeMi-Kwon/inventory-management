<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>품목 수정</h3>

        <div class="d-flex gap-2">
            <a href="/items/detail/${item.itemId}" class="btn btn-secondary">
                상세보기
            </a>

            <a href="/items/list" class="btn btn-dark">
                목록
            </a>
        </div>
    </div>

    <form action="/items/edit/${item.itemId}" method="post">

        <div class="card">
            <div class="card-body">

                <div class="row">

                    <div class="col-md-6 mb-3">
                        <label class="form-label">품목코드</label>
                        <input type="text" class="form-control" value="${item.itemCode}" readonly>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">품목명</label>
                        <input type="text" name="itemName" class="form-control" value="${item.itemName}" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">품목유형</label>
                        <select name="itemType" class="form-select" required>
                            <option value="MATERIAL" ${item.itemType == 'MATERIAL' ? 'selected' : ''}>
                                자재
                            </option>
                            <option value="PRODUCT" ${item.itemType == 'PRODUCT' ? 'selected' : ''}>
                                판매품목
                            </option>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">카테고리</label>
                        <input type="text" name="category" class="form-control" value="${item.category}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">규격</label>
                        <input type="text" name="spec" class="form-control" value="${item.spec}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">단위</label>
                        <select name="unit" class="form-select" required>
                            <option value="EA" ${item.unit == 'EA' ? 'selected' : ''}>EA</option>
                            <option value="BOX" ${item.unit == 'BOX' ? 'selected' : ''}>BOX</option>
                            <option value="SET" ${item.unit == 'SET' ? 'selected' : ''}>SET</option>
                            <option value="KG" ${item.unit == 'KG' ? 'selected' : ''}>KG</option>
                            <option value="PACK" ${item.unit == 'PACK' ? 'selected' : ''}>PACK</option>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">구매단가</label>
                        <input type="number" step="0.01" min="0" name="purchasePrice" class="form-control" value="${item.purchasePrice}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">판매단가</label>
                        <input type="number" step="0.01" min="0" name="salePrice" class="form-control" value="${item.salePrice}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">사용여부</label>
                        <select name="useYn" class="form-select">
                            <option value="Y" ${item.useYn == 'Y' ? 'selected' : ''}>
                                사용
                            </option>
                            <option value="N" ${item.useYn == 'N' ? 'selected' : ''}>
                                미사용
                            </option>
                        </select>
                    </div>

                    <div class="col-md-12 mb-3">
                        <label class="form-label">비고</label>
                        <textarea name="remark" class="form-control" rows="4">${item.remark}</textarea>
                    </div>

                </div>

            </div>
        </div>

        <div class="mt-4 text-end">
            <button type="submit" class="btn btn-primary">
                수정
            </button>

            <a href="/items/detail/${item.itemId}" class="btn btn-secondary">
                취소
            </a>
        </div>

    </form>

</div>