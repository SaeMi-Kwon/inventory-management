<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>출고 수정</h3>

        <a href="/outbounds/detail/${outbound.outboundId}" class="btn btn-secondary">
            상세
        </a>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
            ${errorMessage}
        </div>
    </c:if>

    <form action="/outbounds/edit/${outbound.outboundId}" method="post">

        <div class="card mb-4">
            <div class="card-body">

                <h5 class="mb-3">출고 기본정보</h5>

                <div class="row">

                    <div class="col-md-4 mb-3">
                        <label class="form-label">출고번호</label>
                        <input type="text" class="form-control" value="${outbound.outboundNo}" readonly>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label">출고유형</label>
                        <select name="outboundType" class="form-select" required>
                            <option value="SALE" ${outbound.outboundType == 'SALE' ? 'selected' : ''}>판매출고</option>
                            <option value="ADJUST" ${outbound.outboundType == 'ADJUST' ? 'selected' : ''}>조정출고</option>
                            <option value="DISPOSAL" ${outbound.outboundType == 'DISPOSAL' ? 'selected' : ''}>폐기출고</option>
                            <option value="TRANSFER" ${outbound.outboundType == 'TRANSFER' ? 'selected' : ''}>이동출고</option>
                        </select>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label">출고일자</label>
                        <input type="date" name="outboundDate" class="form-control" value="${outbound.outboundDate}" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">거래처</label>
                        <select name="customerId" class="form-select">
                            <option value="">선택 안 함</option>
                            <c:forEach var="customer" items="${customerList}">
                                <option value="${customer.customerId}" ${outbound.customerId == customer.customerId ? 'selected' : ''}>
                                    ${customer.customerName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">출고창고</label>
                        <select name="warehouseId" class="form-select" required>
                            <option value="">선택하세요</option>
                            <c:forEach var="warehouse" items="${warehouseList}">
                                <option value="${warehouse.warehouseId}" ${outbound.warehouseId == warehouse.warehouseId ? 'selected' : ''}>
                                    ${warehouse.warehouseName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="col-md-12 mb-3">
                        <label class="form-label">비고</label>
                        <textarea name="remark" class="form-control" rows="3">${outbound.remark}</textarea>
                    </div>

                </div>

            </div>
        </div>

        <div class="card">
            <div class="card-body">

                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h5 class="mb-0">출고 상세</h5>

                    <button type="button" class="btn btn-outline-primary btn-sm" onclick="addDetailRow()">
                        품목 추가
                    </button>
                </div>

                <div class="table-responsive">
                    <table class="table table-bordered align-middle text-center">

                        <thead class="table-light">
                        <tr>
                            <th style="width: 22%;">품목</th>
                            <th style="width: 10%;">규격</th>
                            <th style="width: 8%;">단위</th>
                            <th style="width: 10%;">수량</th>
                            <th style="width: 13%;">출고단가</th>
                            <th style="width: 13%;">출고금액</th>
                            <th>비고</th>
                            <th style="width: 7%;">삭제</th>
                        </tr>
                        </thead>

                        <tbody id="detailBody">

                        <c:forEach var="detail" items="${outbound.detailList}" varStatus="status">
                            <tr>
                                <td>
                                    <select name="detailList[${status.index}].itemId" class="form-select item-select" required onchange="changeItem(this)">
                                        <option value="">품목 선택</option>

                                        <c:forEach var="item" items="${itemList}">
                                            <option value="${item.itemId}"
                                                    data-spec="${item.spec}"
                                                    data-unit="${item.unit}"
                                                    data-price="${item.salePrice}"
                                                    ${detail.itemId == item.itemId ? 'selected' : ''}>
                                                ${item.itemCode} - ${item.itemName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </td>

                                <td>
                                    <input type="text" class="form-control item-spec" readonly
                                        value="<c:forEach var='item' items='${itemList}'><c:if test='${detail.itemId == item.itemId}'>${item.spec}</c:if></c:forEach>">
                                </td>

                                <td>
                                    <input type="text" class="form-control item-unit" readonly
                                        value="<c:forEach var='item' items='${itemList}'><c:if test='${detail.itemId == item.itemId}'>${item.unit}</c:if></c:forEach>">
                                </td>

                                <td>
                                    <input type="number" name="detailList[${status.index}].quantity" class="form-control quantity"
                                        min="1" value="${detail.quantity}" required oninput="calculateRow(this)">
                                </td>

                                <td>
                                    <input type="number" name="detailList[${status.index}].unitPrice" class="form-control unit-price"
                                        step="0.01" min="0" value="${detail.unitPrice}" oninput="calculateRow(this)">
                                </td>

                                <td>
                                    <input type="number" name="detailList[${status.index}].totalPrice" class="form-control total-price"
                                        step="0.01" min="0" value="${detail.totalPrice}" readonly>
                                </td>

                                <td>
                                    <input type="text" name="detailList[${status.index}].remark" class="form-control" value="${detail.remark}">
                                </td>

                                <td>
                                    <button type="button" class="btn btn-danger btn-sm" onclick="removeDetailRow(this)">
                                        삭제
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>

                        </tbody>

                        <tfoot>
                        <tr class="table-light fw-bold">
                            <td colspan="3">합계</td>
                            <td id="totalQuantity">0</td>
                            <td></td>
                            <td id="totalAmount">0.00</td>
                            <td colspan="2"></td>
                        </tr>
                        </tfoot>

                    </table>
                </div>

            </div>
        </div>

        <div class="mt-4 text-end">
            <button type="submit" class="btn btn-primary">
                수정
            </button>

            <a href="/outbounds/detail/${outbound.outboundId}" class="btn btn-secondary">
                취소
            </a>
        </div>

    </form>

</div>

<script>
    let detailIndex = ${empty outbound.detailList ? 0 : outbound.detailList.size()};

    function addDetailRow() {
        const tbody = document.getElementById("detailBody");
        const row = document.createElement("tr");

        row.innerHTML = `
            <td>
                <select name="detailList[\${detailIndex}].itemId"
                        class="form-select item-select"
                        required
                        onchange="changeItem(this)">
                    <option value="">품목 선택</option>

                    <c:forEach var="item" items="${itemList}">
                        <option value="${item.itemId}"
                                data-spec="${item.spec}"
                                data-unit="${item.unit}"
                                data-price="${item.salePrice}">
                            ${item.itemCode} - ${item.itemName}
                        </option>
                    </c:forEach>
                </select>
            </td>

            <td>
                <input type="text" class="form-control item-spec" readonly>
            </td>

            <td>
                <input type="text" class="form-control item-unit" readonly>
            </td>

            <td>
                <input type="number" name="detailList[\${detailIndex}].quantity" class="form-control quantity"
                    min="1" required oninput="calculateRow(this)">
            </td>

            <td>
                <input type="number" name="detailList[\${detailIndex}].unitPrice" class="form-control unit-price"
                    step="0.01" min="0" oninput="calculateRow(this)">
            </td>

            <td>
                <input type="number" name="detailList[\${detailIndex}].totalPrice" class="form-control total-price"
                    step="0.01" min="0" readonly>
            </td>

            <td>
                <input type="text" name="detailList[\${detailIndex}].remark" class="form-control">
            </td>

            <td>
                <button type="button" class="btn btn-danger btn-sm" onclick="removeDetailRow(this)">
                    삭제
                </button>
            </td>
        `;

        tbody.appendChild(row);
        detailIndex++;
    }

    function changeItem(select) {
        const row = select.closest("tr");
        const selectedOption = select.options[select.selectedIndex];

        const spec = selectedOption.dataset.spec || "";
        const unit = selectedOption.dataset.unit || "";
        const price = selectedOption.dataset.price || 0;

        row.querySelector(".item-spec").value = spec;
        row.querySelector(".item-unit").value = unit;
        row.querySelector(".unit-price").value = price;

        calculateRow(select);
    }

    function removeDetailRow(button) {
        const tbody = document.getElementById("detailBody");

        if (tbody.children.length === 1) {
            alert("출고 상세는 최소 1건 이상 필요합니다.");
            return;
        }

        button.closest("tr").remove();
        calculateTotal();
    }

    function calculateRow(input) {
        const row = input.closest("tr");

        const quantityInput = row.querySelector(".quantity");
        const unitPriceInput = row.querySelector(".unit-price");
        const totalPriceInput = row.querySelector(".total-price");

        const quantity = Number(quantityInput.value || 0);
        const unitPrice = Number(unitPriceInput.value || 0);

        totalPriceInput.value = (quantity * unitPrice).toFixed(2);

        calculateTotal();
    }

    function calculateTotal() {
        let totalQuantity = 0;
        let totalAmount = 0;

        document.querySelectorAll("#detailBody tr").forEach(row => {
            const quantity = Number(row.querySelector(".quantity").value || 0);
            const totalPrice = Number(row.querySelector(".total-price").value || 0);

            totalQuantity += quantity;
            totalAmount += totalPrice;
        });

        document.getElementById("totalQuantity").innerText = totalQuantity;
        document.getElementById("totalAmount").innerText = totalAmount.toFixed(2);
    }

    document.addEventListener("DOMContentLoaded", function () {
        calculateTotal();
    });
</script>