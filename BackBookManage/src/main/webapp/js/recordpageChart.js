document.addEventListener("DOMContentLoaded", function () {
    const ctx = document.getElementById('goalChart').getContext('2d');

    // Chart.js로 도넛 그래프 생성
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['읽은 책', '남은 책'],
            datasets: [{
                data: [booksRead, booksRemaining], // 서버에서 전달된 데이터 사용
                backgroundColor: ['#FFD700', '#FFFFFF'], // 노란색, 하얀색
                borderColor: ['#FFD700', '#CCCCCC'],     // 테두리 색상
                borderWidth: 1,
				radius: 150
            }]
        },
        options: {
         responsive: true,
            plugins: {
                legend: {
                    position: 'bottom' // 범례 위치
                }
            }
        }
    });
});