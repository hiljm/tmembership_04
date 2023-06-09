<%@ page contentType = "text/html;charset=euc-kr" pageEncoding="EUC-KR" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.agencypro.aig.admin.event.EventManage"%>
<%@ page import="com.agencypro.aig.goods.CGoodsDAO"%>
<%@ include file="/common/common_module.jsp"%>
<%@ include file="/inc/front/front_title.jsp"%>
<%
	if (domainPath.equals(aigDomainName)) {
		V_DynamicServiceUrl = V_ServiceSSLUrl;
	}
	
	String ardsFileNm = "";
	String imgFileLoadUrl = "../common/viewImg.jsp?serverFileNm=";
	
	EventManage em = new EventManage();

	String cpcode = CUtil.checkNull((String)session.getAttribute("cpcode"));
	if ("".equals(cpcode)) {
		cpcode = CUtil.scanString((String)request.getParameter("hCpcode"));		
		session.setAttribute("cpcode", cpcode);
	}

	if("".equals(CUtil.checkNull(reqAgCode))){
		reqAgCode = CUtil.scanString((String)request.getParameter("hAgCode"));
	}
	
	String lastCpcode = "";
	if (!"".equals(cpcode) && cpcode.length() > 0) {
		lastCpcode = cpcode.charAt(cpcode.length() - 1) + "";
	}
	
	logcode = request.getRequestURL()+"";
	SimpleDateFormat formatter = new SimpleDateFormat( "yyyyMMddHHmmssSSS" );
	Date today = new Date();
	logcode += formatter.format( today );
	session.setAttribute("logcode", logcode);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
   <meta charset="UTF-8">

   <meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="format-detection" content="telephone=no">
   <meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no">
   <meta property="og:image" content="http://www.aia.co.kr/content/dam/kr/ko/images/site/og/aia-life.png">
   <title>AIA생명</title>

   <style>
      /* font-family: 'Noto Sans KR',Sans-serif; */
      /* @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap'); */
      
      /* font-family: 'Roboto', sans-serif; */
      /* @import url('https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap'); */
      

      @font-face {
         font-family: 'Noto Sans KR',Sans-serif;
         font-weight: 100;
         font-style: normal;
         src: url("./font/NotoSans-Thin.eot?") format("eot"),
         url("./font/NotoSans-Thin.otf") format("opentype"),
         url("./font/NotoSans-Thin.woff") format("woff"),
         url("./font/NotoSans-Thin.woff2") format("woff2");
      }

      @font-face {
         font-family: 'Noto Sans KR',Sans-serif;
         font-weight: 200;
         font-style: normal;
         src: url("./font/NotoSans-Light.eot?") format("eot"),
         url("./font/NotoSans-Light.otf") format("opentype"),
         url("./font/NotoSans-Light.woff") format("woff"),
         url("./font/NotoSans-Light.woff2") format("woff2");
      }

      @font-face {
         font-family: 'Noto Sans KR',Sans-serif;
         font-weight: 300;
         font-style: normal;
         src: url("./font/NotoSans-DemiLight.eot?") format("eot"),
         url("./font/NotoSans-DemiLight.otf") format("opentype"),
         url("./font/NotoSans-DemiLight.woff") format("woff"),
         url("./font/NotoSans-DemiLight.woff2") format("woff2");
      }

      @font-face {
         font-family: 'Noto Sans KR',Sans-serif;
         font-weight: 400;
         font-style: normal;
         src: url("./font/NotoSans-Regular.eot?") format("eot"),
         url("./font/NotoSans-Regular.otf") format("opentype"),
         url("./font/NotoSans-Regular.woff") format("woff"),
         url("./font/NotoSans-Regular.woff2") format("woff2");
      }

      @font-face {
         font-family: 'Noto Sans KR',Sans-serif;
         font-weight: 500;
         font-style: normal;
         src: url("./font/NotoSans-Medium.eot?") format("eot"),
         url("./font/NotoSans-Medium.otf") format("opentype"),
         url("./font/NotoSans-Medium.woff") format("woff"),
         url("./font/NotoSans-Medium.woff2") format("woff2");
      }

      @font-face {
         font-family: 'Noto Sans KR',Sans-serif;
         font-weight: 700;
         font-style: normal;
         src: url("./font/NotoSans-Black.eot?") format("eot"),
         url("./font/NotoSans-Black.otf") format("opentype"),
         url("./font/NotoSans-Black.woff") format("woff"),
         url("./font/NotoSans-Black.woff2") format("woff2");
      }

      @font-face {
         font-family: 'Noto Sans KR',Sans-serif;
         font-weight: 900;
         font-style: normal;
         src: url("./font/NotoSans-Bold.eot?") format("eot"),
         url("./font/NotoSans-Bold.otf") format("opentype"),
         url("./font/NotoSans-Bold.woff") format("woff"),
         url("./font/NotoSans-Bold.woff2") format("woff2");
      }

      @font-face {
         font-family: 'Roboto', sans-serif;
         font-style: normal;
         font-weight: normal;
         src: url('./font/Roboto-Regular.woff') format('woff');
      }


      @-webkit-keyframes fadeInUp {
         0% {opacity: 0; -webkit-transform: translateY(20px); transform: translateY(20px);}
         100% {opacity: 1; -webkit-transform: translateY(0); transform: translateY(0);}
      }
      @keyframes fadeInUp {
         0% {opacity: 0; -webkit-transform: translateY(20px); -ms-transform: translateY(20px); transform: translateY(20px);}
         100% {opacity: 1; -webkit-transform: translateY(0); -ms-transform: translateY(0); transform: translateY(0);}
      }
      .animate-plus {opacity: 0;}
      .fadeInUp {-webkit-animation-name: fadeInUp; animation-name: fadeInUp;}
      .animated {-webkit-animation-duration: 1s; animation-duration: 1s; -webkit-animation-fill-mode: both; animation-fill-mode: both;}




      * {margin: 0; padding: 0; box-sizing: border-box; font-family: 'Noto Sans KR',"맑은 고딕",Sans-serif; font-weight: 300; color: #000;}
      html,body {font-family: 'Noto Sans KR',"맑은 고딕",Sans-serif; letter-spacing: -2px; word-break: keep-all; overflow-x: hidden; background-color: #fff;}
      ul,ol,li {list-style: none;}
      img {display: inline-block;}
      a {background-color: transparent; text-decoration:none; display: inline-block;}
      span {display: inline-block}
      b {font-weight: bold;}
      input[type="text"] { border: none; color: #000; outline: none; background-color: transparent;}
      /* input:-ms-input-placeholder { color: #fff !important; }
      input::-webkit-input-placeholder { color: #fff; }
      input::-moz-placeholder { color: #fff; } */
      input:focus {outline: none;}
      button {display: block; text-transform: none; border-style: none; padding: 0; background-color: transparent;}

      .hide {display: none;}
      .bold { font-weight: bold; }

      .only_pc {display: inline-block !important;}
      .only_mo {display: none !important;}

      #AIA_wrap {background-color: #f8f8f8;}
      #AIA_wrap .contents {width: 100%; max-width: 720px; margin: 0 auto;}
      #AIA_wrap .contents .sc1 {margin-bottom: 60px; width: 100%;}
      #AIA_wrap .contents .sc1 .wrap {background-color: #efe4e4; padding-top: 100px; position: relative; border-radius: 0 0 50px 50px; text-align: center;}
      
	  #AIA_wrap .contents .sc1 .wrap .subtitle {display: inline-block; font-size: 35px; text-align: center; padding: 15px 30px; background-color: #3e21cf; border-radius: 50px; font-family: 'Roboto', sans-serif; color: #fff; font-weight: 300; margin-bottom: 30px;}
      #AIA_wrap .contents .sc1 .wrap .subtitle b {font-weight: 400; color: #fff;}
      #AIA_wrap .contents .sc1 .wrap .title {font-size: 73px; line-height: 1.3; text-align: center; font-weight: 500; padding-bottom: 40px; animation-delay: 0.3s;}
	  #AIA_wrap .contents .sc1 .wrap .title b {font-size: 42px; font-weight: 400;}
      
	  #AIA_wrap .contents .sc1 .wrap .title span {color: #d01345; font-weight: 600;}
            #AIA_wrap .contents .sc1 .wrap .img {text-align: center; animation-delay: 0.6s;}
      #AIA_wrap .contents .sc1 .wrap .bg {position: absolute; left: 0; bottom: 0; z-index: 1; margin-bottom: -20px;}
      #AIA_wrap .contents .sc1 .wrap .bg img {width: 100%; display: block;}
      #AIA_wrap .contents .sc1 .wrap .gift {position: absolute; right: 50px; bottom: 0px; z-index: 2;}


      #AIA_wrap .contents .sc2 {margin-bottom: 65px;}
      #AIA_wrap .contents .sc2 .wrap {width: 90%; margin: 0 auto;}
      #AIA_wrap .contents .sc2 .wrap .quizArea {max-width: 620px; margin: 0 auto 90px;}
      #AIA_wrap .contents .sc2 .wrap .quizArea .quiz {display: none; position: relative; background-color: #f8e9ed; border-radius: 20px; margin: 0 auto;}
      #AIA_wrap .contents .sc2 .wrap .quizArea .quiz.on {display: block;}
      #AIA_wrap .contents .sc2 .wrap .quizArea .quiz .num {position: absolute; font-size: 33px; color: #fff; text-align: center; padding: 5px 0; width: 260px; height: 60px; background-color: #d01345; border-radius: 50px; top: -30px; left: 50%; transform: translate(-50%, 0);}
      #AIA_wrap .contents .sc2 .wrap .quizArea .quiz .question {background-color: #f8dbe3; border-radius: 20px; font-size: 36px; font-weight: 700; text-align: center; line-height: 1.3; padding: 65px 5px 55px;}
      #AIA_wrap .contents .sc2 .wrap .quizArea .quiz .btnWrap {display: flex; justify-content: center; align-items: center; padding: 70px 0 120px;}
      #AIA_wrap .contents .sc2 .wrap .quizArea .quiz .btnWrap a {display: block; width: 230px; height: 220px; background-color: #fff; border: 1px solid #997575; border-radius: 30px; box-shadow: 5px 5px 0 0 #bfa3a5; margin-right: 40px; font-size: 140px; font-weight: 700; cursor: pointer; padding-bottom: 15px; text-align: center;}
      #AIA_wrap .contents .sc2 .wrap .quizArea .quiz .btnWrap a:last-child {margin-right: 0;}

      #AIA_wrap .contents .sc2 .wrap .formArea {display: none;}
      #AIA_wrap .contents .sc2 .wrap .formArea .title {font-size: 52px; text-align: center; color: #d41146; font-weight: 600; padding-bottom: 10px;}
      #AIA_wrap .contents .sc2 .wrap .formArea .des {font-size: 40px; font-weight: 400; line-height: 1.3; text-align: center; padding-bottom: 40px;}

      #AIA_wrap .db_box {}
      #AIA_wrap .db_box form {max-width: 440px; margin: 0 auto; position: relative;}
      #AIA_wrap .db_box ul {padding-bottom: 40px;}
      #AIA_wrap .db_box ul li {width: 100%; position: relative; margin-bottom: 13px;}
      #AIA_wrap .db_box ul li input {font-size: 28px; font-weight: 300;}
      #AIA_wrap .db_box ul li input[type=text] {background-color: #fff; border-radius: 10px; padding: 5px 15px; width: 100%; height: 55px; overflow: hidden;  font-weight: 400; letter-spacing: -2.5px;}
      #AIA_wrap .db_box ul li input[type=text]:-ms-input-placeholder { color: #9c9c9c !important; }
      #AIA_wrap .db_box ul li input[type=text]::-webkit-input-placeholder { color: #9c9c9c; }
      #AIA_wrap .db_box ul li input[type=text]::-moz-placeholder { color: #9c9c9c; }

      #AIA_wrap .db_box ul li.name {display: flex; align-items: center; max-width: 315px;}

      #AIA_wrap .db_box ul li.sex {position: absolute; top: 0; right: 0; max-width: 115px;}
      #AIA_wrap .db_box ul li.sex input { width: 1px; height: 1px; overflow: hidden; position: absolute; left: -9999px; }
      #AIA_wrap .db_box ul li.sex input + label { position: absolute; top: 0; left: 0; display: flex; justify-content: center; align-items: center; width: 53px; height: 55px; cursor: pointer; color: #fff; font-size: 32px; font-weight: 400; line-height: 30px; background: #adadad; text-align:center; border-radius: 10px;}
      #AIA_wrap .db_box ul li.sex label:last-child { right: 0; left: auto; }
      #AIA_wrap .db_box ul li.sex input:checked + label { color: #fff; background: #d31145; }

      #AIA_wrap .db_box ul li.phone,
      #AIA_wrap .db_box ul li.confirm {display: flex; align-items: center; position: relative; overflow: hidden; border-radius: 0 10px 10px 0;}

      #AIA_wrap .db_box ul li.phone .confirm_btn,
      #AIA_wrap .db_box ul li.confirm .check {display: flex; align-items: center; justify-content: center; text-align: center; width: 88px; height: 55px; border-radius: 0 10px 10px 0; font-weight: 500; cursor: pointer;}

      #AIA_wrap .db_box ul li.phone input,
      #AIA_wrap .db_box ul li.confirm input {max-width: calc(100% - 88px); border-radius: 10px 0 0 10px;}

      #AIA_wrap .db_box ul li.phone .confirm_btn img,
      #AIA_wrap .db_box ul li.confirm .check img {width: auto; height: 100%;}

      #AIA_wrap .db_box_agree {}
      #AIA_wrap .db_box_agree .agree_check {display: flex; align-items: center; padding-bottom: 20px; max-width: 620px; margin: 0 auto;}
      #AIA_wrap .db_box_agree .agree_check input[type=checkbox] {display: block; width: 1px; height: 1px;}
      #AIA_wrap .db_box_agree .agree_check input[type=checkbox] + label {position: relative; display: flex; align-items: center; font-size: 28px; font-weight: 400; color: #5f5f5f;}
      #AIA_wrap .db_box_agree .agree_check input[type=checkbox] + label::before {display: block; position: relative; content: ''; width: 25px; height: 25px; border: 1px solid #6a6a6a; border-radius: 50px; margin-right: 10px; background-color: #fff; margin-top: 3px;}
      #AIA_wrap .db_box_agree .agree_check input[type=checkbox]:checked + label::before {background-image: url('./images/20230314_aia_form_checked.png'); background-repeat: no-repeat; background-position: center; background-size: contain;}
      
      #AIA_wrap .db_box_agree .detail {overflow-x: hidden; overflow-y: auto; border: 1px solid #adadad; border-radius: 10px; height: 420px; max-width: 620px; margin: 0 auto 20px;}
      #AIA_wrap .db_box_agree .detail img {width: 100%;}

      #AIA_wrap .db_box_btn {text-align: center;}

   
      #AIA_wrap .contents .sc3 {padding-bottom: 70px;}
      #AIA_wrap .contents .sc3 .wrap {max-width: 620px; margin: 0 auto;}
      #AIA_wrap .contents .sc3 .wrap .hint {position: relative; padding-bottom: 90px;}
      #AIA_wrap .contents .sc3 .wrap .hint span {position: absolute; top: -30px; left: 0; display: inline-block; padding: 10px 35px; border-radius: 15px 0 15px 0; background-color: #2e4363; color: #fff; font-size: 35px; font-weight: 400; font-family: 'Roboto', sans-serif; text-align: center; letter-spacing: 0;}
      #AIA_wrap .contents .sc3 .wrap .hint .box {background-color: #f8dbe3; border-radius: 20px; padding: 40px; text-align: center;}
      #AIA_wrap .contents .sc3 .wrap .hint .box p {font-size: 33px; font-weight: 500; text-align: center;}
      #AIA_wrap .contents .sc3 .wrap .hint .box a {display: inline-block; font-size: 33px; font-weight: 400; color: #d01345; border-bottom: 2px solid #d01345; text-align: center;}

      #AIA_wrap .contents .sc3 .wrap .howto {text-align: center;}
      #AIA_wrap .contents .sc3 .wrap .howto .title {font-size: 33px; font-weight: 400; color: #fff; background-color: #d01345; width: 260px; height: 60px; text-align: center; display: flex; justify-content: center; align-items: start; border-radius: 50px; margin: 0 auto 40px; padding-top: 3px;}
      #AIA_wrap .contents .sc3 .wrap .howto .flex {background-color: #fff; border-radius: 20px; padding: 40px; display: flex; align-items: flex-start; justify-content: center; margin-bottom: 55px;}
      #AIA_wrap .contents .sc3 .wrap .howto .flex span {position: relative; text-align: center; height: 100%; display: block; min-height: 270px;}
      #AIA_wrap .contents .sc3 .wrap .howto .flex span::after {content: ''; display: block; position: absolute; top: 65%; right: 0; transform: translate(0,-50%); width: 10px; height: 21px; background-image: url('./images/20230314_aia_sc3_arrow.png'); background-repeat: no-repeat; background-size: contain;}
      #AIA_wrap .contents .sc3 .wrap .howto .flex span:last-child::after {display: none;}
      #AIA_wrap .contents .sc3 .wrap .howto .flex span b img {padding-bottom: 10px;}
      #AIA_wrap .contents .sc3 .wrap .howto .flex span b {font-size: 28px; font-weight: 600; color: #d01345; padding-bottom: 10px; text-align: center;}
      #AIA_wrap .contents .sc3 .wrap .howto .flex span p {font-size: 25px; line-height: 1.3; font-weight: 500; text-align: center;}

      #AIA_wrap .contents .sc3 .wrap .howto .tag {font-size: 33px; font-weight: 400; color: #fff; width: 275px; height: 65px; display: flex; justify-content: center; align-items: center; text-align: center; background-color: #686868; border-radius: 50px; margin: 0 auto 25px;} 
      #AIA_wrap .contents .sc3 .wrap .howto >p {font-size: 40px; font-weight: 500; margin-bottom: 40px; line-height: 1.4;}
      #AIA_wrap .contents .sc3 .wrap .howto >p span {display: block; font-size: 32px; font-weight: 400; color: #8b8b8b;}


      #AIA_wrap .contents .footer {background-color: #a0a0a0;}
      #AIA_wrap .contents .footer .inner {}
      #AIA_wrap .contents .footer .inner b {font-size: 28px; color: #fff; font-weight: 400; padding-bottom: 30px; display: block;}
      #AIA_wrap .contents .footer .inner p {font-size: 24px; color: #fff; font-weight: 300; line-height: 1.6; padding-bottom: 25px; letter-spacing: -1px;}

      #AIA_wrap .popup.on {display: flex;}
      #AIA_wrap .popup {position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0,0,0,0.3); display: none; justify-content: center; align-items: center; z-index: 995;}
      #AIA_wrap .popup .wrap {background-color: #fff; position: relative; padding: 30px 40px 70px; text-align: center; width: 90%; max-width: 600px;}
      #AIA_wrap .popup .wrap .top {display: flex; justify-content: space-between; align-items: center; padding-bottom: 30px;}
      #AIA_wrap .popup .wrap .top .logo {display: inline-block;}
      #AIA_wrap .popup .wrap .top .close {display: block; width: 50px; font-size: 36px; color: #959595; display: flex; justify-content: center; align-items: center; cursor: pointer;}
      #AIA_wrap .popup .wrap b {display: block; font-size: 46px; font-weight: 600; color: #d41146; padding-bottom: 20px; line-height: 1.3;}
      #AIA_wrap .popup .wrap p {font-size: 40px; font-weight: 400; padding-bottom: 40px;}
      #AIA_wrap .popup .wrap p.small {font-size: 24px;}
      #AIA_wrap .popup .wrap >a,
      #AIA_wrap .popup .wrap >button {display: block; text-align: center; max-width: 512px; margin: 0 auto;}
      #AIA_wrap .popup .wrap >a img,
      #AIA_wrap .popup .wrap >button img {width: 100%;}
      #AIA_wrap .popup .wrap .popup_close {cursor: pointer;}

      @media (max-width : 720px) {
         .only_pc {display: none !important;}
         .only_mo {display: inline-block !important;}

         #AIA_wrap .contents .sc1 {margin-bottom: 14vw;}
         #AIA_wrap .contents .sc1 .wrap {padding-top: 14.5vw; border-radius: 0 0 10vw 10vw;}
         #AIA_wrap .contents .sc1 .wrap .subtitle {font-size: 5vw; padding: 2.2vw 4.3vw; border-radius: 10vw; margin-bottom: 5vw;}
         #AIA_wrap .contents .sc1 .wrap .title {font-size: 10.5vw; padding-bottom: 6.5vw;}
				#AIA_wrap .contents .sc1 .wrap .title b {font-size: 6vw; padding-bottom: 6.5vw;}
				 
         #AIA_wrap .contents .sc1 .wrap .img img {width: 65.14%;}
         #AIA_wrap .contents .sc1 .wrap .bg {margin-bottom: -3vw;}
         #AIA_wrap .contents .sc1 .wrap .gift {right: 7vw; width: 40.69%;}
         #AIA_wrap .contents .sc1 .wrap .gift img {width: 100%;}

         #AIA_wrap .contents .sc2 {margin-bottom:  10vw;}
         #AIA_wrap .contents .sc2 .wrap .quizArea {margin-bottom: 11vw;}
         #AIA_wrap .contents .sc2 .wrap .quizArea .quiz {border-radius: 3vw;}
         #AIA_wrap .contents .sc2 .wrap .quizArea .quiz .num {font-size: 4.5vw; width: 37.5vw; height: 8.5vw; padding: 0.8vw 0; border-radius: 10vw; top: -4vw;}
         #AIA_wrap .contents .sc2 .wrap .quizArea .quiz .question {font-size: 5.5vw; border-radius: 3vw; padding: 9.5vw 0.7vw 8.5vw;}
         #AIA_wrap .contents .sc2 .wrap .quizArea .quiz .btnWrap {padding: 9.5vw 0 16vw;}
         #AIA_wrap .contents .sc2 .wrap .quizArea .quiz .btnWrap a {width: 32.2vw; height: 31.2vw; border-radius: 4vw; box-shadow: 0.7vw 0.7vw 0 0 #bfa3a5; margin-right: 5.5vw; font-size: 19.5vw; padding-bottom: 1.5vw;}

         #AIA_wrap .contents .sc2 .wrap .formArea .title {font-size: 7.5vw; padding-bottom: 0.5vw;}
         #AIA_wrap .contents .sc2 .wrap .formArea .des {font-size: 5.5vw; padding-bottom: 5.5vw;}

         #AIA_wrap .db_box form {max-width: 68.11%;}

         #AIA_wrap .db_box ul {padding-bottom: 6vw;}
         #AIA_wrap .db_box ul li {margin-bottom: 1.7vw;}

         #AIA_wrap .db_box ul li input {font-size: 3.8vw;}
         #AIA_wrap .db_box ul li input[type=text] {padding: 0.7vw 1.7vw; height: 8vw; border-radius: 1.2vw 0 0 1.2vw; letter-spacing: -0.3vw;}

         #AIA_wrap .db_box ul li.name {max-width: 44vw;}
         #AIA_wrap .db_box ul li.sex {max-width: 16vw;}
         #AIA_wrap .db_box ul li.sex input + label {width: 7.5vw; height: 7.9vw; font-size: 4vw; line-height: 4vw; border-radius: 0.8vw;}
         
         #AIA_wrap .db_box ul li.phone, 
         #AIA_wrap .db_box ul li.confirm {border-radius: 0 1.2vw 1.2vw 0;}
         #AIA_wrap .db_box ul li.phone .confirm_btn,
         #AIA_wrap .db_box ul li.confirm .check {font-size: 4vw; width: 12vw; height: 7.7vw; border-radius: 0 1.2vw 1.2vw 0;}
         #AIA_wrap .db_box ul li.phone input, 
         #AIA_wrap .db_box ul li.confirm input {max-width: calc(100% - 12vw);}

         #AIA_wrap .db_box_agree .agree_check {max-width: 100%; padding-bottom: 3vw;}
         #AIA_wrap .db_box_agree .agree_check input[type=checkbox] + label {font-size: 4vw;}
         #AIA_wrap .db_box_agree .agree_check input[type=checkbox] + label::before {width: 3.8vw; height: 3.8vw; border-radius: 10vw; margin-right: 1vw; margin-top: 0.3vw;}

         #AIA_wrap .db_box_agree .detail {max-width: 100%; height: 70vw; margin: 0 auto 4vw;}

         #AIA_wrap .db_box_btn a img {width: 100%;}


         #AIA_wrap .contents .sc3 {padding-bottom: 10.5vw;}
         #AIA_wrap .contents .sc3 .wrap {width: 90%; margin: 0 auto;}
         #AIA_wrap .contents .sc3 .wrap .hint {padding-bottom: 13vw;}
         #AIA_wrap .contents .sc3 .wrap .hint span {top: -4vw; padding: 1.5vw 5.2vw; border-radius: 2vw 0 2vw 0; font-size: 4.5vw;}
         #AIA_wrap .contents .sc3 .wrap .hint .box {padding: 5vw; border-radius: 3vw;}
         #AIA_wrap .contents .sc3 .wrap .hint .box p {font-size: 4.7vw;}
         #AIA_wrap .contents .sc3 .wrap .hint .box a {font-size: 4.7vw;}

         #AIA_wrap .contents .sc3 .wrap .howto .title {font-size: 4.7vw; width: 38vw; height: 9vw; border-radius: 10vw; margin: 0 auto 6vw; padding-top: 0.6vw; font-weight: 300;}

         #AIA_wrap .contents .sc3 .wrap .howto .flex {padding: 5.2vw 0; margin-bottom: 8vw; border-radius: 3vw;}
         #AIA_wrap .contents .sc3 .wrap .howto .flex span {min-height: 38vw; width: 33.3333%;}
         #AIA_wrap .contents .sc3 .wrap .howto .flex span img {width: 21vw; max-width: 150px; display: block; margin: 0 auto;}
         #AIA_wrap .contents .sc3 .wrap .howto .flex span b {font-size: 4vw; padding-bottom: 0.7vw;}
         #AIA_wrap .contents .sc3 .wrap .howto .flex span p {font-size: 3.6vw; font-weight: 400;}
         #AIA_wrap .contents .sc3 .wrap .howto .flex span::after {width: 1.7vw; height: 3.8vw; top: 25.5vw;}

         #AIA_wrap .contents .sc3 .wrap .howto .tag {font-size: 4.7vw; width: 38vw; height: 9vw; margin: 0 auto 3vw; padding-bottom: 0.5vw;}
         #AIA_wrap .contents .sc3 .wrap .howto >p {font-size: 5.2vw; margin-bottom: 5vw;}
         #AIA_wrap .contents .sc3 .wrap .howto >p span {font-size: 85%;}
         #AIA_wrap .contents .sc3 .wrap .howto >.img {width: 43.5%; margin: 0 auto;}
         #AIA_wrap .contents .sc3 .wrap .howto >.img img {width: 100%;}


         #AIA_wrap .contents .footer .inner img {width:100%;}
         #AIA_wrap .contents .footer .inner b {font-size: 4vw; padding-bottom: 5vw;}
         #AIA_wrap .contents .footer .inner p {font-size: 3.5vw; padding-bottom: 4.5vw;}


         #AIA_wrap .popup .wrap {padding: 4.5vw 5vw 10vw; width: 83.88%;}
         #AIA_wrap .popup .wrap .top {padding-bottom: 4vw;}
         #AIA_wrap .popup .wrap .top .logo {width: 25%;}
         #AIA_wrap .popup .wrap .top .logo img {width: 100%;}
         #AIA_wrap .popup .wrap .top .close {width: 7vw; font-size: 5vw;}
         #AIA_wrap .popup .wrap b {font-size: 7vw; padding-bottom: 3vw;}
         #AIA_wrap .popup .wrap p {font-size: 5.5vw; padding-bottom: 5vw;}
         #AIA_wrap .popup .wrap p.small {font-size: 3.5vw;}

      }
    </style>
    <%@ include file="/event/landingManage.jsp"%>
    <%@ include file="/common/front/tracking/webLog_common_head.jsp"%>
    <script type="text/javascript" src="../common/js/common_02.js"></script>
    
</head>

<body>
   <div id="AIA_wrap">
		<div class="contents">
			<div class="sc1">
				<div class="wrap">
					<h3 class="subtitle animate-plus" data-animations="fadeInUp" data-animation-when-visible="true"><b>T 멤버십</b> 고객님을 위한 <b>단독 이벤트</b></h3>
					<h2 class="title animate-plus" data-animations="fadeInUp" data-animation-when-visible="true">
					<b>(무)AIA Vitality 든든 튼튼 암보험(갱)</b><br />
						퀴즈 정답을 맞힌<br /> 모든 고객님께<br />
						<span>신세계상품권 증정</span>
					</h2>
					<div class="img animate-plus" data-animations="fadeInUp" data-animation-when-visible="true"><img src="<%=imgFilePath%>20230314_aia_sc1_img01.png" alt=""></div>
					<div class="bg"><img src="<%=imgFilePath%>20230314_aia_sc1_bg.png" alt=""></div>
					<div class="gift animate-plus"  data-animations="fadeInUp" data-animation-when-visible="true"><img src="<%=imgFilePath%>20230314_aia_sc1_img02.png" alt=""></div>
				</div>
			</div>
	
			<div class="sc2">
				<div class="wrap">
					<div class="quizArea">
						<div class="quiz on">
							<div class="num">문제 1</div>
							<div class="question">
								(무)AIA Vitality 든든 튼튼 암보험(갱)은<br />
								건강 관리하면 보험료가 할인된다.
							</div>
							<div class="btnWrap">
								<a href="javascript:void(0)" onclick="return false" class="correct">O</a>
								<a href="javascript:void(0)" onclick="return false" class="wrong wrongPopBtn">X</a>
							</div>
						</div>
						<div class="quiz">
							<div class="num">문제 2</div>
							<div class="question">
								(무)AIA Vitality 든든 튼튼 암보험(갱)은<br />
								건강 관리하면 <br />매주 보상이 제공된다. 
							</div>
							<div class="btnWrap">
								<a href="javascript:void(0)" onclick="return false" class="correct">O</a>
								<a href="javascript:void(0)" onclick="return false" class="wrong wrongPopBtn">X</a>
							</div>
						</div>
					</div>
					<div class="formArea">
						<div class="title">정답입니다!</div>
						<p class="des">이벤트 참여를 위해<br /> 정보를 입력해 주세요.</p>
	
						<div class="db_box">
							<form method="post" action="" name="frm">
								<ul>
									<li class="name">
										<input type="text" id="rn_cust_name" name="rn_cust_name" placeholder="이름">
									</li>
									<li class="sex">
										<input type="radio" id="rn_sex1" name="rn_sex" value="M" checked="checked">
										<label for="rn_sex1">남</label>
										<input type="radio" id="rn_sex2" name="rn_sex" value="F">
										<label for="rn_sex2">여</label>
									</li>
									<li class="birth">
										<input type="text" id="rn_jumin1" name="rn_jumin1" maxlength="6" placeholder="생년월일(예: 730804)"
											onKeyUp="onlyNumber(this);" onKeyPress="checkInt()">
									</li>
									<li class="phone">
										<input type="text" id="cr_mphone" name="cr_mphone" maxlength="11" placeholder="휴대폰 번호(예: 01012345678)"
											onKeyUp="onlyNumberWithBar(this);numToTel(this);" onKeyPress="checkInt()">
										<button type="button" class="confirm_btn"><img src="<%=imgFilePath%>20230314_aia_sc2_form_btn01.png" alt=""></button>
									</li>
									<li class="confirm">
										<input type="text" id="confirm" name="confirm" placeholder="인증 번호">
										<button type="button" class="check"><img src="<%=imgFilePath%>20230314_aia_sc2_form_btn02.png" alt=""></button></button>
									</li>
								</ul>
							</form>
	
							<div class="db_box_agree">
								<div class="agree_check">
									<input type="checkbox" id="check01" name="">
									<label for="check01">개인정보 이용 동의(필수)</label>
								</div>
								<div class="detail">
									<img src="<%=imgFilePath%>20230314_popup_agree.png" alt="">
								</div>
							</div>
	
							<div class="db_box_btn">
								<a href="javascript:void(0)" onclick="return false" class="send eventPopBtn">
									<img src="<%=imgFilePath%>20230314_aia_sc2_form_btn03.png" alt="">
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
	
	
			<div class="sc3">
				<div class="wrap">
					<div class="hint">
						<span>힌트</span>
						<div class="box">
							<br /><p>AIA생명 홈페이지에서 힌트를 찾아보세요.</p>
							<a href="https://dm.vitality.aia.co.kr/event/aia_vitalityDirect_calculation_09.jsp" target="_blank">정답 찾기</a>
						</div>
					</div>
					<div class="howto">
						<div class="title">응모 방법</div>
						<div class="flex">
							<span>
								<img src="<%=imgFilePath%>20230314_aia_sc3_img01.png" alt="">
								<b>STEP 1</b>
								<p>퀴즈 풀기</p>
							</span>
							<span>
								<img src="<%=imgFilePath%>20230314_aia_sc3_img02.png" alt="">
								<b>STEP 2</b>
								<p>
									마케팅<br />
									동의하기
								</p>
							</span>
							<span>
								<img src="<%=imgFilePath%>20230314_aia_sc3_img03.png" alt="">
								<b>STEP 3</b>
								<p>
									동의 시<br />
									자동 응모 완료
								</p>
							</span>
						</div>
						<div class="tag">기간</div>
						<p>2023년 4월 7일(금)~4월 20일(목)</p>
						<div class="tag">경품 발송일</div>
						<p>2023년 5월 12일(금)</p>
						<div class="tag">경품</div>
						<p>
							<span>OX 퀴즈 참여하고 정답을 맞힌 모든 고객님께</span>
							신세계상품권 5천 원권 증정<br />
						</p>
						<div class="img"><img src="<%=imgFilePath%>20230314_aia_sc3_img04.png" alt=""></div>
					</div>
				</div>
			</div>
	
	
	
			<!-- footer -->
			<div class="footer">
				<div class="inner">
					<img src="<%=imgFilePath%>20230314_aia_sc4_img01.png" alt="">
				</div>
			</div>
	
	
	
			<!-- popup (wrong answer) -->
			<div class="popup wrongPop" data-receive="popup_event">
				<div class="wrap">
					<div class="top">
						<a href="" class="logo"><img src="<%=imgFilePath%>20230314_aia_popup_logo.png" alt=""></a>
						<button class="close popup_close">X</button>
					</div>
					<b>오답입니다!</b>
					<p>힌트를 다시 한번 확인해 보세요.</p>
					<button class="popup_close"><img src="<%=imgFilePath%>20230314_aia_popup_btn01.png" alt=""></button>
				</div>
			</div>
	
	
			<!-- popup (done) -->
			<div class="popup eventPop" data-receive="popup_event">
				<div class="wrap">
					<div class="top">
						<a class="logo"><img src="<%=imgFilePath%>20230314_aia_popup_logo.png" alt=""></a>
						<button class="close popup_close">X</button>
					</div>
					<b>이벤트에 참여해 <br />주셔서 감사합니다. </b>
					<p class="small">참여하신 고객님께 보험 상담 전화를 드릴 수 있습니다. </p>
					<a href="https://dm.vitality.aia.co.kr/event/aia_vitalityDirect_calculation_09.jsp" target="_blank"><img src="<%=imgFilePath%>20230314_aia_popup_btn02.png" alt=""></a>
				</div>
			</div>
		</div>
	</div>

   <script src="./js/wow.js"></script>
	<script src="./js/jquery-2.1.1.min.js"></script>
	<script>


		(function ($) {
			var AIA_UI = {
				popup: function () {
               $(".wrongPopBtn").on({
						"click": function (e) {
							$(".popup.wrongPop").addClass('on');
			            $(".popup.eventPop").removeClass('on');
						}
					});
               $(".eventPopBtn").on({
						"click": function (e) {
							$(".popup.eventPop").addClass('on');
			            $(".popup.wrongPop").removeClass('on');
						}
					});
					$(".popup .popup_close").on({
						"click": function (e) {
							$(this).parents(".popup").removeClass('on');
							e.preventDefault();
						}
					});
				},

            quiz: function () {
               $(".quiz .correct").on({
                  "click": function (e) {
                     var formTop = $('.quizArea').offset().top + $('.quizArea').innerHeight();

                     if($(this).closest('.quiz').index() < 1){
                        $(this).parents('.quiz').removeClass('on');
                        $(this).closest('.quiz').next().addClass('on');
                     }else{
                        $('.formArea').slideDown();
                        $('html,body').animate({scrollTop: formTop}, 300);
                     }
                  }
               })
            },

            init: function() {
               this.popup(),
               this.quiz()
            }

			};
			$(function () {
				new WOW().init();
				AIA_UI.init();

			});

			$(window).load(function () {
				setTimeout(function () { $(window).scrollTop(0); }, 0);
			});
		})(jQuery);



      //에니메이션
      !function(a){function b(b){this.htmlElement=b,this.animations=a(this.htmlElement).attr("data-animations").split(","),this.animationIndex=0,this.lastAnimation="",void 0!==a(this.htmlElement).attr("data-animation-duration")&&(this.animationDuration=a(this.htmlElement).attr("data-animation-duration").split(",")),void 0!==a(this.htmlElement).attr("data-animation-delay")&&(this.animationDelay=a(this.htmlElement).attr("data-animation-delay").split(","))}function c(){this.elements=[],this.animateWhenVisible=!1,this.isPerformingAnimation=!1,this.resetWhenOffscreen=!1,this.repeat=!1,this.isReset=!0}function d(){this.onVisbileGroups=[],this.map=[],a(".animate-plus").addClass("animated"),a.each(a(".animate-plus"),function(d,e){var f=new b(e),g=a(e).attr("data-animation-group");void 0===g&&(g="_"+d,a(e).attr("data-animation-group",g)),void 0===this.map[g]&&(this.map[g]=new c);var h=a(e).attr("data-animation-when-visible");void 0!==h&&(this.map[g].animateWhenVisible=!0);var i=a(e).attr("data-animation-reset-offscreen");void 0!==i&&(this.map[g].resetWhenOffscreen=!0);var j=a(e).attr("data-animation-repeat");void 0!==j&&(this.map[g].repeat=!0);var k=this.map[g].elements,l=a(e).attr("data-animation-order"),m=void 0!==l;if(m)var n=l.split(",");for(var o=a(e).attr("data-animations").split(","),p=0;p<o.length;p++){var q=p+1;m&&(q=n[p]),void 0===k[q]&&(k[q]=[]),k[q].push(f)}}.bind(this)),a(window).on("scroll",function(){this.checkOnVisibleGroups()}.bind(this)),a(window).on("resize",function(){this.checkOnVisibleGroups()}.bind(this)),a(document).ready(function(){this.checkOnVisibleGroups()}.bind(this)),this.isElementVisible=function(b){var c=a(window).scrollTop(),d=a(window).height()+c-150,e=a(b).offset().top,f=a(b).height()+e;return d>=e&&f>=c},this.checkOnVisibleGroups=function(){for(var a=0;a<this.onVisbileGroups.length;a++)for(var b=this.map[this.onVisbileGroups[a]],c=1;c<b.elements.length;c++)for(var d=b.elements[c],e=0;e<d.length;e++){var f=d[e].htmlElement;this.isElementVisible(f)&&!b.isPerformingAnimation&&b.animate(1),this.isElementVisible(f)||b.isPerformingAnimation||!b.resetWhenOffscreen||b.reset()}}}jQuery.fn.redraw=function(){return this.hide(0,function(){a(this).show()})},jQuery.fn.restartAnimation=function(){var b=a(this).attr("data-animation-group"),c=d.getInstance().getMap()[b];c.restart()},b.prototype.doNextAnimation=function(b){if(this.animationIndex>=this.animations.length)return void b();var c,d;a(this.htmlElement).removeClass(this.lastAnimation),this.lastAnimation=this.animations[this.animationIndex],a(this.htmlElement).css("animation-duration","").css("-webkit-animation-duration","").css("-moz-animation-duration","").css("-ms-animation-duration","").css("-o-animation-duration",""),void 0!==this.animationDuration&&void 0!==this.animationDuration[this.animationIndex]&&(c=this.animationDuration[this.animationIndex],a(this.htmlElement).css("animation-duration",c).css("-webkit-animation-duration",c).css("-moz-animation-duration",c).css("-ms-animation-duration",c).css("-o-animation-duration",c)),a(this.htmlElement).css("animation-delay","").css("-webkit-animation-delay","").css("-moz-animation-delay","").css("-ms-animation-delay","").css("-o-animation-delay",""),void 0!==this.animationDelay&&void 0!==this.animationDelay[this.animationIndex]&&(d=this.animationDelay[this.animationIndex],a(this.htmlElement).css("animation-delay",d).css("-webkit-animation-delay",d).css("-moz-animation-delay",d).css("-ms-animation-delay",d).css("-o-animation-delay",d)),this.animationIndex++,a(this.htmlElement).redraw(),a(this.htmlElement).addClass(this.lastAnimation).one("webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend",b)},c.prototype.reset=function(){if(!this.isReset){for(var b=1;b<this.elements.length;b++)for(var c=0;c<this.elements[b].length;c++)this.elements[b][c].animationIndex=0,a(this.elements[b][c].htmlElement).removeClass(this.elements[b][c].lastAnimation);this.isReset=!0}},c.prototype.animate=function(a){var b=0,c=this.elements[a];if(void 0===c)return void(this.repeat?(this.reset(),this.animate(1)):this.isPerformingAnimation=!1);this.isPerformingAnimation=!0,this.isReset=!1;for(var d=0;d<c.length;d++)c[d].doNextAnimation(function(){b++,b==c.length&&this.animate(++a)}.bind(this))},c.prototype.restart=function(){this.isPerformingAnimation||(this.reset(),this.animate(1))},d.prototype.start=function(){for(var a in this.map)this.map.hasOwnProperty(a)&&(this.map[a].animateWhenVisible?this.registerOnVisbileMap(a):this.map[a].animate(1))},d.prototype.registerOnVisbileMap=function(a){this.onVisbileGroups.push(a)},d.prototype.getMap=function(){return this.map},d.instance=null,d.getInstance=function(){return null===d.instance&&(d.instance=new d),d.instance},a(document).ready(function(){d.getInstance().start()})}(jQuery);




	</script>

   <div id="_layerTracking" style="display:none;position:absolute;">
   <%@ include file="/common/front/tracking/webLog_common_body.jsp"%>
   <iframe id="_trck" title="빈프레임" name="_trck" src="" width="0" height="0" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" leftmargin="no" topmargin="no" ></iframe>
   </div>
    
</body>

</html>