// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shopping_cart_local_source.dart';

// ignore_for_file: type=lint
class $ProductCartItemTable extends ProductCartItem
    with TableInfo<$ProductCartItemTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductCartItemTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<String> price = GeneratedColumn<String>(
    'price',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String> mediaUrls =
      GeneratedColumn<String>(
        'media_urls',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 255,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<List<String>>($ProductCartItemTable.$convertermediaUrls);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    displayName,
    price,
    mediaUrls,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_cart_item';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price'],
      )!,
      mediaUrls: $ProductCartItemTable.$convertermediaUrls.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}media_urls'],
        )!,
      ),
    );
  }

  @override
  $ProductCartItemTable createAlias(String alias) {
    return $ProductCartItemTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $convertermediaUrls =
      JsonConverter();
}

class ProductCartItemCompanion extends UpdateCompanion<Product> {
  final Value<int> id;
  final Value<String> productId;
  final Value<String> displayName;
  final Value<String> price;
  final Value<List<String>> mediaUrls;
  const ProductCartItemCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.price = const Value.absent(),
    this.mediaUrls = const Value.absent(),
  });
  ProductCartItemCompanion.insert({
    this.id = const Value.absent(),
    required String productId,
    required String displayName,
    required String price,
    required List<String> mediaUrls,
  }) : productId = Value(productId),
       displayName = Value(displayName),
       price = Value(price),
       mediaUrls = Value(mediaUrls);
  static Insertable<Product> custom({
    Expression<int>? id,
    Expression<String>? productId,
    Expression<String>? displayName,
    Expression<String>? price,
    Expression<String>? mediaUrls,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (displayName != null) 'display_name': displayName,
      if (price != null) 'price': price,
      if (mediaUrls != null) 'media_urls': mediaUrls,
    });
  }

  ProductCartItemCompanion copyWith({
    Value<int>? id,
    Value<String>? productId,
    Value<String>? displayName,
    Value<String>? price,
    Value<List<String>>? mediaUrls,
  }) {
    return ProductCartItemCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      displayName: displayName ?? this.displayName,
      price: price ?? this.price,
      mediaUrls: mediaUrls ?? this.mediaUrls,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (price.present) {
      map['price'] = Variable<String>(price.value);
    }
    if (mediaUrls.present) {
      map['media_urls'] = Variable<String>(
        $ProductCartItemTable.$convertermediaUrls.toSql(mediaUrls.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductCartItemCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('displayName: $displayName, ')
          ..write('price: $price, ')
          ..write('mediaUrls: $mediaUrls')
          ..write(')'))
        .toString();
  }
}

abstract class _$ShoppingCartLocalDatabase extends GeneratedDatabase {
  _$ShoppingCartLocalDatabase(QueryExecutor e) : super(e);
  $ShoppingCartLocalDatabaseManager get managers =>
      $ShoppingCartLocalDatabaseManager(this);
  late final $ProductCartItemTable productCartItem = $ProductCartItemTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [productCartItem];
}

typedef $$ProductCartItemTableCreateCompanionBuilder =
    ProductCartItemCompanion Function({
      Value<int> id,
      required String productId,
      required String displayName,
      required String price,
      required List<String> mediaUrls,
    });
typedef $$ProductCartItemTableUpdateCompanionBuilder =
    ProductCartItemCompanion Function({
      Value<int> id,
      Value<String> productId,
      Value<String> displayName,
      Value<String> price,
      Value<List<String>> mediaUrls,
    });

class $$ProductCartItemTableFilterComposer
    extends Composer<_$ShoppingCartLocalDatabase, $ProductCartItemTable> {
  $$ProductCartItemTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get mediaUrls => $composableBuilder(
    column: $table.mediaUrls,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$ProductCartItemTableOrderingComposer
    extends Composer<_$ShoppingCartLocalDatabase, $ProductCartItemTable> {
  $$ProductCartItemTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mediaUrls => $composableBuilder(
    column: $table.mediaUrls,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductCartItemTableAnnotationComposer
    extends Composer<_$ShoppingCartLocalDatabase, $ProductCartItemTable> {
  $$ProductCartItemTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get mediaUrls =>
      $composableBuilder(column: $table.mediaUrls, builder: (column) => column);
}

class $$ProductCartItemTableTableManager
    extends
        RootTableManager<
          _$ShoppingCartLocalDatabase,
          $ProductCartItemTable,
          Product,
          $$ProductCartItemTableFilterComposer,
          $$ProductCartItemTableOrderingComposer,
          $$ProductCartItemTableAnnotationComposer,
          $$ProductCartItemTableCreateCompanionBuilder,
          $$ProductCartItemTableUpdateCompanionBuilder,
          (
            Product,
            BaseReferences<
              _$ShoppingCartLocalDatabase,
              $ProductCartItemTable,
              Product
            >,
          ),
          Product,
          PrefetchHooks Function()
        > {
  $$ProductCartItemTableTableManager(
    _$ShoppingCartLocalDatabase db,
    $ProductCartItemTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductCartItemTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductCartItemTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductCartItemTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> price = const Value.absent(),
                Value<List<String>> mediaUrls = const Value.absent(),
              }) => ProductCartItemCompanion(
                id: id,
                productId: productId,
                displayName: displayName,
                price: price,
                mediaUrls: mediaUrls,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String productId,
                required String displayName,
                required String price,
                required List<String> mediaUrls,
              }) => ProductCartItemCompanion.insert(
                id: id,
                productId: productId,
                displayName: displayName,
                price: price,
                mediaUrls: mediaUrls,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductCartItemTableProcessedTableManager =
    ProcessedTableManager<
      _$ShoppingCartLocalDatabase,
      $ProductCartItemTable,
      Product,
      $$ProductCartItemTableFilterComposer,
      $$ProductCartItemTableOrderingComposer,
      $$ProductCartItemTableAnnotationComposer,
      $$ProductCartItemTableCreateCompanionBuilder,
      $$ProductCartItemTableUpdateCompanionBuilder,
      (
        Product,
        BaseReferences<
          _$ShoppingCartLocalDatabase,
          $ProductCartItemTable,
          Product
        >,
      ),
      Product,
      PrefetchHooks Function()
    >;

class $ShoppingCartLocalDatabaseManager {
  final _$ShoppingCartLocalDatabase _db;
  $ShoppingCartLocalDatabaseManager(this._db);
  $$ProductCartItemTableTableManager get productCartItem =>
      $$ProductCartItemTableTableManager(_db, _db.productCartItem);
}
