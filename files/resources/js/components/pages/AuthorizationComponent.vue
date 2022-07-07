<template>
    <div>
        <div class="container-fluid">
            <MenuComponent></MenuComponent>
            <br>
            <div class="container">
                <div class="content">
                    <div class="row justify-content-between">
                        <div class="col-sm-4 text-left">
                            <h2 class="h2">Вход</h2>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-sm-5">
                        <v-card class="elevation-12">
                            <v-toolbar
                                color="red"
                                dark
                                flat
                            >
                                <v-toolbar-title>Форма входа</v-toolbar-title>
                                <v-spacer />
                            </v-toolbar>
                            <v-progress-linear
                                :active="loading"
                                :indeterminate="loading"
                                absolute
                                color="primary accent-4"
                            ></v-progress-linear>
                            <v-card-text>
                                <v-form v-model="valid">
                                    <v-text-field
                                        color="red"
                                        label="Введите email"
                                        name="email"
                                        prepend-icon="mdi-account-circle-outline"
                                        type="email"
                                        v-model="email"
                                        :rules="emailRules"
                                        required
                                    />

                                    <v-text-field
                                        color="red"
                                        id="password"
                                        label="Введите пароль"
                                        name="password"
                                        prepend-icon="mdi-account-lock-outline"
                                        type="password"
                                        v-model="password"
                                        :rules="passwordRules"
                                        required
                                    />
                                </v-form>
                            </v-card-text>
                            <v-card-actions>
                                <v-spacer />
                                <v-btn :disabled="!valid" block @click="login" color="red">Войти</v-btn>
                            </v-card-actions>
                            <v-snackbar
                                v-model="snackbar"
                                :top="y === 'top'"
                            >
                                {{ text }}
                                <v-btn
                                    color="red"
                                    text
                                    @click="snackbar = false"
                                >
                                    Закрыть
                                </v-btn>
                            </v-snackbar>
                        </v-card>
                    </div>
                </div>
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
        props: {
            source: String,
        },
        data(){
            return {
                loading: false,
                valid: true,
                email: '',
                emailRules: [
                    v => !!v || 'Email обьязательно для заполнения',
                    v => /.+@.+\..+/.test(v) || 'Email должна быть действительной',
                ],
                password: '',
                passwordRules: [
                    v => !!v || 'Пароль обьязательно для заполнения',
                ],
                snackbar: false,
                text: '',
                y: 'top',
            }
        },

        methods: {
            login: function (){
                axios.interceptors.request.use((config) => {
                    this.loading = true;
                    return config;
                }, (error) => {
                    this.loading = false;
                    return Promise.reject(error);
                });

                axios.interceptors.response.use((response) => {
                    this.loading = false;
                    return response;
                }, (error) => {
                    this.loading = false;
                    return Promise.reject(error);
                });

                axios.post('/api/login', {'email':this.email, 'password':this.password})
                    .then(res => {
                        localStorage.setItem('token', res.data.token);
                        localStorage.setItem('loggedIn', true);
                        if(res.data.client){
                            this.$router.push('/checkout')
                                .then(res => {
                                    this.text = 'Успешно вошли';
                                    this.snackbar = true;
                                })
                                .catch(err => console.log(err))
                        } else {
                            this.text = 'Вы не клиент';
                            this.snackbar = true;
                        }
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
