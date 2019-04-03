import Vue from 'vue'
import Router from 'vue-router'

import Welcome from '@/components/Welcome'
import Entities from '@/components/Entities'
import Entity from '@/components/Entity'

import EntitiesIndex from '@/components/entities/Index'
import New from '@/components/entities/New'
import Show from '@/components/entities/Show'
import Edit from '@/components/entities/Edit'

import Login from '@/components/Login'
import Logout from '@/components/Logout'
import NotFound from '@/components/404'

Vue.use(Router)

export default new Router({
  mode: 'history',
  base: __dirname,
  routes: [
    { path: '/', component: Welcome },
    { path: '/login', component: Login },
    { path: '/logout', component: Logout },
    { path: '/entities',
      component: Entities,
      children: [
        {
          path: '',
          component: EntitiesIndex
        },
        {
          path: 'new',
          component: New
        }
      ]
    },
    { path: '/entities/:id',
      component: Entity,
      children: [
        {
          path: '',
          component: Show
        },
        {
          path: 'edit',
          component: Edit
        }
      ]
    },
    { path: '*', component: NotFound }
  ]
})
