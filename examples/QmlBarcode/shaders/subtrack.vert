uniform highp mat4 qt_Matrix;
attribute highp vec4 qt_Vertex;
attribute highp vec2 qt_MultiTexCoord0;
varying highp vec2 vTexCoord;

void main() {
    vTexCoord = qt_MultiTexCoord0;
    gl_Position = qt_Matrix * qt_Vertex;
}
