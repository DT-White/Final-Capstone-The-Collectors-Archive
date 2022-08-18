import axios from "axios";

export default {
    createBook(book) {
        return axios.post("http://localhost:8080/books", book)
    },

    getBooks() {
        return axios.get("http://localhost:8080/books")
    },

    getGenres(){
        return axios.get("http://localhost:8080/genres")
    },

    getReadingList(){
        return axios.get("http://localhost:8080/reading-list")
    },

    addBookToReadingList(book){
        return axios.post("http://localhost:8080/reading-list", book)
    },

    removeBookFromReadingList(id){
        return axios.delete(`http://localhost:8080/reading-list/${id}`,);
    },

    getFriendBookList(id){
        return axios.get(`http://localhost:8080/friends/${id}`)
    }

}
