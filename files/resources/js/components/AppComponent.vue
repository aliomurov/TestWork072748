<template>
    <vue-page-transition name="moveInUp" mode="out-in">
        <router-view></router-view>
    </vue-page-transition>
</template>

<script>
    export default {
        mounted() {
            console.log('Component mounted.')
        }
    }
</script>
