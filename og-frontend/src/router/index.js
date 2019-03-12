import Vue from 'vue'
import Router from 'vue-router'
import Welcome from '@/components/Welcome'
import Entities from '@/components/Entities'
import Entity from '@/components/Entity'
import NewEntity from '@/components/NewEntity'
import Login from '@/components/Login'
import Logout from '@/components/Logout'

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: __dirname,
  routes: [
    { path: '/', name: 'Welcome', component: Welcome },
    { path: '/login', name: 'Login', component: Login },
    { path: '/logout', name: 'Logout', component: Logout },
    { path: '/entities', name: 'Entities', component: Entities },
    { path: '/entities/:id', name: 'Entity', component: Entity },
    { path: '/entity/new', name: 'New Entity Form', component: NewEntity }
  ]
})
