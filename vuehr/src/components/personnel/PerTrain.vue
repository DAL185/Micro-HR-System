<template>
  <div>
    <el-container>
      <el-header style="display: flex;justify-content: space-between;align-items: center;padding-left: 0px">
        <el-button @click="dialogVisible = true" icon="el-icon-plus" type="primary" size="mini">Add Training</el-button>
        <el-button size="mini" type="success" @click="loadTrainList" icon="el-icon-refresh"></el-button>
      </el-header>
      <el-main style="padding-left: 0px;padding-top: 0px;">
        <div>
          <el-table
            :data="trains"
            stripe
            v-loading="tableLoading"
            size="mini"
            @selection-change="handleSelectionChange"
            style="width: 100%">
            <el-table-column type="selection" width="30"></el-table-column>
            <el-table-column width="90" prop="eid" label="Job Number" align="center"></el-table-column>
            <!--<el-table-column width="90" prop="workID" label="Job Number" align="center"></el-table-column>-->
            <el-table-column width="120" label="Date of Training" align="center">
              <template slot-scope="scope">{{scope.row.trainDate | formatDate}}</template>
            </el-table-column>
            <el-table-column width="400" prop="trainContent" label="Training content" align="center"></el-table-column>
            <el-table-column width="400" prop="remark" label="Remark" align="center"></el-table-column>
            <el-table-column label="Operating" align="center">
              <el-table-column label="Edit" align="center">
                <template slot-scope="scope">
                  <el-button
                    size="mini"
                    @click="handleEdit(scope.$index, scope.row)">Edit
                  </el-button>
                </template>
              </el-table-column>
              <el-table-column label="Delete" align="center">
                <template slot-scope="scope">
                  <el-button
                    size="mini"
                    type="danger"
                    @click="handleDelete(scope.$index, scope.row)">Delete
                  </el-button>
                </template>
              </el-table-column>
            </el-table-column>
          </el-table>
        </div>
        <div style="text-align: left;margin-top: 10px" v-if="trains!=0">
          <el-button type="danger" round size="mini" :disabled="multipleSelection.length==0" @click="deleteAll">Batch Delete
          </el-button>
        </div>
      </el-main>
    </el-container>
    <div style="text-align: left">
      <el-dialog
        title="Add Training information"
        :visible.sync="dialogVisible"
        width="50%"
        @close="emptyTrain"
        :close-on-click-modal="false">
        <div style="display: flex;justify-content: flex-start;">
          <el-steps :active="index" direction="vertical">
            <el-step title="Employee's Job Number" size="mini"></el-step>
            <!--<el-step title="Employee's Job Number"></el-step>-->
            <el-step title="Date of Training"></el-step>
            <el-step title="Training Content"></el-step>
            <el-step title="Remark"></el-step>
          </el-steps>
          <div style="margin-left: 30px;display: flex;justify-content: center;align-items: center;width: 80%;">
            <div v-show="index==0">
              Employee's Job Number:
              <el-input
                placeholder="Please input Employee's Job Number..."
                size="mini"
                style="width: 200px"
                @keyup.enter.native="next"
                v-model="empTrain.eid">
              </el-input>
            </div>
            <!--<div v-show="index==1">
              Employee's Job Number
              <el-input
                placeholder="Please input Employee's Job Number..."
                @keyup.enter.native="next"
                size="mini"
                style="width: 200px"
                v-model="empTrain.workID">
              </el-input>
            </div>-->
            <div v-show="index==1">
              Date of Training:
              <el-date-picker
                v-model="empTrain.trainDate"
                type="date"
                size="mini"
                value-format="yyyy-MM-dd HH:mm:ss"
                style="width: 200px;"
                placeholder="Select Date">
              </el-date-picker>
            </div>
            <div v-show="index==2">
              Training Content:
              <el-input
                type="textarea"
                size="mini"
                style="width: 200px;"
                :autosize="{ minRows: 5, maxRows: 10}"
                placeholder="Please input Training Content..."
                v-model="empTrain.trainContent">
              </el-input>
            </div>
            <div v-show="index==3">
              Remark:
              <el-input
                type="textarea"
                size="mini"
                style="width: 200px;"
                :autosize="{ minRows: 5, maxRows: 10}"
                placeholder="Please input remark..."
                v-model="empTrain.remark">
              </el-input>
            </div>
          </div>
        </div>
        <div style="display: flex;align-items: center;justify-content: center;padding: 0px;margin: 0px;">
          <el-button round size="mini" v-if="index!=0" @click="index--">Previous Step</el-button>
          <el-button type="primary" round size="mini" @click="next" v-text="index==3?'Finish':'Next Step'"></el-button>
        </div>
      </el-dialog>
    </div>
  </div>
