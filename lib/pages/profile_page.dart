import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_gate/providers/profile_provider.dart';
import 'package:time_gate/providers/tabbar_provider.dart';
import 'package:time_gate/themes/custom_styles.dart';
import 'package:time_gate/utils/responsive_utils.dart';
import 'package:time_gate/widgets/logout_button.dart';
import 'package:time_gate/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tabbarProv = context.read<TabbarProvider>();
      final profileProv = context.read<ProfileProvider>();

      // 1. Solo carga si el índice es 3 (Perfil) y no hay datos previos
      if (tabbarProv.selectedMEnuOption == 3 && profileProv.profile == null) {
        profileProv.loadProfile();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabIndexPrincipal = context.watch<TabbarProvider>().selectedMEnuOption;
    
    final profileProv = context.read<ProfileProvider>();

    if (tabIndexPrincipal == 3 && profileProv.profile == null && !profileProv.isLoading) {
      Future.microtask(() => profileProv.loadProfile());
    }

    final titleOsw28Bold500Secondary =
        Theme.of(context).textTheme.titleOsw28Bold500Secondary;
    final titleOsw24Bold500Primary =
        Theme.of(context).textTheme.titleOsw24Bold500Primary;
    final titleJt20Bold500Grey =
        Theme.of(context).textTheme.titleJt20Bold500Grey;
    final fontSizedGrow = getResponsiveScaleFactor(context);
    final double maxContainerWidth = getMaxContentWidth(context);

    return Consumer<ProfileProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMessage != null) {
          return Center(child: Text(provider.errorMessage!));
        }

        final profile = provider.profile;
        if (profile == null) {
          return const Center(child: Text('Sin información de perfil'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 60),
          child: SafeArea(
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(20),
                width: maxContainerWidth,
                child: Column(
                  spacing: 10,
                  children: [
                    Text(
                      'Perfil',
                      style: titleOsw28Bold500Secondary
                          .copyWith(fontSize: 28 * fontSizedGrow),
                    ),
                    const SizedBox(height: 10),

                    /// FOTO
                    CirclePhoto(
                      maxRadius: 60,
                      image: profile.profilePhotoUrl,
                    ),

                    const SizedBox(height: 10),

                    /// NOMBRE
                    Text(
                      profile.name,
                      style: titleOsw28Bold500Secondary
                          .copyWith(fontSize: 28 * fontSizedGrow),
                    ),

                    /// PUESTO
                    Text(
                      profile.puesto,
                      style: titleJt20Bold500Grey
                          .copyWith(fontSize: 20 * fontSizedGrow),
                    ),

                    const SizedBox(height: 10),

                    /// INFO SUPERIOR
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoColumn(title: 'Area', description: profile.area),
                        InfoColumn(
                            title: 'ID de Empleado',
                            description: profile.idEmpleado),
                        InfoColumn(
                            title: 'Antigüedad',
                            description: profile.antiguedad),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Información General',
                        style: titleOsw24Bold500Primary,
                      ),
                    ),

                    PersonalInfo(
                      title: 'Nombre Completo',
                      info: profile.name,
                    ),
                    PersonalInfo(
                      title: 'Dirección',
                      info: profile.direccion,
                    ),
                    PersonalInfo(
                      title: 'Correo Electrónico',
                      info: profile.email,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: PersonalInfo(
                            title: 'Teléfono de Contacto',
                            info: profile.telefono,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: PersonalInfo(
                            title: 'Antigüedad',
                            info: profile.antiguedad,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: PersonalInfo(
                            title: 'Firma de Contrato',
                            info: profile.firmaContrato,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: PersonalInfo(
                            title: 'Rescisión de Contrato',
                            info:
                                profile.rescisionContrato ?? '-- / -- / ----',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Información Personal',
                        style: titleOsw24Bold500Primary,
                      ),
                    ),

                    const SizedBox(height: 10),

                    PersonalInfo(
                      title: 'Fecha de Nacimiento',
                      info: profile.fechaNacimiento,
                    ),
                    PersonalInfo(
                      title: 'NSS',
                      info: profile.nss,
                    ),

                    Row(
                      children: [
                        Expanded(
                          child: PersonalInfo(
                            title: 'CURP',
                            info: profile.curp,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: PersonalInfo(
                            title: 'RFC',
                            info: profile.rfc,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const LogoutButton(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PersonalInfo extends StatelessWidget {
  final String title;
  final String info;

  const PersonalInfo({
    super.key,
    required this.title,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    final subtitleOsw16Bold500Secondary =
        Theme.of(context).textTheme.subtitleOsw16Bold500Secondary;
    final textJt14bold400Grey =
        Theme.of(context).textTheme.textJt14bold400Grey;
    final fontSizedGrow = getResponsiveScaleFactor(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: subtitleOsw16Bold500Secondary
              .copyWith(fontSize: 16 * fontSizedGrow),
        ),
        const SizedBox(height: 5),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            info,
            style: textJt14bold400Grey
                .copyWith(fontSize: 14 * fontSizedGrow),
          ),
        ),
      ],
    );
  }
}

class InfoColumn extends StatelessWidget {
  final String title;
  final String description;

  const InfoColumn({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final subtitleOsw16Bold500Primary =
        Theme.of(context).textTheme.subtitleOsw16Bold500Primary;
    final titleJt18Bold500Secondary =
        Theme.of(context).textTheme.titleJt18Bold500Secondary;
    final fontSizedGrow = getResponsiveScaleFactor(context);

    return Column(
      children: [
        Text(
          title,
          style: subtitleOsw16Bold500Primary
              .copyWith(fontSize: 16 * fontSizedGrow),
        ),
        Text(
          description,
          style: titleJt18Bold500Secondary
              .copyWith(fontSize: 18 * fontSizedGrow),
        ),
      ],
    );
  }
}
