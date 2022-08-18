import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

/*
 * The authorization header is set for axios when you login but what happens when you come back or
 * the page is refreshed. When that happens you need to check for the token in local storage and if it
 * exists you should set the header so that it will be attached to each request
 */
const currentToken = localStorage.getItem('token')
const currentUser = JSON.parse(localStorage.getItem('user'));

if (currentToken != null) {
  axios.defaults.headers.common['Authorization'] = `Bearer ${currentToken}`;
}

export default new Vuex.Store({
  state: {
    filtered: [],
    genres: [],
    books: [],
    readingList: [],
    storeFilter: {
      title: "",
      author: "",
      keyword: "",
      startDate: "",
      endDate: "",
      genres: [],
      isbn: ""
    },
    token: currentToken || '',
    user: currentUser || {},
    profile: {}
  },
  mutations: {

    SET_PROFILE(state, profile){
      state.profile = profile;
    },

    GET_READING_LIST(state, readingList){
      state.readingList = readingList;
    },

    GET_FILTERED_LIST(state, filterBooks) {
      state.filtered = filterBooks;
    },

    GET_GENRE_LIST(state, genres) {
      state.genres = genres;
    },

    GET_BOOK_LIST(state, books) {
      state.books = books;
    },

    ADD_BOOK(state, book) {
      state.books.unshift(book);
    },
    
    SET_STORE_FILTER(state, filter) {
      state.storeFilter = filter
    },

    SET_AUTH_TOKEN(state, token) {
      state.token = token;
      localStorage.setItem('token', token);
      axios.defaults.headers.common['Authorization'] = `Bearer ${token}`
    },
    SET_USER(state, user) {
      state.user = user;
      localStorage.setItem('user', JSON.stringify(user));
    },
    LOGOUT(state) {
      localStorage.removeItem('token');
      localStorage.removeItem('user');
      state.token = '';
      state.user = {};
      axios.defaults.headers.common = {};
    }
  }
})
