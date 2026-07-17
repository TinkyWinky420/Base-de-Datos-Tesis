document.addEventListener("turbo:load", function () {
    const canvas = document.getElementById("graficaCarreras");
    if (!canvas) return;
    if (typeof Chart === "undefined") return;
    const datos = JSON.parse(canvas.dataset.datos);
    new Chart(canvas, {
        type: "bar",
        data: {
            labels: Object.keys(datos),
            datasets: [{
                label: "Número de tesis",
                data: Object.values(datos),
                borderWidth: 1
            }]
        },

        options: {
            responsive: true,
            plugins: {
                legend: {
                    display: false
                }
            },

            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0
                    }
                }
            }
        }
    });
});