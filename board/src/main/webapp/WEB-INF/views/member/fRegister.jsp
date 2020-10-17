<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="/resources/css/fRegister.css">
<link rel="stylesheet" href="/resources/css/top.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/js/fRegister.js"></script>
</head>


<body>
<div id="header">
 
  <div class="logo">
    <a href="/board/main">Plus+</a>
  </div>
  

   
</div>

<div class="pg">
   <img src="/resources/imgs/1p.png">
</div>
 
<form id="f" method="post" >
<div class="register">
  <div class="top">
   <p>약관동의</p>
  </div>
  
  
  <div class="middle">
    
    
    
    <div class="info">
      <label>
      <input id="ch1" value="ch1" name="ch" type="checkbox">이용약관 동의 (필수)  </label>  
      <a href="#pop01"><i class="fas fa-info-circle"></i></a>
      
   </div>
   <div class="info">
   <label>
      <input id="ch2" value="ch2" name="ch" type="checkbox">개인정보 수집 및 이용 동의 (필수)</label>
      <a href="#pop02"><i class="fas fa-info-circle"></i></a>
   
   </div>
   <div class="info">
   <label>
      <input id="ch3" value="ch3" name="ch" type="checkbox">위치 정보 동의 (필수)</label>
      <a href="#pop03"><i class="fas fa-info-circle"></i></a>   
   
   </div>
   <div class="info">
   <label>
      <input type="checkbox">이메일 및 광고 홍보 동의 (선택)</label>
      <a href="#pop04"><i class="fas fa-info-circle"></i></a>
 
   </div>
   <div class="all">
   <label>
      <input id="ch4" type="checkbox">전체동의</label>
     
 
   </div>



