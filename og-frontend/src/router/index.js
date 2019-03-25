import Vue from 'vue'
import Router from 'vue-router'

import Welcome from '@/components/Welcome'
import Entities from '@/components/Entities'
import Show from '@/components/entities/Show'
import Edit from '@/components/entities/Edit'
import New from '@/components/entities/New'
import Login from '@/components/Login'
import Logout from '@/components/Logout'
import NotFound from '@/components/404'

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: __dirname,
  routes: [
    { path: '/', name: 'Welcome', component: Welcome },
    { path: '/login', name: 'Login', component: Login },
    { path: '/logout', name: 'Logout', component: Logout },
    { path: '/entities', name: 'Entities', component: Entities },
    { path: '/entities/:id', name: 'ShowEntity', component: Show },
    { path: '/entities/:id/edit', name: 'EditEntity', component: Edit },
    { path: '/entity/new', name: 'NewEntity', component: New },
    { path: '*', component: NotFound }
  ]
})
