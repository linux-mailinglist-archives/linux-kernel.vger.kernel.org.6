Return-Path: <linux-kernel+bounces-519575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386A3A39E40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C243A99F9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73137269883;
	Tue, 18 Feb 2025 14:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGpBOpE4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF5512E5B;
	Tue, 18 Feb 2025 14:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887416; cv=none; b=Hn17t7/7uNWAf8CGLGq78vSArUxIkV8AEyPXaXLXqJumM9CJ+lHU9XgdTu0IhlduwvfqSFWOX2cJ41PbZ0DKDopaWuSyaANJUvxw415GsrSJE3+9jl0vn5Nm8PqCeAIetDgqAlsPdStV94wxwaEPpe+ohQe6KjFEb6iCql1Efeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887416; c=relaxed/simple;
	bh=7g3Ss5mFEPQ/MC/G4bdVTlWPBOqJj0JwqqcGScdjGVk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=CvO0iwWmGFUUu0Ya0encESJR9YGcPdEWBIKgumh6F6jE5UKHClehbncOFi+q9GLgPadTHs9XHlDXf5dPnZ3ZNTTo1pdpRhPrdLq1gbflr1PFSuqNlm4w6Eb8NYZoTHeQAqZx7N9rGP571Od6/2Y2iAMwRC+IqOvRfgzc2t8+nSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGpBOpE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FF3C4CEE2;
	Tue, 18 Feb 2025 14:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739887416;
	bh=7g3Ss5mFEPQ/MC/G4bdVTlWPBOqJj0JwqqcGScdjGVk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=eGpBOpE4cwSraM7JXq4doESHEtvNYMnDOhYjPZk574Nfq5SK1a++F9XEnMMO8sml6
	 t54PQi6RY4SvbFoz6k9NdZIDY6zmAzLzdXnOSD1+LLeKx/QryvnaLsXz3lzGC8WoYC
	 A35Lo2tKwUrk58fKixIAz/Jz2DYtlRQtFBd0fQ9MLUae/r+OTAo6m0AhbZgJMFTJdV
	 zDbU5T7aVcXods/MN8ApjchCKVqg72w69dKX77S/aRzOsbpXMvp6pO3k2jggxwtK5G
	 GE3y3kURi7LYfRiL7QDQj16Iy4pD4GrRlDHfbYA7zJAV1pEIWWAsoOU1XZkaG5Hx1X
	 b8r6Hyk/sxYpA==
Date: Tue, 18 Feb 2025 08:03:34 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Inochi Amaoto <inochiama@gmail.com>, sophgo@lists.linux.dev, 
 devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 linux-kernel@vger.kernel.org, Chen Wang <unicorn_wang@outlook.com>, 
 Conor Dooley <conor+dt@kernel.org>
To: Alexander Sverdlin <alexander.sverdlin@gmail.com>
In-Reply-To: <20250216180924.2506416-1-alexander.sverdlin@gmail.com>
References: <20250216180924.2506416-1-alexander.sverdlin@gmail.com>
Message-Id: <173988741497.6115.7372535970415942115.robh@kernel.org>
Subject: Re: [PATCH RFC] dt-bindings: rtc: sophgo: add RTC support for
 Sophgo CV1800 series SoC


On Sun, 16 Feb 2025 19:09:09 +0100, Alexander Sverdlin wrote:
> Add RTCSYS devicetree binding for Sophgo CV1800 SoC.
> 
> The RTC (Real Time Clock) is an independently powered module in the chip.
> It contains a 32KHz oscillator and a Power-On-Reset (POR) sub-module, which
> can be used for time display and scheduled alarm produce. In addition, the
> hardware state machine provides triggering and timing control for chip
> power-on, power-off and reset.
> 
> Furthermore, the 8051 subsystem is located within RTCSYS and is
> independently powered. System software can use the 8051 to manage wake
> conditions and wake the system while the system is asleep, and communicate
> with external devices through peripheral controllers.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---
> QUESTION:
> 
> I'm unsure about reg properties in the subnodes (child devices) of
> RTCSYS:
> - they will not be used anyway by the drivers because they genuinely
> overlap (the whole point of going MFD) -- therefore the drivers will do
> syscon_node_to_regmap(pdev->dev.parent->of_node)
> - as I understood from the history of MFD dt bindings' submissions, regs
> are encouraged, if can be specified
> - overlapping regs cause dt_binding_check warnings:
> Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:34.19-39.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/mcu@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/pmu@0)
> Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:34.19-39.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/mcu@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/rtc@0)
> 
> Shall I remove the MMIO resources from the actual devices or rather ignore the warnings?
> 
>  .../bindings/mfd/sophgo,cv1800b-rtcsys.yaml   | 222 ++++++++++++++++++
>  1 file changed, 222 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.yaml: patternProperties:^mcu@[0-9a-f]+$:properties:sram:maxItems: False schema does not allow 1
	hint: Scalar properties should not have array keywords
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:34.19-39.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/mcu@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/pmu@0)
Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:34.19-39.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/mcu@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/rtc@0)
Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:41.19-47.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/pmu@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/rtc@0)
Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:34.19-39.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/mcu@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/sram@0)
Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:41.19-47.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/pmu@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/sram@0)
Documentation/devicetree/bindings/mfd/sophgo,cv1800b-rtcsys.example.dts:49.19-55.15: Warning (unique_unit_address_if_enabled): /example-0/rtcsys@5025000/rtc@0: duplicate unit-address (also used in node /example-0/rtcsys@5025000/sram@0)

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250216180924.2506416-1-alexander.sverdlin@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


