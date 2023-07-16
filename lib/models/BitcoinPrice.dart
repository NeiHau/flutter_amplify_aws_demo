/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;


/** This is an auto generated class representing the BitcoinPrice type in your schema. */
class BitcoinPrice extends amplify_core.Model {
  static const classType = const _BitcoinPriceModelType();
  final String id;
  final double? _priceUSD;
  final double? _priceJPY;
  final amplify_core.TemporalDateTime? _timestamp;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  BitcoinPriceModelIdentifier get modelIdentifier {
      return BitcoinPriceModelIdentifier(
        id: id
      );
  }
  
  double get priceUSD {
    try {
      return _priceUSD!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double get priceJPY {
    try {
      return _priceJPY!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime get timestamp {
    try {
      return _timestamp!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const BitcoinPrice._internal({required this.id, required priceUSD, required priceJPY, required timestamp, createdAt, updatedAt}): _priceUSD = priceUSD, _priceJPY = priceJPY, _timestamp = timestamp, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory BitcoinPrice({String? id, required double priceUSD, required double priceJPY, required amplify_core.TemporalDateTime timestamp}) {
    return BitcoinPrice._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      priceUSD: priceUSD,
      priceJPY: priceJPY,
      timestamp: timestamp);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BitcoinPrice &&
      id == other.id &&
      _priceUSD == other._priceUSD &&
      _priceJPY == other._priceJPY &&
      _timestamp == other._timestamp;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("BitcoinPrice {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("priceUSD=" + (_priceUSD != null ? _priceUSD!.toString() : "null") + ", ");
    buffer.write("priceJPY=" + (_priceJPY != null ? _priceJPY!.toString() : "null") + ", ");
    buffer.write("timestamp=" + (_timestamp != null ? _timestamp!.format() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  BitcoinPrice copyWith({double? priceUSD, double? priceJPY, amplify_core.TemporalDateTime? timestamp}) {
    return BitcoinPrice._internal(
      id: id,
      priceUSD: priceUSD ?? this.priceUSD,
      priceJPY: priceJPY ?? this.priceJPY,
      timestamp: timestamp ?? this.timestamp);
  }
  
  BitcoinPrice copyWithModelFieldValues({
    ModelFieldValue<double>? priceUSD,
    ModelFieldValue<double>? priceJPY,
    ModelFieldValue<amplify_core.TemporalDateTime>? timestamp
  }) {
    return BitcoinPrice._internal(
      id: id,
      priceUSD: priceUSD == null ? this.priceUSD : priceUSD.value,
      priceJPY: priceJPY == null ? this.priceJPY : priceJPY.value,
      timestamp: timestamp == null ? this.timestamp : timestamp.value
    );
  }
  
  BitcoinPrice.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _priceUSD = (json['priceUSD'] as num?)?.toDouble(),
      _priceJPY = (json['priceJPY'] as num?)?.toDouble(),
      _timestamp = json['timestamp'] != null ? amplify_core.TemporalDateTime.fromString(json['timestamp']) : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'priceUSD': _priceUSD, 'priceJPY': _priceJPY, 'timestamp': _timestamp?.format(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'priceUSD': _priceUSD,
    'priceJPY': _priceJPY,
    'timestamp': _timestamp,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt
  };

  static final amplify_core.QueryModelIdentifier<BitcoinPriceModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<BitcoinPriceModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final PRICEUSD = amplify_core.QueryField(fieldName: "priceUSD");
  static final PRICEJPY = amplify_core.QueryField(fieldName: "priceJPY");
  static final TIMESTAMP = amplify_core.QueryField(fieldName: "timestamp");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "BitcoinPrice";
    modelSchemaDefinition.pluralName = "BitcoinPrices";
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: BitcoinPrice.PRICEUSD,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: BitcoinPrice.PRICEJPY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: BitcoinPrice.TIMESTAMP,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _BitcoinPriceModelType extends amplify_core.ModelType<BitcoinPrice> {
  const _BitcoinPriceModelType();
  
  @override
  BitcoinPrice fromJson(Map<String, dynamic> jsonData) {
    return BitcoinPrice.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'BitcoinPrice';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [BitcoinPrice] in your schema.
 */
class BitcoinPriceModelIdentifier implements amplify_core.ModelIdentifier<BitcoinPrice> {
  final String id;

  /** Create an instance of BitcoinPriceModelIdentifier using [id] the primary key. */
  const BitcoinPriceModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'BitcoinPriceModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is BitcoinPriceModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}