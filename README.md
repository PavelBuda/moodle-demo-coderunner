# Moodle demo with Coderunner
Sample local Moodle deployment with configuring Coderunner question types support and own Jobe server.

- **Jobe**: Rest API server which allow to execute different languages code.

# Configuration and initial deployment
1. Copy `.env.dist` to `.env`
2. Update configuration in `.env`

- `MOODLE_VERSION` - Moodle version to use (should be existing tag in [Moodle repository](https://github.com/moodle/moodle))
- `MOODLE_DOCKER_APP_VERSION` - Moodle version for docker image
- `MOODLE_DOCKER_WWWROOT` - Path to Moodle application (should be empty on initial deploy)
- `MOODLE_DOCKER_DB` - Database db driver ()
- `MOODLE_DOCKER_WEB_PORT` - Moodle website localhost port
- `MOODLE_DOCKER_DB_PORT`- Moodle database localhost port
- `JOBE_PORT` - Jobe website localhost port

3. Run `make docker.deploy.local`
4. Navigate to http://localhost:8888 and follow installation 

[*] Initial deployment may take time as Jobe image is 1gb size

# Coderunner plugin installation

### Install plugin from Moodle admin settins Plugins page
- [qbehaviour_adaptive_adapted_for_coderunner](https://github.com/trampgeek/moodle-qbehaviour_adaptive_adapted_for_coderunner)
- [qtype_coderunner](https://github.com/trampgeek/moodle-qtype_coderunner)

### Configuration
1. Navigate to `Site administration > Plugins > CodeRunner`:
2. Set configuration values:

- `Enable jobesandbox`: Should be checked
- `Jobe server`: `jobe:80` (* Value of JobInABox server which is the name of docker service)
- `Jobe API-key`: Should be empty for using local container

3. Navigate to `Site administration > HTTP security > cURL blocked host list` and 
check that ip of `jobe` container is not in list of blocked. 
Or else it would not be available from Moodle.

# Coderunner question creation guide
[Sample Python question configuration guide](https://github.com/trampgeek/moodle-qtype_coderunner/blob/master/authorguide.md)

# Samples:
1. Create/Open `Course`
2. Add `Quiz` block
3. Navigate to `Question bank`
4. In left action dropdown select `Import`
5. Select `Moodle XML` format and upload file from `./samples/quiz_questions/`

# Help links
- [Moodle docker compose](https://github.com/moodlehq/moodle-docker)
- [Moodle](https://github.com/moodle/moodle)
- [CodeRunner](https://github.com/trampgeek/moodle-qtype_coderunner)
- [Jobe](https://hub.docker.com/r/trampgeek/jobeinabox)
