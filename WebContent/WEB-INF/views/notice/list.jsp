<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<jsp:include page="../common-template.jsp" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<style>
.search-container {
	text-align: center;
}

.search-input, .search-select {
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 5px;
	margin-right: 10px;
	box-sizing: border-box; /* 패딩과 경계선을 포함한 요소 크기를 지정합니다. */
}
</style>
<script>

var ctx = "${pageContext.request.contextPath}";
/* console.log("pageNumber    " + pageNumber); */

 var tmp = window.location.href;
function getBoardData(pageNumber) {
	// RestController url - 데이터를 받아올 곳 
    var url = ctx + '/notice/' + pageNumber + '.do'; // 동적으로 URL 생성
    var moveUrl = ctx + '/notice/list.do?page=' + pageNumber;
    
    // url을 변경해도 현재의 페이지가 뜨게 해주는 기능 
    // Controller url - jsp를 사용해야 하기에 이 url 사용
    if(tmp.includes("searchContent")){	
    	history.pushState({}, '', tmp);
    	url = tmp;
    	console.log("url    "+ url);
    } else {
	    history.pushState({}, '', moveUrl);
    }
    
    
   	
    $.ajax({
        url: url,
        type: 'GET',
        success: function(data) {
            // 성공적으로 데이터를 받아온 경우 처리 로직
            var boardList = data.boardInfo;
            var html = ''; 

            // 받아온 데이터로 HTML을 생성
            for (var i = 0; i < boardList.length; i++) {
                var board = boardList[i];
               	var boardUrl = '<c:url value="/notice/read.do?page=' + pageNumber + '&boardSeq=' + board.boardSeq + '" />';
                
                // 생성한 HTML을 변수에 추가
                html += '<tr>' +
                            '<td align="center">' + board.boardSeq + '</td>' +
                            '<td>' +
                                '<span class="bold"><a href="' + boardUrl +'">' + 
                                        board.title + '</a>' +
                                '</span>' +
                            '</td>' +
                            '<td>' + board.memberNick + '</td>' +
                            '<td>' + board.hits + '</td>' +
                            '<td>' + (board.hasFile ? board.hasFile : '') + '</td>' +
                            '<td>' + (board.createDtm ? board.createDtm : '') + '</td>' +
                        '</tr>';
                        
            	generatePagination(data.pageTotalNums, data.pageGroup, ${page});
            }

            // 생성한 HTML을 tbody에 삽입 
            $('#boardTableBody').html(html);
            
        },
        error: function(xhr, status, error) {
            console.error(error); // 오류 처리
        }
    });
}

function hadleEnterkeyPress(event) {
	if(event.keyCode == 13){ // Enter의 keyCode는 13 
		submitForm();
	}
}

function submitForm() {
    var searchSelect = document.getElementById("searchSelect").value;
    var searchInput = document.getElementById("searchInput").value;
    var url = '<c:url value="/notice/list.do?searchSelect=' + searchSelect + '&searchContent=' + searchInput + '" />';
    document.getElementById("searchForm").setAttribute("action", url);
    document.getElementById("searchForm").submit();
}

function generatePagination(pageTotalNums, pageGroup, currentPage) {
    var pageUnit = 10;
    var beginPage = 1 + (pageGroup * pageUnit);
    var endPage = (pageTotalNums - currentPage) < 10 ? pageTotalNums : pageUnit + (pageGroup * 10);

    var html = '';

    // 이전 페이지로 이동하는 링크 - 1보다 값이 작아지면 1로 설정. 
    var prevPage = '<c:url value="/notice/list.do?page=' +  Math.max(1, (beginPage - pageUnit)) + '" />';
    var firstPage = '<c:url value="/notice/list.do?page=' +  1 + '" />';
    		
    html += '<li class="page-item"><a class="page-link" href="' + firstPage + '" data-page="' + (beginPage - pageUnit) + '">&laquo;</a></li>';
    html += '<li class="page-item"><a class="page-link" href="' + prevPage + '" data-page="1">&lt;</a></li>';

    // 페이지 번호 생성
    for (var i = beginPage; i <= endPage; i++) {
    	
    	var baseUrl = '<c:url value="/notice/list.do?page=' + i + '" />';
    	var nextUrl = '<c:url value="/notice/list.do?page=' + (pageUnit + 1 + (pageGroup * 10)) + '" />'
    			
        if (currentPage == i) {
        	// Controller로 현재 페이지 값을 보내고  
            html += '<li class="page-item active"><a class="page-link" href="/notice/list.do?page=' + i 
            		+ '" data-page="' + i + '">' + i + '</a></li>';
        } else {
        	html += '<li class="page-item"><a class="page-link" href="' + baseUrl + '" data-page="' + i + '">' + i + '</a></li>';
        }
    }
	// 다음 페이지로 이동하는 링크
	html += '<li class="page-item"><a class="page-link" href="' + nextUrl + '" data-page="' + (pageUnit + 1 + (pageGroup * 10)) + '">&gt;</a></li>';
	
    // 가장 마지막 페이지 
    var lastUrl = '<c:url value="/notice/list.do?page=' + pageTotalNums +'" />';
    // 마지막 페이지로 이동하는 링크
    html += '<li class="page-item"><a class="page-link" href="' + lastUrl + '" data-page="' + (pageUnit + 1 + (pageGroup * 10)) + '">&raquo;</a></li>';

    // 페이지 번호를 출력할 요소에 HTML 삽입
    $('#pagination').html(html);
}

// 페이지 로드 시 데이터 요청
window.onload = function() {
	// 동적으로 url 변경을 위해 Controller에서 값을 받아옴.
    var currentPage = parseInt('${page}');
    getBoardData(currentPage); // 초기 페이지 번호를 전달하여 데이터 요청
}

$(document).ready(function() {
	console.log("document ready");
	// 동적으로 url 변경을 위해 Controller에서 값을 받아옴.
	var currentPage = parseInt('${page}');
    getBoardData(currentPage); // 초기 페이지 번호를 전달하여 데이터 요청
    
    
	$('.search-btn').on('click', function() {
		console.log("search btn clicked ");
			let option = document
					.querySelector('.search-select').value;
			let keyword = document
					.querySelector('.search-input').value;
			console.log(option);
			console.log(keyword);
			let toSearch = "notice/list.do?searchSelect="
					+ option + "&searchContent=" + keyword;
			console.log(toSearch);
			window.location.href = toSearch;
	});
});

</script>
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
				
				<!-- 공지글 정보 들어가는 곳 -->
				<tbody id="boardTableBody">
				</tbody>
				
			</table>
		</div>
		<div class="row text-center">
			<div class="col-md-12">
			
				<!-- 하단 번 -->
				<ul class="pagination pagination-simple pagination-sm" id="pagination">
				</ul>
				
			</div>
		</div>
		<div class="row">
			<div class="col-md-12 text-right">
				<a href="<c:url value='/notice/goToWrite.do' />">
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
					<option value="member_nick" name="member_nick">글쓴이</option>
				</select>
				<!-- 검색 입력란 -->
				<input type="text" id="searchInput" class="search-input"
					placeholder="검색어를 입력하세요" name="searchContent">
				<!-- 검색 버튼 -->
				<button id="searchButton" class="btn btn-primary search-btn" onclick="submitForm()"
					type="submit">검색</button>
				<!-- <a href="javascript:movePage('/notice/list.do?')"> -->
				<!-- </a> -->
			</div>
		</form>
	</div>
	</section>
	<!-- / -->
</body>
<jsp:include page="../common-template-footer.jsp" />
</html>