<template>
  <div>
    <div style="text-align: left">
      <el-input
        placeholder="Please input department name..."
        style="width: 500px;margin: 0px;padding: 0px;"
        size="mini"
        prefix-icon="el-icon-search"
        v-model="keywords">
      </el-input>
    </div>
    <div>
      <el-tree
        :props="defaultProps"
        :data="treeData"
        ref="tree"
        :filter-node-method="filterNode"
        v-loading="treeLoading"
        style="width: 500px;margin-top: 10px"
        :render-content="renderContent">
      </el-tree>
      <div style="text-align: left">
        <el-dialog
          title="Add Department"
          :visible.sync="dialogVisible"
          width="25%">
          <div>
            <span>Higher Department</span>
            <el-select v-model="pDep" style="width: 200px" placeholder="Please select" size="mini">
              <el-option
                v-for="item in allDeps"
                :key="item.id"
                :label="item.name"
                :value="item.id">
              </el-option>
            </el-select>
          </div>
          <div style="margin-top: 10px">
            <span>Department Name</span>
            <el-input size="mini" style="width: 200px;" v-model="depName" placeholder="Please input department name..." @keyup.enter.native="addDep"></el-input>
          </div>
          <span slot="footer" class="dialog-footer">
    <el-button size="small" @click="dialogVisible = false">Cancel</el-button>
    <el-button size="small" type="primary" @click="addDep">Add</el-button>
  </span>
        </el-dialog>
      </div>
    </div>
  </div>
</template>
<script>
  export default {
    data() {
      return {
        keywords: '',
        depName: '',
        treeLoading: false,
        dialogVisible: false,
        allDeps: [],
        pDep: '',
        treeData: [],
        defaultProps: {
          label: 'name',
          isLeaf: 'leaf',
          children: 'children'
        }
      }
    },
    mounted: function () {
      this.treeLoading = true;
      this.loadTreeData();
    },
    watch: {
      keywords(val) {
        this.$refs.tree.filter(val);
      }
    },
    methods: {
      filterNode(value, data) {
        if (!value) return true;
        return data.name.indexOf(value) !== -1;
      },
      loadTreeData(){
        var _this = this;
        this.getRequest("/system/basic/dep/-1").then(resp=> {
          _this.treeLoading = false;
          if (resp && resp.status == 200) {
            _this.treeData = resp.data;
          }
        })
      },
      setDataToTree(treeData,pId,respData){
        for(var i=0;i<treeData.length;i++) {
          var td = treeData[i];
          if(td.id==pId) {
            treeData[i].children=treeData[i].children.concat(respData);
            return;
          }else{
            this.setDataToTree(td.children, pId, respData);
          }
        }
      },
      addDep(){
        var _this = this;
        this.dialogVisible = false;
        this.treeLoading = true;
        this.postRequest("/system/basic/dep", {
          name: this.depName,
          parentId: this.pDep
        }).then(resp=> {
          _this.treeLoading = false;
          if (resp && resp.status == 200) {
            var respData = resp.data;
            _this.depName = '';
            _this.setDataToTree(_this.treeData,_this.pDep,respData.msg)
          }
        })
      },
      loadAllDeps(){
        var _this = this;
        this.getRequest("/system/basic/deps").then(resp=> {
          if (resp && resp.status == 200) {
            _this.allDeps = resp.data;
          }
        });
      },
      showAddDepView(data, event){
        this.loadAllDeps();
        this.dialogVisible = true;
        this.pDep = data.id;
        event.stopPropagation()
      },
      deleteDep(data, event){
        var _this = this;
        if (data.children.length>0) {
          this.$message({
            message: 'this department cannot be deleted because of under departments!',
            type: 'warning'
          });
        } else {
          this.$confirm('Delete[' + data.name + ']department, continue?', 'reminder', {
            confirmButtonText: 'Confirm',
            cancelButtonText: 'Cancel',
            type: 'warning'
          }).then(() => {
            _this.treeLoading = true;
            _this.deleteRequest("/system/basic/dep/" + data.id).then(resp=> {
              _this.treeLoading = false;
              if (resp && resp.status == 200) {
                var respData = resp.data;

                _this.deleteLocalDep(_this.treeData, data);
              }
            });
          }).catch(() => {
            _this.$message({
              type: 'info',
              message: 'Delete Canceled'
            });
          });
        }
        event.stopPropagation()
      },
      deleteLocalDep(treeData,data){
        for(var i=0;i<treeData.length;i++) {
          var td = treeData[i];
          if(td.id==data.id) {
            treeData.splice(i, 1);
            return;
          }else{
            this.deleteLocalDep(td.children, data);
          }
        }
      },
      renderContent(h, {node, data, store}) {
        return (
          <span style="flex: 1; display: flex; align-items: center; justify-content: space-between; font-size: 14px; padding-right: 8px;">
          <span>
          <span>{node.label}</span>
        </span>
        <span>
        <el-button style="font-size: 12px;" type="primary" size="mini" style="padding:3px" on-click={ () => this.showAddDepView(data,event) }>Add Department</el-button>
        <el-button style="font-size: 12px;" type="danger" size="mini" style="padding:3px" on-click={ () => this.deleteDep(data,event) }>Delete Department</el-button>
        </span>
        </span>);
      }
    }
  };
</script>
