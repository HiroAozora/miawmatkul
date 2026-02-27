// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jadwal_exception.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetJadwalExceptionCollection on Isar {
  IsarCollection<JadwalException> get jadwalExceptions => this.collection();
}

const JadwalExceptionSchema = CollectionSchema(
  name: r'JadwalException',
  id: 8593269315172395540,
  properties: {
    r'jadwalId': PropertySchema(
      id: 0,
      name: r'jadwalId',
      type: IsarType.long,
    ),
    r'keterangan': PropertySchema(
      id: 1,
      name: r'keterangan',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 2,
      name: r'status',
      type: IsarType.string,
    ),
    r'tanggal': PropertySchema(
      id: 3,
      name: r'tanggal',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _jadwalExceptionEstimateSize,
  serialize: _jadwalExceptionSerialize,
  deserialize: _jadwalExceptionDeserialize,
  deserializeProp: _jadwalExceptionDeserializeProp,
  idName: r'id',
  indexes: {
    r'jadwalId': IndexSchema(
      id: -1767887433316251753,
      name: r'jadwalId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'jadwalId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'tanggal': IndexSchema(
      id: 5193070597002198496,
      name: r'tanggal',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'tanggal',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _jadwalExceptionGetId,
  getLinks: _jadwalExceptionGetLinks,
  attach: _jadwalExceptionAttach,
  version: '3.1.0+1',
);

int _jadwalExceptionEstimateSize(
  JadwalException object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.keterangan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _jadwalExceptionSerialize(
  JadwalException object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.jadwalId);
  writer.writeString(offsets[1], object.keterangan);
  writer.writeString(offsets[2], object.status);
  writer.writeDateTime(offsets[3], object.tanggal);
}

JadwalException _jadwalExceptionDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = JadwalException();
  object.id = id;
  object.jadwalId = reader.readLongOrNull(offsets[0]);
  object.keterangan = reader.readStringOrNull(offsets[1]);
  object.status = reader.readStringOrNull(offsets[2]);
  object.tanggal = reader.readDateTimeOrNull(offsets[3]);
  return object;
}

P _jadwalExceptionDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _jadwalExceptionGetId(JadwalException object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _jadwalExceptionGetLinks(JadwalException object) {
  return [];
}

void _jadwalExceptionAttach(
    IsarCollection<dynamic> col, Id id, JadwalException object) {
  object.id = id;
}

extension JadwalExceptionQueryWhereSort
    on QueryBuilder<JadwalException, JadwalException, QWhere> {
  QueryBuilder<JadwalException, JadwalException, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhere> anyJadwalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'jadwalId'),
      );
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhere> anyTanggal() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'tanggal'),
      );
    });
  }
}

