import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdp/constants/app_colors.dart';
import 'package:mdp/constants/app_constants.dart';
import 'package:mdp/constants/routes.dart';
import 'package:mdp/constants/styles/app_styles.dart';

import '../../../interventions_bloc.dart';

class RecapDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RecapDialogState();
}

class _RecapDialogState extends State<RecapDialog> {
  final bloc = Modular.get<InterventionsBloc>();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
      color: AppColors.white,
      height: MediaQuery.of(context).size.height * 0.88,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        primary: true,
        child: Container(
          color: AppColors.white,
          child: Container(
            width: double.infinity,
            child: _buildContent(),
          ),
        ),
      ),
    ));
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildHeader(),
        _buildBloc(),
        _buildPhotos(),
        _buildFourchetteTarifiaire()
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(color: AppColors.closeDialogColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Récapitulatif", style: AppStyles.subTitleWhite),
          IconButton(
            onPressed: () {
              Modular.to.pop();
            },
            icon: FaIcon(FontAwesomeIcons.chevronDown,
                color: AppColors.white, size: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildBloc() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.default_padding,
          vertical: AppConstants.default_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.clip,
            text: TextSpan(
              children: [
                TextSpan(text: "Partenaire : ", style: AppStyles.textNormal),
                TextSpan(
                    text: bloc.interventionDetail.interventionDetail
                        .subcontractors.first.company.name,
                    style: AppStyles.textNormalBold),
              ],
            ),
          ),
          SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.left,
            maxLines: 10,
            overflow: TextOverflow.clip,
            text: TextSpan(
              children: [
                TextSpan(
                    text: "N° de référence : ", style: AppStyles.textNormal),
                TextSpan(
                    text: bloc.interventionDetail.interventionDetail.code,
                    style: AppStyles.textNormalBold),
              ],
            ),
          ),
          SizedBox(height: 30),
          for (var i in bloc.interventionDetail.interventionDetail.details)
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: _orderCase(i.ordercase.code, i.ordercase.name)),
        ],
      ),
    );
  }

  Widget _orderCase(String code, String name) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.md_dark_blue),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            color: AppColors.md_dark_blue,
          ),
          child: Text(code + " - " + name,
              style: AppStyles.smallTitleWhite,
              textAlign: TextAlign.start,
              maxLines: 5,
              overflow: TextOverflow.ellipsis),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.md_dark_blue),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            color: AppColors.white,
          ),
          child: Text(
              ((bloc.interventionDetail.interventionDetail.indication ==
                          null) ||
                      (bloc.interventionDetail.interventionDetail.indication ==
                          ""))
                  ? "Aucun commentaire."
                  : bloc.interventionDetail.interventionDetail.indication,
              style: AppStyles.textNormal,
              textAlign: TextAlign.start,
              maxLines: 5,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }

  Widget _buildPhotos() {
    return Padding(
      padding: EdgeInsets.all(AppConstants.default_padding),
      child: Container(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Photos du client",
              style: AppStyles.header2, overflow: TextOverflow.ellipsis),
          SizedBox(height: 10),
          bloc.interventionDetail.interventionDetail.clientPhotos.length == 0
              ? Padding(
                  padding: EdgeInsets.all(AppConstants.default_padding * 2),
                  child: Center(
                    child: Text(
                      "Aucune photo",
                      style: AppStyles.bodyMdTextLight,
                    ),
                  ),
                )
              : Container(
                  height: 250,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: bloc.interventionDetail.interventionDetail
                          .clientPhotos.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => {
                            Modular.to.pushNamed(Routes.photoView, arguments: {
                              'image': bloc.interventionDetail
                                  .interventionDetail.clientPhotos[index],
                              'path': ""
                            })
                          },
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 4,
                            child: Container(
                              width: 180,
                              child: Hero(
                                tag: AppConstants.IMAGE_VIEWER_TAG,
                                child: Image.network(
                                    bloc.interventionDetail.interventionDetail
                                        .clientPhotos[index],
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        );
                      }),
                )
        ]),
      ),
    );
  }

  Widget _buildFourchetteTarifiaire() {
    return Padding(
      padding: EdgeInsets.all(AppConstants.default_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Fourchette tarifaire :",
            style: AppStyles.header2,
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            width: double.infinity,
            height: 50,
            child: ListTile(
              minLeadingWidth: 15,
              leading: Container(
                height: double.infinity,
                width: 30,
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.euroSign,
                    color: AppColors.default_black,
                    size: 16,
                  ),
                ),
              ),
              title: Text(
                  "Min : " +
                      bloc.interventionDetail.interventionDetail.totalMinPrice
                          .toString() +
                      " € - Max : " +
                      bloc.interventionDetail.interventionDetail.totalMaxPrice
                          .toString() +
                      " €",
                  style: AppStyles.body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
              subtitle: Text(
                  "Montant pré-bloqué " +
                      bloc.interventionDetail.interventionDetail.amountToBlock
                          .toString() +
                      " €",
                  style: AppStyles.smallGray,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
