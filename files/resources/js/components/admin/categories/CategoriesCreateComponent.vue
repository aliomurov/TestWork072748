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
                            <v-text-field
                                v-model="category.name"
                                label="Имя категории (портфолио)"
                                :rules="nameRules"
                                required
                            ></v-text-field>
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
                text: '',
                snackbar: false,
                y: 'top',
                category: {},
                valid: true,
                nameRules: [v => !!v || 'Это поле обьязательно для заполнения'],
            }
        },

        methods: {
            save() {
                axios.post(`/api/admin/categories`, this.category)
                    .then(res => {
                        this.$router.push({name: 'categories.index'})
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
