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
    }

}
