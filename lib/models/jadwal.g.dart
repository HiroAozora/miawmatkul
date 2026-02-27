// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jadwal.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetJadwalKuliahCollection on Isar {
  IsarCollection<JadwalKuliah> get jadwalKuliahs => this.collection();
}

const JadwalKuliahSchema = CollectionSchema(
  name: r'JadwalKuliah',
  id: -9064563008446360171,
  properties: {
    r'dosen': PropertySchema(
      id: 0,
      name: r'dosen',
      type: IsarType.string,
    ),
    r'firestoreId': PropertySchema(
      id: 1,
      name: r'firestoreId',
      type: IsarType.string,
    ),
    r'hari': PropertySchema(
      id: 2,
      name: r'hari',
      type: IsarType.string,
    ),
    r'isSubscribed': PropertySchema(
      id: 3,
      name: r'isSubscribed',
      type: IsarType.bool,
    ),
    r'jamMulai': PropertySchema(
      id: 4,
      name: r'jamMulai',
      type: IsarType.string,
    ),
    r'jamSelesai': PropertySchema(
      id: 5,
      name: r'jamSelesai',
      type: IsarType.string,
    ),
    r'namaMatkul': PropertySchema(
      id: 6,
      name: r'namaMatkul',
      type: IsarType.string,
    ),
    r'ruangan': PropertySchema(
      id: 7,
      name: r'ruangan',
      type: IsarType.string,
    )
  },
  estimateSize: _jadwalKuliahEstimateSize,
  serialize: _jadwalKuliahSerialize,
  deserialize: _jadwalKuliahDeserialize,
  deserializeProp: _jadwalKuliahDeserializeProp,
  idName: r'id',
  indexes: {
    r'firestoreId': IndexSchema(
      id: 1863077355534729001,
      name: r'firestoreId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'firestoreId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _jadwalKuliahGetId,
  getLinks: _jadwalKuliahGetLinks,
  attach: _jadwalKuliahAttach,
  version: '3.1.0+1',
);

int _jadwalKuliahEstimateSize(
  JadwalKuliah object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.dosen;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.firestoreId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.hari;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.jamMulai;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.jamSelesai;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.namaMatkul;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.ruangan;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _jadwalKuliahSerialize(
  JadwalKuliah object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.dosen);
  writer.writeString(offsets[1], object.firestoreId);
  writer.writeString(offsets[2], object.hari);
  writer.writeBool(offsets[3], object.isSubscribed);
  writer.writeString(offsets[4], object.jamMulai);
  writer.writeString(offsets[5], object.jamSelesai);
  writer.writeString(offsets[6], object.namaMatkul);
  writer.writeString(offsets[7], object.ruangan);
}

JadwalKuliah _jadwalKuliahDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = JadwalKuliah();
  object.dosen = reader.readStringOrNull(offsets[0]);
  object.firestoreId = reader.readStringOrNull(offsets[1]);
  object.hari = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.isSubscribed = reader.readBool(offsets[3]);
  object.jamMulai = reader.readStringOrNull(offsets[4]);
  object.jamSelesai = reader.readStringOrNull(offsets[5]);
  object.namaMatkul = reader.readStringOrNull(offsets[6]);
  object.ruangan = reader.readStringOrNull(offsets[7]);
  return object;
}

P _jadwalKuliahDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _jadwalKuliahGetId(JadwalKuliah object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _jadwalKuliahGetLinks(JadwalKuliah object) {
  return [];
}

void _jadwalKuliahAttach(
    IsarCollection<dynamic> col, Id id, JadwalKuliah object) {
  object.id = id;
}

extension JadwalKuliahByIndex on IsarCollection<JadwalKuliah> {
  Future<JadwalKuliah?> getByFirestoreId(String? firestoreId) {
    return getByIndex(r'firestoreId', [firestoreId]);
  }

  JadwalKuliah? getByFirestoreIdSync(String? firestoreId) {
    return getByIndexSync(r'firestoreId', [firestoreId]);
  }

  Future<bool> deleteByFirestoreId(String? firestoreId) {
    return deleteByIndex(r'firestoreId', [firestoreId]);
  }

  bool deleteByFirestoreIdSync(String? firestoreId) {
    return deleteByIndexSync(r'firestoreId', [firestoreId]);
  }

  Future<List<JadwalKuliah?>> getAllByFirestoreId(
      List<String?> firestoreIdValues) {
    final values = firestoreIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'firestoreId', values);
  }

  List<JadwalKuliah?> getAllByFirestoreIdSync(List<String?> firestoreIdValues) {
    final values = firestoreIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'firestoreId', values);
  }

  Future<int> deleteAllByFirestoreId(List<String?> firestoreIdValues) {
    final values = firestoreIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'firestoreId', values);
  }

  int deleteAllByFirestoreIdSync(List<String?> firestoreIdValues) {
    final values = firestoreIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'firestoreId', values);
  }

  Future<Id> putByFirestoreId(JadwalKuliah object) {
    return putByIndex(r'firestoreId', object);
  }

  Id putByFirestoreIdSync(JadwalKuliah object, {bool saveLinks = true}) {
    return putByIndexSync(r'firestoreId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByFirestoreId(List<JadwalKuliah> objects) {
    return putAllByIndex(r'firestoreId', objects);
  }

  List<Id> putAllByFirestoreIdSync(List<JadwalKuliah> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'firestoreId', objects, saveLinks: saveLinks);
  }
}

