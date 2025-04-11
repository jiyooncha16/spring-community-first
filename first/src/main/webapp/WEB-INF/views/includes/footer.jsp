        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jsp 파일 작성 시 자바스크립트로 조작하는 경우 많으므로, jQuery는 header에 두고 jsp에서 자유롭게 작성할수 있도록 하는 것이 좋음.
    <script src="/resources/vendor/jquery/jquery.min.js"></script>  -->

    <!-- Bootstrap Core JavaScript -->
    <script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- DataTables JavaScript -->
    <script src="/resources/vendor/datatables/js/jquery.dataTables.min.js"></script>
    <script src="/resources/vendor/datatables-plugins/dataTables.bootstrap.min.js"></script>
    <script src="/resources/vendor/datatables-responsive/dataTables.responsive.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="/resources/dist/js/sb-admin-2.js"></script>

    <!-- Page-Level Demo Scripts - Tables - Use for reference -->
    <script>
    $(document).ready(function() {
        $('#dataTables-example').DataTable({
            responsive: true
        });
        $(".sidebar-nav") // 모바일 크기에서 사이드바 펼쳐짐 현상 수정용 코드
    	.attr("class", "sidebar-nav navbar-collapse collapse")
    	.attr("aria-expanded", "false")
    	.attr("style", "height:1px");
    });
    </script>

</body>

</html>
<!-- 
<script>
$(document).ready(function() {
	$('#dataTables-example').DataTable();
	 -->