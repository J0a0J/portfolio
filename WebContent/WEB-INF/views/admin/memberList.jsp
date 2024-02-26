<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<!-- mobile settings -->
		
	
		<!-- JQGRID TABLE ㅇㅇㅇㅇㅇ-->
		
		
		<link href="<c:url value='/resources/plugins/jqgrid/css/ui.jqgrid.css'/>" rel="stylesheet" type="text/css" />
		<link href="<c:url value='/resources/css/layout-jqgrid.css'/>" rel="stylesheet" type="text/css" />
	</head>
<body>


	<section class="page-header page-header-xs">
				<div class="container">
					<h1>회원 관리 - 조회 및 삭제 </h1>
				</div>
			</section>
			<!-- /PAGE HEADER -->

			<!-- -->
			<section>
				<div class="container">

				<table id="jqgrid"></table>
				<div id="pager_jqgrid"></div>

				<br />


				<div class="divider divider-dotted"></div>



				</div>
			</section>
			<!-- / "<c:url value='/resources/~~'/>" -->
			
			


	<!-- PAGE LEVEL SCRIPTS ㅇㅇㅇㅇㅇ-->
		<script src="<c:url value='/resources/plugins/jqgrid/js/jquery.jqGrid.js'/>"></script>
		<script src="<c:url value='/resources/plugins/jqgrid/js/i18n/grid.locale-en.js'/>"></script>
		<script src="<c:url value='/resources/plugins/bootstrap.datepicker/js/bootstrap-datepicker.min.js'/>"></script>
		<script>
		
