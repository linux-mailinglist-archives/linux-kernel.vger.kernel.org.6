Return-Path: <linux-kernel+bounces-243362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E66FB92953B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 23:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D63F01C20B04
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 21:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354F62AD39;
	Sat,  6 Jul 2024 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB8GNJOs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184EB1CD13;
	Sat,  6 Jul 2024 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720300347; cv=none; b=FlhRclgdPdWRP/Cqd/+L8M4A7ivwpCF6ZulTh5h7ChJNwHndUbopz+NHREkWo/dDKTApWiGbqlgeq20Bm/hsXcFo5GSvJx1c/W0uY2FI9oUjQG9xlm/kbx32WePuaKK8AWQSxuutJkjM480ArHkV6PIc44fTD55gvq2LSxnC7Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720300347; c=relaxed/simple;
	bh=nJNFookH7BOLgSmzU5vUHiCpMqpfXwBi8e5XFCkRAAI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=IKZmaeRUDcwhawHOVAoDFpxRMz7/JE/hoSjfzwG42EoIOlFaUTPsPu6fCXaOp77rziTygbpRsMbWdk3X8M/F7CYFhO0L8UNh68KdkAS4164IydI1nZESXGJDBRkDkwqcNMVs2HcjVEeTAFN5ObXJsGkBME2NbCWXnreyCfUDrok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB8GNJOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F27C2BD10;
	Sat,  6 Jul 2024 21:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720300346;
	bh=nJNFookH7BOLgSmzU5vUHiCpMqpfXwBi8e5XFCkRAAI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=lB8GNJOsB+fzmHXJ3J5F2XVWshm4+q5LVbyVHrUBv9+8AgwwybYbFRsHp8eWukAm5
	 /bnZncL8sPdJ4+RzyAciX/y4EgUoNr1m6KGtW3G/HWyCoJNc6yK7NZ1jxecnpM0g0C
	 PJH89ZQK58h/4Vbh8uohhgKwNk6GrFsKD75o8Zi3+trHVcCxStS7aVWeAGNS93CSzj
	 Cqr5bTFGLD4+YSyAj7WohalwOBPBI+GZxCBnAEtsHLekrUWughhp/36hJctJ/F1ZC8
	 kOAfvxxtpK4Di/HNCbfSZV8AjvlAiLn0AldxvLB/9nXBjzftHjm/ji6GddcSDSZh8G
	 ODs2r8s+ryndQ==
Date: Sat, 06 Jul 2024 15:12:25 -0600
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
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 conor+dt@kernel.org, krzk+dt@kernel.org
In-Reply-To: <ZomhRSs3Y/EQKXNa@laptop>
References: <ZomhRSs3Y/EQKXNa@laptop>
Message-Id: <172030034555.3339698.1374802054532903085.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: misc: axi-fifo: Add dt documentation for
 xilinx axi-fifo


On Sat, 06 Jul 2024 16:55:49 -0300, Mark Watson wrote:
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,axis-tid-width: 'anyOf' conditional failed, one must be fixed:
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,axis-tuser-width: 'anyOf' conditional failed, one must be fixed:
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,rx-min-pkt-size: 'anyOf' conditional failed, one must be fixed:
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
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,tx-fifo-pe-threshold: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/uint32' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/xlnx,axi-fifo-mm-s-4.1.yaml: properties:xlnx,rx-fifo-pe-threshold: 'anyOf' conditional failed, one must be fixed:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ZomhRSs3Y/EQKXNa@laptop

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


