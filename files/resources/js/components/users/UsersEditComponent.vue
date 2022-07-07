<template>
    <div>
        <div class="container-fluid">
            <MenuComponent></MenuComponent>
            <br>
            <div class="container">
                <div class="content">
                    <div class="row justify-content-between">
                        <div class="col-sm-6 text-left">
                            <h2 class="h2">Изменение данных</h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container pk-none">
                <div class="row">
                    <div class="col">
                        <router-link :to="{name: 'page.profile'}">
                            <v-icon>mdi-step-backward-2</v-icon>
                            Назад в личный кабинет
                        </router-link>
                    </div>
                </div>
                <v-progress-linear
                    color="indigo"
                    rounded
                    value="100"
                ></v-progress-linear>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <v-form v-model="valid">
                            <v-col cols="12" sm="12">
                                <v-text-field v-model="user.name" required :rules="nameRules" color="error" label="ФИО"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="emailRules" required color="error" v-model="user.email" label="Email"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="nameRules" required color="error" v-model="user.name_company" label="Название компании"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-select
                                    :rules="nameRules"
                                    required color="error"
                                    :items="cities"
                                    v-model="user.city_company"
                                    label="Область (город)"
                                ></v-select>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="nameRules" required color="error" v-model="user.address_company" label="Адрес компании (улица, №)"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="nameRules" required color="error" v-model="user.phone_company" label="Телефон компании"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-select
                                    :rules="nameRules"
                                    required color="error"
                                    :items="types"
                                    v-model="user.type_company"
                                    label="Тип компании"
                                ></v-select>
                            </v-col>
                            <br>
                            <v-progress-linear
                                color="indigo"
                                rounded
                                value="100"
                            ></v-progress-linear>
                            <br>
                            <v-col cols="12" sm="12">
                                <v-text-field color="error" type="password" v-model="user.password" label="Пароль"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="[passwordMatch]"  required color="error" type="password" v-model="user.rpassword" label="Повторите Пароль"></v-text-field>
                            </v-col>
                            <v-spacer></v-spacer>
                            <v-spacer></v-spacer>
                            <v-col>
                                <v-btn color="blue darken-1" :disabled="!valid" @click="update">Сохранить</v-btn>
                            </v-col>
                        </v-form>
                    </div>
                </div>
                <br>
                <div class="row mob-none">
                    <router-link :to="{name: 'page.profile'}">
                        <a class="btn btn-primary">
                            Назад в личный кабинет
                        </a>
                    </router-link>
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
        data () {
            return {
                id: this.$route.params.id,
                types: ['Ресторан', 'Кафе', 'Пансионат', 'Отель', 'Частный сектор', 'Хостел'],
                cities: ['Бишкек', 'Чуй', 'Нарын', 'Жалал-Абад', 'Ыссык-Кол', 'Талас', 'Баткен', 'Ош'],
                valid: true,
                snackbar: false,
                text: '',
                y: 'top',
                user: {},
                nameRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                emailRules: [
                    v => !!v || 'Email обьязательно для заполнения',
                    v => /.+@.+\..+/.test(v) || 'Email должна быть действительной',
                ],
                passwordRules: [v => !!v || 'Это поле обьязательно для заполнения'],
            }
        },

        computed: {
            passwordMatch() {
                return this.user.password != this.user.rpassword
                    ? "Пароль Не Совпадает"
                    : true;
            }
        },

        created () {
            this.initialize()
        },

        methods: {
            initialize () {
                axios.get(`/api/profile/`)
                    .then(res => {
                        this.user = res.data.user;
                    })
                    .catch(err => console.dir(err.response))
            },

            update() {
                axios.post(`/api/profile/update/${this.$route.params.id}`, this.user)
                    .then(res => {
                        this.$router.push({name: 'page.profile'});
                    })
                    .catch(err =>{
                        this.text = err.response.data.status;
                        this.snackbar = true;
                    })
            }
        }
    }
</script>

<style scoped></style>
