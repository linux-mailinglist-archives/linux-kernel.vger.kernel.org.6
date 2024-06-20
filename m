Return-Path: <linux-kernel+bounces-221975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 725E590FB48
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 04:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479BF1C211AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631A01CAA4;
	Thu, 20 Jun 2024 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBAvG/lQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D5218026;
	Thu, 20 Jun 2024 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718850166; cv=none; b=FQzPiH0ADvW6vxG65T8r1pazDkGsP7F0USPxsitxxTXQkqBB+58EXpGvwzFPbS2BkJivnvViXBi5gXgpTuXsO9PTk0etQaiZ4qw1n95KLD7yLpUxkQRWbs0K0+0COqBbeKlVQfuWbbrEaaUPAya4f14UdKM7XpaH+hYtsXGeAZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718850166; c=relaxed/simple;
	bh=Q38MQiU2rWYYF3F0MXA0cp2jliQrue18RoNP0xmEKfE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=RDaKn3rC0h1FKDDPYnMIUd+KL1nFVBvvmjiFVchClAwvtmDoPOzgmHfAiYxsUr0ia17qIJjkoiezhtYQF/WU+HD6zn8OOmYKEnmHZ5a8Ruz4+DoduX6EOTVuwVRzZ75Vtg7Si9m5vBZKSOvMeVUSyj4Z16PEMjC0Y8sxFRRGMEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBAvG/lQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45C4C2BBFC;
	Thu, 20 Jun 2024 02:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718850165;
	bh=Q38MQiU2rWYYF3F0MXA0cp2jliQrue18RoNP0xmEKfE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=UBAvG/lQRPmV4qFplzjrJDm0sByfB/q0Yi6rdDImVvtiYZly5qfl1q4NJh6tsCjSi
	 cijv11OQxE48mDamtp+RhaHpcD5kDYhkinyBdD489O3EkXtiRBqhWFZxkgxLe4PnY2
	 NV9LIICvhbY2uWVlJKRjIF7tcbZRgcmCK02NznMKKJH8OCHnafZy6eDe7Vd3sVZppt
	 fx4oNhdDxEK1OE/reXNYhIbRyHsQt9jI623RUjRShsyI4IuzapAbqbjV9wGuZtwIgA
	 OyL6EhTWXxqSamNv+ctOBG08l6ihy5DhiLqijG2A+Z3sZ2i5hTuYSVGEBxXaGBUn3W
	 DZRd6QG6t9DbQ==
Date: Wed, 19 Jun 2024 20:22:44 -0600
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mark Watson <markus.c.watson@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, krzk+dt@kernel.org
In-Reply-To: <ZnOAgM+zacF6u1x7@laptop>
References: <ZnOAgM+zacF6u1x7@laptop>
Message-Id: <171885016475.4084173.17387665152208712740.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: misc: axi-fifo: Add binding for
 AXI-Stream FIFO


On Wed, 19 Jun 2024 22:06:08 -0300, Mark Watson wrote:
> This resolves a checkpatch warning in drivers/staging/axis-fifo
> regarding a missing devie-tree binding. The full warning is included
> below.
> 
> WARNING: DT compatible string "xlnx,axi-fifo-mm-s-4.1" appears
> un-documented -- check ./Documentation/devicetree/bindings/
> +       { .compatible = "xlnx,axi-fifo-mm-s-4.1", },
> 
> Signed-off-by: Mark Watson <markus.c.watson@gmail.com>
> ---
>  .../bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml | 214 ++++++++++++++++++
>  1 file changed, 214 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:interrupt-parent: False schema does not allow {'$ref': '/schemas/types.yaml#/definitions/phandle'}
	from schema $id: http://devicetree.org/meta-schemas/interrupts.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,rx-fifo-pe-threshold: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/uint32' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,tx-fifo-depth: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/uint32' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,rx-min-pkt-size: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/uint32' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,tx-fifo-pf-threshold: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/uint32' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,axis-tdest-width: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/uint32' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,rx-fifo-pf-threshold: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/uint32' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,axis-tuser-width: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/uint32' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,tx-max-pkt-size: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/uint32' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,rx-fifo-depth: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/uint32' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,tx-fifo-pe-threshold: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/uint32' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,axis-tid-width: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/uint32' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,axi-str-rxd-tdata-width: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,axi-str-txc-tdata-width: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,axi-str-txd-tdata-width: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,data-interface-type: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,has-axis-tdest: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,has-axis-tid: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,has-axis-tkeep: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,has-axis-tstrb: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,has-axis-tuser: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,s-axi-id-width: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,s-axi4-data-width: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,select-xpm: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,use-rx-cut-through: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,use-rx-data: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,use-tx-ctrl: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,use-tx-cut-through: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: xlnx,use-tx-data: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.example.dtb: axi_fifo_mm_s@43c00000: xlnx,use-rx-data:0:0: 1 was expected
	from schema $id: http://devicetree.org/schemas/misc/xlnx,axi-fifo-mm-s-4.1.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.example.dtb: axi_fifo_mm_s@43c00000: 'interrupt-parent' is a required property
	from schema $id: http://devicetree.org/schemas/misc/xlnx,axi-fifo-mm-s-4.1.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ZnOAgM+zacF6u1x7@laptop

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


