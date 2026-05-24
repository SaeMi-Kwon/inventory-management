<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container-fluid">

    <!-- 제목 -->
    <div class="d-flex justify-content-between align-items-center mb-4">

        <h3>거래처 수정</h3>

        <div class="d-flex gap-2">

            <a href="/customers/detail/${customer.customerId}" class="btn btn-secondary">
                상세보기
            </a>

            <a href="/customers/list" class="btn btn-dark">
                목록
            </a>

        </div>

    </div>


    <!-- 수정 폼 -->
    <form action="/customers/edit/${customer.customerId}" method="post">

        <div class="card">

            <div class="card-body">

                <div class="row">

                    <!-- 거래처코드 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">거래처코드</label>
                        <input type="text" class="form-control" value="${customer.customerCode}" readonly>
                    </div>

                    <!-- 거래처명 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">거래처명</label>
                        <input type="text" name="customerName" class="form-control" value="${customer.customerName}" required>
                    </div>

                    <!-- 거래처유형 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">거래처유형</label>
                        <select name="customerType" class="form-select" required>
                            <option value="SUPPLIER" ${customer.customerType == 'SUPPLIER' ? 'selected' : ''}>
                                공급처
                            </option>
                            <option value="BUYER" ${customer.customerType == 'BUYER' ? 'selected' : ''}>
                                구매처
                            </option>
                        </select>
                    </div>

                    <!-- 사업자번호 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">사업자번호</label>
                        <input type="text" name="businessNo" class="form-control" value="${customer.businessNo}">
                    </div>

                    <!-- 대표자명 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">대표자명</label>
                        <input type="text" name="ceoName" class="form-control" value="${customer.ceoName}">
                    </div>

                    <!-- 대표 연락처 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">대표 연락처</label>
                        <input type="text" name="phone" class="form-control" value="${customer.phone}">
                    </div>

                    <!-- 이메일 -->
                    <div class="col-md-12 mb-3">
                        <label class="form-label">이메일</label>
                        <input type="email" name="email" class="form-control" value="${customer.email}">
                    </div>

                    <!-- 담당자명 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">담당자명</label>
                        <input type="text" name="managerName" class="form-control" value="${customer.managerName}">
                    </div>

                    <!-- 담당자 연락처 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">담당자 연락처</label>
                        <input type="text" name="managerPhone" class="form-control" value="${customer.managerPhone}">
                    </div>

                    <!-- 주소 -->
                    <div class="col-md-12 mb-3">
                        <label class="form-label">주소</label>
                        <input type="text" name="address" class="form-control" value="${customer.address}">
                    </div>

                    <!-- 사용여부 -->
                    <div class="col-md-6 mb-3">
                        <label class="form-label">사용여부</label>
                        <select name="useYn" class="form-select">
                            <option value="Y" ${customer.useYn == 'Y' ? 'selected' : ''}>
                                사용
                            </option>
                            <option value="N" ${customer.useYn == 'N' ? 'selected' : ''}>
                                미사용
                            </option>
                        </select>
                    </div>

                    <!-- 비고 -->
                    <div class="col-md-12 mb-3">
                        <label class="form-label">비고</label>
                        <textarea name="remark" class="form-control" rows="4">${customer.remark}</textarea>
                    </div>

                </div>

            </div>

        </div>


        <!-- 버튼 -->
        <div class="mt-4 text-end">

            <button type="submit" class="btn btn-primary">
                수정
            </button>

            <a href="/customers/detail/${customer.customerId}" class="btn btn-secondary">
                취소
            </a>

        </div>

    </form>

</div>