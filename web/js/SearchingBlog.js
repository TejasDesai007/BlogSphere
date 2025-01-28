

// search.js
$(document).ready(function () {
    $("#searchButton").click(function () {
        let query = $("#searchInput").val().trim();
        if (query === "") {
            alert("Please enter a search query.");
            return;
        }

        // Make AJAX request
        $.ajax({
            url: "SearchBlog",
            method: "GET",
            data: { query: query },
            dataType: "json",
            success: function (response) {
                console.log(response.trim());
                if (response.length === 0) {
                    $("#searchResults").html("<p class='text-danger'>No results found!</p>");
                } else {
                    let output = "<div class='row'>";
                    response.forEach(blog => {
                        output += `
                            <div class="col-md-6">
                                <div class="card mb-4">
                                    <div class="card-body">
                                        <h5 class="card-title">${blog.title}</h5>
                                        <h6 class="card-subtitle mb-2 text-muted">By ${blog.userName} on ${blog.publishedAt}</h6>
                                        <p class="card-text">${blog.content.length > 150 ? blog.content.substring(0, 150) + "..." : blog.content}</p>
                                        <a href="viewPost?postID=${blog.postID}" class="card-link">Read More</a>
                                    </div>
                                </div>
                            </div>
                        `;
                    });
                    output += "</div>";
                    $("#searchResults").html(output);
                }
            },
            error: function () {
                $("#searchResults").html("<p class='text-danger'>An error occurred while searching. Please try again.</p>");
            }
        });
    });
});
