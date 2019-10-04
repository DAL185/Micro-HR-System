<template>
  <div>
    <el-tabs v-model="activeName" @tab-click="handleClick" style="margin-top: 10px">
      <el-tab-pane label="System Notification" name="notification"><nf></nf></el-tab-pane>
      <el-tab-pane label="Friend Chat" name="chat"><fc></fc></el-tab-pane>
    </el-tabs>
  </div>
</template>
<script>
  import FriendChat from '@/components/chat/FriendChat'
  import Notification from '@/components/chat/Notification'
  export default {
    data() {
      return {
        activeName: 'notification'
      };
    },
    methods: {
      handleClick(tab, event) {
        console.log(tab, event);
      }
    },
    components:{
      'fc':FriendChat,
      'nf':Notification
    }
  };
</script>
