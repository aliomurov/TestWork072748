<template>
    <v-container>
        <v-row justify="center">
            <v-col cols="11">
                <div>
                    <div>
                        <br>
                        <v-toolbar-title>{{category.name}}</v-toolbar-title>
                        <br>
                        <v-form v-model="valid">
                            <v-text-field
                                v-model="category.name"
                                label="Имя категории (портфолио)"
                                :rules="nameRules"
                                required
                            ></v-text-field>
                            <v-spacer></v-spacer>
                            <br>
                            <v-btn color="blue darken-1" :disabled="!valid" text @click="update">Сохранить</v-btn>
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
                category: {},
                valid: true,
                nameRules: [v => !!v || 'Это поле обьязательно для заполнения'],
            }
        },

        created () {
            this.initialize()
        },

        methods: {
            initialize () {
                axios.get(`/api/admin/categories/edit/${this.$route.params.id}`)
                    .then(res => {
                        this.category = res.data.category;
                    })
                    .catch(err => console.dir(err.response))
            },

            update() {
                axios.post(`/api/admin/categories/update/${this.$route.params.id}`, this.category)
                    .then(res => {
                        this.$router.push({name: 'categories.index'});
                    })
                    .catch(err => console.dir(err.response))
            }
        }
    }
</script>

<style scoped></style>
