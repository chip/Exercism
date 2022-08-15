package electionday

import "fmt"

// NewVoteCounter returns a new vote counter with
// a given number of initial votes.
func NewVoteCounter(initialVotes int) *int {
	voteCount := initialVotes
	return &voteCount
}

// VoteCount extracts the number of votes from a counter.
func VoteCount(counter *int) int {
	if counter != nil {
		return *counter
	}
	return 0
}

// IncrementVoteCount increments the value in a vote counter.
func IncrementVoteCount(counter *int, increment int) {
	*counter += increment
}

// NewElectionResult creates a new election result.
func NewElectionResult(candidateName string, votes int) *ElectionResult {
	return &ElectionResult{Name: candidateName, Votes: votes}
}

// DisplayResult creates a message with the result to be displayed.
func DisplayResult(result *ElectionResult) string {
	er := *result
	return fmt.Sprintf("%s (%d)", er.Name, er.Votes)
}

// DecrementVotesOfCandidate decrements by one the vote count of a candidate in a map.
func DecrementVotesOfCandidate(results map[string]int, candidate string) {
	for name, votes := range results {
		if candidate == name {
			results[candidate] = votes - 1
		}
	}
}
