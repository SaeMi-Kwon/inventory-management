<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>현재고 수정</h3>

        <a href="/stocks/list" class="btn btn-secondary">
            목록
        </a>
    </div>

    <form action="/stocks/edit/${stock.stockId}" method="post">

        <div class="card">
            <div class="card-body">

                <div class="row">

                    <div class="col-md-6 mb-3">
                        <label class="form-label">품목코드</label>
                        <input type="text" class="form-control" value="${stock.itemCode}" readonly>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">품목명</label>
                        <input type="text" class="form-control" value="${stock.itemName}" readonly>
                    </div>

                    <div class="col-md-12 mb-3">
                        <label class="form-label">창고</label>
                        <input type="text" class="form-control" value="${stock.warehouseName}" readonly>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">현재재고</label>
                        <input type="number" name="quantity" class="form-control" min="0" value="${stock.quantity}" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">안전재고</label>
                        <input type="number" name="safetyStock" class="form-control" min="0" value="${stock.safetyStock}" required>
                    </div>

                </div>

            </div>
        </div>

        <div class="mt-4 text-end">
            <button type="submit" class="btn btn-primary">
                수정
            </button>

            <a href="/stocks/list" class="btn btn-secondary">
                취소
            </a>
        </div>

    </form>

</div>