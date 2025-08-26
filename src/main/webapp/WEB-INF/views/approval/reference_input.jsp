<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reference Line</title>
</head>
<body>
<div>
    <jsp:include page ="../nav/header.jsp"></jsp:include>
</div>

<div class="main-content">
    <div class="page-content">
        <div class="container-fluid">

            <!-- 페이지 타이틀 -->
            <div class="row align-items-center mb-2">
                <div class="col">
                    <h4 class="mb-0">참조선 지정</h4>
                </div>
            </div>

            <!-- 본문 -->
            <div class="card">
                <div class="card-body">

                    <!-- 상단 탭 -->
					<ul class="nav nav-tabs mb-3">
					    <li class="nav-item">
					        <a class="nav-link active" data-bs-toggle="tab" href="#tab-org">조직도</a>
					    </li>
					    <!--
					    <li class="nav-item">
					        <a class="nav-link" data-bs-toggle="tab" href="#tab-search">검색</a>
					    </li>
					    -->
					</ul>
					
						<div class="row">						
						    <!-- 조직도 / 검색 패널 -->
						    <div class="col-md-5">
						        <div class="tab-content border rounded p-2" style="height: 440px; overflow:auto;">
						        
						            <!-- 조직도 -->
						            <div id="tab-org" class="tab-pane fade show active">
									    <small class="text-muted d-block mb-2">조직도 (체크 후 ▶ 버튼)</small>
									    <ul class="list-unstyled" id="orgTreeBox">
									        <c:forEach var="dept" items="${orgTree}">
									            <li class="mb-2">
									                <a class="text-decoration-none d-inline-flex align-items-center org-toggle"
									                   data-bs-toggle="collapse"
									                   href="#dept-${dept.id}"
									                   role="button"
									                   aria-expanded="true"
									                   aria-controls="dept-${dept.id}">
									                    <span class="me-1 caret" style="display:inline-block; transition:.2s transform;">▾</span>
									                    <i class="uil uil-building me-1"></i> ${dept.name}
									                </a>
									                
									                <!-- 부서: 기본 펼침 -->
									                <ul class="list-unstyled ms-3 mt-1 collapse show" id="dept-${dept.id}">
									                	<%-- dept.users가 없을 때(forEach NPE) 방지 --%>
									                	<c:if test="${not empty dept.users}">
										                    <c:forEach var="team" items="${dept.users}">
										                        <li class="mt-2">
										                            <a class="text-decoration-none d-inline-flex align-items-center org-toggle"
										                               data-bs-toggle="collapse"
										                               href="#team-${dept.id}-${team.id}"
										                               role="button"
										                               aria-expanded="false"
										                               aria-controls="team-${dept.id}-${team.id}">
										                                <span class="me-1 caret" style="display:inline-block; transition:.2s transform;">▸</span>
										                                <i class="uil uil-sitemap me-1"></i> ${team.name}
										                            </a>
										                            
										                            <!-- 팀: 기본 접힘 -->
										                            <ul class="list-unstyled ms-3 mt-1 collapse" id="team-${dept.id}-${team.id}">
										                            	<!-- 팀 자체 참조용 체크박스 -->
										                            	<li class="form-check mb-1">
																	        <input class="form-check-input ref-chk team-chk"
																	               type="checkbox"
																	               id="t${team.id}"
																	               data-type="TEAM"
																	               data-id="${team.id}"
																	               data-team-id="${team.id}"
																	               data-name="${team.name}"
																	               data-dept="${dept.name}"
																	               data-team="${team.name}">
																	        <label class="form-check-label" for="t${team.id}">
																	            👥 팀 전체 참조: ${team.name}
																	        </label>
																	    </li>
										                            
										                                <!-- 팀 소속 사용자 목록 -->
																	    <c:forEach var="user" items="${team.users}">
																	        <li class="form-check">
																	            <input class="form-check-input ref-chk user-chk"
																	                   type="checkbox"
																	                   id="u${user.id}"
																	                   data-type="USER"
																	                   data-id="${user.id}"
																	                   data-team-id="${team.id}"
																	                   data-name="${user.name}"
																	                   data-rank="${user.userRank}"
																	                   data-dept="${dept.name}"
																	                   data-team="${team.name}">
																	            <label class="form-check-label" for="u${user.id}">
																	                👤 ${user.name} <span class="text-muted">(${user.userRank})</span>
																	            </label>
																	        </li>
																	    </c:forEach>
										                            </ul>
										                            
										                        </li>
										                    </c:forEach>
										                </c:if>
									                </ul>
									                
									            </li>
									        </c:forEach>
									    </ul>
									</div>
						
						            <!-- 검색 -->
						            <!--
						            <div id="tab-search" class="tab-pane fade">
						                <div class="input-group">
						                    <input type="text" class="form-control" id="keyword" placeholder="이름/부서/팀 검색">
						                    <button class="btn btn-primary" type="button" id="btnSearch">검색</button>
						                </div>
						                <div class="mt-2" id="searchResultsBox"></div>
						            </div>
						            -->
						            
						        </div>
						    </div>
						
						    <!-- 가운데 이동 버튼 -->
						    <div class="col-md-1 d-flex flex-column align-items-center justify-content-center gap-2">
						        <button type="button" id="btnAdd" class="btn btn-outline-primary">&gt;</button>
						        <button type="button" id="btnRemove" class="btn btn-outline-secondary">&lt;</button>
						        <button type="button" id="btnReset" class="btn btn-outline-danger">&#x21BA;</button>
						    </div>
						
						    <!-- 우측: 결재선 정보 -->
						    <div class="col-md-6">
						        <div class="border rounded p-2" style="height: 440px; overflow:auto;">
						            <table class="table table-sm table-hover align-middle text-center" id="tblLines">
						                <thead class="table-light">
						                    <tr>
						                        <th style="width:8%;">선택</th>
										        <th style="width:12%;">유형</th>  <!-- 개인 / 팀 -->
										        <th style="width:30%;">대상</th>  <!-- 이름 또는 팀명 -->
										        <th style="width:30%;">소속</th>  <!-- 부서 / 팀 (개인일 때만 표시) -->
						                    </tr>
						                </thead>
						                <!-- tbody는 JavaScript에서 동적으로 행(tr) 추가 -->
						                <tbody>
						                	<!-- JS addSelectedRefs() 실행 시 여기에 행이 추가됨 -->
						                </tbody>
						            </table>
						        </div>
						        <small class="text-muted d-block mt-1">※ 팀 참조는 최대 3팀까지만 가능합니다.</small>
						        <small class="text-muted d-block mt-1">※ 개인 참조는 최대 10명까지만 가능합니다.</small>
						        <small class="text-muted d-block mt-1">※ 참조 대상은 총 15개까지만 가능합니다.</small>
						    </div>						    
						</div>

                    <!-- 하단 버튼 -->
                    <div class="d-flex justify-content-end gap-2 mt-3">
                        <a href="javascript:history.back();" class="btn btn-outline-secondary">닫기</a>
                        <button type="button" id="btnRefApply" class="btn btn-outline-success">적용</button>
                    </div>
                   
                </div>
            </div>

        </div>
    </div>
