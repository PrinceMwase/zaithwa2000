import 'package:flutter/material.dart';
import 'package:flutter_parcel_app/src/widgets.dart';

class MyParcelDeliveryMethod extends StatefulWidget {
  const MyParcelDeliveryMethod(
      {Key? key,
      required this.parcelDeliveryMethod,
      required this.parcelDeliveryDuration,
      required this.parcelDeliveryImage})
      : super(key: key);

  final String parcelDeliveryMethod,
      parcelDeliveryDuration,
      parcelDeliveryImage;

  @override
  _MyParcelDeliveryMethodState createState() => _MyParcelDeliveryMethodState();
}

enum WhatsappStatus { online, offline }

enum IsFragile { yes, no }

enum IsElectronic { yes, no }

class _MyParcelDeliveryMethodState extends State<MyParcelDeliveryMethod> {
  final _formKey =
      GlobalKey<FormState>(debugLabel: '_MyParcelDeliveryMethodState');

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _locationController = TextEditingController();
  final _districtController = TextEditingController();

  WhatsappStatus? _whatsappStatus = WhatsappStatus.offline;
  IsFragile? _isFragile = IsFragile.no;
  IsElectronic? _isElectronic = IsElectronic.no;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(
          bottom: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor,
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: ExpansionTile(
            tilePadding: const EdgeInsets.all(0),
            trailing: const SizedBox.shrink(),
            title: Container(
              padding: const EdgeInsets.all(
                16,
              ),
              height: 102,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.parcelDeliveryImage),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 34,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.parcelDeliveryMethod,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        widget.parcelDeliveryMethod,
                        style: Theme.of(context).textTheme.headline5,
                      )
                    ],
                  )
                ],
              ),
            ),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 1,
                color: const Color(0xFFd5d5d5),
              ),
              _buildExpansionChildren(context),
            ],
          ),
        ));
  }

  Widget _buildExpansionChildren(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).copyWith(top: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Text(
            'Recipient Info',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Name',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          TextFormField(
            controller: _nameController,
            decoration:
                const InputDecoration(hintText: 'Enter details here...'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter details";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          // Phone Number
          Row(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Phone number',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          TextFormField(
            controller: _phoneController,
            decoration:
                const InputDecoration(hintText: 'Enter details here...'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter details";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),
          // whatsapp status
          Text(
            'Whatsapp Status',
            style: Theme.of(context).textTheme.headline6,
          ),
          ListTile(
            title: const Text('Online'),
            leading: Radio<WhatsappStatus>(
              value: WhatsappStatus.online,
              groupValue: _whatsappStatus,
              onChanged: (WhatsappStatus? value) {
                setState(() {
                  _whatsappStatus = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Offline'),
            leading: Radio<WhatsappStatus>(
              value: WhatsappStatus.offline,
              groupValue: _whatsappStatus,
              onChanged: (WhatsappStatus? value) {
                setState(() {
                  _whatsappStatus = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ), //end Whatsapp Status

          // Fragility
          Text(
            'Is it Fragile',
            style: Theme.of(context).textTheme.headline6,
          ),
          ListTile(
            title: const Text('Yes'),
            leading: Radio<IsFragile>(
              value: IsFragile.yes,
              groupValue: _isFragile,
              onChanged: (IsFragile? value) {
                setState(() {
                  _isFragile = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('No'),
            leading: Radio<IsFragile>(
              value: IsFragile.no,
              groupValue: _isFragile,
              onChanged: (IsFragile? value) {
                setState(() {
                  _isFragile = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ), //end fragility Status
          // electronic status
          Text(
            'Is it Electronic',
            style: Theme.of(context).textTheme.headline6,
          ),
          ListTile(
            title: const Text('Yes'),
            leading: Radio<IsElectronic>(
              value: IsElectronic.yes,
              groupValue: _isElectronic,
              onChanged: (IsElectronic? value) {
                setState(() {
                  _isElectronic = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('No'),
            leading: Radio<IsElectronic>(
              value: IsElectronic.no,
              groupValue: _isElectronic,
              onChanged: (IsElectronic? value) {
                setState(() {
                  _isElectronic = value;
                });
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ), //end electronic status

          // Location
          Row(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Location',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          TextFormField(
            controller: _locationController,
            decoration:
                const InputDecoration(hintText: 'Enter details here...'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter details";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),

          // District
          Row(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'District',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
          TextFormField(
            controller: _districtController,
            decoration:
                const InputDecoration(hintText: 'Enter details here...'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Enter details";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 16,
          ),

          // Send Button
          StyledButton(
              child: Row(children: const [
                Icon(Icons.send),
                SizedBox(width: 4),
                Text('SEND')
              ]),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print(_nameController.text);
                  _nameController.clear();
                  print(_phoneController.text);
                  _phoneController.clear();
                  print(_locationController.text);
                  _locationController.clear();
                  print(_districtController.text);
                  _districtController.clear();
                }
              })
        ],
      ),
    );
  }
}
