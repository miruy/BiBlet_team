<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css">
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/bootstrap.min2.css"> --%>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/star.css">
<title>BiBlet 도서 상세/평가</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"
	integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
	crossorigin="anonymous"></script>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand" href="/Main">BiBlet</a>
    <div class="collapse navbar-collapse" id="navbarColor01">
       <div class="form-group">
		<select class="form-select" id="exampleSelect1" name="option">
			<option value="title">제목</option>
			<option value="author">저자</option>
			<option value="publisher">출판사</option>
		</select>
		</div>
      <form class="d-flex">
        <input class="form-control me-sm-2"  type="text" name="query" id="query" value="${query}" placeholder="제목, 저자 또는 출판사 검색">
        <button class="btn btn-secondary my-2 my-sm-0" id="search">Search</button>
      </form>
    </div>
	<button class="btn btn-secondary my-2 my-sm-0" id="mypage" onClick="location.href = '/MyPage'">마이페이지</button>
	<button class="btn btn-secondary my-2 my-sm-0" id="mainpage" onClick="location.href = '/MainLogin'">메인페이지</button>
  </div>	
</nav>

	<div id="searchBook"></div>
	
	<div class="container">
	 	<div class="row">
		 	<div style="margin-top: 40px;" class="col-4">
				<div id="bookThumbnail"></div>
			</div>
			<div class="col-6">
				<div style="margin-top: 40px;" id="bookTitle" ></div>	
				<form:form method="post" commandName="insertCmd" onsubmit="return bookSubmit()">
				
					<div style="float: right;">
						<div style="padding-left: 30px;">독서 상태</div>
						 <select style="width:120px; height:36px;" id="option" name="option" onChange="bookStatus()" >
							<option value="none">=== 선택 ===</option>
							<option value=0>찜</option>
							<option value=1>보는 중</option>
							<option value=2>독서 완료</option>
						</select>
						<button class="btn btn-secondary my-2 my-sm-0" id='insertStatus' onclick="insertStatus()">등록</button>
						<div class="text-muted" >* 독서 완료 시에만 평가 작성이 가능합니다.</div>
					</div>
					
					<div style="padding-left: 70px; margin-top: 30px;" >평가하기</div>
						
					<div class="star-rating">
						<input type="radio" id="5-star" name="star" value=5 /> 
						<label for="5-star" class="star">&#9733;</label> 
						<input type="radio" id="4-star" name="star" value=4 /> 
						<label for="4-star" class="star">&#9733;</label> 
						<input type="radio" id="3-star" name="star" value=3 /> 
						<label for="3-star" class="star">&#9733;</label>
						<input type="radio" id="2-star" name="star" value=2 /> 
						<label for="2-star" class="star">&#9733;</label> 
						<input type="radio" id="1-star" name="star" value=1 /> 
						<label for="1-star" class="star">&#9733;</label>
					</div>
					
					<h3 style="margin-top: 20px;">코멘트</h3>
					<textarea class="form-control" rows="5" id="book_comment" name="book_comment"
					placeholder="이 작품의 대한 생각을 자유롭게 표현해주세요."></textarea>
			
			
					<div style="float: left; margin-top: 20px; margin-left: 25px;">독서 시작 날짜 : <input type="date" id="start_date" name="start_date" /></div>
					<div style="float: left; margin-top: 20px; margin-left: 25px;">독서 완료 날짜 : <input type="date" id="end_date" name="end_date" /></div>
					
					<div style="float: left; margin-top: 20px; margin-left: 145px;"> 공개 여부 :</div>
						
					<div style="float: left; margin-top: 20px; margin-left: 25px;">
						공개 <input class="form-check-input" type="checkbox" id="co_prv" name="co_prv" value="공개" onclick='checkOnlyOne(this)'/> 
					</div>
						
					<div style="float: left; margin-top: 20px; margin-left: 25px;">
					 	비공개<input class="form-check-input" type="checkbox" id="co_prv" name="co_prv" value="비공개" onclick='checkOnlyOne(this)'/>
					</div>
					
						
					<input type="hidden" name="isbn" id="isbn" value="${isbn}" /> 
					<input type="hidden" name="query" id="query" value="${query}" />
					
					<div  style="float: left; margin-top: 20px; margin-left: 200px;">
						<input class="btn btn-secondary my-2 my-sm-0" type="submit" value="코멘트 등록하기" id="writeComment" /> 
					</div>
					
					<span id="msg"></span>
				</form:form>
				
			</div>
		</div>
	</div>

