<template>
  <div>
    <h1>Employee Reward and Punishment </h1>
    <el-dialog :visible.sync="dialogVisible" :title="dialogTitle"
               style="padding: 0px;"
               :close-on-click-modal="false"
               width="33%"></el-dialog>
    <div style="text-align: center; margin-top: 50px; margin-left: 40%">
      <el-form :model="ec" :rules="ecrules" ref="addReasonForm">
        <div>
          <el-row>
            <el-col :span="5">
              <div>
                <el-form-item label="Job Number:" prop="eid">
                  <el-input prefix-icon="el-icon-edit" v-model="ec.eid" size="mini" style="width: 300px"
                            placeholder="Please input employee's job number"></el-input>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="5">
              <div>
                <el-form-item label="Date:" prop="ecDate">
                  <el-date-picker
                    v-model="ec.ecDate"
                    size="mini"
                    value-format="yyyy-MM-dd HH:mm:ss"
                    style="width: 300px"
                    type="date"
                    placeholder="Date of Reward and Punishment">
                  </el-date-picker>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="5">
              <div>
                <el-form-item label="Reason:" prop="ecReason">
                  <el-radio-group v-model="ec.ecReason">
                    <el-radio label="Being Late">Being Late</el-radio>
                    <el-radio style="margin-left: 15px" label="Asking Leave">Asking Leave</el-radio>
                    <el-radio style="margin-left: 15px" label="Working Overtime">Working Overtime</el-radio>
                  </el-radio-group>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="5">
              <div>
                <el-form-item label="Type:" prop="ecType">
                  <el-radio-group v-model="ec.ecType">
                    <el-radio label="0">Reward</el-radio>
                    <el-radio style="margin-left: 15px" label="1">Punishment</el-radio>
                  </el-radio-group>
                </el-form-item>
              </div>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="5">
              <div>
                <el-form-item label="Remark:" prop="remark">
                  <el-input
                    type="textarea"
                    size="mini"
                    style="width: 300px;"
                    :autosize="{ minRows: 5, maxRows: 10}"
                    placeholder="Please input remark message..."
                    v-model="ec.remark"></el-input>
                </el-form-item>
              </div>
              <div style="margin-left: 240px">
                <el-button size="mini" @click="addEc('addReasonForm')" >Confirm</el-button>
              </div>
            </el-col>
          </el-row>
        </div>
      </el-form>
    </div>
  </div>
</template>
<script>
  export default {
    data() {
      return{
        dialogTitle: 'Success',
        dialogVisible: false,
        ec:{
          eid:'',
          ecDate:'',
          ecReason:'',
          ecType:'',
          remark:''
        },
        ecrules:{
          name: [{required: true, message: 'Required:Employee Name', trigger: 'blur'}],
          workID: [{required: true, message: 'Required:Employee Job Number', trigger: 'blur'}],
          ecDate: [{required: true, message: 'Required:Date of Reward and Punishment', trigger: 'blur'}],
          ecReason: [{required: true, message: 'Required:Reason of Reward and Punishment', trigger: 'blur'}],
          ecType: [{required: true, message: 'Required:Type of Reward and Punishment', trigger: 'blur'}]
        }
      };
    },
    methods:{
      addEc(formName){
        var _this = this;
        this.$refs[formName].validate((valid) => {
          if (valid) {
              //添加
              this.postRequest("/personnel/ec/addec", this.ec).then(resp=> {
                if (resp && resp.status == 200) {
                  var data = resp.data;

                  _this.dialogVisible = false;
                  _this.emptyEcData();
                }
              })
          } else {
            return false;
          }
        });
      },
      emptyEcData(){
        this.ec={
          eid:'',
          ecDate:'',
          ecReason:'',
          ecType:'',
          remark:''
        }
      }
    }
  };
</script>
