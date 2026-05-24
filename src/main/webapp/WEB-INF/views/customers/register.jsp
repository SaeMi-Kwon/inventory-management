<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>거래처 등록</h3>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">
            ${errorMessage}
        </div>
    </c:if>

    <c:if test="${param.success eq 'true'}">
        <div class="alert alert-success">
            거래처 등록이 완료되었습니다.
        </div>
    </c:if>

    <form action="/customers/register" method="post">

        <div class="card">
            <div class="card-body">
                <div class="row">

                    <div class="col-md-6 mb-3">
                        <label class="form-label">거래처코드</label>
                        <input type="text" name="customerCode" class="form-control" value="${customer.customerCode}" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">거래처명</label>
                        <input type="text" name="customerName" class="form-control" value="${customer.customerName}" required>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">거래처유형</label>
                        <select name="customerType" class="form-select" required>
                            <option value="">선택하세요</option>
                            <option value="SUPPLIER" ${customer.customerType == 'SUPPLIER' ? 'selected' : ''}>
                                공급처
                            </option>
                            <option value="BUYER" ${customer.customerType == 'BUYER' ? 'selected' : ''}>
                                구매처
                            </option>
                        </select>
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">사업자번호</label>
                        <input type="text" name="businessNo" class="form-control"
                               value="${customer.businessNo}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">대표자명</label>
                        <input type="text" name="ceoName" class="form-control" value="${customer.ceoName}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">대표 연락처</label>
                        <input type="text" name="phone" class="form-control" value="${customer.phone}">
                    </div>

                    <div class="col-md-12 mb-3">
                        <label class="form-label">이메일</label>
                        <input type="email" name="email" class="form-control" value="${customer.email}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">담당자명</label>
                        <input type="text" name="managerName" class="form-control" value="${customer.managerName}">
                    </div>

                    <div class="col-md-6 mb-3">
                        <label class="form-label">담당자 연락처</label>
                        <input type="text" name="managerPhone" class="form-control" value="${customer.managerPhone}">
                    </div>

                    <div class="col-md-12 mb-3">
                        <label class="form-label">주소</label>
                        <input type="text" name="address" class="form-control" value="${customer.address}">
                    </div>

                    <div class="col-md-12 mb-3">
                        <label class="form-label">비고</label>
                        <textarea name="remark" class="form-control" rows="4">${customer.remark}</textarea>
                    </div>

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

    </form>

</div>