extension JadwalExceptionQueryWhere
    on QueryBuilder<JadwalException, JadwalException, QWhereClause> {
  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      jadwalIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'jadwalId',
        value: [null],
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      jadwalIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'jadwalId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      jadwalIdEqualTo(int? jadwalId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'jadwalId',
        value: [jadwalId],
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      jadwalIdNotEqualTo(int? jadwalId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'jadwalId',
              lower: [],
              upper: [jadwalId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'jadwalId',
              lower: [jadwalId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'jadwalId',
              lower: [jadwalId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'jadwalId',
              lower: [],
              upper: [jadwalId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      jadwalIdGreaterThan(
    int? jadwalId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'jadwalId',
        lower: [jadwalId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      jadwalIdLessThan(
    int? jadwalId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'jadwalId',
        lower: [],
        upper: [jadwalId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      jadwalIdBetween(
    int? lowerJadwalId,
    int? upperJadwalId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'jadwalId',
        lower: [lowerJadwalId],
        includeLower: includeLower,
        upper: [upperJadwalId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      tanggalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tanggal',
        value: [null],
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      tanggalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tanggal',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      tanggalEqualTo(DateTime? tanggal) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'tanggal',
        value: [tanggal],
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      tanggalNotEqualTo(DateTime? tanggal) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tanggal',
              lower: [],
              upper: [tanggal],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tanggal',
              lower: [tanggal],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tanggal',
              lower: [tanggal],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'tanggal',
              lower: [],
              upper: [tanggal],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      tanggalGreaterThan(
    DateTime? tanggal, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tanggal',
        lower: [tanggal],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      tanggalLessThan(
    DateTime? tanggal, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tanggal',
        lower: [],
        upper: [tanggal],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterWhereClause>
      tanggalBetween(
    DateTime? lowerTanggal,
    DateTime? upperTanggal, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'tanggal',
        lower: [lowerTanggal],
        includeLower: includeLower,
        upper: [upperTanggal],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension JadwalExceptionQueryFilter
    on QueryBuilder<JadwalException, JadwalException, QFilterCondition> {
  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      jadwalIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'jadwalId',
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      jadwalIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'jadwalId',
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      jadwalIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jadwalId',
        value: value,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      jadwalIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jadwalId',
        value: value,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      jadwalIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jadwalId',
        value: value,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      jadwalIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jadwalId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      keteranganIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'keterangan',
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      keteranganIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'keterangan',
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      keteranganEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keterangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      keteranganGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'keterangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      keteranganLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'keterangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      keteranganBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'keterangan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      keteranganStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'keterangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      keteranganEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'keterangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      keteranganContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'keterangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      keteranganMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'keterangan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      keteranganIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'keterangan',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      keteranganIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'keterangan',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      statusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      statusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      statusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      statusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      tanggalIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tanggal',
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      tanggalIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tanggal',
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      tanggalEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tanggal',
        value: value,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      tanggalGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tanggal',
        value: value,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      tanggalLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tanggal',
        value: value,
      ));
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterFilterCondition>
      tanggalBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tanggal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension JadwalExceptionQueryObject
    on QueryBuilder<JadwalException, JadwalException, QFilterCondition> {}

extension JadwalExceptionQueryLinks
    on QueryBuilder<JadwalException, JadwalException, QFilterCondition> {}

extension JadwalExceptionQuerySortBy
    on QueryBuilder<JadwalException, JadwalException, QSortBy> {
  QueryBuilder<JadwalException, JadwalException, QAfterSortBy>
      sortByJadwalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jadwalId', Sort.asc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy>
      sortByJadwalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jadwalId', Sort.desc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy>
      sortByKeterangan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keterangan', Sort.asc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy>
      sortByKeteranganDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keterangan', Sort.desc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy> sortByTanggal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tanggal', Sort.asc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy>
      sortByTanggalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tanggal', Sort.desc);
    });
  }
}

extension JadwalExceptionQuerySortThenBy
    on QueryBuilder<JadwalException, JadwalException, QSortThenBy> {
  QueryBuilder<JadwalException, JadwalException, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy>
      thenByJadwalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jadwalId', Sort.asc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy>
      thenByJadwalIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jadwalId', Sort.desc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy>
      thenByKeterangan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keterangan', Sort.asc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy>
      thenByKeteranganDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'keterangan', Sort.desc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy> thenByTanggal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tanggal', Sort.asc);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QAfterSortBy>
      thenByTanggalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tanggal', Sort.desc);
    });
  }
}

extension JadwalExceptionQueryWhereDistinct
    on QueryBuilder<JadwalException, JadwalException, QDistinct> {
  QueryBuilder<JadwalException, JadwalException, QDistinct>
      distinctByJadwalId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jadwalId');
    });
  }

  QueryBuilder<JadwalException, JadwalException, QDistinct>
      distinctByKeterangan({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'keterangan', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JadwalException, JadwalException, QDistinct>
      distinctByTanggal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tanggal');
    });
  }
}

extension JadwalExceptionQueryProperty
    on QueryBuilder<JadwalException, JadwalException, QQueryProperty> {
  QueryBuilder<JadwalException, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<JadwalException, int?, QQueryOperations> jadwalIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jadwalId');
    });
  }

  QueryBuilder<JadwalException, String?, QQueryOperations>
      keteranganProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'keterangan');
    });
  }

  QueryBuilder<JadwalException, String?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<JadwalException, DateTime?, QQueryOperations> tanggalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tanggal');
    });
  }
}
