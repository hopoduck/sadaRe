<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>sadaRe: 사다리 - 비밀번호 찾기</title>
        <c:import url="../head.jsp"></c:import>
        
        <script src="http://code.jquery.com/jquery-latest.min.js"></script>
        <script>

            	$(document).ready(function(){
            		// enter 금지
            		$('input[type="text"]').keydown(function() {
            			  if (event.keyCode === 13) {
            			    event.preventDefault();
            			  };
            			});

            		$("input:radio[name=a]").change(function(){
            			var box = $(this).val();
            			var c = "use_e_box";
            			if(box===c){
            				c = "use_b_box";
            			}
            			$("#"+box).show();
            			$("#"+box+"_ip")[0].focus();
            			$("#"+c).hide();
            			if(box!=="use_e_box"){
            				$("#"+c+"_ip").val("");
            			}else{
            				$("#"+c+"_ip").val("1900-01-01");
            			}

            			console.log($("#"+box+"_ip").val());

            		})
            		<c:if test="${not empty error}">
                        alert("${error}")
                    </c:if>
                           
            	})
                        


            		 /* var html="<input type='text' id='box'><input type='submit'>"
            			var box = $(this).val();
            			//var tag = document.getElementById("box")
            			if(document.getElementById("box")!==null){
            				document.getElementById("box").remove();

            			}
            			document.getElementById(box).innerHTML = html;


            		})

            	}) */




            /* 	function radiobox(e){
            		var html="<input type='text'>"
            		var div = e.target.id;
            		document.getElementById(div).innerHTML = html;
            	} */
        </script>
    </head>
    <body>
        <c:import url="../header.jsp"></c:import>
        <section class="py-5">
            <div class="container">
                <h1>비밀번호 찾기</h1>

                <form action="/member/findPwd" method="post">
                    <div class="mb-3 col-md-3">
                        <!-- <label for="user_id" class="form-label">아이디</label> -->

                        <input
                            type="text"
                            class="form-control"
                            id="user_id"
                            name="user_id"
                            placeholder="아이디를 입력하세요."
                        />
                    </div>

                    <div class="form-check col-md-3">
                        <!-- <input class="form-check-input" type="radio" name="flexRadioDefault" id="flexRadioDefault1"> -->
                        <input type="radio" id="use_e" class="form-check-input" name="a" value="use_e_box" />
                        <label class="form-check-label" for="use_e"> 이메일로 찾기</label>

                        <div class="input-group mb-3" id="use_e_box" style="display: none">
                            <input type="email" name="email" id="use_e_box_ip" class="form-control" placeholder="이메일을 입력하세요." />
                            <button class="btn btn-outline-secondary" type="submit">확인</button>
                        </div>
                    </div>
                    <div class="form-check col-md-3">
                        <input type="radio" id="use_b" class="form-check-input" name="a" value="use_b_box" />
                        <label class="form-check-label" for="use_b"> 생일로 찾기 </label>

                        <div class="input-group mb-3" id="use_b_box" style="display: none">
                            <input
                                type="date"
                                class="form-control"
                                id="use_b_box_ip"
                                name="birth"
                                min="1900-01-01"
                                max="2999-01-01"
                                value="1900-01-01"
                            />
                            <button class="btn btn-outline-secondary" type="submit">확인</button>
                        </div>
                </form>
            </div>
        </section>
        <c:import url="../footer.jsp"></c:import>
    </body>
</html>
