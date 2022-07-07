<template>
    <div>
        <div class="container-fluid">
            <MenuComponent></MenuComponent>
            <br>
            <div class="container">
                <div class="content">
                    <div class="row justify-content-between">
                        <div class="col-sm-6 text-left">
                            <h2 class="h1">Спасибо за заявку!</h2>
                        </div>
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
    }
</script>

<style scoped></style>