<div class="container">
	<div class="row">
		<div style="margin-top: 30px;" class="col"></div>
			<div style="margin-top: 30px;" class="col-11">
				<div class="card border-secondary mb-3" style="max-width: 100rem;">
				  <div class="card-header"><h4>기본 정보</h4></div>
				 	 <div class="card-body">
				 	 	<div class="card-text" id="bookInfo"></div>
					 </div>
				</div>
			</div>
		<div style="margin-top: 100px;" class="col"></div>
	</div>
</div>

<div class="container">
	<div class="row">
		<div class="col"></div>
			<div class="col-11">
				<div class="card text-white bg-secondary mb-3" style="max-width: 100rem;">
					<div class="card-header">
				  		<c:if test="${!empty commentCount}">
								평가 총 개수 : ${commentCount}	
						</c:if>
					</div>
					<div class="card-body">
					   <table class="table table-hover" style="margin-left: 10px; width: 95%;">
					   	<thead>
						    <tr>
						      <th scope="col">ID</th>
						      <th scope="col">코멘트</th>
						      <th scope="col">평가</th>
						      <th scope="col">독서 시작 날짜</th>
						      <th scope="col">독서 완료 날짜</th>
						      <th scope="col">수정/삭제</th>
						    </tr>
						 </thead>
						 <tbody>
						 	<c:if test="${!empty commentsByMembers}">
								 <c:forEach var="commentsByMember" items="${commentsByMembers}">
								 	<tr class="table-light">
								      <th scope="row">${commentsByMember.mem_id}</th>
								      <td>${commentsByMember.book_comment}</td>
								      <td>${commentsByMember.star}</td>
								      <td>${commentsByMember.start_date}</td>
								      <td>${commentsByMember.end_date}</td>
								      <td>
									    <input class="btn btn-secondary my-2 my-sm-0" type="button" value="삭제" onclick='deleteBtn(${commentsByMember.appraisal_num})' />
										<input class="btn btn-secondary my-2 my-sm-0" type='button' value='수정' onclick='updateBtn(${commentsByMember.appraisal_num})' />
								      </td>
								    </tr>
								  
									<input type="hidden" name="isbn" id="isbn" value="${isbn}" />
									<input type="hidden" name="query" id="query" value="${query}" />
									<input type="hidden" name="appraisal_num" id="appraisal_num" value="${commentsByMember.appraisal_num}" />
									<input type="hidden" name="mem_pass" id="mem_pass" value="${commentsByMember.mem_pass}" />
									<input type="hidden" name="book_status_num" id="book_status_num" value="${commentsByMember.book_status_num}" />
									<input type="hidden" name="book_comment" id="book_comment" value="${commentsByMember.book_comment}" />
									
									<div id="pd${commentsByMember.appraisal_num}"></div>
									<div id="pu${commentsByMember.appraisal_num}"></div>
						
									<div id="u${commentsByMember.appraisal_num}"></div>
									
								  </c:forEach>
						 	</c:if>
						 </tbody>
<%-- 								평가 번호 : ${commentsByMember.appraisal_num}  --%>
<%-- 								프로필 : ${commentsByMember.mem_pic}  --%>
<%-- 								비밀번호 : ${commentsByMember.mem_pass} --%>
<%-- 								book_status_num : ${commentsByMember.book_status_num} --%>
					   </table>
					   
				  	</div>
				</div>
			</div>
		<div style="margin-top: 100px;" class="col"></div>
	</div>
</div>
	
	<script>


