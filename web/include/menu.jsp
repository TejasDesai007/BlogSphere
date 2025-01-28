<%!
    public String isBlankNull(String str) {
        return (str == null || str.trim().isEmpty()) ? "" : str;
    }
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid">
        <a class="navbar-brand" href="Home"><i class="fas fa-blog"></i> Blog Sphere</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                
                
                <li class="nav-item">
                    <a class="nav-link" href="AddPost" title="AddPost">
                        Add Post <i class="fas fa-plus-circle"></i>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Login" title="Login">
                        Login <i class="fas fa-sign-int-alt"></i>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="Logout" title="Logout">
                        Logout <i class="fas fa-sign-out-alt"></i>
                    </a>
                </li>
            </ul>
                
            <div class="justify-content-end mb-0"><input type="text" id="txtSearch" class="form-control form-control-sm" placeholder="Search"></div>
        </div>
    </div>
</nav>

<!-- Bootstrap JS and necessary JS for dropdown -->
<!-- Option 1: Bootstrap Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
