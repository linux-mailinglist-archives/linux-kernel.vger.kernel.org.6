Return-Path: <linux-kernel+bounces-351902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EC699176C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7969A1C2155B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BF9154BEC;
	Sat,  5 Oct 2024 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiEFnaC/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D7A1547C9;
	Sat,  5 Oct 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728139256; cv=none; b=mpgJSp2VtP0ytfUVNv1NeLufY3eIJsH0yhgtz7/TkVjUZZDoBNGRZGk438Tmn7oLsXwp3NViZtOXdX2KP/XSGCKI/nz6h/McaOrmsvWmApemgJZwWJxtW09scvTVQ6XwBQdIQAZ+zXvTcPKSebeVBOjToiOUedWwvFz13RXH41g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728139256; c=relaxed/simple;
	bh=IESewRE5dpOceertCQW9BhawHutEpUXflIqNfJ3XaiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GUItIRL/5RHN45fXVfq4giEzE/10kM2aPHLo/mwyiglRYEe1saPNzv5PwPa2dgr06gQrHk1B02l2RuhbTUpby+jeWwXT1KPQVWfAJ6NKU1AzcoG3BhyV3kfuRPrV9EU3+VEkiHr/dD/T5IQM741eZv9MgIEQnuTYSj54phlHjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiEFnaC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7ECC4CEC2;
	Sat,  5 Oct 2024 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728139256;
	bh=IESewRE5dpOceertCQW9BhawHutEpUXflIqNfJ3XaiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiEFnaC/R+PzY5GrMTfZz07v2r5v9DyW/CpVVXZD1Ezh4ZkoBFL1JzVJWjGAqZXpz
	 Mqk/JlCc2TN6zpMCE56C5SkPvVUXPTpZy1mdh1bOo0aCXzlNzeCPzkTEc+Cn6K4fR8
	 8h4xfrtOvxdv6MTYP7n965dXaA+5r4ofSYRxUQRqBqnsLoHp5Idy0SnlqMC316hwJ7
	 1BGNSCP2bcR1xWbzsXbLqhrLjKSxOvAL/JpJ4TJzKxO254RgbNa9pRbIQ3fEZAEuZQ
	 1hV1Jo+1LMIEJXOAeFAQGMd/sbb5pIihGKZ5JpF9Jx+yg6AUuUhUW4r33oVjBLOUT1
	 rUWOy85FusAPw==
Date: Sat, 5 Oct 2024 09:40:54 -0500
From: Rob Herring <robh@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v3 2/2] dt-bindings: mtd: davinci: convert to yaml
Message-ID: <20241005144054.GA156122-robh@kernel.org>
References: <20241005-ondie-v3-0-459d9c32225c@gmail.com>
 <20241005-ondie-v3-2-459d9c32225c@gmail.com>
 <172813824343.140783.17306442382482143087.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172813824343.140783.17306442382482143087.robh@kernel.org>

On Sat, Oct 05, 2024 at 09:24:04AM -0500, Rob Herring (Arm) wrote:
> 
> On Sat, 05 Oct 2024 10:26:12 +0200, Marcus Folkesson wrote:
> > Convert the bindings to yaml format.
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  .../devicetree/bindings/mtd/davinci-nand.txt       |  94 -------------------
> >  .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 102 +++++++++++++++++++++
> >  2 files changed, 102 insertions(+), 94 deletions(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:

I think this is the 2nd version with the same failures. This is not a 
free testing service. Test you patches before sending.

> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml: 'oneOf' conditional failed, one must be fixed:
> 	'unevaluatedProperties' is a required property
> 	'additionalProperties' is a required property
> 	hint: Either unevaluatedProperties or additionalProperties must be present
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml: properties:ti,davinci-ecc-bits: '$ref' should not be valid under {'const': '$ref'}
> 	hint: Standard unit suffix properties don't need a type $ref
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dts:32.13-40: Warning (reg_format): /example-0/nand-controller@62000000/partition@180000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
> Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dts:30.28-33.14: Warning (avoid_default_addr_size): /example-0/nand-controller@62000000/partition@180000: Relying on default #address-cells value
> Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dts:30.28-33.14: Warning (avoid_default_addr_size): /example-0/nand-controller@62000000/partition@180000: Relying on default #size-cells value
> Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: '#address-cells' is a required property
> 	from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: '#size-cells' is a required property
> 	from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: reg: [[1644167168, 526335], [1744830464, 32768]] is too long
> 	from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: ti,davinci-ecc-bits: 4 is not of type 'array'
> 	from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: '#address-cells' is a required property
> 	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: '#size-cells' is a required property
> 	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: ti,davinci-ecc-bits: 4 is not of type 'array'
> 	from schema $id: http://devicetree.org/schemas/property-units.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241005-ondie-v3-2-459d9c32225c@gmail.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

