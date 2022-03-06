package Entity;

import java.io.Serializable;
import java.util.Date;

public class ChooseCourse implements Serializable {
    private String chooseCourseId;

    private String userId;

    private String courseId;

    private Integer status;

    private String reason;

    private String gradeId;

    private Date insertTime;

    //非数据库字段
    /**
     * 课程名
     */
    private String courseName;
    /**
     * 课程号
     */
    private String courseNum;
    /**
     * 学分
     */
    private Integer courseCredit;
    /**
     * 任课老师名字
     */
    private String teacherName;
    /**
     * 教师联系电话
     */
    private String teacherPhone;

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCourseNum() {
        return courseNum;
    }

    public void setCourseNum(String courseNum) {
        this.courseNum = courseNum;
    }

    public Integer getCourseCredit() {
        return courseCredit;
    }

    public void setCourseCredit(Integer courseCredit) {
        this.courseCredit = courseCredit;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName;
    }

    public String getTeacherPhone() {
        return teacherPhone;
    }

    public void setTeacherPhone(String teacherPhone) {
        this.teacherPhone = teacherPhone;
    }

    private static final long serialVersionUID = 1L;

    public String getChooseCourseId() {
        return chooseCourseId;
    }

    public void setChooseCourseId(String chooseCourseId) {
        this.chooseCourseId = chooseCourseId == null ? null : chooseCourseId.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId == null ? null : courseId.trim();
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason == null ? null : reason.trim();
    }

    public String getGradeId() {
        return gradeId;
    }

    public void setGradeId(String gradeId) {
        this.gradeId = gradeId == null ? null : gradeId.trim();
    }

    public Date getInsertTime() {
        return insertTime;
    }

    public void setInsertTime(Date insertTime) {
        this.insertTime = insertTime;
    }
}