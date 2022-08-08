import axios from "axios";

export default{
    createBook(book){
       return axios.post("http://localhost:8080/books",book)
    }

}
