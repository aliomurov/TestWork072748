<template>
    <div>
        <div class="container-fluid">
            <MenuComponent></MenuComponent>
            <br>
            <div class="container">
                <div class="content">
                    <div class="row justify-content-between">
                        <div class="col-sm-4 text-left">
                            <h2 class="h2">Регистрация</h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <v-form v-model="valid">
                    <div class="row justify-content-center">
                        <div class="col-sm-6">
                            <v-col cols="12" sm="12">
                                <v-text-field v-model="company.name" required :rules="nameRules" color="error" label="ФИО"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="emailRules" required color="error" v-model="company.email" label="Email"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="passwordRules" required color="error" type="password" v-model="company.password" label="Пароль"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="[passwordMatch]"  required color="error" type="password" v-model="company.rpassword" label="Повторите Пароль"></v-text-field>
                            </v-col>
                            <br>
                            <v-btn color="blue darken-1" :disabled="!valid" @click="save">Добавить</v-btn>
                        </div>
                        <div class="col-sm-6">
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="nameRules" required color="error" v-model="company.name_company" label="Название компании"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-select
                                    :rules="nameRules"
                                    required color="error"
                                    :items="cities"
                                    v-model="company.city_company"
                                    label="Область (город)"
                                ></v-select>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="nameRules" required color="error" v-model="company.address_company" label="Адрес компании (улица, №)"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="nameRules" required color="error" v-model="company.phone_company" label="Телефон компании"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-select
                                    :rules="nameRules"
                                    required color="error"
                                    :items="types"
                                    v-model="company.type_company"
                                    label="Тип компании"
                                ></v-select>
                            </v-col>
                        </div>
                    </div>
                </v-form>
            </div>
        </div>
        <v-snackbar
            v-model="snackbar"
            :top="y === 'top'"
        >
            {{ text }}
            <v-btn
                color="pink"
                text
                @click="snackbar = false"
            >
                Закрыть
            </v-btn>
        </v-snackbar>

    </div>
</template>

<script>
    import MenuComponent from "../include/MenuComponent";

    export default {
        components:{
            'MenuComponent': MenuComponent,
        },
        data(){
            return {
                cities: ['Бишкек', 'Чуй', 'Нарын', 'Жалал-Абад', 'Ыссык-Кол', 'Талас', 'Баткен', 'Ош'],
                types: ['Ресторан', 'Кафе', 'Пансионат', 'Отель', 'Частный сектор', 'Хостел'],
                valid: true,
                snackbar: false,
                text: '',
                y: 'top',
                company: {},
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
                return this.company.password != this.company.rpassword
                    ? "Пароль Не Совпадает"
                    : true;
            }
        },

        methods: {
            save() {
                axios.post(`/api/register/store`, this.company)
                    .then(res => {
                        console.dir(res.data);
                        localStorage.setItem('token', res.data.token);
                        localStorage.setItem('loggedIn', true);
                        this.$router.push({name: 'page'});
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
