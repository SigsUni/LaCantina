document.addEventListener("DOMContentLoaded", function() {
    // elements to watch for intersection
    var elements_to_watch = document.querySelectorAll('.watch');

    // callback function for intersection observer
    var callback = function(items) {
        items.forEach((item) => {
            if(item.isIntersecting) {
                item.target.classList.add("in-page");
            } else {
                item.target.classList.remove("in-page");
            }
        });
    }

    // create an IntersectionObserver instance
    var observer = new IntersectionObserver(callback, { threshold: 0.6 });

    // observe each element in elements_to_watch
    elements_to_watch.forEach((element) => {
        observer.observe(element);
    });
});