// 		# '찜', '보는 중' 등록
		function insertStatus(){
			let option = $("#option").val();
			let isbn = $("#isbn").val();
			
			$.ajax({
				url: '<c:url value="/insertStatus"/>',
				type: 'POST',
				data: JSON.stringify({
					"option": option,
					"isbn": isbn
				}),
				dataType: "json",
				contentType: 'application/json',
				success: function(data) {
					location.reload(); 
				}, error: function(){
					location.reload(); 
				}

			});
		}
		
// 		# 평가 삭제를 위한 비밀번호 입력 폼 
		function deleteBtn(appraisal_num) {
			$("#pd"+appraisal_num).html(
			'비밀번호 입력 : '+
			'<input type="password" name="passCheck" id="passCheck" />'+
			'<input type="button" value="확인" onClick="passCheckAndDelete('+
					appraisal_num+')"/>');
		}
		
//		비밀번호 확인 및 평가 삭제	
		function passCheckAndDelete(appraisal_num){
			
			let isbn = $("#isbn").val();
			let query = $("#query").val();
			let passCheck = $("#passCheck").val();
			let mem_pass = $("#mem_pass").val();
			
			$.ajax({
				url: '<c:url value="/passCheck"/>',
				type: 'POST',
				data: JSON.stringify({
					"appraisal_num": appraisal_num,
					"passCheck": passCheck,
					"mem_pass": mem_pass,
					"isbn": isbn,
					"query": query
				}),
				dataType: "json",
				contentType: 'application/json',
				success: function(data) {
					if(data == 1){
					 	alert("비밀번호가 확인되었습니다.");
					 	deleteComment(appraisal_num);
					 	
					 	//비밀번호 입력 폼 사라지기
					 	$("#pd"+appraisal_num).hide();
					}else if(data == 0){
						alert("비밀번호가 일치하지 않습니다.");
						
						//비밀번호 입력 폼 사라지기
						$("#pd"+appraisal_num).html('');
					}
				}
			});
		}

// 		평가 삭제 요청		
		function deleteComment(appraisal_num){
			$.ajax({
				url: '<c:url value="/delete"/>',
				type: 'POST',
				data: JSON.stringify({
					"appraisal_num": appraisal_num
				}),
				dataType: "json",
				contentType: 'application/json',
				success: function(data) {
					location.reload(); 
				}, error: function(){
					location.reload(); 
				}
			});
		}


// 		# 평가 작성,수정 시 공개/비공개 둘 중 하나만 선택
		function checkOnlyOne(chk) {
		 let obj = document.getElementsByName("co_prv");
		    for(var i = 0; i < obj.length; i++){
		        if(obj[i] != chk){
		            obj[i].checked = false;
		        }
		    }
		}
			
//			# 평가 수정을 위한 비밀번호 입력 폼 
			function updateBtn(appraisal_num) {
				$("#pu"+appraisal_num).html(
						'비밀번호 입력 : '+
						'<input type="password" name="passCheck" id="passCheck" />'+
						'<input type="button" value="확인" onClick="passCheckAndUpdate('+
								appraisal_num+')"/>');
			}		  
	
		
//			비밀번호 확인 및 평가 수정 폼 보여주기
			function passCheckAndUpdate(appraisal_num){
				
				let isbn = $("#isbn").val();
				let query = $("#query").val();
				let passCheck = $("#passCheck").val();
				let mem_pass = $("#mem_pass").val();
				console.log(passCheck);
				
				$.ajax({
					url: '<c:url value="/passCheck"/>',
					type: 'POST',
					data: JSON.stringify({
						"appraisal_num": appraisal_num,
						"passCheck": passCheck,
						"mem_pass": mem_pass,
						"isbn": isbn,
						"query": query
					}),
					dataType: "json",
					contentType: 'application/json',
					success: function(data) {
						console.log(data);
 						if(data == 1){
						 	alert("비밀번호가 확인되었습니다.");
						 	
  						 	updateForm(appraisal_num);
						 	
 						 	//비밀번호 입력 폼 사라지기
  						 	$("#pu"+appraisal_num).html('');
 						}else if(data == 0){
 							alert("비밀번호가 일치하지 않습니다.");
							
 							//비밀번호 입력 폼 사라지기
 							$("#pu"+appraisal_num).html('');
 						}
					}
				});
				
			}	
	