extension JadwalKuliahQueryWhereSort
    on QueryBuilder<JadwalKuliah, JadwalKuliah, QWhere> {
  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension JadwalKuliahQueryWhere
    on QueryBuilder<JadwalKuliah, JadwalKuliah, QWhereClause> {
  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterWhereClause> idBetween(
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

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterWhereClause>
      firestoreIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'firestoreId',
        value: [null],
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterWhereClause>
      firestoreIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'firestoreId',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterWhereClause>
      firestoreIdEqualTo(String? firestoreId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'firestoreId',
        value: [firestoreId],
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterWhereClause>
      firestoreIdNotEqualTo(String? firestoreId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firestoreId',
              lower: [],
              upper: [firestoreId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firestoreId',
              lower: [firestoreId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firestoreId',
              lower: [firestoreId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firestoreId',
              lower: [],
              upper: [firestoreId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension JadwalKuliahQueryFilter
    on QueryBuilder<JadwalKuliah, JadwalKuliah, QFilterCondition> {
  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      dosenIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dosen',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      dosenIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dosen',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> dosenEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dosen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      dosenGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dosen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> dosenLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dosen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> dosenBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dosen',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      dosenStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dosen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> dosenEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dosen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> dosenContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dosen',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> dosenMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dosen',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      dosenIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dosen',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      dosenIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dosen',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      firestoreIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firestoreId',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      firestoreIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firestoreId',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      firestoreIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      firestoreIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      firestoreIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      firestoreIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firestoreId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      firestoreIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      firestoreIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      firestoreIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firestoreId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      firestoreIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firestoreId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      firestoreIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firestoreId',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      firestoreIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firestoreId',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> hariIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hari',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      hariIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hari',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> hariEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hari',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      hariGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hari',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> hariLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hari',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> hariBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hari',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      hariStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hari',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> hariEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hari',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> hariContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hari',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> hariMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hari',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      hariIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hari',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      hariIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hari',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition> idBetween(
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

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      isSubscribedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSubscribed',
        value: value,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamMulaiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'jamMulai',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamMulaiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'jamMulai',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamMulaiEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jamMulai',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamMulaiGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jamMulai',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamMulaiLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jamMulai',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamMulaiBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jamMulai',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamMulaiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'jamMulai',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamMulaiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'jamMulai',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamMulaiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'jamMulai',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamMulaiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'jamMulai',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamMulaiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jamMulai',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamMulaiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'jamMulai',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamSelesaiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'jamSelesai',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamSelesaiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'jamSelesai',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamSelesaiEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jamSelesai',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamSelesaiGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'jamSelesai',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamSelesaiLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'jamSelesai',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamSelesaiBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'jamSelesai',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamSelesaiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'jamSelesai',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamSelesaiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'jamSelesai',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamSelesaiContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'jamSelesai',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamSelesaiMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'jamSelesai',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamSelesaiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'jamSelesai',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      jamSelesaiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'jamSelesai',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      namaMatkulIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'namaMatkul',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      namaMatkulIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'namaMatkul',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      namaMatkulEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'namaMatkul',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      namaMatkulGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'namaMatkul',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      namaMatkulLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'namaMatkul',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      namaMatkulBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'namaMatkul',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      namaMatkulStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'namaMatkul',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      namaMatkulEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'namaMatkul',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      namaMatkulContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'namaMatkul',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      namaMatkulMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'namaMatkul',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      namaMatkulIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'namaMatkul',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      namaMatkulIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'namaMatkul',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      ruanganIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'ruangan',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      ruanganIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'ruangan',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      ruanganEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ruangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      ruanganGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ruangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      ruanganLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ruangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      ruanganBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ruangan',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      ruanganStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ruangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      ruanganEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ruangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      ruanganContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ruangan',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      ruanganMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ruangan',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      ruanganIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ruangan',
        value: '',
      ));
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterFilterCondition>
      ruanganIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ruangan',
        value: '',
      ));
    });
  }
}

extension JadwalKuliahQueryObject
    on QueryBuilder<JadwalKuliah, JadwalKuliah, QFilterCondition> {}

extension JadwalKuliahQueryLinks
    on QueryBuilder<JadwalKuliah, JadwalKuliah, QFilterCondition> {}

extension JadwalKuliahQuerySortBy
    on QueryBuilder<JadwalKuliah, JadwalKuliah, QSortBy> {
  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> sortByDosen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosen', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> sortByDosenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosen', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> sortByFirestoreId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy>
      sortByFirestoreIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> sortByHari() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hari', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> sortByHariDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hari', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> sortByIsSubscribed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSubscribed', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy>
      sortByIsSubscribedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSubscribed', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> sortByJamMulai() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jamMulai', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> sortByJamMulaiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jamMulai', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> sortByJamSelesai() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jamSelesai', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy>
      sortByJamSelesaiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jamSelesai', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> sortByNamaMatkul() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaMatkul', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy>
      sortByNamaMatkulDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaMatkul', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> sortByRuangan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ruangan', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> sortByRuanganDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ruangan', Sort.desc);
    });
  }
}

