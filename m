Return-Path: <linux-kernel+bounces-347664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C52898D998
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF821C22B8F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50541D0E0A;
	Wed,  2 Oct 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBSxJJ6x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90C1D07B2;
	Wed,  2 Oct 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878099; cv=none; b=V53oYFSjLk7CKB4VNJQcZsMaUF+V0vEEYTKqulJRmirOm70YMSH4zjsc7mz9G8MMqGW/LFk3PjKBaf3Qufj+A9YbqyhLKG9ffsrzbkMnbwv/cMHjMvkZy2ybOFYem5Fyuj53kVh5F1qtkvDZFMTKq1s2WHccoYhdfL0g884v70M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878099; c=relaxed/simple;
	bh=qJV6eyrnGPWmmU20pxH/K4MLwVtohfRZCXDJX1Iwjcs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=f/zs1aNhEsm8BM3St9QwDzv01LV/WUxFdSQa/g54ZJTqsvd0L49WGaleU14ZTXFkcg8Rs054xg05fPtk4soT+b+QlwhMcPWvJn5fiOZkOwJuK01TBnZ01AtZfIUor5xQ2FdrJaXlt/2uawQfT6Rl2a9pTid4Uek+0NtdDorjd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vBSxJJ6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA2BC4CEC2;
	Wed,  2 Oct 2024 14:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727878098;
	bh=qJV6eyrnGPWmmU20pxH/K4MLwVtohfRZCXDJX1Iwjcs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=vBSxJJ6xgdknU1uv6DfthE/71edkecUN9of5sSJG3hST9HO6TQ2EHVSqpkxgrUhw0
	 khITaNc820DpOJTCtIYtjstXqkf2BEMpakY+ZXb/vR6rESbNW4VgaQ4DQA35JS9lZB
	 M+9y++WeLkzmH8uFtf+PResr+78fymnqrOhsxqZ6gkTOq2s4uRmU8DDHZVpAt+vh4G
	 cKN2sAqSNvwKFoVZD4/yDpSo2BlnXfjUqyD+DoIu5NKkCgdRg6KRzFbK0S0AWARzCw
	 pu5AE+uogVdyvAsdo7tgq/WraV3aeqqouITEHMdjaM1f+hgSNzShTVmRPuWlIQLwFO
	 y3BVtFUnNKLJw==
Date: Wed, 02 Oct 2024 09:08:17 -0500
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
 Richard Weinberger <richard@nod.at>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241002-ondie-v2-2-318156d8c7b4@gmail.com>
References: <20241002-ondie-v2-0-318156d8c7b4@gmail.com>
 <20241002-ondie-v2-2-318156d8c7b4@gmail.com>
Message-Id: <172787809778.573984.9575281841886802333.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: mtd: davinci: convert to yaml


On Wed, 02 Oct 2024 11:01:31 +0200, Marcus Folkesson wrote:
> Convert the bindings to yaml format.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  .../devicetree/bindings/mtd/davinci-nand.txt       |  94 ------------------
>  .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 105 +++++++++++++++++++++
>  2 files changed, 105 insertions(+), 94 deletions(-)
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
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dts:32.17-44: Warning (reg_format): /example-0/nand_cs3@62000000/partition@180000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dts:30.30-33.15: Warning (avoid_default_addr_size): /example-0/nand_cs3@62000000/partition@180000: Relying on default #address-cells value
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dts:30.30-33.15: Warning (avoid_default_addr_size): /example-0/nand_cs3@62000000/partition@180000: Relying on default #size-cells value
Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand_cs3@62000000: $nodename:0: 'nand_cs3@62000000' does not match '^nand-controller(@.*)?'
	from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand_cs3@62000000: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand_cs3@62000000: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand_cs3@62000000: reg: [[1644167168, 526335], [1744830464, 32768]] is too long
	from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand_cs3@62000000: ti,davinci-ecc-bits: 4 is not of type 'array'
	from schema $id: http://devicetree.org/schemas/mtd/ti,davinci-nand.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/ti,davinci-nand.example.dtb: nand_cs3@62000000: ti,davinci-ecc-bits: 4 is not of type 'array'
	from schema $id: http://devicetree.org/schemas/property-units.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241002-ondie-v2-2-318156d8c7b4@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


