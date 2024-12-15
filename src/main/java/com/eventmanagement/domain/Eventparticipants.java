package com.sample;


public class Eventparticipants {

  private long participantId;
  private long eventId;
  private long userId;
  private String participationStatus;
  private java.sql.Timestamp createdAt;
  private java.sql.Timestamp updatedAt;


  public long getParticipantId() {
    return participantId;
  }

  public void setParticipantId(long participantId) {
    this.participantId = participantId;
  }


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


  public String getParticipationStatus() {
    return participationStatus;
  }

  public void setParticipationStatus(String participationStatus) {
    this.participationStatus = participationStatus;
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

}
