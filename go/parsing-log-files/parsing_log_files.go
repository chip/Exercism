package parsinglogfiles

import (
	"regexp"
)

func IsValidLine(text string) bool {
	re := regexp.MustCompile(`^\[(TRC|DBG|INF|WRN|ERR|FTL)\]`)
	return re.Match([]byte(text))
}

func SplitLogLine(text string) []string {
	return regexp.MustCompile(`\<[~*=-]*\>`).Split(text, -1)
}

func CountQuotedPasswords(lines []string) int {
	re := regexp.MustCompile(`(?i)(".*password"?)`)
	sum := 0
	for _, line := range lines {
		if re.Match([]byte(line)) {
			sum++
		}
	}
	return sum
}

func RemoveEndOfLineText(text string) string {
	old := `end-of-line\d+`
	re := regexp.MustCompile(old)
	if re.Match([]byte(text)) {
		return re.ReplaceAllString(text, "")
	}
	return text
}

func TagWithUserName(lines []string) []string {
	re := regexp.MustCompile(`User\s+(\w+)`)
	for i, line := range lines {
		if matches := re.FindSubmatch([]byte(line)); matches != nil {
			lines[i] = "[USR] " + string(matches[1]) + " " + line
		}
	}
	return lines
}