<div id="pop01" class="overlay">
  <div class="popup">
       <a href="#none" class="close"><i class="fas fa-times"></i></a>
           <div  class="p"> 제 1장 총칙 </div>
         
           <div class="pp">제 1 조 (목적)</div>
              <div class="ppp">  
                                 본 약관은 Plus+팀이 운영하는 웹 사이트의 제반 서비스의 이용조건 및 절차에 관한 사항 및 기타 필요한 사항을 규정함을 목적으로 한다.
               </div>
         
            <div class="pp">제 2 조 (용어의 정의)</div>
             <div class="ppp">         
                                  본 약관에서 사용하는 용어는 다음과 같이 정의한다.<br><br>
               ① 회원 : 기본 회원 정보를 입력하였고, 회사와 서비스 이용계약을 체결하여 아이디를 부여받은 개인<br>
               ② 아이디(ID) : 회원식별과 회원의 서비스 이용을 위해 회원이 선정하고 회사가 승인하는 문자와 숫자의 조합<br>
               ③ 비밀번호(Password) : 회원이 통신상의 자신의 비밀을 보호하기 위해 선정한 문자와 숫자의 조합
             </div>
             
             <div class="pp">제 3 조 (약관의 공시 및 효력과 변경)</div>
              <div class="ppp">
                ①본 약관은 회원가입 화면에 게시하여 공시하며 회사는 사정변경 및 영업상 중요한 사유가 있을 경우 약관을 변경할 수 있으며 변경된 약관은 공지사항을 통해 공시한다.<br>
                ②본 약관 및 차후 회사사정에 따라 변경된 약관은 이용자에게 공시함으로써 효력을 발생한다.
              </div>
              
              <div class="pp">제 4 조 (약관 외 준칙)</div>
               <div class="ppp"> 
                                   본 약관에 명시되지 않은 사항이 전기통신기본법, 전기통신사업법, 정보통신촉진법, ‘전자상거래등에서의 소비자 보호에 관한 법률’, ‘약관의 규제에관한법률’, ‘전자거래기본법’, ‘전자서명법’, ‘정보통신망 이용촉진등에 관한 법률’, ‘소비자보호법’ 등 기타 관계 법령에 규정되어 있을 경우에는 그 규정을 따르도록 한다.
                </div>
                
              <div class="p">제 2 장 가입계약 </div>
                <div class="pp">
                                     제 5 조 (가입신청)
                </div>
                 <div class="ppp">
                   ①가입신청자가 회원가입 안내에서 본 약관과 개인정보보호정책에 동의하고 등록절차(회사의 소정 양식의 가입 신청서 작성)를 거쳐 '확인' 버튼을 누르면 가입신청을 할 수 있다.<br>
                   ②가입신청자는 반드시 아이디, 닉네임, 비밀번호를 양식에 맞춰 설정해야 이용신청을 할 수 있다.
                 </div>
                 <div class="pp">
                                        제 6 조 (이용신청의 승낙)
                 </div>
                 <div class="ppp">
                 ①회사는 제5조에 따른 이용신청자에 대하여 제2항 및 제3항의 경우를 예외로 하여 서비스 이용을 승낙한다.<br>
                 ②회사는 아래 사항에 해당하는 경우에 그 제한사유가 해소될 때까지 승낙을 유보할 수 있다.<br><br>
                                        가. 서비스 관련 설비에 여유가 없는 경우<br>
                                        나. 기술상 지장이 있는 경우<br>
                                        다. 기타 회사 사정상 필요하다고 인정되는 경우
                 </div>
                 <div class="p">
                                         제 3 장 계약 당사자의 의무
                 </div>
                 <div class="pp">
                                          제 7 조 (회사의 의무)
                 </div>
                 <div class="ppp">
                 ①회사는 사이트를 안정적이고 지속적으로 운영할 의무가 있다.<br>
                 ②회사는 이용자로부터 제기되는 의견이나 불만이 정당하다고 인정될 경우에는 즉시 처리해야 한다. 단, 즉시 처리가 곤란한 경우에는 이용자에게 그 사유와 처리일정을 공지사항 또는 전자우편을 통해 통보해야 한다.<br>
                 ③제1항의 경우 수사상의 목적으로 관계기관 및 정보통신윤리위원회의 요청이 있거나 영장 제시가 있는 경우, 기타 관계 법령에 의한 경우는 예외로 한다.
                 
                 </div>
                 <div class="pp">
                                       제 8 조 (이용자의 의무)
                 </div>
                 <div class="ppp">
                 ①이용자는 본 약관 및 회사의 공지사항, 사이트 이용안내 등을 숙지하고 준수해야 하며 기타 회사의 업무에 방해되는 행위를 해서는 안된다.<br>
                 ②이용자는 회사의 사전 승인 없이 본 사이트를 이용해 어떠한 영리행위도 할 수 없다.<br>
                 ③이용자는 본 사이트를 통해 얻는 정보를 회사의 사전 승낙 없이 복사, 복제, 변경, 번역, 출판, 방송 및 기타의 방법으로 사용하거나 이를 타인에게 제공할 수 없다.
                 </div>
                 <div class="p">
                                           제 4 장 서비스의 제공 및 이용
                 </div>
                 <div class="pp">
                                           제 9 조 (서비스 이용)
                 </div>
                 <div class="ppp">
                 ①이용자는 본 약관의 규정된 사항을 준수해 사이트를 이용한다.<br>
                 ②본 약관에 명시되지 않은 서비스 이용에 관한 사항은 회사가 정해 '공지사항'에 게시하거나 또는 별도로 공지하는 내용에 따른다.
                 </div>
                 <div class="pp">제 10 조 (서비스 이용의 제한)</div>
                 <div class="ppp">
                                             본 사이트 이용 및 행위가 다음 각 항에 해당하는 경우 회사는 해당 이용자의 이용을 제한할 수 있다.<br><br>
                     ①공공질서 및 미풍양속, 기타 사회질서를 해하는 경우<br>
                     ②범죄행위를 목적으로 하거나 기타 범죄행위와 관련된다고 객관적으로 인정되는 경우<br>
                     ③타인의 명예를 손상시키거나 타인의 서비스 이용을 현저히 저해하는 경우<br>
                     ④타인의 의사에 반하는 내용이나 광고성 정보 등을 지속적으로 전송하는 경우<br>
                     ⑤해킹 및 컴퓨터 바이러스 유포 등으로 서비스의 건전한 운영을 저해하는 경우<br>
                     ⑥다른 이용자 또는 제3자의 지적재산권을 침해하거나 지적재산권자가 지적 재산권의 침해를 주장할 수 있다고 판단되는 경우<br>
                     ⑦타인의 아이디 및 비밀번호를 도용한 경우<br>
                     ⑧기타 관계 법령에 위배되는 경우 및 회사가 이용자로서 부적당하다고 판단한 경우
                 </div>
                    <div class="pp">제 11 조 (서비스 제공의 중지)</div>  
                 <div class="ppp">
                                     회사는 다음 각 호에 해당하는 경우 서비스의 전부 또는 일부의 제공을 중지할 수 있다.<br><br>
                 ①전기통신사업법 상에 규정된 기간통신 사업자 또는 인터넷 망 사업자가 서비스를 중지했을 경우<br>
                 ②정전으로 서비스 제공이 불가능할 경우<br>
                 ③설비의 이전, 보수 또는 공사로 인해 부득이한 경우<br>
                 ④서비스 설비의 장애 또는 서비스 이용의 폭주 등으로 정상적인 서비스 제공이 어려운 경우<br>
                 ⑤전시, 사변, 천재지변 또는 이에 준하는 국가비상사태가 발생하거나 발생할 우려가 있는 경우
                 </div>
                    <div class="pp">제 12 조 (게시물 관리)</div>  
                  <div class="ppp">
                                     회사는 건전한 통신문화 정착과 효율적인 사이트 운영을 위하여 이용자가 게시하거나 제공하는 자료가 제12조에 해당한다고 판단되는 경우에 임의로 삭제, 자료이동, 등록거부를 할 수 있다.
                  </div>
                  <div class="pp">제 13 조 (서비스 이용 책임)</div>  
                 <div class="ppp">
                                    이용자는 회사에서 권한 있는 사원이 서명한 명시적인 서면에 구체적으로 허용한 경우를 제외하고는 서비스를 이용하여 불법상품을 판매하는 영업활동을 할 수 없으며 특히 해킹, 돈벌기 광고, 음란 사이트를 통한 상업행위, 상용 S/W 불법제공 등을 할 수 없다. 이를 어기고 발생한 영업활동의 결과 및 손실, 관계기관에 의한 구속 등 법적 조치 등에 관해서는 회사가 책임을 지지 않는다.
                  </div>
                  <div class="pppp">
                  <부칙>본 약관은 2020년 10월 18일부터 적용한다.
                  </div>
                



    
  </div>
