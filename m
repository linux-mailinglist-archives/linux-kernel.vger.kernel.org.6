Return-Path: <linux-kernel+bounces-263675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E7193D8F7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 21:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D342826A4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 19:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046EE57CBE;
	Fri, 26 Jul 2024 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8AXu5MN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162C38DEE;
	Fri, 26 Jul 2024 19:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021973; cv=none; b=OguYdvpW2oK5j4QV3WTW14Coy7yOIHI6byNqJ/7+WprIJxNSwuLROZR61QonOo7Awc3RUA+G/Gx8abNVJ8DfEhiJxoDrb0MF9V6Ju4QbaVs08t0MeSS1bCTs4B4K7HRvxcenhrVXML3lITBn41+qRo4vkY4rnlgYMbN1LZg8jpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021973; c=relaxed/simple;
	bh=SZJMrHcMmqY2SUiUlSu9xKKZdsDzO+qcgAmMeSpsinw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=agZ0eKBK6lIBALzSFwN3+9NcytpLS1Gz4IJAdEZedmGxmI2NTziyp37qRK6kQKYFUJQYHey4/Nz6chfCuQnH7UJLBWf9/7A9XxzH9W7fUqqjyBS4rCXzv21q6eZzfCE/euBWzWJjqKlqwliczEPZeyoiarYut4DMD1FyAXOHmSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8AXu5MN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D05C32782;
	Fri, 26 Jul 2024 19:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722021972;
	bh=SZJMrHcMmqY2SUiUlSu9xKKZdsDzO+qcgAmMeSpsinw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=c8AXu5MNC75ERaiY1fEY91nAurQ58HgHjnshtPI2p8GJGT13Vvug7HJSJYUG7ZVNS
	 /IsUpJPDeqUiHLkg3szrD116IEFTA8gaeKGCd5WlnaVr7c71rptiSpfwQjk+KgE5CB
	 SwSLpRYD8CfskDKa/RGwCLrLC06mdEyzaszEZWA5259G0u5gw8b9FX3uxj39SvVYH3
	 Foxaz1sff2sXC+P8jpVgTUiJVOpFSkqp/sg/yMdGRfNfSKsNHPRNAL/X/Bsog5vrOP
	 Lrqt3RF7vLAexmvBdCyXPyspp2FaF4J/fgjUoQggk0oxiCg7IrcroWjGXkKkdeoX4N
	 xe8TZu1n+wHBw==
Date: Fri, 26 Jul 2024 14:26:11 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Kevin Hilman <khilman@kernel.org>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 devicetree@vger.kernel.org, Tero Kristo <kristo@kernel.org>, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Pawel Laszczak <pawell@cadence.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Roger Quadros <rogerq@kernel.org>, Peter Chen <peter.chen@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240726-s2r-cdns-v5-2-8664bfb032ac@bootlin.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <20240726-s2r-cdns-v5-2-8664bfb032ac@bootlin.com>
Message-Id: <172202197161.1924212.4114467370508864411.robh@kernel.org>
Subject: Re: [PATCH v5 02/12] dt-bindings: usb: ti,j721e-usb: add
 ti,j7200-usb compatible


On Fri, 26 Jul 2024 20:17:50 +0200, Théo Lebrun wrote:
> On J7200, the controller & its wrapper are reset on resume. It has the
> same behavior as ti,j721e-usb with a different SoC integration.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml: properties:compatible:oneOf:1:items: 'oneOf' conditional failed, one must be fixed:
	[{'enum': [{'const': 'ti,am64-usb'}, {'const': 'ti,j7200-usb'}]}, {'const': 'ti,j721e-usb'}] is not of type 'object'
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml: properties:compatible:oneOf:1:items:0:enum: 'oneOf' conditional failed, one must be fixed:
		{'const': 'ti,am64-usb'} is not of type 'integer'
		{'const': 'ti,am64-usb'} is not of type 'string'
		{'const': 'ti,j7200-usb'} is not of type 'integer'
		{'const': 'ti,j7200-usb'} is not of type 'string'
		hint: "enum" must be an array of either integers or strings
		from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml: properties:compatible:oneOf:1:items: 'oneOf' conditional failed, one must be fixed:
	[{'enum': [{'const': 'ti,am64-usb'}, {'const': 'ti,j7200-usb'}]}, {'const': 'ti,j721e-usb'}] is not of type 'object'
	{'const': 'ti,am64-usb'} is not of type 'string'
	{'const': 'ti,j7200-usb'} is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240726-s2r-cdns-v5-2-8664bfb032ac@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


