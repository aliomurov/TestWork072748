import Vue from 'vue';
import VueRouter from 'vue-router';

import PageComponent from "./components/pages/PageComponent";
import ThanksComponent from "./components/pages/ThanksComponent";
import ProductComponent from "./components/pages/ProductComponent";
import CartComponent from "./components/pages/CartComponent";
import CatalogComponent from "./components/pages/CatalogComponent";
import AuthorizationComponent from "./components/pages/AuthorizationComponent";
import ChechComponent from "./components/pages/ChechComponent";
import RegistrationComponent from "./components/pages/RegistrationComponent";

import UsersIndexComponent from "./components/users/UsersIndexComponent";
import UsersEditComponent from "./components/users/UsersEditComponent";
import UsersOrderComponent from "./components/users/UsersOrderComponent";

import LoginComponent from "./components/admin/LoginComponent";
import AdminComponent from "./components/admin/AdminComponent";

import ProductsEditComponent from "./components/admin/products/ProductsEditComponent";
import ProductsIndexComponent from "./components/admin/products/ProductsIndexComponent";
import ProductsCreateComponent from "./components/admin/products/ProductsCreateComponent";

import CategoriesIndexComponent from "./components/admin/categories/CategoriesIndexComponent";
import CategoriesCreateComponent from "./components/admin/categories/CategoriesCreateComponent";
import CategoriesEditComponent from "./components/admin/categories/CategoriesEditComponent";

import AdministratorsIndexComponent from "./components/admin/administrators/AdministratorsIndexComponent";
import AdministratorsCreateComponent from "./components/admin/administrators/AdministratorsCreateComponent";
import AdministratorsEditComponent from "./components/admin/administrators/AdministratorsEditComponent";

import OrdersIndexComponent from "./components/admin/orders/OrdersIndexComponent";
import OrdersEditComponent from "./components/admin/orders/OrdersEditComponent";

Vue.use(VueRouter);

const routes = [
    {
        path: '/',
        component: PageComponent,
        name: 'page',
    },

    {
        path: '/login',
        component: AuthorizationComponent,
        name: 'page.login',
    },

    {
        path: '/register',
        component: RegistrationComponent,
        name: 'page.register',
    },

    {
        path: '/checkout',
        component: ChechComponent,
        name: 'page.checkout',
        beforeEnter: (to, from, next) => {
            axios.get('api/verify')
                .then(res => next())
                .catch(err => next('/login') )
        },
    },

    {
        path: '/catalog',
        component: CatalogComponent,
        name: 'page.catalog',
    },

    {
        path: '/catalog/:id',
        component: ProductComponent,
        name: 'page.product',
    },

    {
        path: '/profile',
        component: UsersIndexComponent,
        name: 'page.profile',
        beforeEnter: (to, from, next) => {
            axios.get('api/verify')
                .then(res => next())
                .catch(err => next('/login') )
        },
    },

    {
        path: '/profile/:id',
        component: UsersEditComponent,
        name: 'profile.edit',
    },

    {
        path: '/profile/order/:id',
        component: UsersOrderComponent,
        name: 'page.orders',
    },

    {
        path: '/thanks',
        component: ThanksComponent,
        name: 'page.thanks'
    },

    {
        path: '/cart',
        component: CartComponent,
        name: 'cart'
    },

    {
        path: '/admin/login',
        component: LoginComponent,
        name: 'login'
    },

    {
        path: '/admin',
        component: AdminComponent,
        name: 'admin',
        children: [
            {
                path: 'categories',
                component: CategoriesIndexComponent,
                name: 'categories.index',
            },
            {
                path: 'categories/create',
                component: CategoriesCreateComponent,
                name: 'categories.create',
            },
            {
                path: 'categories/edit/:id',
                component: CategoriesEditComponent,
                name: 'categories.edit',
            },

            {
                path: 'products',
                component: ProductsIndexComponent,
                name: 'products.index'
            },
            {
                path: 'products/create',
                component: ProductsCreateComponent,
                name: 'products.create',
            },

            {
                path: 'products/edit/:id',
                component: ProductsEditComponent,
                name: 'products.edit',
            },

            {
                path: 'administrators',
                component: AdministratorsIndexComponent,
                name: 'administrators.index',
            },
            {
                path: 'administrators/create',
                component: AdministratorsCreateComponent,
                name: 'administrators.create',
            },
            {
                path: 'administrators/edit/:id',
                component: AdministratorsEditComponent,
                name: 'administrators.edit',
            },

            {
                path: 'orders',
                component: OrdersIndexComponent,
                name: 'orders.index',
            },
            {
                path: 'orders/edit/:id',
                component: OrdersEditComponent,
                name: 'orders.edit',
            }
        ],
        beforeEnter: (to, from, next) => {
            axios.get('api/admin/verify')
                .then(res => next())
                .catch(err => next('/admin/login') )

        },
    }
];

const router = new VueRouter({
    routes,
    mode: 'history'
});

router.beforeEach((to, from, next) => {
    const token = localStorage.getItem('token') || null;
    window.axios.defaults.headers['Authorization'] = 'Bearer ' + token;
    next();
});

export default router
