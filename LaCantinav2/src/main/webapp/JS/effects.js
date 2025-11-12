function fadeInOnScroll() {
    var elements = document.querySelectorAll('.fade-in');


    function isElementInViewport(el) {
        var rect = el.getBoundingClientRect();
        return (
            rect.top >= 0 &&
            rect.left >= 0 &&
            rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
            rect.right <= (window.innerWidth || document.documentElement.clientWidth)
        );
    }


    function checkFadeIn() {
        elements.forEach(function(element) {
            if (isElementInViewport(element)) {
                if (!element.classList.contains('visible')) {
                    element.classList.add('visible');
                }
            } else {
                element.classList.remove('visible');
            }
        });
    }

    checkFadeIn();
    document.addEventListener('scroll', checkFadeIn);
    window.addEventListener('resize', checkFadeIn);
}

document.addEventListener('DOMContentLoaded', function() {
    fadeInOnScroll();
});