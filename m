Return-Path: <linux-kernel+bounces-445366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B539F1518
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4DB4188D8E7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE8361E766F;
	Fri, 13 Dec 2024 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWE2nNfr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399281DA5F;
	Fri, 13 Dec 2024 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734115299; cv=none; b=jb9vqSHzftA3rfGIiek0UdiNy42VRrruoC19GTfhRTGDtJZMeH42iQB6YpknVoHqwq0+WTSBulze5sxO0uqljO8nGqwHbK75Nu+4DoPbM9TSZVFPHUWbDL1BioUjsKn3AKkcruf4IkCVFQ4BKCY0RRmmJJgHnrRuENDTUJBrf50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734115299; c=relaxed/simple;
	bh=wRJ8qQ3xQiXWSxtvdm/koVUzsw5TiG3iOKY3mVRPgFs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=b+M5AU5QVCVsLixXa3KQsg2jLf58AY8hKAEHpDQ3Mp6TRGOKboA4JYjNlffv8NO3FG4Hz6mlKdzWY0C6puo0cMYGLYDEwl7dUSsxwLLXuBXYf/MLaQniO/Uckjw6TChMAJ7K6Kl5N5dkK13ESoJTfQKRuaak19d29qQWpKgIFNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWE2nNfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D52EC4CED0;
	Fri, 13 Dec 2024 18:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734115298;
	bh=wRJ8qQ3xQiXWSxtvdm/koVUzsw5TiG3iOKY3mVRPgFs=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=DWE2nNfrOnlUnhlWqxHJeCxU68euwj0EXuwvkTNLuH+afbFiiUY7jSr9E6fvT1jBa
	 KXyBoW4PRiXtmz9p7SGjssY92LGFH12WHJO0UF3elHKkgyLy6ubgvmCE6y0NoSfMZr
	 FQoGI/ZRYfLIVZCsvTnG98xZ+tuMxVMNKDSzQA5asW1HJcEFAtfSRcjT8htb0PKjoR
	 jYKik/pKvw17hGSxSG0pqUjjhpr5aqyoNTqEzPPtfPnmLLnvSf11318naxa1ZVbeTs
	 RiwPE9l++GnmXHrEUzm1n1wbXj+5rnUf5sjwkKRNYvTXQvHHyPddMC4kztEtGJHaPr
	 a199Ef3Tska4A==
Date: Fri, 13 Dec 2024 12:41:36 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sudeep Holla <sudeep.holla@arm.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
In-Reply-To: <20241213165240.3652961-2-vincenzo.frascino@arm.com>
References: <20241213165240.3652961-1-vincenzo.frascino@arm.com>
 <20241213165240.3652961-2-vincenzo.frascino@arm.com>
Message-Id: <173411529511.1995180.15087547116526411560.robh@kernel.org>
Subject: Re: [PATCH 1/3] xlnx: dt-bindings: xlnx,i2s: Convert to
 json-schema


On Fri, 13 Dec 2024 16:52:38 +0000, Vincenzo Frascino wrote:
> Convert the Xilinx I2S device tree binding documentation to json-schema.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  .../devicetree/bindings/sound/xlnx,i2s.txt    | 28 -------
>  .../devicetree/bindings/sound/xlnx,i2s.yaml   | 79 +++++++++++++++++++
>  2 files changed, 79 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml: properties:xlnx,num-channels: 'minimum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml: properties:xlnx,num-channels: 'maximum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml: properties:xlnx,num-channels:maxItems: False schema does not allow 1
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml: properties:compatible:oneOf: [{'const': 'xlnx,i2s-receiver-1.0'}, {'const': 'xlnx,i2s-transmitter-1.0'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml: properties:xlnx,dwidth:oneOf: [{'const': 16}, {'const': 24}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml: properties:xlnx,dwidth:maxItems: False schema does not allow 1
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml: title: 'Device-Tree bindings for Xilinx I2S PL block' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml: properties:#address-cells: 'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,i2s.yaml: properties:#size-cells: 'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,i2s.example.dtb: i2s_receiver@a0080000: reg: [[0, 2684878848], [0, 65536]] is too long
	from schema $id: http://devicetree.org/schemas/sound/xlnx,i2s.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/xlnx,i2s.example.dtb: i2s_transmitter@a0090000: reg: [[0, 2684944384], [0, 65536]] is too long
	from schema $id: http://devicetree.org/schemas/sound/xlnx,i2s.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241213165240.3652961-2-vincenzo.frascino@arm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