</div>

<div id="pop02" class="overlay">
  <div class="popup">
    <a href="#none" class="close"><i class="fas fa-times"></i></a>
    <div class="p">제 5장 개인 정보</div>
     <div class="pp">
     제 14 조 (개인신용정보 제공 및 활용에 대한 동의서)     
     </div>
     <div class="ppp">
     회사가 회원 가입과 관련해 취득한 개인 신용 정보는 신용정보의 이용 및 보호에 관한 법률 제23조의 규정에 따라 타인에게 제공 및 활용 시 이용자의 동의를 얻어야 한다. 이용자의 동의는 회사가 회원으로 가입한 이용자의  신용정보를 신용정보기관, 신용정보업자 및 기타 이용자 등에게 제공해 이용자의 신용을 판단하기 위한 자료로서 활용하거나 공공기관에서 정책자료로 활용하는데 동의하는 것으로 간주한다.<br><br>
     ① 회사는 관련 법령이 정하는 바에 따라 회원의 개인정보를 보호하기 위해 노력하며, 개인정보의 보호 및 사용에 대해서는 관련 법령 및 회사의 개인정보처리방침에 따르도록 한. 다만, 회사가 제공하는 서비스 이외의 링크된 서비스에서는 회사의 개인정보처리방침이 적용되지 않는다.<br>
     ② 서비스의 특성에 따라 회원의 개인정보와 관련이 없는 닉네임‧프로필 사진‧게시글 등 내용이 공개될 수 있다.<br>
     ③ 회사는 관련 법령에 의해 관련 국가기관 등의 요청이 있는 경우를 제외하고는 회원의 개인정보를 본인의 동의 없이 타인에게 제공하지 않는다.<br>
     ④ 회사는 회원의 귀책사유로 개인정보가 유출되어 발생한 피해에 대하여 책임을 지지 않는다.<br>
     ⑤아이디와 비밀번호의 관리 및 이용자의 부주의로 인하여 발생되는 손해 또는 제3자에 의한 부정사용 등에 대한 책임은 이용자에게 있다.<br>
     ⑥이용자가 본 약관의 규정을 위반함으로써 회사에 손해가 발생하는 경우 이 약관을 위반한 이용자는 회사에 발생한 모든 손해를 배상해야 하며 동 손해로부터 회사를 면책시켜야 한다.
     
     </div>
  </div>
</div>

<div id="pop03" class="overlay">
  <div class="popup">
    <a href="#none" class="close"><i class="fas fa-times"></i></a>
     위치 정보 동의 내용
  </div>
</div>

<div id="pop04" class="overlay">

  <div class="popup">
    <a href="#none" class="close"><i class="fas fa-times"></i></a>
   <div class="p">제 7장 광고성 정보</div>
   <div class="pp">
       제 16 조 (정보의 제공)
   </div>
   <div class="ppp">
   회사는 회원이 서비스 이용 중 필요하다고 인정되는 다양한 정보에 대하여 전자메일이나 서신우편 등의 방법으로 회원에게 정보를 제공할 수 있다.
   </div>
   <div class="pp">
   제 17 조 (광고게재)   
   </div>
   <div class="ppp">
   ①회사는 서비스의 운용과 관련하여 서비스 화면, 홈페이지, 전자우편 등에 광고 등을 게재할 수 있다.<br>
②회사는 사이트에 게재되어 있는 광고주의 판촉활동에 회원이 참여하거나 교신 또는 거래의 결과로서 발생하는 모든 손실 또는 손해에 대해 책임을 지지 않는다.<br>
   
   </div>
  </div>
  
</div>
    
  
  </div>
    <div class="low">
    
       <div class="back" style=" float:left">
          <button type="button" id="bBack">이전</button>
       </div>    
       
       <div class="next" style="float:right">
          <button type="button" id="bNext">다음</button>
       </div>
       
    </div>

</div>

</form>
</body>
</html>

 