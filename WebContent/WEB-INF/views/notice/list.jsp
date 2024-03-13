<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<style>
.search-container {
    text-align: center;
}
.search-input,
.search-select {
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 5px;
    margin-right: 10px;
    box-sizing: border-box; /* 패딩과 경계선을 포함한 요소 크기를 지정합니다. */
}
</style>
	<section>
	<div class="container">
		<h4>공지사항</h4>
		<div class="table-responsive">
			<table class="table table-sm">
				<colgroup>
					<col width="10%" />
					<col width="35%" />
					<col width="10%" />
					<col width="8%" />
					<col width="8%" />
					<col width="15%" />
				</colgroup>

				<thead>
					<tr>
						<th class="fw-30" align="center">&emsp;&emsp;&emsp;#</th>
						<th align="center">제목</th>
						<th align="center">글쓴이</th>
						<th align="center">조회수</th>
						<th align="center">첨부파일</th>
						<th align="center">작성일</th>
					</tr>
				</thead>
				<tbody>

					<c:forEach var="member" items="${memberList}" varStatus="rowStatus">
						<tr>
							<td align="center">${member.boardSeq}</td>
							<td><span class="bold"> <a
									href="javascript:movePage('/notice/read.do?boardSeq=${member.boardSeq }&hasFile=${member.hasFile }&page=${currentPage }')">
										${member.title } </a>
							</span></td>
							<td>${member.memberNick}</td>
							<td>${member.hits}</td>
							<td>${member.hasFile}</td>
							<td>${member.createDtm}</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>
		<div class="row text-center">
			<div class="col-md-12">
				<ul class="pagination pagination-simple pagination-sm">
					<!-- 페이징 -->
					<li class="page-item"><a class="page-link"
						href="javascript:movePage('/notice/list.do?page=1')">&laquo;</a></li>
					<c:set var="lastPageNum" value="${pageTotalNum}" />
					<c:set var="pageUnit" value="10" />

					<c:choose>
						<c:when test="${lastPageTimes >= pageTimes}">
							<c:set var="beginPage" value="${1 + (pageTimes * 10)}" />
							<c:set var="endPage"
								value="${lastPageTimes eq pageTimes ? pageTotalNum : (pageUnit + (pageTimes * 10))}" />
						</c:when>
					</c:choose>

					<c:forEach begin="${beginPage}" end="${endPage}" var="i">
						<c:choose>
							<c:when test="${currentPage eq i}">
								<li class="page-item active"><a class="page-link"
									href="javascript:movePage('/notice/list.do?page=${i}')">${i}</a>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item"><a class="page-link"
									href="javascript:movePage('/notice/list.do?page=${i}')">${i}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					

					<li class="page-item"><a class="page-link"
						href="javascript:movePage('/notice/list.do?page=${pageUnit + 1 + (pageTimes * 10)}')">&raquo;</a></li>
					</li>
				</ul>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 text-right">
				<a href="javascript:movePage('/notice/goToWrite.do')">
					<button type="button" class="btn btn-primary">
						<i class="fa fa-pencil"></i> 글쓰기
					</button>
				</a>
			</div>
		</div>
		<form action="<c:url value='/notice/list.do'/>" method="GET">
		<div class="search-container">
	        <!-- 검색 조건 선택 드롭다운 -->
	        <select id="searchSelect" class="search-select" name="searchSelect">
	            <option value="title" name="title">제목</option>
	            <option value="author" name="memberId">글쓴이</option>
        	</select>	
	        <!-- 검색 입력란 -->
	        <input type="text" id="searchInput" class="search-input" placeholder="검색어를 입력하세요" name="searchInput">
	        <!-- 검색 버튼 -->
	        <!-- <a href="javascript:movePage('/notice/list.do?')"> -->
		        <button id="searchButton" class="btn btn-primary" type="submit">검색</button>
	        <!-- </a> -->
    	</div>
    	</form>
	</div>
	</section>
	<!-- / -->
</body>
</html>