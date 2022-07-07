<template>
    <div>
        <div class="container-fluid">
            <MenuComponent></MenuComponent>
            <br>
            <div class="container">
                <div class="content">
                    <div class="row justify-content-between">
                        <div class="col-sm-6 text-left">
                            <h2 class="h2">Личный кабинет</h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container mob-none">
                <div class="row">
                    <div class="col-4">
                        <table class="table">
                            <thead class="thead-light">
                            <tr>
                                <th scope="col">Меню</th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">
                                    <a @click="goToDetail(user.id)">Изменить данные</a>
                                </th>
                                <th scope="row"></th>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <a @click="goToOrder(user.id)">История заказов</a>
                                </th>
                                <th scope="row"></th>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-8">
                        <table class="table">
                            <thead class="thead-light">
                            <tr>
                                <th scope="col">Ваши данные</th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">ФИО</th>
                                <td>{{user.name}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Email</th>
                                <td>{{user.email}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Комапния</th>
                                <td>{{user.name_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Тип компании</th>
                                <td>{{user.type_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Область (город)</th>
                                <td>{{user.city_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Адрес компании (улица, №)</th>
                                <td>{{user.address_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Телефон компании</th>
                                <td>{{user.phone_company}}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="container pk-none">
                <div class="row">
                    <div class="col-12">
                        <table class="table">
                            <thead class="thead-light">
                            <tr>
                                <th scope="col">Меню</th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">
                                    <a @click="goToDetail(user.id)">Изменить данные</a>
                                </th>
                                <th scope="row"></th>
                            </tr>
                            <tr>
                                <th scope="row">
                                    <a @click="goToOrder(user.id)">История заказов</a>
                                </th>
                                <th scope="row"></th>
                            </tr>
                            
                            </tbody>
                        </table>
                    </div>
                    <div class="col-12">
                        <table class="table">
                            <thead class="thead-light">
                            <tr>
                                <th scope="col">Ваши данные</th>
                                <th scope="col"></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <th scope="row">ФИО</th>
                                <td>{{user.name}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Email</th>
                                <td>{{user.email}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Комапния</th>
                                <td>{{user.name_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Тип компании</th>
                                <td>{{user.type_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Область (город)</th>
                                <td>{{user.city_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Адрес компании (улица, №)</th>
                                <td>{{user.address_company}}</td>
                            </tr>
                            <tr>
                                <th scope="row">Телефон компании</th>
                                <td>{{user.phone_company}}</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import MenuComponent from "../include/MenuComponent";
    export default {
        components:{
            'MenuComponent': MenuComponent
        },
        data() {
            return {
                user: {},
                snackbar: false,
                text: '',
                y: 'top',
            }
        },

        created () {
            this.initialize();
        },

        methods: {
            goToDetail(id) {
                this.$router.push({name:'profile.edit',params:{id:id}})
            },

            goToOrder(id) {
                this.$router.push({name:'page.orders',params:{id:id}})
            },

            

            initialize() {
                axios.get(`/api/profile`)
                    .then(res => {
                        this.user = res.data.user;
                    })
                    .catch(err => console.dir(err.response))
            },
        }
    }
</script>

<style scoped></style>
