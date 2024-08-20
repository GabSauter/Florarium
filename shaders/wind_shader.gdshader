shader_type canvas_item;
uniform float speed = 1.0;
uniform float dis = 20.0;

void vertex(){
	VERTEX.x += sin(TIME * speed) * dis * (UV.y - 1.0);
}