<template>
    <v-app id="inspire">
        <v-navigation-drawer
            v-model="drawer"
            :clipped="$vuetify.breakpoint.lgAndUp"
            app
        >
            <v-list>
                <v-col>
                    <v-badge
                        bordered
                        bottom
                        color="deep-purple accent-4"
                        dot
                        offset-x="10"
                        offset-y="10"
                        class="mb-2 mr-2"
                    >
                        <v-avatar size="40">
                            <v-img src="https://cdn.vuetifyjs.com/images/lists/2.jpg"></v-img>
                        </v-avatar>
                    </v-badge>
                    <strong class="title mb-2 mr-2">{{ name }}</strong>
                </v-col>
            </v-list>

            <v-list dense>
                <template v-for="item in items">
                    <v-row
                        v-if="item.heading"
                        :key="item.heading"
                        align="center"
                    >
                        <v-col cols="6">
                            <v-subheader v-if="item.heading">
                                {{ item.heading }}
                            </v-subheader>
                        </v-col>
                        <v-col
                            cols="6"
                            class="text-center"
                        >
                            <a
                                href="#!"
                                class="body-2 black--text"
                            >EDIT</a>
                        </v-col>
                    </v-row>

                    <v-list-group
                        v-else-if="item.children"
                        :key="item.text"
                        v-model="item.model"
                        :prepend-icon="item.model ? item.icon : item['icon-alt']"
                        append-icon=""
                    >
                        <template v-slot:activator>
                            <v-list-item-content>
                                <v-list-item-title>
                                    {{ item.text }}
                                </v-list-item-title>
                            </v-list-item-content>
                        </template>
                        <v-list-item
                            v-for="(child, i) in item.children"
                            :key="i"
                            link
                        >
                            <v-list-item-action v-if="child.icon">
                                <v-icon>{{ child.icon }}</v-icon>
                            </v-list-item-action>
                            <v-list-item-content>
                                <v-list-item-title>
                                    {{ child.text }}
                                </v-list-item-title>
                            </v-list-item-content>
                        </v-list-item>
                    </v-list-group>
                    <v-list-item
                        v-else
                        :key="item.text"
                        link
                        :to="item.action"
                    >
                        <v-list-item-action>
                            <v-icon>{{ item.icon }}</v-icon>
                        </v-list-item-action>
                        <v-list-item-content>
                            <v-list-item-title>
                                {{ item.text }}
                            </v-list-item-title>
                        </v-list-item-content>
                    </v-list-item>
                </template>
            </v-list>
            <v-switch v-model="theme" class="ma-4" label="Изменить тему"></v-switch>
        </v-navigation-drawer>

        <v-app-bar
            :clipped-left="$vuetify.breakpoint.lgAndUp"
            app
            color="blue darken-3"
            dark
        >
            <v-app-bar-nav-icon @click.stop="drawer = !drawer" />
            <v-toolbar-title
                style="width: 300px"
                class="ml-0 pl-4"
            >
                <span class="hidden-sm-and-down">
                    Adminka
                </span>
            </v-toolbar-title>
            <v-text-field
                flat
                solo-inverted
                hide-details
                prepend-inner-icon="mdi-magnify"
                label="Поиск ..."
                class="hidden-sm-and-down"
            />
            <v-spacer />
            <v-btn icon>
                <v-icon>mdi-apps</v-icon>
            </v-btn>
            <v-btn icon>
                <v-icon>mdi-bell</v-icon>
            </v-btn>
            <div class="text-center">
                <v-card-actions>
                    <v-spacer />
                    <v-btn color="primary" @click="logout">Выйти</v-btn>
                </v-card-actions>
            </div>
        </v-app-bar>
        <v-content>
            <v-container
                class=""
                fluid
            >
                <v-row
                    align="center"
                    justify="center"
                >
                    <router-view></router-view>
                </v-row>
            </v-container>
        </v-content>
        <v-snackbar
            v-model="snackbar"
            :top="y === 'top'"
        >
            Вы успешно вошли в админ панель
            <v-btn
                color="pink"
                text
                @click="snackbar = false"
            >
                Закрыть
            </v-btn>
        </v-snackbar>
    </v-app>
</template>

<script>
    export default {
        props: {
            source: String,
        },
        data: () => ({
            name: '',
            theme: true,
            snackbar: false,
            y: 'top',
            dialog: false,
            drawer: null,
            items: [
                { icon: 'mdi-account-tie', text: 'Администраторы', action: '/admin/administrators'},
                { icon: 'mdi-medical-bag', text: 'Категории', action: '/admin/categories'},
                { icon: 'mdi-medical-bag', text: 'Продукты', action: '/admin/products'},
                { icon: 'mdi-message-plus', text: 'Заказы', action: '/admin/orders'},
            ],
        }),
        created() {
            this.$vuetify.theme.dark = true;
            axios.get(`/api/admin`)
                .then(res => {})
                .catch(err => {
                    if(err.response.status === 401)
                    localStorage.removeItem('token');
                    this.$router.push('/admin/login');
                })
        },
        mounted(){
            this.snackbar = localStorage.getItem('loggedIn') ? true : false;
            this.name = 'Админ';
            localStorage.removeItem('loggedIn')
        },
        watch:{
            theme: function(old, newval){
                this.$vuetify.theme.dark = old;
            }
        },
        methods:{
            logout: function(){
                localStorage.removeItem('token');
                localStorage.removeItem('loggedIn');
                this.$router.push('/admin/login')
                    .then(res => {
                        this.text = 'Успешно вышли';
                        this.snackbar = true;
                    })
                    .catch(err => console.log(err))
            }
        },
    }
</script>

<style scoped></style>