extension JadwalKuliahQuerySortThenBy
    on QueryBuilder<JadwalKuliah, JadwalKuliah, QSortThenBy> {
  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenByDosen() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosen', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenByDosenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosen', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenByFirestoreId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy>
      thenByFirestoreIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firestoreId', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenByHari() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hari', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenByHariDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hari', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenByIsSubscribed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSubscribed', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy>
      thenByIsSubscribedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSubscribed', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenByJamMulai() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jamMulai', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenByJamMulaiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jamMulai', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenByJamSelesai() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jamSelesai', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy>
      thenByJamSelesaiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'jamSelesai', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenByNamaMatkul() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaMatkul', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy>
      thenByNamaMatkulDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'namaMatkul', Sort.desc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenByRuangan() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ruangan', Sort.asc);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QAfterSortBy> thenByRuanganDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ruangan', Sort.desc);
    });
  }
}

extension JadwalKuliahQueryWhereDistinct
    on QueryBuilder<JadwalKuliah, JadwalKuliah, QDistinct> {
  QueryBuilder<JadwalKuliah, JadwalKuliah, QDistinct> distinctByDosen(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dosen', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QDistinct> distinctByFirestoreId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firestoreId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QDistinct> distinctByHari(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hari', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QDistinct> distinctByIsSubscribed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSubscribed');
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QDistinct> distinctByJamMulai(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jamMulai', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QDistinct> distinctByJamSelesai(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'jamSelesai', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QDistinct> distinctByNamaMatkul(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'namaMatkul', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<JadwalKuliah, JadwalKuliah, QDistinct> distinctByRuangan(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ruangan', caseSensitive: caseSensitive);
    });
  }
}

extension JadwalKuliahQueryProperty
    on QueryBuilder<JadwalKuliah, JadwalKuliah, QQueryProperty> {
  QueryBuilder<JadwalKuliah, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<JadwalKuliah, String?, QQueryOperations> dosenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dosen');
    });
  }

  QueryBuilder<JadwalKuliah, String?, QQueryOperations> firestoreIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firestoreId');
    });
  }

  QueryBuilder<JadwalKuliah, String?, QQueryOperations> hariProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hari');
    });
  }

  QueryBuilder<JadwalKuliah, bool, QQueryOperations> isSubscribedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSubscribed');
    });
  }

  QueryBuilder<JadwalKuliah, String?, QQueryOperations> jamMulaiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jamMulai');
    });
  }

  QueryBuilder<JadwalKuliah, String?, QQueryOperations> jamSelesaiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'jamSelesai');
    });
  }

  QueryBuilder<JadwalKuliah, String?, QQueryOperations> namaMatkulProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'namaMatkul');
    });
  }

  QueryBuilder<JadwalKuliah, String?, QQueryOperations> ruanganProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ruangan');
    });
  }
}
