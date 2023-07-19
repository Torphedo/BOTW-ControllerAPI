#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>

typedef struct {
  char* string;
  void* sead_vtable;
}sead__SafeString;

void* sead_vtable_addr = (void*)0x10263910;

typedef struct {
  float x;
  float y;
}vec2f;

typedef struct {
  uint8_t unknown_1[0x28];
  uint16_t A;
  uint16_t B;
  uint16_t ZL;
  uint16_t X;
  uint16_t Y;
  uint16_t ZR;
  uint16_t RS_click;
  uint16_t LS_click;
  uint16_t unknown_input_1;
  uint16_t select;
  uint16_t start;
  uint16_t start_2;  // This is tracked twice for some reason?
  uint16_t select_2; // This is ALSO tracked twice for some reason?
  uint16_t L;
  uint16_t R;
  uint16_t touchscreen; // Triggers if you click anywhere on the gamepad (or anywhere on the screen in Cemu)
  uint16_t unknown_input_2;
  uint16_t dpad_down; // This is the only D-Pad input I could find here
  uint16_t unknown_input_3;
  uint16_t unknown_input_4;
  
  uint16_t LS_up; // Triggers if the stick is pointing within a few degrees of up. The same applies to all other stick directions.
  uint16_t LS_down;
  uint16_t LS_left;
  uint16_t LS_right;
  
  uint16_t RS_up;
  uint16_t RS_down;
  uint16_t RS_left;
  uint16_t RS_right;
  
  uint8_t unknown_2[0xAA]; // Not sure if this is padding or actual input data
  uint32_t time_since_last_input;
  uint8_t unknown_3[0xC];
  vec2f LS;
  uint8_t unknown_4[0x7]; // This padding amount seems wrong. Check later.
  vec2f RS;
}controller_state;

void* (*getControllerSafe)(uint32_t* controller_index) = (void*)0x02DE207C;
bool (*ksys__evt__callEvent)(void* actor, sead__SafeString* event_name, sead__SafeString* entry_point, bool pause_other_actors, bool skip_IsStartableAir_check) = (void*)0x02DDF744;

bool call_event(char* event_name, char* entry_point, bool pause_other_actors, bool skip_IsStartableAir_check) {
  // Create a sead::SafeString for the name and entry point
 	sead__SafeString name_sead = {
 	  .string = event_name,
 	  .sead_vtable = sead_vtable_addr
 	};
 	sead__SafeString entry_point_sead = {
 	  .string = entry_point,
 	  .sead_vtable = sead_vtable_addr
 	};
 	
 	return ksys__evt__callEvent(NULL, &name_sead, &entry_point_sead, pause_other_actors, skip_IsStartableAir_check);
}

int main() {
  static uint32_t controller_index = 1;
  controller_state* controller = getControllerSafe(&controller_index);
  if (controller->L && controller->R) {
    return call_event("FaroreFlow", "Trigger", false, false);
  }

  return 0;
}

