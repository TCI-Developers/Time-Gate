// 
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/providers/home_provider.dart';
import 'package:time_gate/utils/responsive_utils.dart';
import 'dart:math' show pi; 
import 'check_button.dart'; 
import 'pause_menu_form.dart'; 

class PauseSection extends StatefulWidget {
  const PauseSection({super.key});

  @override
  State<PauseSection> createState() => _PauseSectionState();
}

class _PauseSectionState extends State<PauseSection> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;


  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    
  
    if (mounted) {
      setState(() {});
    }
  }

  void _toggleMenu() {
    if (_overlayEntry == null) {

      _overlayEntry = _createOverlay();
      Overlay.of(context).insert(_overlayEntry!);
    } else {

      _closeMenu();
    }

    if (mounted) {
      setState(() {}); 
    }
  }

  Widget _buildAnimatedCheckButton({required bool menuIsVisible, required double fontSizedGrow}) {
    

    const IconData baseIcon = Icons.chevron_right_outlined;

    final double rotationAngle = menuIsVisible ? pi / 2 : 0;
    
    final Widget animatedIcon = AnimatedRotation(
      duration: const Duration(milliseconds: 300), 
      curve: Curves.easeInOut,

      turns: rotationAngle / (2 * pi),
      child:  Icon(baseIcon, color: Colors.white, size: 40*fontSizedGrow),
    );

    return CheckButton(
      iconStart: Icons.pause_circle_outline,
      text: 'Pausa',
      iconEnd: animatedIcon,
    );
  }

  OverlayEntry _createOverlay() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    
    if (renderBox == null || renderBox.size.isEmpty) {
      return OverlayEntry(builder: (context) => const SizedBox.shrink());
    }

    final double buttonWidth = renderBox.size.width;
    final double buttonHeight = renderBox.size.height;

    const bool menuIsVisibleForOverlay = true; 
    final fontSizedGrow = getResponsiveScaleFactor(context);
    
    return OverlayEntry(
      builder: (overlayContext) {
        
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeMenu,
                behavior: HitTestBehavior.translucent,
              ),
            ),

            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.bottomLeft, 
              followerAnchor: Alignment.topLeft, 

              offset: const Offset(0, -20), 
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: buttonWidth,
                  child: PauseMenuForm(
                    onOptionSelected: (option) async {
                
                      final provider = context.read<HomeProvider>();
                      final ok = await provider.pause(activity: option);
                      if (!mounted) return;
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) => AlertDialog(
                          title: Text(ok ? 'Éxito' : 'Error'),
                          content: Text(
                            ok 
                              ? (provider.successMessage ?? 'Operación realizada correctamente') 
                              : (provider.errorMessage ?? 'Ocurrió un error inesperado perro'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                                if (ok) {
                                  provider.loadHome();
                                } else {
                                  
                                }
                              },
                              child: const Text('Aceptar'),
                            ),
                          ],
                          
                        ),
                      );
                      
                      _closeMenu();
                    },
                    onSave: (save)async{
                      final provider = context.read<HomeProvider>();
                      final ok = await provider.pause(activity: save);
                      if (!mounted) return;
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) => AlertDialog(
                          title: Text(ok ? 'Éxito' : 'Error'),
                          content: Text(
                            ok 
                              ? (provider.successMessage ?? 'Operación realizada correctamente') 
                              : (provider.errorMessage ?? 'Ocurrió un error inesperado perro'),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(dialogContext);
                                if (ok) {
                                  provider.loadHome();
                                } else {
                                  
                                }
                              },
                              child: const Text('Aceptar'),
                            ),
                          ],
                          
                        ),
                      );
                       _closeMenu();
                    },
                  ),
                ),
              ),
            ),
            
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              targetAnchor: Alignment.topLeft, 
              followerAnchor: Alignment.topLeft,
              offset: Offset.zero,
              child: Material(
                type: MaterialType.transparency,
                child: SizedBox(
                  width: buttonWidth,
                  height: buttonHeight, 
                  child: GestureDetector(
                    onTap: _toggleMenu, 
                    child: _buildAnimatedCheckButton(menuIsVisible: menuIsVisibleForOverlay, fontSizedGrow:fontSizedGrow),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final bool menuIsVisible = _overlayEntry != null;
    final fontSizedGrow = getResponsiveScaleFactor(context);

    return CompositedTransformTarget(
      link: _layerLink,
      child: Opacity(
        opacity: menuIsVisible ? 0.0 : 1.0, 
        child: IgnorePointer(
          // Ignorar clics cuando el Overlay está visible (se manejan en el Overlay)
          ignoring: menuIsVisible, 
          child: GestureDetector(
            onTap: _toggleMenu,
            child: _buildAnimatedCheckButton(menuIsVisible: menuIsVisible, fontSizedGrow : fontSizedGrow),
          ),
        ),
      ),
    );
  }
}