</div>

<div>
    <jsp:include page ="../nav/footer.jsp"></jsp:include>
</div>

<div>
    <jsp:include page ="../nav/javascript.jsp"></jsp:include>
</div>

<script>
	(function () {
	    // ===== 조직도(부서/팀) 접기/펼치기 =====
	    function setCaret(el, expanded) {
	        const caret = el.querySelector('.caret');
	        if (!caret) return;
	        caret.textContent = expanded ? '▾' : '▸';
	    }
	
	    // 초기 caret 상태 설정 (부서: 펼침, 팀: 접힘)
	    document.querySelectorAll('a.org-toggle').forEach(function(a) {
	        const target = document.querySelector(a.getAttribute('href'));
	        const expanded = target && target.classList.contains('show');
	        setCaret(a, expanded);
	    });
	
	    // collapse 이벤트에 맞춰 caret(▾/▸) 자동 전환
	    document.addEventListener('shown.bs.collapse', function (e) {
	        const id = e.target.id;
	        // aria-controls 또는 href로 해당 id를 가리키는 토글 앵커 선택
	        const selector =
	            'a.org-toggle[aria-controls="' + id + '"], ' +
	            'a.org-toggle[href="#' + id + '"]';
	        const toggle = document.querySelector(selector);
	        if (!toggle) return;
	        setCaret(toggle, true);
	    });
	
	    document.addEventListener('hidden.bs.collapse', function (e) {
	        const id = e.target.id;
	        const selector =
	            'a.org-toggle[aria-controls="' + id + '"], ' +
	            'a.org-toggle[href="#' + id + '"]';
	        const toggle = document.querySelector(selector);
	        if (!toggle) return;
	        setCaret(toggle, false);
	    });

        
        // ===== 참조선 목록 업데이트 로직 =====
        const tblBody = document.querySelector('#tblLines tbody');
        const addBtn = document.getElementById('btnAdd');
        const removeBtn = document.getElementById('btnRemove');
        const resetBtn = document.getElementById('btnReset');
        const applyBtn = document.getElementById('btnRefApply');

        // 상한 값
        const MAX_TEAMS = 3;   // 최대 3팀
        const MAX_USERS = 10;  // 최대 10명
        const MAX_TOTAL = 15;  // 총합 15 (팀+개인)

        // 현재 카운트
        function countTeams() {
            return tblBody.querySelectorAll('tr[data-type="TEAM"]').length;
        }
        function countUsers() {
            return tblBody.querySelectorAll('tr[data-type="USER"]').length;
        }
        function countTotal() {
            return tblBody.querySelectorAll('tr').length;
        }

        // 추가 버튼 상태 (총 15개 선택 시 비활성화)
        function updateAddBtnState() {
	      addBtn.disabled = (countTotal() >= MAX_TOTAL);
	    }
        
    	// 팀 선택 시 소속 개인 체크박스 비활성화
        function setTeamUsersDisabled(teamId, disabled) {
            document.querySelectorAll('.user-chk[data-team-id="' + teamId + '"]').forEach(function(chk) {
                if (disabled) chk.checked = false;
                chk.disabled = disabled;
                const label = chk.closest('li.form-check')?.querySelector('label');  // 라벨 흐리게
                if (label) label.classList.toggle('text-muted', disabled);
            });
        }

    	// 해당 팀이 체크된 상태면 개인 선택 불가
        document.addEventListener('change', function(e) {
            if (e.target.classList.contains('team-chk')) {
                const teamId = e.target.dataset.teamId;
                setTeamUsersDisabled(teamId, e.target.checked);
            }
            if (e.target.classList.contains('user-chk')) {
                const teamId = e.target.dataset.teamId;
                const teamChk = document.querySelector('.team-chk[data-team-id="' + teamId + '"]');
                if (teamChk && teamChk.checked) {
                    e.target.checked = false;
                }
            }
        });
        
        // 좌측에서 선택된 참조 대상들을 우측 테이블에 추가 (중복 방지 + 상한 제한)
        function addSelectedRefs() {
            const checked = Array.from(document.querySelectorAll('.ref-chk:checked'));
            if (!checked.length) return;

            let teamCnt = countTeams();
            let userCnt = countUsers();
            let totalCnt = countTotal();

            let totalAtLimit = false;  		// 상한 초과로 추가하지 못한 참조자 존재 여부
            let userBlockedByTeam = false;  // 팀 선택 시 개인 추가 차단
            let userAtLimit = false;  		// 개인 초과 여부
            let teamAtLimit = false;       	// 팀 초과 여부

            for (const chk of checked) {
                const type = chk.dataset.type;  // USER | TEAM
                const id = chk.dataset.id;
                const name = chk.dataset.name || '';
                const rank = chk.dataset.rank || '';
                const dept = chk.dataset.dept || '';
                const team = chk.dataset.team || '';
                const teamId = chk.dataset.teamId || '';

                // 중복 확인: 이미 추가된 대상이면 패스
                if (tblBody.querySelector('tr[data-type="' + type + '"][data-id="' + id + '"]')) {
                    chk.checked = false;
                    continue;
                }
                
             	// 팀이 이미 선택된 경우 개인 선택 불가
                if (type == 'USER' && teamId) {
                    const existsTeamRow = tblBody.querySelector('tr[data-type="TEAM"][data-id="' + teamId + '"]');
                    if (existsTeamRow) {
                        chk.checked = false;
                        if (!userBlockedByTeam) {
                            alert('해당 팀이 참조로 추가되어 개인을 별도로 선택할 수 없습니다.');
                            userBlockedByTeam = true;
                        }
                        continue;
                    }
                }
             	
             	// 팀 참조 추가 시 해당 팀 개인 참조 제거
                if (type == 'TEAM' && teamId) {
                    tblBody.querySelectorAll('tr[data-type="USER"][data-team-id="' + teamId + '"]').forEach(function(tr) {
                        tr.remove();
                        userCnt--;
                        totalCnt--;
                    });
                }

                // 총합 상한 체크
                if (totalCnt >= MAX_TOTAL) {
                	totalAtLimit = true;
                    chk.checked = false;
                    continue;
                }

                // 유형별 상한 체크
                if (type == 'TEAM' && teamCnt >= MAX_TEAMS) {
                	teamAtLimit = true;
                    chk.checked = false;
                    continue;
                }
                if (type == 'USER' && userCnt >= MAX_USERS) {
                	userAtLimit = true;
                    chk.checked = false;
                    continue;
                }
             
                // 행 추가
                const tr = document.createElement('tr');
                tr.setAttribute('data-type', type);
                tr.setAttribute('data-id', id);
                if (teamId) tr.setAttribute('data-team-id', teamId);
                tr.innerHTML =
                    '<td class="text-center"><input type="checkbox" class="row-chk"></td>' +
                    '<td class="text-center">' + (type == 'USER' ? '개인' : '팀') + '</td>' +
                    '<td class="text-center">' + (type == 'USER' ? name + (rank ? ' (' + rank + ')' : '') : name) + '</td>' +
                    '<td class="text-center"><span class="small text-muted d-inline-block text-truncate" style="max-width: 220px;">' +
                        (dept || '') + ((dept && team) ? ' / ' : '') + (team || '') +
                    '</span></td>';
                tblBody.appendChild(tr);

                // 카운트 증가
                if (type == 'TEAM') teamCnt++;
                if (type == 'USER') userCnt++;
                totalCnt++;

                // 좌측 체크 해제
                chk.checked = false;
            }

            if (teamAtLimit) {
                alert('팀 참조는 최대 ' + MAX_TEAMS + '팀까지만 가능합니다.');
            }
            if (userAtLimit) {
                alert('개인 참조는 최대 ' + MAX_USERS + '명까지만 가능합니다.');
            }
            if (totalAtLimit) {
                alert('참조 대상은 총 ' + MAX_TOTAL + '개까지만 추가할 수 있습니다.');
            }

            updateAddBtnState();
        }

        
        // 체크된 참조자 행 삭제
        function removeSelectedRows() {
            tblBody.querySelectorAll('input.row-chk:checked')
                .forEach(function(chk){ chk.closest('tr').remove(); });
            updateAddBtnState();
        }

        // 참조자 전체 초기화
        function resetAll() {
            tblBody.innerHTML = '';
            document.querySelectorAll('.ref-chk:checked').forEach(function(chk){ chk.checked = false; });
            document.querySelectorAll('.team-chk').forEach(function(teamChk) {
                setTeamUsersDisabled(teamChk.dataset.teamId, false);
            });
            updateAddBtnState();
        }

        // 체크 시 행 강조
        tblBody.addEventListener('change', function (e) {
            if (!e.target.classList.contains('row-chk')) return;
            const tr = e.target.closest('tr');
            if (!tr) return;
            tr.classList.toggle('table-active', e.target.checked);
        });

        // 선택한 참조선 저장 후 이전 페이지로 이동
        function applySelection() {
            // 현재 테이블의 모든 행 수집
            const rows = tblBody.querySelectorAll('tr');
            
            if (rows.length == 0) {
                alert('참조 대상을 최소 1개 이상 선택해 주세요.');
                return;
            }

            
            // 최종 검증
            const teamCnt = countTeams();
            const userCnt = countUsers();
            const totalCnt = teamCnt + userCnt;

            if (teamCnt > MAX_TEAMS) {
                alert('팀 참조는 최대 ' + MAX_TEAMS + '팀까지만 가능합니다.');
                return;
            }
            if (userCnt > MAX_USERS) {
                alert('개인 참조는 최대 ' + MAX_USERS + '명까지만 가능합니다.');
                return;
            }
            if (totalCnt > MAX_TOTAL) {
                alert('참조 대상은 총합 ' + MAX_TOTAL + '개까지만 가능합니다.');
                return;
            }
                
            // 선택된 행들을 전송/저장용 최소 데이터로 변환
            const list = Array.from(rows).map(function(tr, idx){
                return {
                    type: tr.getAttribute('data-type'),      	   // USER or TEAM
                    id: parseInt(tr.getAttribute('data-id'), 10),  // userId or teamId
                    seq: idx + 1
                };
            });
            
            // 다음 화면에서 읽을 수 있도록 localStorage에 저장
            localStorage.setItem('referenceLines', JSON.stringify(list));
            
            // 뒤로가기
            history.back();
        }

        // 버튼 바인딩
        addBtn.addEventListener('click', addSelectedRefs);
        removeBtn.addEventListener('click', removeSelectedRows);
        resetBtn.addEventListener('click', resetAll);
        applyBtn.addEventListener('click', applySelection);
        updateAddBtnState();  // 초기 로드 시 추가 버튼 상태 초기화
    })();
</script>

</body>
</html>