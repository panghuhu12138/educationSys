package Entity;

import java.io.Serializable;

public class Grade implements Serializable {
    private String gradeId;

    private String chooseCourseId;

    private Byte dailyGrade;

    private Byte midtermGrade;

    private Byte endtermGrade;

    private Byte point;

    private static final long serialVersionUID = 1L;

    public String getGradeId() {
        return gradeId;
    }

    public void setGradeId(String gradeId) {
        this.gradeId = gradeId == null ? null : gradeId.trim();
    }

    public String getChooseCourseId() {
        return chooseCourseId;
    }

    public void setChooseCourseId(String chooseCourseId) {
        this.chooseCourseId = chooseCourseId == null ? null : chooseCourseId.trim();
    }

    public Byte getDailyGrade() {
        return dailyGrade;
    }

    public void setDailyGrade(Byte dailyGrade) {
        this.dailyGrade = dailyGrade;
    }

    public Byte getMidtermGrade() {
        return midtermGrade;
    }

    public void setMidtermGrade(Byte midtermGrade) {
        this.midtermGrade = midtermGrade;
    }

    public Byte getEndtermGrade() {
        return endtermGrade;
    }

    public void setEndtermGrade(Byte endtermGrade) {
        this.endtermGrade = endtermGrade;
    }

    public Byte getPoint() {
        return point;
    }

    public void setPoint(Byte point) {
        this.point = point;
    }
}