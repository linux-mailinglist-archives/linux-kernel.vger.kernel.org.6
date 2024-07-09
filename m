Return-Path: <linux-kernel+bounces-246699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AFEB92C544
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 23:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BCC21C21E79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 21:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35F418786B;
	Tue,  9 Jul 2024 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1fgBk9l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECD9187852;
	Tue,  9 Jul 2024 21:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720560143; cv=none; b=gBZtKntrfH7G28RqK43R7CsRnt6qoOzukqEiXGHdvkjP5XkmfhwkqAwyzdPnpv667v8fcreGVXbroZAiRIlFfoDV4nPNGEhg6705i6ZO8O0icdApUvgRWpcewfIzHRvynjXrtB5fDIoq0M/IMk2h+XCmWt6mQfI085JgQB52W+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720560143; c=relaxed/simple;
	bh=PBSqaIbfp0Htue5RbLXrgCqKnH8wnNGynK9hnMexWRE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=F5bnPKRZGNb2OQ7/n9AsNXc3P0/CBPZNesDXiWtGqEZlnR3FRq1BxVY09cXXEEUP505Qx2vPdZwAvIPM8+XkJIodjLi0vKxOHLTPptknZTaFjbZdE1tfDBtZ2AQJlr13fqK5CAjy+M49FwZLCih8gNeNlImtvFZBxUAXaBKsyY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1fgBk9l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF332C4AF0B;
	Tue,  9 Jul 2024 21:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720560142;
	bh=PBSqaIbfp0Htue5RbLXrgCqKnH8wnNGynK9hnMexWRE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=F1fgBk9ldH/2Z+INmq6me9LfLS2IPWylQzzywzEusildr2LW6Li3l2sMqzFtZ/U7X
	 6NSM4GFI+W4Y+XFal97cQTifRDSludzWpKnU0F6MuwLIdH/0U5ebB/yo60B8tIjFNe
	 3EvgjK82VYK7SpcSMCKLy9RYVw/aXU/5sUHDG3QQym24tbVu13g/upa2386i/1rTCk
	 bTtWZELqLivrvzH2saaVBGgMwWiHhK77ymj10AGAIZiKyqQuZAseVanRjKpK5qF+pD
	 omN45FRjnbCbwQD8f6sgxZ7J/NGuFZrBQygJKjJiAifF0rIZq8th0zZblbZ4AgsLQS
	 CPZHWOujA8oSQ==
Date: Tue, 09 Jul 2024 15:22:20 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: Takashi Iwai <tiwai@suse.com>, kernel@salutedevices.com, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org, 
 prusovigor@gmail.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Philipp Zabel <p.zabel@pengutronix.de>, Mark Brown <broonie@kernel.org>
In-Reply-To: <20240709172834.9785-6-ivprusov@salutedevices.com>
References: <20240709172834.9785-1-ivprusov@salutedevices.com>
 <20240709172834.9785-6-ivprusov@salutedevices.com>
Message-Id: <172056013918.1151267.15277149998657038582.robh@kernel.org>
Subject: Re: [PATCH 5/6] ASoC: dt-bindings: Add bindings for NeoFidelity
 NTP8835


On Tue, 09 Jul 2024 20:28:33 +0300, Igor Prusov wrote:
> Add dt-bindings for NeoFidelity NTP8835C/NTP8835C Amplifiers
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>  .../bindings/sound/neofidelity,ntp8835.yaml   | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/neofidelity,ntp8835.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/neofidelity,ntp8835.yaml: properties:reg: 'enum' should not be valid under {'enum': ['const', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'minimum', 'maximum', 'multipleOf', 'pattern']}
	hint: Scalar and array keywords cannot be mixed
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/neofidelity,ntp8835.yaml: properties:reg: 'anyOf' conditional failed, one must be fixed:
	'enum' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('enum' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	1 is less than the minimum of 2
		hint: Arrays must be described with a combination of minItems/maxItems/items
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/neofidelity,ntp8835.example.dtb: ntp8835@56: reg:0:0: 86 is not one of [42, 43, 44, 45]
	from schema $id: http://devicetree.org/schemas/sound/neofidelity,ntp8835.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/neofidelity,ntp8835.example.dtb: ntp8835@56: Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/neofidelity,ntp8835.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240709172834.9785-6-ivprusov@salutedevices.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


