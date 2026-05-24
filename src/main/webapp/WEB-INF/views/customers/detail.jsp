<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="container-fluid">

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3>거래처 상세보기</h3>

        <div class="d-flex gap-2">
            <a href="/customers/edit/${customer.customerId}" class="btn btn-primary">
                수정
            </a>

            <a href="/customers/list" class="btn btn-secondary">
                목록
            </a>
        </div>
    </div>

    <div class="card">
        <div class="card-body">

            <table class="table table-bordered align-middle">

                <tr>
                    <th style="width: 180px;">거래처코드</th>
                    <td>${customer.customerCode}</td>
                </tr>

                <tr>
                    <th>거래처명</th>
                    <td>${customer.customerName}</td>
                </tr>

                <tr>
                    <th>거래처유형</th>
                    <td>
                        ${customer.customerType}
                    </td>
                </tr>

                <tr>
                    <th>사업자번호</th>
                    <td>${customer.businessNo}</td>
                </tr>

                <tr>
                    <th>대표자명</th>
                    <td>${customer.ceoName}</td>
                </tr>

                <tr>
                    <th>대표 연락처</th>
                    <td>${customer.phone}</td>
                </tr>

                <tr>
                    <th>이메일</th>
                    <td>${customer.email}</td>
                </tr>

                <tr>
                    <th>주소</th>
                    <td>${customer.address}</td>
                </tr>

                <tr>
                    <th>담당자명</th>
                    <td>${customer.managerName}</td>
                </tr>

                <tr>
                    <th>담당자 연락처</th>
                    <td>${customer.managerPhone}</td>
                </tr>

                <tr>
                    <th>사용여부</th>
                    <td>${customer.useYn}</td>
                </tr>

                <tr>
                    <th>비고</th>
                    <td>${customer.remark}</td>
                </tr>

                <tr>
                    <th>등록일시</th>
                    <td>${customer.createdAt}</td>
                </tr>

                <tr>
                    <th>수정일시</th>
                    <td>${customer.updatedAt}</td>
                </tr>

            </table>

        </div>
    </div>

</div>