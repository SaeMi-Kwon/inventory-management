<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>출고 등록</h3>

        <a href="/outbounds/list" class="btn btn-secondary">
            출고 목록
        </a>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
            ${errorMessage}
        </div>
    </c:if>

    <c:if test="${param.success eq 'true'}">
        <div class="alert alert-success">
            출고 등록이 완료되었습니다.
        </div>
    </c:if>

    <form action="/outbounds/register" method="post">

        <div class="card mb-4">
            <div class="card-body">

                <h5 class="mb-3">출고 기본정보</h5>

                <div class="row">

                    <div class="col-md-4 mb-3">
                        <label class="form-label">출고번호</label>
                        <input type="text" name="outboundNo" class="form-control" value="${outbound.outboundNo}" required>
                    </div>

                    <div class="col-md-4 mb-3">
                        <label class="form-label">출고유형</label>
                        <select name="outboundType" class="form-select" required>
                            <option value="SALE">판매출고</option>
                            <option value="ADJUST">조정출고</option>
                            <option value="DISPOSAL">폐기출고</option>
                            <option value="TRANSFER">이동출고</option>
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
                                <option value="${customer.customerId}">
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
                                <option value="${warehouse.warehouseId}">
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
                            <th style="width: 28%;">품목</th>
                            <th style="width: 12%;">수량</th>
                            <th style="width: 15%;">출고단가</th>
                            <th style="width: 15%;">출고금액</th>
                            <th>비고</th>
                            <th style="width: 8%;">삭제</th>
                        </tr>
                        </thead>

                        <tbody id="detailBody">

                        <tr>
                            <td>
                                <select name="detailList[0].itemId" class="form-select" required>
                                    <option value="">품목 선택</option>
                                    <c:forEach var="item" items="${itemList}">
                                        <option value="${item.itemId}">
                                            ${item.itemCode} - ${item.itemName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </td>

                            <td>
                                <input type="number" name="detailList[0].quantity" class="form-control quantity"
                                       min="1" required oninput="calculateRow(this)">
                            </td>

                            <td>
                                <input type="number" name="detailList[0].unitPrice" class="form-control unit-price"
                                       step="0.01" min="0" oninput="calculateRow(this)">
                            </td>

                            <td>
                                <input type="number" name="detailList[0].totalPrice" class="form-control total-price"
                                       step="0.01" min="0" readonly>
                            </td>

                            <td>
                                <input type="text" name="detailList[0].remark" class="form-control">
                            </td>

                            <td>
                                <button type="button" class="btn btn-danger btn-sm" onclick="removeDetailRow(this)">
                                    삭제
                                </button>
                            </td>
                        </tr>

                        </tbody>

                    </table>
                </div>

            </div>
        </div>

        <div class="mt-4 text-end">
            <button type="submit" class="btn btn-primary">
                등록
            </button>

            <a href="/" class="btn btn-secondary">
                취소
            </a>
        </div>

        <script>
            let detailIndex = 1;

            function addDetailRow() {
                const tbody = document.getElementById("detailBody");

                const row = document.createElement("tr");

                row.innerHTML = `
                    <td>
                        <select name="detailList[\${detailIndex}].itemId" class="form-select" required>
                            <option value="">품목 선택</option>

                            <c:forEach var="item" items="${itemList}">
                                <option value="${item.itemId}">
                                    ${item.itemCode} - ${item.itemName}
                                </option>
                            </c:forEach>
                        </select>
                    </td>

                    <td>
                        <input type="number"
                            name="detailList[\${detailIndex}].quantity" class="form-control quantity"
                            min="1" required oninput="calculateRow(this)">
                    </td>

                    <td>
                        <input type="number" name="detailList[\${detailIndex}].unitPrice"
                            class="form-control unit-price" step="0.01" min="0" oninput="calculateRow(this)">
                    </td>

                    <td>
                        <input type="number" name="detailList[\${detailIndex}].totalPrice"
                            class="form-control total-price" step="0.01" min="0" readonly>
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

            function removeDetailRow(button) {
                const tbody = document.getElementById("detailBody");

                if (tbody.children.length === 1) {
                    alert("출고 상세는 최소 1건 이상 필요합니다.");
                    return;
                }

                // const tr = button.closest("tr");
                // tr.parentNode.removeChild(tr);

                button.closest("tr").remove();
            }

            function calculateRow(input) {
                
                const row = input.closest("tr");
                const quantityInput = row.querySelector(".quantity");
                const unitPriceInput = row.querySelector(".unit-price");
                const totalPriceInput = row.querySelector(".total-price");
                const quantity = Number(quantityInput.value || 0);
                const unitPrice = Number(unitPriceInput.value || 0);

                totalPriceInput.value = (quantity * unitPrice).toFixed(2);
            }
        </script>

    </form>

</div>