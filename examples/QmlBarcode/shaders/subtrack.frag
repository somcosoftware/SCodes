uniform highp vec4 uColor;
uniform highp float uOpacity;
uniform highp vec4 uCaptureRect;
uniform highp vec2 uSize;
varying highp vec2 vTexCoord;

void main() {
    // Convert normalized coordinates to pixel coordinates
    highp vec2 pixelCoord = vTexCoord * uSize;

    // Check if current pixel is inside captureRect
    highp bool inRect = (pixelCoord.x >= uCaptureRect.x &&
                         pixelCoord.x <= uCaptureRect.x + uCaptureRect.z &&
                         pixelCoord.y >= uCaptureRect.y &&
                         pixelCoord.y <= uCaptureRect.y + uCaptureRect.w);

    if (inRect) {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
    } else {
        gl_FragColor = vec4(uColor.rgb, uOpacity);
    }
}