</template>
<script>
  export default {
    data(){
      return {
        dialogVisible:false,
        trains:[],
        index:0,
        tableLoading:false,
        multipleSelection:[],
        empTrain:{
          id:'',
          eid:'',
          trainDate:'',
          trainContent:'',
          remark:''
        }
      };
    },
    methods:{
      handleSelectionChange(val) {
        this.multipleSelection = val;
      },
      loadTrainList(){
        this.tableLoading = true;
        var _this = this;
        this.getRequest("/personnel/train/trains").then(resp=> {
          _this.tableLoading = false;
          if (resp && resp.status == 200) {
            _this.trains = resp.data;
          }
        })
      },
      handleEdit(index, row) {
        this.dialogVisible = true;
        row.trainDate = new Date(row.trainDate);
        this.empTrain = row;
      },
      handleDelete(index, row) {
        this.$confirm('Delete[' + row.eid + ']rows, continue', 'reminder', {
          confirmButtonText: 'Confirm',
          cancelButtonText: 'Cancel',
          type: 'warning'
        }).then(() => {
          this.doDelete(row.id);
        }).catch(() => {
          this.$message({
            type: 'info',
            message: 'Delete canceled'
          });
        });
      },
      doDelete(id){
        var _this = this;
        _this.tableLoading = true;
        this.deleteRequest("/personnel/train/trains/" + id).then(resp=>{
          _this.tableLoading = false;
          if (resp && resp.status == 200) {
            var data = resp.data;

            _this.loadTrainList();
          }
        });
      },
      deleteAll(){
        this.$confirm('Delete[' + this.multipleSelection.length + ']rows, continue?', 'reminder', {
          confirmButtonText: 'Confirm',
          cancelButtonText: 'Cancel',
          type: 'warning'
        }).then(() => {
          var ids = '';
          this.multipleSelection.forEach(row=> {
            ids = ids + row.id + ",";
          })
          this.doDelete(ids);
        }).catch(() => {
          this.$message({
            type: 'info',
            message: 'Delete Canceled'
          });
        });
      },
      emptyTrain(){
        this.empTrain={
          id:'',
          eid:'',
          trainDate:'',
          trainContent:'',
          remark:''
        };
        this.index = 0;
      },
      next(){
        var _this = this;
        if (this.index == 3) {
          if(this.empTrain.eid&&this.empTrain.trainDate&&this.empTrain.trainContent&&this.empTrain.remark){
            if (this.empTrain.id) {//更新
              _this.tableLoading = true;
              this.putRequest("/personnel/train/trains", this.empTrain).then(resp=> {
                _this.tableLoading = false;
                if (resp && resp.status == 200) {
                  var data = resp.data;
                  _
                  _this.dialogVisible = false;
                  _this.index = 0;
                  _this.loadTrainList();
                }
              });
            } else {//添加
                this.postRequest("/personnel/train/trains", this.empTrain).then(resp=> {
                  if (resp && resp.status == 200) {
                    var data = resp.data;

                    _this.dialogVisible = false;
                    _this.index = 0;
                    _this.loadTrainList();
                  }
                });
            }
          }else{
            this.$message({type: 'error', message: 'Please input something!'});
          }
        } else {
          this.index++;
        }
      },
      mounted: function () {
        this.loadSalaryCfg();
      }
    }
  }
</script>
