<template>
  <div style="margin-top: 10px">
    <el-tabs v-model="defaultTab" type="card">
      <el-tab-pane label="Department Management" name="depMana">
        <dep-mana></dep-mana>
      </el-tab-pane>
      <el-tab-pane label="Position Management" name="positionMana">
        <pos-mana state="position"></pos-mana>
      </el-tab-pane>
      <el-tab-pane label="Title Management" name="jobTitleMana">
        <pos-mana state="jobtitle"></pos-mana>
      </el-tab-pane>
      <el-tab-pane label="Permission Group" name="menuRole">
        <menu-role></menu-role>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>
<script>
  import MenuRole from './basic/MenuRole.vue'
  import DepMana from './basic/DepMana.vue'
  import JobTitleMana from './basic/JobTitleMana.vue'
  import PosMana from './basic/PosMana.vue'
  export default {
    data() {
      return {
        defaultTab: 'depMana'
      };
    },
    methods: {},
    components: {
      'menu-role': MenuRole,
      'dep-mana': DepMana,
      'jobtitle-mana': JobTitleMana,
      'pos-mana': PosMana
    }
  };
</script>
