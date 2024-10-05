Return-Path: <linux-kernel+bounces-351893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C792C991751
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 16:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468841F22605
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 14:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D5A715539A;
	Sat,  5 Oct 2024 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkU76rzu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A296154C15;
	Sat,  5 Oct 2024 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728138245; cv=none; b=h4grPe6o+Fm1MRwClyaMKxjxgNqlWEwOPjKiGXgeTtWgrGU1cXmuOMI431prhDt+SBLu8EYbhxpdwG9VFi2jJTLRRNeQErniy3eO70F1wMHL/whEv1DaLm3GImBTVZSsVYwKX2VHp9wAaOJFVASn9KVI3VqopMLt4TRpSIthf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728138245; c=relaxed/simple;
	bh=txlfB+9xh3mLZ1jCT2FDFCuADgC+DWHCutNmzx33phc=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=rENaOSeegWeNWJFdmdVZyytgnsuFLx4spvI7ND5UlcqKOOoeDHw4cZwl1Ixxst8Lu+lKgqKsCghZeIQBgTiX8YDM7wCLApgpwrhbwtjQMVv+Kf3jy9eVobn0/g2uU62OeMDAP7rAy/0ziLLoP/40GjPv3IK75Ao70ha5W0+JFpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkU76rzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06875C4CED0;
	Sat,  5 Oct 2024 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728138245;
	bh=txlfB+9xh3mLZ1jCT2FDFCuADgC+DWHCutNmzx33phc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=IkU76rzuV1Ark0vVlF427vyGCcw+iQH5bZd+63SyLUjrqDjHa4QQdyG36YzADhStc
	 cXYsGGbFx0/e1E9rOnDaId6rS78GTC71zQWfa90EGdcfC5BfKO5qu5xtYYmMcZxGrt
	 0wA/u5ETki8p4XDSALd7uR5WaE6Zyaj82XMQ2wKKZREDt0B9cplLQVRXOy9KesVjRU
	 YN7YJgN2H9F+858LFWn6qC1rMYpSCw6Mc/4/E22Vj3XssRYq3STCjYP4xWL0s+GC0s
	 AS2XCnPv1+ye6bjXtHZOfTvrzoax0mIVJGLlWaMxivQyG3u73zrbvj1UNKQengFAtm
	 UstXNY23vKzjQ==
Date: Sat, 05 Oct 2024 09:24:04 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
 linux-mtd@lists.infradead.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 devicetree@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Richard Weinberger <richard@nod.at>
In-Reply-To: <20241005-ondie-v3-2-459d9c32225c@gmail.com>
References: <20241005-ondie-v3-0-459d9c32225c@gmail.com>
 <20241005-ondie-v3-2-459d9c32225c@gmail.com>
Message-Id: <172813824343.140783.17306442382482143087.robh@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: mtd: davinci: convert to yaml


On Sat, 05 Oct 2024 10:26:12 +0200, Marcus Folkesson wrote:
> Convert the bindings to yaml format.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  .../devicetree/bindings/mtd/davinci-nand.txt       |  94 -------------------
>  .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 102 +++++++++++++++++++++
>  2 files changed, 102 insertions(+), 94 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.yaml: properties:ti,davinci-ecc-bits: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dts:32.13-40: Warning (reg_format): /example-0/nand-controller@62000000/partition@180000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dts:30.28-33.14: Warning (avoid_default_addr_size): /example-0/nand-controller@62000000/partition@180000: Relying on default #address-cells value
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dts:30.28-33.14: Warning (avoid_default_addr_size): /example-0/nand-controller@62000000/partition@180000: Relying on default #size-cells value
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: reg: [[1644167168, 526335], [1744830464, 32768]] is too long
	from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: ti,davinci-ecc-bits: 4 is not of type 'array'
	from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand-controller@62000000: ti,davinci-ecc-bits: 4 is not of type 'array'
	from schema $id: http://devicetree.org/schemas/property-units.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241005-ondie-v3-2-459d9c32225c@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


