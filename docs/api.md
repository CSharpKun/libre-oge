## libre-oge Document Class

### Arguments
- drm - enables drm background (Warning: compilation becomes a lot more slower)
- (other for exam class)

### Task Environment
Task environment is the main element of the entire class. It allows you to create tasks that look identical to the real exams.
#### Arguments
1. (required, string) Task number - sets up number of the task, e.g `\begin{task}{1}` or `\begin{task}{11.2}`.

### Answer Fields

#### \answerfield
The most simple command that makes field that allows to write something into it.

#### \answerbox
Makes box that allows to write number into it.

#### \answertable (LuaLaTeX only)
Makes simple table that allows to write something for items given.
##### Arguments
1. (optional, number, defaults to 3) Number of columns
2. (required, string) Items of the table's header, separated by ` & `
