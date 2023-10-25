<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Footer-->
        <footer class="py-5 bg-dark" style="height:150px;">
            <div class="container"><p class="m-0 text-center text-white" style="text-shadow: 2px 2px 2px gray; font-size: 2em;">
            	현재 시각 : <span id="current" class="display"></span>
            </p></div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="/resources/js/scripts.js"></script>
    </body>
    
    <script>
    setInterval(displayNow, 1000); // 1초마다 시간 갱신
    function displayNow() {
      let now = new Date();
      let currentTime = now.toLocaleTimeString();//현재 거주 지역에 맞는 시간

      document.querySelector("#current").innerHTML = currentTime
    }

  </script>
</html>