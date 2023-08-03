using MaterialAnalysis as service from '../../srv/data-provider';

annotate service.Orders with @(
    Aggregation.ApplySupported                 : {
        Transformations       : [
            'aggregate',
            'topcount',
            'bottomcount',
            'identity',
            'concat',
            'groupby',
            'filter',
            'expand',
            'search'
        ],
        GroupableProperties   : [
            purchaseOrder,
            supplier,
            material,
            orderQuantity
        ],
        AggregatableProperties: [{
            $Type   : 'Aggregation.AggregatablePropertyType',
            Property: orderQuantity
        }]
    },
    Analytics.AggregatedProperty #totalQuantity: {
        $Type               : 'Analytics.AggregatedPropertyType',
        AggregatableProperty: orderQuantity,
        AggregationMethod   : 'sum',
        Name                : 'totalQuantity',
        ![@Common.Label]    : 'Total Quantity'
    },
);

annotate service.Orders with @(
    UI.Chart              : {
        $Type              : 'UI.ChartDefinitionType',
        Title              : 'Order Quantity',
        ChartType          : #Column,
        Dimensions         : [
            material,
            supplier
        ],
        DimensionAttributes: [
            {
                $Type    : 'UI.ChartDimensionAttributeType',
                Dimension: material,
                Role     : #Category
            },
            {
                $Type    : 'UI.ChartDimensionAttributeType',
                Dimension: supplier,
                Role     : #Category2
            }
        ],
        DynamicMeasures    : [ ![@Analytics.AggregatedProperty#totalQuantity] ],
        MeasureAttributes  : [{
            $Type         : 'UI.ChartMeasureAttributeType',
            DynamicMeasure: ![@Analytics.AggregatedProperty#totalQuantity],
            Role          : #Axis1
        }]
    },
    UI.PresentationVariant: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: ['@UI.Chart', ],
    }
);

annotate service.Orders with @(
    UI.Chart #material                  : {
        $Type          : 'UI.ChartDefinitionType',
        ChartType      : #Bar,
        Dimensions     : [material],
        DynamicMeasures: [ ![@Analytics.AggregatedProperty#totalQuantity] ]
    },
    UI.PresentationVariant #prevMaterial: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: ['@UI.Chart#material', ],
    }
) {
    material @Common.ValueList #vlMaterial: {
        $Type                       : 'Common.ValueListType',
        CollectionPath              : 'Orders',
        Parameters                  : [{
            $Type            : 'Common.ValueListParameterInOut',
            ValueListProperty: 'material',
            LocalDataProperty: material
        }],
        PresentationVariantQualifier: 'prevMaterial'
    }
}

annotate service.Orders with @(UI: {
    SelectionFields: [
        material,
        supplier
    ],
    LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: purchaseOrder,
        },
        {
            $Type: 'UI.DataField',
            Value: purchaseOrderItem,
        },
        {
            $Type: 'UI.DataField',
            Value: material,
        },
        {
            $Type: 'UI.DataField',
            Value: materialDescription,
        },
        {
            $Type: 'UI.DataField',
            Value: orderQuantity,
        },
        {
            $Type: 'UI.DataField',
            Value: purchaseOrderQuantityUnit,
        },
    ],
});
