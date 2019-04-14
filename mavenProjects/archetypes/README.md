# Create your own archetype

Source:
https://maven.apache.org/guides/mini/guide-creating-archetypes.html

## I. Quickstart example: Create custom Scala / SparkArchetype

### 1. Create archetype from generic archetype "maven-archetype-archetype"
```
mvn archetype:generate
  -DgroupId=[your project's group id]
  -DartifactId=[your project's artifact id]
  -DarchetypeArtifactId=maven-archetype-archetype
```
...

### 2. Create the archetype descriptor
### 2.1 archetype.xml
...
### 2.2 archetype-metadata.xml
...
### 3 Create the prototype files and the prototype pom.xml
...
### 4. Install
...

## II. Create project based on custom archetype