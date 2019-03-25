import JwtDecode from 'jwt-decode'

export default class User {
  static from (token) {
    try {
      let obj = JwtDecode(token)
      return new User(obj)
    } catch (_) {
      return null
    }
  }

  /* eslint-disable camelcase */
  constructor ({user_id, name, email}) {
    this.id = user_id
    this.name = name
    this.email = email
  }
}
