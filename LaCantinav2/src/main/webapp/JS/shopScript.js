function filter() {
    var category = document.getElementById("categories").value;
    var minPrice = document.getElementById("minPrice").value;
    var maxPrice = document.getElementById("maxPrice").value;
    var sort = document.getElementById("sort").value;
	
    if (maxPrice == 0 || maxPrice=="") {
        maxPrice = 10000000;
    }
    
    
    if (minPrice == 0 || minPrice=="") {
        minPrice = 0;
    }
    
     if (maxPrice < minPrice) {
        var temp = minPrice;
        minPrice = maxPrice;
        maxPrice = temp;
    }
    
    if (sort == "") {
        sort = "AZ";
    }
    console.log(`Category: ${category}, Min Price: ${minPrice}, Max Price: ${maxPrice}, Sort: ${sort}`);

    const xhr = new XMLHttpRequest();
    xhr.open("GET", `./FilterServlet?category=${category}&minPrice=${minPrice}&maxPrice=${maxPrice}&sort=${sort}`, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var productItemsElement = document.getElementById("products");
            if (productItemsElement) {
                productItemsElement.innerHTML = xhr.responseText;
            } else {
                console.error("Elemento non trovato nel DOM.");
            }
        }
    };
    xhr.send();
}
