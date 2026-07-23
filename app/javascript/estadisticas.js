document.addEventListener("turbo:load", function () {
    const canvas = document.getElementById("graficaCarreras");
    if (!canvas) return;
    const datos = JSON.parse(canvas.dataset.datos);
    new Chart(canvas.getContext("2d"), {
        type: "bar",
        data: {
            labels: Object.keys(datos),
            datasets: [{
                label: "Número de tesis",
                data: Object.values(datos),
                backgroundColor: [
                    "#3B82F6",
                    "#2563EB",
                    "#1D4ED8",
                    "#60A5FA",
                    "#93C5FD",
                    "#38BDF8",
                    "#2563EB",
                    "#1E40AF"
                ],
                borderColor: "#1E40AF",
                borderWidth: 2,
                borderRadius: 12,
                borderSkipped: false,
                barThickness: 45,
                hoverBackgroundColor: "#1E40AF",
                hoverBorderWidth: 3
            }]
        },

        options: {
            responsive: true,
            maintainAspectRatio: false,
            layout: {
                padding: 20
            },

            animation: {
                duration: 1200,
                easing: "easeOutQuart"
            },

            plugins: {
                legend: {
                    display: false
                },

                title: {
                    display: true,
                    text: "Tesis registradas por carrera",
                    color: "#1F2937",
                    font: {
                        size: 18,
                        weight: "bold"
                    },
                    padding: {
                        bottom: 20
                    }
                },

                tooltip: {
                    backgroundColor: "#1F2937",
                    titleColor: "#FFFFFF",
                    bodyColor: "#FFFFFF",
                    padding: 12,
                    cornerRadius: 10,
                    callbacks: {
                        label: function(context) {
                            const valor = context.raw;
                            const datos = context.dataset.data;
                            const total = datos.reduce((a, b) => a + b, 0);
                            const porcentaje = ((valor / total) * 100).toFixed(1);
                            return [
                                "Tesis: " + valor,
                                "Porcentaje: " + porcentaje + "%"
                            ];
                        }
                    }
                }
            },

            scales: {
                x: {
                    grid: {
                        display: false
                    },

                    ticks: {
                        color: "#374151",
                        font: {
                            size: 13,
                            weight: "bold"
                        }
                    }
                },

                y: {
                    beginAtZero: true,
                    ticks: {
                        precision: 0,
                        color: "#6B7280"
                    },

                    grid: {
                        color: "rgba(0,0,0,0.06)"
                    }
                }
            }
        }
    });
});