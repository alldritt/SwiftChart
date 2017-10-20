//
//  ChartSeries.swift
//
//  Created by Giampaolo Bellavite on 07/11/14.
//  Copyright (c) 2014 Giampaolo Bellavite. All rights reserved.
//

import UIKit

/**
Represent a series to draw in the line chart. Each series is defined with a dataset and appareance settings.
*/

public enum ChartCalloutKind {
    case circle,
         square,
         line, // line with title on top
         lineTop, // line with title on top
         lineBottom // line with title on bottom
}

public struct ChartCallout {
    private (set) var x: Int
    private (set) var kind: ChartCalloutKind
    private (set) var strokeColor: UIColor?
    private (set) var fillColor: UIColor?
    private (set) var lineWidth: CGFloat?
    private (set) var title: String?
    private (set) var titleColor: UIColor?

    public init(_ x: Int, kind: ChartCalloutKind = .circle, strokeColor: UIColor? = nil, fillColor: UIColor? = nil, lineWidth: CGFloat? = nil, title: String? = nil, titleColor: UIColor? = nil) {
        self.x = x
        self.kind = kind
        self.strokeColor = strokeColor
        self.fillColor = fillColor
        self.lineWidth = lineWidth
        self.title = title
        self.titleColor = titleColor
    }
}

open class ChartSeries {
    open var data: [(x: Float, y: Float)]
    open var callouts: [ChartCallout] = []
    open var area: Bool = false
    open var line: Bool = true
    open var lineWidth : CGFloat?
    open var color: UIColor = ChartColors.blueColor() {
        didSet {
            colors = (above: color, below: color, 0)
        }
    }
    open var colors: (
        above: UIColor,
        below: UIColor,
        zeroLevel: Float
    ) = (above: ChartColors.blueColor(), below: ChartColors.redColor(), 0)

    public init(_ data: [Float]) {
        self.data = []

        data.enumerated().forEach { (x, y) in
            let point: (x: Float, y: Float) = (x: Float(x), y: y)
            self.data.append(point)
        }
    }

    public init(data: [(x: Float, y: Float)]) {
        self.data = data
    }

    public init(data: [(x: Double, y: Double)]) {
        self.data = data.map ({ (Float($0.x), Float($0.y))})
    }
}
