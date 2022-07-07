<template>
    <v-container>
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

        <v-row justify="center">
            <v-col cols="11">
                <div>
                    <div>
                        <br>
                        <v-toolbar-title>Добавление</v-toolbar-title>
                        <br>
                        <v-form v-model="valid">
                            <v-col cols="12" sm="12">
                                <v-text-field v-model="administrator.name" required :rules="nameRules" color="error" label="ФИО"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="emailRules" required color="error" v-model="administrator.email" label="Email"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="passwordRules" required color="error" type="password" v-model="administrator.password" label="Пароль"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-text-field :rules="[passwordMatch]"  required color="error" type="password" v-model="administrator.rpassword" label="Повторите Пароль"></v-text-field>
                            </v-col>
                            <v-col cols="12" sm="12">
                                <v-select
                                    :rules="roleRules"
                                    required color="error"
                                    :items="roles"
                                    v-model="administrator.role"
                                    item-text="name"
                                    item-value="id"
                                    label="Статус"
                                ></v-select>
                            </v-col>
                            <v-spacer></v-spacer>
                            <v-btn color="blue darken-1" :disabled="!valid" text @click="save">Добавить</v-btn>
                        </v-form>
                    </div>
                </div>
            </v-col>
        </v-row>
    </v-container>
</template>

<script>
    export default {
        data () {
            return {
                valid: true,
                roles: [
                    {
                        name: 'Администратор',
                        id: 1,
                    },
                    {
                        name: 'Менеджер',
                        id: 2
                    }
                ],
                snackbar: false,
                text: '',
                y: 'top',
                administrator: {},
                nameRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                emailRules: [
                    v => !!v || 'Email обьязательно для заполнения',
                    v => /.+@.+\..+/.test(v) || 'Email должна быть действительной',
                ],
                passwordRules: [v => !!v || 'Это поле обьязательно для заполнения'],
                roleRules: [v => !!v || 'Это поле обьязательно для заполнения'],
            }
        },

        computed: {
            passwordMatch() {
                return this.administrator.password != this.administrator.rpassword
                    ? "Пароль Не Совпадает"
                    : true;
            }
        },

        methods: {
            save() {
                axios.post(`/api/admin/administrators`, this.administrator)
                    .then(res => {
                        console.dir(this.$router.push({name: 'administrators.index'}))
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
