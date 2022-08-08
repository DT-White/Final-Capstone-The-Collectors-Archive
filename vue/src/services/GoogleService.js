import axios from 'axios';

export default{
    
getBook(isbn){
return axios.get("https://www.googleapis.com/books/v1/volumes?q=isbn:" + isbn)
}
}