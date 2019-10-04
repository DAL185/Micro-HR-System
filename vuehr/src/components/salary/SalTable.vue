<template>
  <div>
    <el-container>
      <el-header style="display: flex;justify-content: space-between;align-items: center;padding-left: 0px">
        <el-button size="mini" type="success" @click="loadSalaryCfg" icon="el-icon-refresh"></el-button>
      </el-header>
      <el-main style="padding-left: 0px;padding-top: 0px">
        <div>
          <el-table
            :data="salaries"
            stripe
            v-loading="tableLoading"
            size="mini"
            @selection-change="handleSelectionChange"
            style="width: 100%">
            <el-table-column
              type="selection"
              width="30">
            </el-table-column>
            <el-table-column
              min-width="15%"
              prop="name"
              align="center"
              label="Employee's Name">
            </el-table-column>
            <el-table-column
              width="200"
              min-width="15%"
              prop="workID"
              align="center"
              label="Job Number">
            </el-table-column>
            <el-table-column
              width="200"
              min-width="15%"
              align="center"
              prop="lateCount"
              label="Late Arrivals">
            </el-table-column>
            <el-table-column
              width="200"
              align="center"
              min-width="15%"
              prop="leaveCount"
              label="Number of Leave">
            </el-table-column>
            <el-table-column
              prop="overtime"
              width="200"
              min-width="15%"
              align="center"
              label="Overtime Numbers">
            </el-table-column>
          </el-table>
        </div>
      </el-main>
    </el-container>
    <div style="text-align: right;margin-top: 10px">
      <el-pagination
        background
        @current-change="currentChange"
        layout="prev, pager, next"
        :total="totalCount">
      </el-pagination>
    </div>
  </div>
</template>
<script>
  export default {
    data() {
      return {
        dialogVisible: false,
        tableLoading: false,
        index: 0,
        salaries: [],
        totalCount: -1,
        currentPage: 1,
        multipleSelection: [],
        salary: {
          id: '',
          name:'',
          workID:'',
          lateCount:'',
          leaveCount:'',
          overtime:''
        }
      };
    },
    methods: {
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
      handleSelectionChange(val) {
        this.multipleSelection = val;
      },
      handleEdit(index, row) {
        this.dialogVisible = true;
        row.createDate = new Date(row.createDate);
        delete row.allSalary;
        this.salary = row;
      },
      handleDelete(index, row) {
        this.$confirm('Delete[' + row.name + '], continue?', 'reminder', {
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
        this.deleteRequest("/salary/sob/salary/" + id).then(resp=>{
          _this.tableLoading = false;
          if (resp && resp.status == 200) {
            var data = resp.data;

            _this.loadSalaryCfg();
          }
        });
      },
      next(){
        var _this = this;
        if (this.index == 7) {
          if(this.salary.createDate&&this.salary.basicSalary&&this.salary.trafficSalary&&this.salary.lunchSalary&&this.salary.bonus&&this.salary.pensionBase&&this.salary.pensionPer&&this.salary.medicalBase&&this.salary.medicalPer&&this.salary.accumulationFundBase&&this.salary.accumulationFundPer){
            if (this.salary.id) {//更新
              _this.tableLoading = true;
              this.putRequest("/salary/sob/salary", this.salary).then(resp=> {
                _this.tableLoading = false;
                if (resp && resp.status == 200) {
                  var data = resp.data;
                  _
                  _this.dialogVisible = false;
                  _this.index = 0;
                  _this.loadSalaryCfg();
                }
              });
            } else {//添加
              this.$prompt('Please input set name', 'reminder', {
                confirmButtonText: 'Confirm',
                cancelButtonText: 'Cancel'
              }).then(({value}) => {
                this.salary.name = value;
                this.postRequest("/salary/sob/salary", this.salary).then(resp=> {
                  if (resp && resp.status == 200) {
                    var data = resp.data;

                    _this.dialogVisible = false;
                    _this.index = 0;
                    _this.loadSalaryCfg();
                  }
                });
              }).catch(() => {
              });
            }
          }else{
            this.$message({type: 'error', message: 'Please input something!'});
          }
        } else {
          this.index++;
        }
      },
      loadSalaryCfg(){
        this.tableLoading = true;
        var _this = this;
        this.getRequest("/salary/table/man?page=" + this.currentPage + "&size=10").then(resp=> {
          _this.tableLoading = false;
          if (resp && resp.status == 200) {
            var data=resp.data;
            _this.salaries = data.salaries;
            _this.totalCount = data.count;
          }
        })
      },
      currentChange(currentPage){
        this.currentPage = currentPage;
        this.loadSalaryCfg();
      },
      emptySalary(){
        this.salary = {
          id: '',
          name:'',
          workID:'',
          lateCount:'',
          leaveCount:'',
          overtime:''
        };
        this.index = 0;
      }
    },
    mounted: function () {
      this.loadSalaryCfg();
    }
  };
</script>
<style>
  .el-dialog__body {
    padding-bottom: 10px;
  }
</style>