// 			평가 수정 폼 
			function updateForm(appraisal_num) {
				let book_status_num = $("#book_status_num").val();
				let book_comment = $("#book_comment").val();
			
				 $("#u"+appraisal_num).html(
				 
				 '<p><strong>독서 상태 : 독서 완료 </strong></p>'+
				

				'별점 :'+
				'<div class="star-rating">'+
					'<input type="radio" id="m-5-star" name="m-star" value=5 />'+ 
					'<label for="m-5-star" class="star">&#9733;</label>'+
					'<input type="radio" id="m-4-star" name="m-star" value=4 />'+
					'<label for="m-4-star" class="star">&#9733;</label>'+ 
					'<input type="radio" id="m-3-star" name="m-star" value=3 />'+ 
					'<label for="m-3-star" class="star">&#9733;</label>'+
					'<input type="radio" id="m-2-star" name="m-star" value=2 />'+ 
					'<label for="m-2-star" class="star">&#9733;</label>'+ 
					'<input type="radio" id="m-1-star" name="m-star" value=1 />'+
					'<label for="m-1-star" class="star">&#9733;</label>'+
				'</div>'+

				'<p>'+
					'평가 :'+
					'<textarea id="book_commentU" name="book_comment"></textarea>'+
				'</p>'+


				'구독 시작 날짜 : <input type="date" id="start_dateU" name="start_date" />'+
				'구독 완료 날짜 : <input type="date" id="end_dateU" name="end_date" />'+
				'공개 : <input type="checkbox" id="co_prv" name="co_prv" value="공개" />'+
				'비공개 : <input type="checkbox" id="co_prv" name="co_prv" value="비공개" />'+
				
				'<input type="hidden" name="appraisal_num" id="appraisal_num" value="'+ appraisal_num +'" />'+ 
				'<input type="hidden" name="book_status_num" id="book_status_num" value="'+ book_status_num +'" />'+ 
				'<input type="button" value="등록" id="updateComment" onClick="updateComment('+ appraisal_num +')" />'
					);
			}


// 			평가 수정
			function updateComment(){
				let isbn = $("#isbn").val();
				let option = $("#optionU").val();
				let star = $("input[name=m-star]").val();
				let book_comment = $("#book_commentU").val();
				let start_date = $("#start_dateU").val();
				let end_date = $("#end_dateU").val();
				let co_prv = $("#co_prv").val();
				let query = $("#query").val();
				let appraisal_num = $("#appraisal_num").val();
				let book_status_num = $("#book_status_num").val();
				
				$.ajax({
					url: '<c:url value="/edit"/>',
					type: 'POST',
					data: JSON.stringify({
						"isbn": isbn,
						"option": option,	
						"star": star,	
						"book_comment": book_comment,	
						"start_date": start_date,	
						"end_date": end_date,	
						"co_prv": co_prv,
						"query": query,
						"appraisal_num": appraisal_num,
						"book_status_num": book_status_num
					}),
					dataType: "json",
					contentType: 'application/json',
					success: function(data) {
						$("#u"+appraisal_num).html('');
						location.reload(); 
					}, error: function(){
						location.reload(); 
					}
				});
			}


	
