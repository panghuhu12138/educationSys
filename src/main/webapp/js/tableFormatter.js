//**********公用***********
//序号
function formatIndex (val,row,index) {
 var txt="";
 txt=index+1;
 return txt;
}

function formatType(val,row,index){
    var txt="";
    switch (val)
    {
        case "A":
            txt="城镇体系规划";
            break;
        case "B":
            txt="城镇总体规划";
            break;
        case "C":
            txt="专项规划";
            break;
        case "D":
            txt="详细规划";
            break;
        case "E":
            txt="村庄规划";
            break;
        case "F":
            txt="规划研究";
            break;
    }
    return txt;
}



//************编制单位******************/
//****企业资质******/
//证书等级
function qyzz_formatCertificateLevel(val,row,index){
    var txt="";
    switch (val)
    {
        case "1":
            txt="甲级";
            break;
        case "2":
            txt="丙级";
            break;
        case "3":
            txt="乙级";
            break;
    }
    return txt;
}
//证书类型
function qyzz_formatCertificateType(val,row,index){
    var txt="";
    switch (val)
    {
        case "1":
            txt="城乡规划编制资质证书";
            break;
        case "2":
            txt="土地利用规划推荐书";
            break;
    }
    return txt;
}

//****从业人员******/
//证件类型
function  cyry_formatIdType(val,row,index) {
    var txt="";
    switch (val)
    {
        case "1":
            txt="身份证";
            break;
        case "2":
            txt="其它";
            break;
    }
    return txt;
}
//人员类型
function  cyry_formatPersonType(val,row,index) {
    var txt = "";
    switch (val) {
        case "1":
            txt = "注册执业人员";
            break;
        case "2":
            txt = "技术人员";
            break;
        case "3":
            txt = "骨干技术人员";
            break;
    }
    return txt;
}
    //****规划业绩******/
//是否获奖
   function ghyj_formatIsAwarded(val,row,index) {
        var txt="";
        switch (val)
        {
            case "1":
                txt="是";
                break;
            case "2":
                txt="否";
                break;
        }
        return txt;
    }

