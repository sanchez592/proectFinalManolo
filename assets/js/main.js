// Carousel automático
let currentSlide = 0;
let carouselInterval;

function initCarousel() {
    const items = document.querySelectorAll('.carousel-item');
    const indicators = document.querySelectorAll('.indicator');
    
    if(items.length === 0) return;

    function showSlide(index) {
        items.forEach((item, i) => {
            item.classList.remove('active');
            if(i === index) {
                item.classList.add('active');
            }
        });
        
        indicators.forEach((indicator, i) => {
            indicator.classList.remove('active');
            if(i === index) {
                indicator.classList.add('active');
            }
        });
    }

    function nextSlide() {
        currentSlide = (currentSlide + 1) % items.length;
        showSlide(currentSlide);
    }

    function startCarousel() {
        carouselInterval = setInterval(nextSlide, 5000); // Cambia cada 5 segundos
    }

    function stopCarousel() {
        clearInterval(carouselInterval);
    }

    // Iniciar carousel automático
    startCarousel();

    // Pausar al hacer hover
    const carouselContainer = document.querySelector('.carousel-container');
    if(carouselContainer) {
        carouselContainer.addEventListener('mouseenter', stopCarousel);
        carouselContainer.addEventListener('mouseleave', startCarousel);
    }

    // Click en items del carousel para redirigir
    items.forEach((item, index) => {
        item.addEventListener('click', function() {
            const productId = this.getAttribute('data-product-id');
            if(productId) {
                window.location.href = `/proyectoFinalManolo/views/producto.php?id=${productId}`;
            }
        });
    });
}

// Funciones para controles manuales
function moveCarousel(direction) {
    const items = document.querySelectorAll('.carousel-item');
    if(items.length === 0) return;
    
    currentSlide += direction;
    if(currentSlide < 0) {
        currentSlide = items.length - 1;
    } else if(currentSlide >= items.length) {
        currentSlide = 0;
    }
    
    const indicators = document.querySelectorAll('.indicator');
    items.forEach((item, i) => {
        item.classList.remove('active');
        if(i === currentSlide) {
            item.classList.add('active');
        }
    });
    
    indicators.forEach((indicator, i) => {
        indicator.classList.remove('active');
        if(i === currentSlide) {
            indicator.classList.add('active');
        }
    });
}

function goToSlide(index) {
    currentSlide = index;
    const items = document.querySelectorAll('.carousel-item');
    const indicators = document.querySelectorAll('.indicator');
    
    items.forEach((item, i) => {
        item.classList.remove('active');
        if(i === index) {
            item.classList.add('active');
        }
    });
    
    indicators.forEach((indicator, i) => {
        indicator.classList.remove('active');
        if(i === index) {
            indicator.classList.add('active');
        }
    });
}

// Inicializar cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', function() {
    initCarousel();
    
    // Mostrar mensajes de éxito/error
    const urlParams = new URLSearchParams(window.location.search);
    if(urlParams.get('success') === '1') {
        showNotification('Operación realizada exitosamente', 'success');
    }
});

function showNotification(message, type) {
    const notification = document.createElement('div');
    notification.className = `alert alert-${type}`;
    notification.textContent = message;
    notification.style.position = 'fixed';
    notification.style.top = '20px';
    notification.style.right = '20px';
    notification.style.zIndex = '9999';
    notification.style.minWidth = '300px';
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        notification.remove();
    }, 3000);
}