// 		 # 도서 검색 버튼 클릭 시 도서 데이터 요청
	   	 $(document).ready(function () {
	        var pageNum = 1;
	       $("#search").click(function () {	//검색 버튼 클릭시 ajax실행
	        	$.ajax({	//카카오 검색요청 / [요청]
	                method: "GET",
	                url: "https://dapi.kakao.com/v3/search/book",
	                data: { query: $("#query").val(), page: pageNum},
	                headers: {Authorization: "KakaoAK 6f9ab74953bbcacc4423564a74af264e"} 
	            })
	           
	            .done(function (msg) {	//검색 결과 담기 / [응답]
	            	console.log(msg);
	                for (var i = 0; i < 10; i++){
	                    $("#searchBook").append("<img src='" + msg.documents[i].thumbnail + "'/><br>");		//표지
	                    $("#searchBook").append("<h2><a href='/read/"+ msg.documents[i].isbn.slice(-13)+"?query="+$("#query").val()+ "'>" + msg.documents[i].title + "</a></h2>");	//제목
	                    $("#searchBook").append("<strong>저자:</strong> " + msg.documents[i].authors + "<br>");		//저자	
	                    $("#searchBook").append("<strong>출판사:</strong> " + msg.documents[i].publisher + "<br>");		//출판사
	                    $("#searchBook").append("<strong>줄거리:</strong> " + msg.documents[i].contents + "...<br>");		//줄거리
	                	$("#searchBook").append("<strong>ISBN:</strong>" + msg.documents[i].isbn + "<br>");	//일련번호
	                }
	            });
	       
	        	$('#searchBook').empty();
	        }) 
	       
	  		
//     		 # 상세페이지 실행하자마자 도서 데이터 요청
             var pageNum = 1;
	       	 var isbn_query = "${isbn}";
	       	 console.log(isbn_query);
            	$.ajax({	//카카오 검색요청 / [요청]
                    method: "GET",
                    url: "https://dapi.kakao.com/v3/search/book",
                    data: { query: isbn_query, page: pageNum},
                    headers: {Authorization: "KakaoAK 6f9ab74953bbcacc4423564a74af264e"} 
                })
               
                .done(function (msg) {	//검색 결과 담기 / [응답]
                	console.log(msg);
                        $("#bookThumbnail").append("<img src='" + msg.documents[0].thumbnail + "'/><br>");		//표지
                        $("#bookTitle").append("<h2>"+ msg.documents[0].title + "</h2>저자 : "+msg.documents[0].authors);	//제목
                        $("#bookInfo").append("<h4 style='display:inline' class='text-primary'>저자:</h4><h5 style='display:inline'> " + msg.documents[0].authors + "</h5><br>");		//저자	
                        $("#bookInfo").append("<h4 style='display:inline' class='text-primary'>출판사:</h4> <h5 style='display:inline'>" + msg.documents[0].publisher + "</h5><br>");		//출판사
                        $("#bookInfo").append("<h4 style='display:inline' class='text-primary'>제작년도:</h4> <h5 style='display:inline'>" + msg.documents[0].datetime.slice(0,10) + "</h5><br>");		//일련번호
                        $("#bookInfo").append("<h4 class='text-primary'>줄거리</h4> <h5>" + msg.documents[0].contents + "...</h5>");		//줄거리
                        $("#bookInfo").append("<h4 style='display:inline' class='text-primary'>ISBN:</h4> <h5 style='display:inline'>" + msg.documents[0].isbn.slice(-13) + "</h5><br>");		//일련번호
                        $("#isbn").val(msg.documents[0].isbn.slice(-13));
                });   
            	
            	
//         		평가 작성,수정 시 구독 날짜 오늘 이후 비활성화 
        		start_date.max = new Date().toISOString().split("T")[0];
        		end_date.max = new Date().toISOString().split("T")[0];
        		
      		  })  
      		
//       	# '독서 완료'시 평가 작성 가능 
      		let submitFlag = false;
      		
      		let bookStatus = function(){
      			let select = document.getElementById("option");
      			let selectValue = select.options[document.getElementById("option").selectedIndex].value;
      			if(selectValue == 2){
      				submitFlag = true;
      				$("#insertStatus").hide();
      				
      			}else{
      				submitFlag = false;
      				$("#insertStatus").show();
      				
      				 $("#insertStatus").click(function () {	      					 
	      				insertStatus();
      				 })
      			}
      			console.log("flag : " + submitFlag);
      		}
			
      		let bookSubmit = function(){
      			let msg = document.getElementById("msg");
      			if(!submitFlag){
      				msg.innerHTML = "독서 완료 시에만 평가 작성이 가능합니다.";
      			}
      				
      			return submitFlag;
      		}
			
 	 </script>
</body>
</html>