$(document).ready(function(){		
			var jqgrid_data = [{
				id : "1",
				date : "2014-10-01",
				name : "Test 1",
				note : "Note 1",
				amount : "150.00",
				tax : "15.00",
				total : "210.00"
			}];

			// ----------------------------------------------------------------------------------------------------
			jQuery("#jqgrid").jqGrid({ // jqGrid그리기 
				url: "<c:url value='/admin/memberList.do'/>", 
				datatype : "json",
				height : '250',
				jsonReader:{ id : "memberIdx"}, //지정할 PK 컬럼/ 변수값 
				prmNames:{ id : "memberIdx"},  // PK 키값 변경
				// key-value넘어갈때 id와 순서로 넘어가는데 지정해주면 밑의 컬럼과 일치하는것 넘어감.
				
				colModel : [
					{ label: '순번', name: 'memberIdx', width: 30 },
					{ label: 'ID', name: 'memberId', width: 90 },
					{ label: '이름', name: 'memberName', width: 100 },
					{ label: '닉네임', name: 'memberNick', width: 80},
					{ label: 'email', name: 'email', width: 120},
					{ label: '가입일', name: 'createDate', width: 80},
		               
				],
				
				rowNum : 10,
				rowList : [10, 20, 30],
				pager : '#pager_jqgrid',
				sortname : 'id',
				toolbarfilter: true,
				viewrecords : true,
				sortorder : "asc",
				gridComplete: function(){
					var ids = jQuery("#jqgrid").jqGrid('getDataIDs');
					for(var i=0;i < ids.length;i++){
						var cl = ids[i];
						be = "<button class='btn btn-sm btn-default btn-quick' title='Edit Row' onclick=\"jQuery('#jqgrid').editRow('"+cl+"');\"><i class='fa fa-pencil'></i></button>"; 
						se = "<button class='btn btn-sm btn-default btn-quick' title='Save Row' onclick=\"jQuery('#jqgrid').saveRow('"+cl+"');\"><i class='fa fa-save'></i></button>";
						ca = "<button class='btn btn-sm btn-default btn-quick' title='Cancel' onclick=\"jQuery('#jqgrid').restoreRow('"+cl+"');\"><i class='fa fa-times'></i></button>";  
						jQuery("#jqgrid").jqGrid('setRowData',ids[i],{act:be+se+ca});
					}	
				},
			
				
				rowNum: 10, // 가져올 게시글 수 (기본) 
				rowList: [5, 10, 15], // 강져올 게시글 수 (선택)
				
				caption : '회원 목록' , // 그리드 제목 
				rownumbers: true, //그리드 목록 대한 순번
				sortname:"memberIdx", // 기본 정렬기준 컬럼 :idx   
				sortorder:"desc", // 기본 정렬 설정:  내림차순 
				scrollrows:true,
				viewrecords:true,
				pager: "#pager_jqgrid" 
				
			});			
			// ----------------------------------------------------------------------------------------------------

			//enable datepicker
			function pickDate( cellvalue, options, cell ) {
				setTimeout(function(){
					jQuery(cell) .find('input[type=text]')
							.datepicker({format:'yyyy-mm-dd' , autoclose:true}); 
				}, 0);
			}

			//nav Buttons 버튼활성화.. 
			jQuery("#jqgrid").jqGrid('navGrid', "#pager_jqgrid", { 
				edit : false,
				add : false,
				del : true,
				search: false,
				refresh: true, //.새로고침 
				view: false // 상세조회 (새창)
				//옵션 순서따라 설정.
			},
			{}, //edit 
			{}, //add
			
			{ //del 
				caption:'회원정보 삭제',
				msg: "선택한 회원을 삭제 하시겠습니까?",
				//width: 400,
				//height: 200,
				recreateForm: true,
				url: '<c:url value="/member/delMember.do" />',
				
				
				//보내기 전 
				beforeSubmit : function(params){
				//post: 지울 key 값
				console.log('beforeSubmit: '+ params);
				//post로 row값 전체 가져오기, return type= OBject
				var rowData = $('#jqgrid').jqGrid('getRowData', params);
							// $('#jqGrid') > html table:<table id="jqGrid"></table>
							// 저 테이블 찾아가서 jqGrid: jqGrid그리는 펑션: (): 매개변수
				console.log("??");
				console.log(rowData);
				console.log(rowData.memberId);
				console.log(rowData.memberIdx);
			
				var loginId = '${sessionScope.memberId}';
					if(loginId == rowData.memberId){
						return [false,"자기 자신을 삭제할 수 없습니다.."]; // false: submit안함. 
					}
					return [true, ""];
				},
				//완료 된 후 실행 
				afterComplete : function(result, postdata){ // result can be potato
					/*
					console.log('delOption - afterComplete');
					console.log(result);
					console.log(result.responseJSON); //result의 여러 속성들중 responseJSON: respJson으로 꺼내기
					//e.g) responseJSON: {msg: "삭제되었습니다.", result: 1}
					*/
					alert(result.responseJSON.msg);
				},

			});
			

			// On Resize
			jQuery(window).resize(function() {

				if(window.afterResize) {
					clearTimeout(window.afterResize);
				}

				window.afterResize = setTimeout(function() {

					/**
						After Resize Code
						.................
					**/

					jQuery("#jqgrid").jqGrid('setGridWidth', jQuery("#middle").width() - 32);

				}, 500);

			});


			// ----------------------------------------------------------------------------------------------------

			/**
				@STYLING
			**/
			jQuery(".ui-jqgrid").removeClass("ui-widget ui-widget-content");
			jQuery(".ui-jqgrid-view").children().removeClass("ui-widget-header ui-state-default");
			jQuery(".ui-jqgrid-labels, .ui-search-toolbar").children().removeClass("ui-state-default ui-th-column ui-th-ltr");
			jQuery(".ui-jqgrid-pager").removeClass("ui-state-default");
			jQuery(".ui-jqgrid").removeClass("ui-widget-content");

			jQuery(".ui-jqgrid-htable").addClass("table table-bordered table-hover");
			jQuery(".ui-pg-div").removeClass().addClass("btn btn-sm btn-primary");
			//jQuery(".ui-icon.ui-icon-plus").removeClass().addClass("fa fa-plus"); //add 
			//jQuery(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil"); //edit
			jQuery(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o"); //delete
			jQuery(".ui-icon.ui-icon-search").removeClass().addClass("fa fa-search");
			jQuery(".ui-icon.ui-icon-refresh").removeClass().addClass("fa fa-refresh");
			jQuery(".ui-icon.ui-icon-disk").removeClass().addClass("fa fa-save").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");
			jQuery(".ui-icon.ui-icon-cancel").removeClass().addClass("fa fa-times").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");

			jQuery( ".ui-icon.ui-icon-seek-prev" ).wrap( "<div class='btn btn-sm btn-default'></div>" );
			jQuery(".ui-icon.ui-icon-seek-prev").removeClass().addClass("fa fa-backward");

			jQuery( ".ui-icon.ui-icon-seek-first" ).wrap( "<div class='btn btn-sm btn-default'></div>" );
			jQuery(".ui-icon.ui-icon-seek-first").removeClass().addClass("fa fa-fast-backward");		  	

			jQuery( ".ui-icon.ui-icon-seek-next" ).wrap( "<div class='btn btn-sm btn-default'></div>" );
			jQuery(".ui-icon.ui-icon-seek-next").removeClass().addClass("fa fa-forward");

			jQuery( ".ui-icon.ui-icon-seek-end" ).wrap( "<div class='btn btn-sm btn-default'></div>" );
			jQuery(".ui-icon.ui-icon-seek-end").removeClass().addClass("fa fa-fast-forward");
			
});
		</script>
</body>
</html>