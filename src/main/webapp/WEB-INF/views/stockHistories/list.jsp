<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="container-fluid">

    
    <div class="d-flex justify-content-between align-items-center mb-4">

        <h3>재고이력 조회</h3>

    </div>

  
    <div class="card mb-4">

        <div class="card-body">

            <form action="/stockHistories/list" method="get">

                <div class="row g-3">

                    <div class="col-md-4">
                        <label class="form-label">검색어</label>
                        <input type="text" name="keyword" class="form-control" value="${searchDTO.keyword}" placeholder="품목코드 / 품목명 / 창고명">
                    </div>
               
                    <div class="col-md-3">
                        <label class="form-label">이력유형</label>
                        <select name="historyType" class="form-select">
                            <option value="">전체</option>
                            <option value="INBOUND" ${searchDTO.historyType == 'INBOUND' ? 'selected' : ''}>
                                입고
                            </option>
                            <option value="OUTBOUND" ${searchDTO.historyType == 'OUTBOUND' ? 'selected' : ''}>
                                출고
                            </option>
                            <option value="ADJUST" ${searchDTO.historyType == 'ADJUST' ? 'selected' : ''}>
                                재고조정
                            </option>
                            <option value="OUTBOUND_CANCEL" ${searchDTO.historyType == 'OUTBOUND_CANCEL' ? 'selected' : ''}>
                                출고취소
                            </option>
                            <option value="INBOUND_CANCEL" ${searchDTO.historyType == 'INBOUND_CANCEL' ? 'selected' : ''}>
                                입고취소
                            </option>
                            <option value="INITIAL" ${searchDTO.historyType == 'INITIAL' ? 'selected' : ''}>
                                초기재고
                            </option>
                        </select>
                    </div>

                    <div class="col-md-5 d-flex align-items-end justify-content-end">
                        <button type="submit" class="btn btn-primary me-2">
                            검색
                        </button>

                        <a href="/stockHistories/list" class="btn btn-secondary">
                            초기화
                        </a>
                    </div>

                </div>

            </form>

        </div>

    </div>

    <!-- 목록 영역 -->
    <div class="card">

        <div class="card-body">

            <div class="table-responsive">

                <table class="table table-bordered table-hover align-middle text-center">

                    <thead class="table-light">

                    <tr>

                        <th>이력번호</th>
                        <th>유형</th>
                        <th>품목코드</th>
                        <th>품목명</th>
                        <th>창고명</th>
                        <th>변경전</th>
                        <th>변경수량</th>
                        <th>변경후</th>
                        <th>처리자</th>
                        <th>처리일시</th>
                        <th>비고</th>

                    </tr>

                    </thead>

                    <tbody>

                    <!-- 데이터 없을 때 -->
                    <c:if test="${empty historyList}">
                        <tr>
                            <td colspan="11">
                                조회된 재고이력이 없습니다.
                            </td>
                        </tr>
                    </c:if>

                    <!-- 목록  -->
                    <c:forEach var="history" items="${historyList}">

                        <tr>

                            <td>${history.historyId}</td>

                            <td>
                                <c:choose>
                                    <c:when test="${history.historyType == 'INBOUND'}">
                                        <span class="badge bg-primary">
                                            입고
                                        </span>
                                    </c:when>
                                    <c:when test="${history.historyType == 'OUTBOUND'}">
                                        <span class="badge bg-danger">
                                            출고
                                        </span>
                                    </c:when>                               
                                    <c:when test="${history.historyType == 'ADJUST'}">
                                        <span class="badge bg-warning text-dark">
                                            재고조정
                                        </span>
                                    </c:when>
                                    <c:when test="${history.historyType == 'OUTBOUND_CANCEL'}">
                                        <span class="badge bg-dark">
                                            출고취소
                                        </span>
                                    </c:when>
                                    <c:when test="${history.historyType == 'INBOUND_CANCEL'}">
                                        <span class="badge bg-secondary">
                                            입고취소
                                        </span>
                                    </c:when>
                                    <c:when test="${history.historyType == 'INITIAL'}">
                                        <span class="badge bg-success">
                                            초기재고
                                        </span>
                                    </c:when>                                  
                                    <c:otherwise>
                                        ${history.historyType}
                                    </c:otherwise>
                                </c:choose>
                            </td>
                   
                            <td>${history.itemCode}</td>                 
                            <td>${history.itemName}</td>       
                            <td>${history.warehouseName}</td>
                            <td>${history.beforeQuantity}</td>
                         
                            <td>
                                <c:choose>                           
                                    <c:when test="${history.changeQuantity > 0}">
                                        <span class="text-primary">
                                            +${history.changeQuantity}
                                        </span>
                                    </c:when>

                                    <c:when test="${history.changeQuantity < 0}">
                                        <span class="text-danger">
                                            ${history.changeQuantity}
                                        </span>
                                    </c:when>

                                    <c:otherwise>
                                        ${history.changeQuantity}
                                    </c:otherwise>
                                </c:choose>
                            </td>
  
                            <td>${history.afterQuantity}</td>                           
                            <td>${history.processUserName}</td>                        
                            <td>${history.createdAt}</td>                        
                            <td>${history.remark}</td>

                        </tr>

                    </c:forEach>

                    </tbody>

                </table>

            </div>

        </div>

    </div>

</div>