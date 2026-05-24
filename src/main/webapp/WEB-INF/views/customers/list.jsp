<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>거래처 목록</h3>

        <a href="/customers/register" class="btn btn-primary">
            거래처 등록
        </a>
    </div>

    <form action="/customers/list" method="get" class="row g-2 mb-4">

        <div class="col-md-2">
            <input type="text"
                   name="customerCode"
                   class="form-control"
                   placeholder="거래처코드"
                   value="${searchDTO.customerCode}">
        </div>

        <div class="col-md-3">
            <input type="text"
                   name="customerName"
                   class="form-control"
                   placeholder="거래처명"
                   value="${searchDTO.customerName}">
        </div>

        <div class="col-md-2">
            <select name="customerType" class="form-select">
                <option value="">거래처유형 전체</option>

                <option value="SUPPLIER"
                    ${searchDTO.customerType == 'SUPPLIER' ? 'selected' : ''}>
                    공급처
                </option>

                <option value="BUYER"
                    ${searchDTO.customerType == 'BUYER' ? 'selected' : ''}>
                    구매처
                </option>
            </select>
        </div>

        <div class="col-md-2">
            <select name="useYn" class="form-select">
                <option value="">사용여부 전체</option>

                <option value="Y"
                    ${searchDTO.useYn == 'Y' ? 'selected' : ''}>
                    사용
                </option>

                <option value="N"
                    ${searchDTO.useYn == 'N' ? 'selected' : ''}>
                    미사용
                </option>
            </select>
        </div>

        <div class="col-auto">
            <button type="submit" class="btn btn-primary">
                검색
            </button>
        </div>

        <div class="col-auto">
            <a href="/customers/list" class="btn btn-secondary">
                초기화
            </a>
        </div>

    </form>

    <div class="card">
        <div class="card-body">

            <table class="table table-bordered table-hover align-middle text-center">
                <thead class="table-light">
                    <tr>
                        <th>번호</th>
                        <th>거래처코드</th>
                        <th>거래처명</th>
                        <th>거래처유형</th>
                        <th>사업자번호</th>
                        <th>대표자명</th>
                        <th>연락처</th>
                        <th>담당자명</th>
                        <th>사용여부</th>
                        <th>등록일시</th>
                    </tr>
                </thead>

                <tbody>

                    <c:if test="${empty customerList}">
                        <tr>
                            <td colspan="10">
                                등록된 거래처가 없습니다.
                            </td>
                        </tr>
                    </c:if>

                    <c:forEach var="customer"
                               items="${customerList}"
                               varStatus="status">

                        <tr style="cursor:pointer;" onclick="location.href='/customers/detail/${customer.customerId}'">
                            <td>${status.count}</td>
                            <td>${customer.customerCode}</td>
                            <td>${customer.customerName}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${customer.customerType == 'SUPPLIER'}">
                                        공급처
                                    </c:when>
                                    <c:when test="${customer.customerType == 'BUYER'}">
                                        구매처
                                    </c:when>
                                    <c:otherwise>
                                        ${customer.customerType}
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>${customer.businessNo}</td>
                            <td>${customer.ceoName}</td>
                            <td>${customer.phone}</td>
                            <td>${customer.managerName}</td>
                            <td>${customer.useYn}</td>
                            <td>${customer.createdAt}</td>
                        </tr>

                    </c:forEach>

                </tbody>
            </table>

        </div>
    </div>

</div>