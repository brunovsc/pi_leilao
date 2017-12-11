package domain;

public class Participant extends User {
    
    private String participantId;
    private String name;
    
    public Participant(String participantId, String name){
        this.participantId = participantId;
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public String getParticipantId() {
        return participantId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setParticipantId(String participantId) {
        this.participantId = participantId;
    }
}
