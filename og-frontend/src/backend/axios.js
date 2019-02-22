import axios from 'axios'

const BASEURL = 'http://localhost:8080'

export default axios.create({
  baseURL: BASEURL,
  headers: {
    'Content-Type': 'application/json'
  }
})
