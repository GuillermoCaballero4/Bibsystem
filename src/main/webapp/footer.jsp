<!DOCTYPE html>

<footer id="footer">
    <!-- Aquí puedes agregar el contenido del pie de página -->
    <div class="text-center">
        <p>&copy; Copyright <strong><span>Bibsystem</span></strong>. Derechos reservados</p>
    </div>
</footer><!-- End Footer -->

<!-- Back to top button -->
<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<!-- Scripts para el Footer -->

<!-- jQuery versión 3.6.0 (para cabecera-detalle) -->
<script src="js/nj/jquery-3.6.0.min.js"></script>

<!-- jQuery versión 3.7.1 (plantilla) -->
<script src="js/jquery-3.7.1.min.js"></script>

<!-- Bootstrap JS -->
<script src="js/nj/bootstrap.min.js"></script>
<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Vendor JS Files -->
<script src="vendor/apexcharts/apexcharts.min.js"></script>
<script src="vendor/chart.js/chart.umd.js"></script>
<script src="vendor/echarts/echarts.min.js"></script>
<script src="vendor/quill/quill.js"></script>
<script src="vendor/simple-datatables/simple-datatables.js"></script>
<script src="vendor/tinymce/tinymce.min.js"></script>
<script src="vendor/php-email-form/validate.js"></script>

<!-- Custom Scripts -->
<script src="js/main.js"></script>

<!-- Select2 -->
<script src="js/select2.min.js"></script>

<!-- ECharts Configuration -->
<script>
document.addEventListener("DOMContentLoaded", () => {
    // Configuración del gráfico de tráfico
    echarts.init(document.querySelector("#trafficChart")).setOption({
        tooltip: {
            trigger: 'item'
        },
        legend: {
            top: '5%',
            left: 'center'
        },
        series: [{
            name: 'Access From',
            type: 'pie',
            radius: ['40%', '70%'],
            avoidLabelOverlap: false,
            label: {
                show: false,
                position: 'center'
            },
            emphasis: {
                label: {
                    show: true,
                    fontSize: '18',
                    fontWeight: 'bold'
                }
            },
            labelLine: {
                show: false
            },
            data: [
                { value: 1048, name: 'Search Engine' },
                { value: 735, name: 'Direct' },
                { value: 580, name: 'Email' },
                { value: 484, name: 'Union Ads' },
                { value: 300, name: 'Video Ads' }
            ]
        }]
    });

    // Configuración del gráfico de presupuesto
    var budgetChart = echarts.init(document.querySelector("#budgetChart")).setOption({
        legend: {
            data: ['Allocated Budget', 'Actual Spending']
        },
        radar: {
            indicator: [
                { name: 'Sales', max: 6500 },
                { name: 'Administration', max: 16000 },
                { name: 'Information Technology', max: 30000 },
                { name: 'Customer Support', max: 38000 },
                { name: 'Development', max: 52000 },
                { name: 'Marketing', max: 25000 }
            ]
        },
        series: [{
            name: 'Budget vs spending',
            type: 'radar',
            data: [
                { value: [4200, 3000, 20000, 35000, 50000, 18000], name: 'Allocated Budget' },
                { value: [5000, 14000, 28000, 26000, 42000, 21000], name: 'Actual Spending' }
            ]
        }]
    });
});
</script>

<!-- Custom Table Filtering Script -->
<script>
function filtrarTabla() {
    var input, filter, table, tr, td, i, j, txtValue;
    input = document.getElementById("filtroInput");
    filter = input.value.toUpperCase();
    table = document.getElementById("resultado");
    tr = table.getElementsByTagName("tr");

    for (i = 1; i < tr.length; i++) {
        tr[i].style.display = "none"; // Ocultar todas las filas inicialmente
        td = tr[i].getElementsByTagName("td");
        for (j = 0; j < td.length; j++) { // Recorrer todas las celdas de la fila
            if (td[j]) {
                txtValue = td[j].textContent || td[j].innerText;
                if (txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display = ""; // Mostrar la fila si coincide con el filtro
                    break; // Dejar de buscar en esta fila si ya encontró una coincidencia
                }
            }
        }
    }
}

</script>

<!-- Select2 Configuration -->
<script>
    $(document).ready(function() {
        $('.select2').select2({
            placeholder: "Seleccione una opción",
            allowClear: true,
            minimumInputLength: 1,
            language: {
                inputTooShort: function () {
                    return "Ingrese uno o más caracteres";
                },
                noResults: function () {
                    return "No se encontraron resultados";
                },
                searching: function () {
                    return "Buscando...";
                }
            },
            matcher: function(params, data) {
                if ($.trim(params.term) === '') {
                    return data;
                }
                if (data.text.toLowerCase().indexOf(params.term.toLowerCase()) > -1) {
                    return data;
                }
                return null;
            }
        });
    });

    $('.select2').on('select2:selecting', function(e) {
        if (!e.params.args.data) {
            e.preventDefault(); // Evitar seleccionar si no hay coincidencias
        }
    });
</script>


</body>
</html>
