// public class UI_ListenerThread implements Runnable {

//     private boolean queueHashRefresh = false;

//     private final UI_Window ParentWindow;
//     private HashMap<String, Object> lastElementStates = new HashMap<String, Object>();

//     public UI_ListenerThread(UI_Window parentWindow) {
//         this.ParentWindow = parentWindow;

//         for(UI_Element element : ParentWindow.getWindowElements()) {
//             if(element instanceof UI_TickSlider) {
//                 UI_TickSlider tickSlider = (UI_TickSlider) element;
//                 lastElementStates.put(tickSlider.TickSlider_Name, element.getElementName());
//             } else if(element instanceof UI_Slider) {
//                 lastElementStates.put(element.getElementName(), element.getValue());
//             } else {
//                 lastElementStates.put(element.getElementName(), element.getState());
//             }
//         }
//     }


//     @Override
//     public void run() {
//         while(true) {
//             if(this.checkHashRefresh()) {
//                 continue;
//             }
//             if(ParentWindow.Window_Visibility) {
//                 for(UI_Element element : ParentWindow.getWindowElements()) {
//                     if(element instanceof UI_TickSlider) {
//                         UI_TickSlider tickSlider = (UI_TickSlider) element;
//                         if(!lastElementStates.get(tickSlider.TickSlider_Name).equals(element.getElementName())) {
//                             lastElementStates.put(tickSlider.TickSlider_Name, element.getElementName());
//                             ParentWindow.receiveElementUpdate(tickSlider.TickSlider_Name, element.getElementName());
//                         }
//                     } else if(element instanceof UI_Slider) {
//                         if(!lastElementStates.get(element.getElementName()).equals(element.getValue())) {
//                             lastElementStates.put(element.getElementName(), element.getValue());
//                             ParentWindow.receiveElementUpdate(element.getElementName(), element.getValue());
//                         }
//                     } else {
//                         if(!lastElementStates.get(element.getElementName()).equals(element.getState())) {
//                             lastElementStates.put(element.getElementName(), element.getState());
//                             ParentWindow.receiveElementUpdate(element.getElementName(), element.getState());
//                         }
//                     }
//                 }
//             }
//             try {
//                 Thread.sleep(10);
//             } catch (InterruptedException e) {
//                 e.printStackTrace();
//             }
//         }
//     }


//     private boolean checkHashRefresh() {
//         if(this.queueHashRefresh) {
//             refHashMp();
//             return true;
//         }
//         return false;
//     }
//     private void refHashMp() {
//         this.lastElementStates.clear();
//         for(UI_Element element : ParentWindow.getWindowElements()) {
//             if(element instanceof UI_TickSlider) {
//                 UI_TickSlider tickSlider = (UI_TickSlider) element;
//                 lastElementStates.put(tickSlider.TickSlider_Name, element.getElementName());
//             } else if(element instanceof UI_Slider) {
//                 lastElementStates.put(element.getElementName(), element.getValue());
//             } else {
//                 lastElementStates.put(element.getElementName(), element.getState());
//             }
//         }
//         this.queueHashRefresh = false;
//     }
//     public void refreshHashMap() {
//         this.queueHashRefresh = true;
//     }

// }
