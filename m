Return-Path: <linux-kernel+bounces-181915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D580D8C8338
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB1C2827E0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 09:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2327B2137E;
	Fri, 17 May 2024 09:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyxVw8NN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA97288A4;
	Fri, 17 May 2024 09:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715937846; cv=none; b=WtERtnJRTBtfYw+eH7AoNWBEtpAu9mc9qNrJdOhQg0SabFs9F13NPh7QnxkbhIr8Xc/1xNNWs3GcKZv3Vh0PDOOaRnvBMVI36/JsLvSwLH6ytBa00fGcXHer1SDJ1ArRqRoR7xUz3lWiA6KHBo8tHQAcPY2yE7hshv1RSZUf1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715937846; c=relaxed/simple;
	bh=xGw3hcqvQocrPtmT5TUi1j5xDED+1T1ee3PN48GUQEs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=bZGn+Yp/nhfrv8SSIuaA1ilNuomcrfVUsrepwr3p5Wbmbja4Fe/hAep7ZLrziZp8WMhCIsnLQJcxMneEDXnHyKY2wc6aG9V9+CT8NtY/Le7rkF9fdOmlPAXgvJYUTNriaGQqb/JH2PjVIDg5U0HC14PLLEGj2xb1Mhwh9TiXbHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyxVw8NN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40D2C2BD10;
	Fri, 17 May 2024 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715937846;
	bh=xGw3hcqvQocrPtmT5TUi1j5xDED+1T1ee3PN48GUQEs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=RyxVw8NNt5Z9Urq6VLHDet3i1YsA6suJDNIsPxRlWlgvAmQYowBnoz/+0tcrvGGLx
	 2uHP9axO3z8oATbJiD/Lx8lVRgT044Z+XfZ8hoFkDz7WCeXjaA2Te6PCf7WvSlU6fN
	 /b8BQgdou+IOatGDjeCAVAEgYTHZmMYCn0SvViRD9dU4MgO3l2K/qtp0wCsNOM4rgF
	 5zmm76TYu2GyaB4jq1nFA5yzUfE9qjZl56m+7r3gG10Bhf5ksifuSkv03NRuie82Tk
	 cyoXjicup6HNbboIjU/Q6IBAoC48xdtMjDEhKc4gxh5nUMMkUaK42V6B+qxwDco4YU
	 AlIa02z9VHF0A==
Date: Fri, 17 May 2024 04:24:04 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mighty <bavishimithil@gmail.com>
Cc: linux-sound@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Lopez Cruz <misael.lopez@ti.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Mark Brown <broonie@kernel.org>
In-Reply-To: <20240517083644.3920-1-bavishimithil@gmail.com>
References: <20240517083644.3920-1-bavishimithil@gmail.com>
Message-Id: <171593784468.974781.7311451940963803133.robh@kernel.org>
Subject: Re: [PATCH v4] ASoC: dt-bindings: omap-mcpdm: Convert to DT schema


On Fri, 17 May 2024 14:06:44 +0530, Mighty wrote:
> From: Mithil Bavishi <bavishimithil@gmail.com>
> 
> Convert the OMAP4+ McPDM bindings to DT schema.
> 
> Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
> ---
> Changelog v4:
> - Changed maintainer name
> - Use $ref and enum in ti-hwmods property
> - Make clocks property only have maxItems, no description
> - Add items to clock-names
> - Fix address of node in example
> - Remove extra line
> 
>  .../devicetree/bindings/sound/omap-mcpdm.txt  | 30 ----------
>  .../bindings/sound/ti,omap4-mcpdm.yaml        | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 30 deletions(-)
>  delete mode 100644
> Documentation/devicetree/bindings/sound/omap-mcpdm.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.yaml: properties:ti,hwmods: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'/schemas/types.yaml#/definitions/string' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
Error: Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.example.dts:28.25-26 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:427: Documentation/devicetree/bindings/sound/ti,omap4-mcpdm.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240517083644.3920-1-bavishimithil@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


