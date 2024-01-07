const selectRating = document.createElement('select');
        selectRating.name = "ratingSelect";
        selectRating.innerHTML = `
            <option value="">Give rating!</option>
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5</option>
        `;

        let posts = [];

        function createPost() {
            const title = document.getElementById('title').value;
            const content = document.getElementById('content').value;
            const author = document.getElementById('username').value || 'Anonymous';

            if (title && content) {
                const post = {
                    title,
                    content,
                    author,
                    date: new Date().toLocaleString(),
                    comments: [],
                    rating: 0
                };

                posts.push(post);
                displayPosts();
                clearForm();
            } else {
                alert('Please enter both title and content.');
            }
            document.getElementById('username').value = "";
        }

        function deletePost(index) {
            posts.splice(index, 1);
            displayPosts();
        }

        function displayPosts() {
            const blogPostsContainer = document.getElementById('blog-posts');
            blogPostsContainer.innerHTML = '';

            posts.forEach((post, index) => {
                const postElement = document.createElement('div');
                postElement.classList.add('post');

                postElement.innerHTML = `
                    <h2>${post.title}</h2>
                    <p><strong>Author:</strong> ${post.author}</p>
                    <p><strong>Date:</strong> ${post.date}</p>
                    <p>${post.content}</p>
                    <p><strong>Rating:</strong> ${post.rating}</p>
                    <button onclick="deletePost(${index})">Delete Post</button>
                    <button onclick="updateRating(${index})">Update Rating</button>
                    ${selectRating.outerHTML}
                    <input type="text" id="comment-${index}" placeholder="Add a comment">
                    <button onclick="addComment(${index})">Add Comment</button>
                `;

                // Display comments
                post.comments.forEach(comment => {
                    const commentElement = document.createElement('div');
                    commentElement.classList.add('comment');
                    commentElement.innerText = `Comment: ${comment.text}`;
                    postElement.appendChild(commentElement);
                });

                // Add comment form
                blogPostsContainer.appendChild(postElement);
            });
        }

        function addComment(index) {
            const commentText = document.getElementById(`comment-${index}`).value;
            // const commentAuthor = document.getElementById('username').value || 'Anonymous';

            if (commentText) {
                const comment = {
                    // author: commentAuthor,   
                    text: commentText,
                };

                posts[index].comments.push(comment);
                displayPosts();
            } else {
                alert('Please enter a comment.');
            }
        }

        function clearForm() {
            document.getElementById('title').value = '';
            document.getElementById('content').value = '';
        }

        function updateRating(index) {
            const selectedInput = document.getElementsByName('ratingSelect');                                                                    // returns an array of elements with the name "ratingSelect" which is stored in selectedInput 
            const selectedRating = selectedInput[index].value;
            posts[index].rating = selectedRating;
            displayPosts();
        }