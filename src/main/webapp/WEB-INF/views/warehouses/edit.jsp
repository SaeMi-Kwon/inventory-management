<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>창고 수정</h3>

        <a href="/warehouses/list" class="btn btn-secondary">
            목록
        </a>
    </div>

    <form action="/warehouses/edit/${warehouse.warehouseId}" method="post">

        <div class="card">
            <div class="card-body">

                <div class="row">

                    <div class="col-md-6 mb-3">
                        <label class="form-label">창고코드</label>
                        <input type="text" class="form-control" value="${warehouse.warehouseCode}" readonly>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">창고명</label>
                        <input type="text" name="warehouseName" class="form-control" value="${warehouse.warehouseName}" required>
                    </div>

                    <div class="col-md-12 mb-3">
                        <label class="form-label">위치</label>
                        <input type="text" name="location" class="form-control" value="${warehouse.location}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">사용여부</label>
                        <select name="useYn" class="form-select">
                            <option value="Y" ${warehouse.useYn == 'Y' ? 'selected' : ''}>
                                사용
                            </option>
                            <option value="N" ${warehouse.useYn == 'N' ? 'selected' : ''}>
                                미사용
                            </option>
                        </select>
                    </div>

                    <div class="col-md-12 mb-3">
                        <label class="form-label">비고</label>
                        <textarea name="remark" class="form-control" rows="4">${warehouse.remark}</textarea>
                    </div>

                </div>

            </div>
        </div>

        <div class="mt-4 text-end">
            <button type="submit" class="btn btn-primary">
                수정
            </button>

            <a href="/warehouses/list" class="btn btn-secondary">
                취소
            </a>
        </div>

    </form>

</div>