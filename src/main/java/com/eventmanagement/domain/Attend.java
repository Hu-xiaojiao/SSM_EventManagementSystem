package com.eventmanagement.domain;


public class Attend {

  private long attendId;
  private long eventId;
  private String eventName;

  private long userId;
  private String name;

  private String attendStatus;

  public String getEventName() {
    return eventName;
  }

  public void setEventName(String eventName) {
    this.eventName = eventName;
  }


  public String getName() {
    return name;
  }

  public void setName(String name) {
    this.name = name;
  }

  private java.sql.Timestamp createdAt;
  private java.sql.Timestamp updatedAt;




  public long getEventId() {
    return eventId;
  }

  public void setEventId(long eventId) {
    this.eventId = eventId;
  }


  public long getUserId() {
    return userId;
  }

  public void setUserId(long userId) {
    this.userId = userId;
  }


  public long getAttendId() {
    return attendId;
  }

  public void setAttendId(long attendId) {
    this.attendId = attendId;
  }


  public String getAttendStatus() {
    return attendStatus;
  }

  public void setAttendStatus(String attendStatus) {
    this.attendStatus = attendStatus;
  }


  public java.sql.Timestamp getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(java.sql.Timestamp createdAt) {
    this.createdAt = createdAt;
  }


  public java.sql.Timestamp getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(java.sql.Timestamp updatedAt) {
    this.updatedAt = updatedAt;
  }

  @Override
  public String toString() {
    return "Attend{" +
            "attendId=" + attendId +
            ", eventId=" + eventId +
            ", eventName='" + eventName + '\'' +
            ", userId=" + userId +
            ", name='" + name + '\'' +
            ", attendStatus='" + attendStatus + '\'' +
            ", createdAt=" + createdAt +
            ", updatedAt=" + updatedAt +
            '}';
  }
}
