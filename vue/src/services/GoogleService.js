import axios from 'axios';

const newAxiosInstance = axios.create();
newAxiosInstance.defaults.headers.common['Authorization'] = "";

export default{
    
getBook(isbn){
return newAxiosInstance.get("https://www.googleapis.com/books/v1/volumes?q=isbn:" + isbn)
}
}