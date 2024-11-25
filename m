Return-Path: <linux-kernel+bounces-421197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255E39D87D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1DB1163FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9341AF0C0;
	Mon, 25 Nov 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="cNdY7SNX"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904E1EAF6;
	Mon, 25 Nov 2024 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544649; cv=none; b=jQwn37uxR1bW1VrEFKMzsZ2vYdDii0W4ZdoE7A0XK/DxMNINz9tJCBtOAKpowPtVp9CREMGZGbyzIRGJmTbsMHpS3o5PkWf+AZ5BdBXv6NeDNx0c+D0MZ7oc+HnLOp6bti9wsvr7FG2Qbqqf1FqCLBCDkmxLg2MyUjAOrSCgQ+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544649; c=relaxed/simple;
	bh=u2XUWhrR6ss2d9FlTj8Plfh2W/SE71nSefpQ0lgJHkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tn1s/gC4abmAfOXTxV8M7//v+SKi5LRdIrmqRQT1ZMWEP9gHsAfH8I3CjZTE11ave1hLNJozMJjt3bNju+JeFYh2yop4dby4vJnc7yI9GZ+uqeoQQ0X3Tp6Kepu60RsEH9cmKP2pNXvfwz3ODkPrRv1WvHEcsIeHmvltfKryySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=cNdY7SNX; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 21AA341DF4;
	Mon, 25 Nov 2024 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1732544094; bh=u2XUWhrR6ss2d9FlTj8Plfh2W/SE71nSefpQ0lgJHkQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cNdY7SNXxqheP/0KddCcPuwen1NKykhMWb6bNamgVZXyM3ezVRM0HUdEY6L69M4CG
	 /fJLMTvwVaUN//eLm2uXZJNQmIMbseOLk3Dk4P/EufLqPJdbZGnnniwrauJMV6Bb06
	 SwXy0JLKwwnMfNSm3NowFr1Ywo/6TFks+sJ2VUREv3HnLhHI1EjN2p9/ab0hzDoUfx
	 QghpKyWji6vfozrrnNHuM4gEZMSIFY4SAutMDXW3MB2W83onm+tslqNsgDLE1QCcyn
	 ScCODCDPzEVRt0FZLpOx1dnsJ2D0KTT7YNlr9k1D9IHIYj7+Mw+W1Bc7j1+AHbY+4Y
	 tWD9FLrZ82LBg==
Message-ID: <a9d1568e-6240-49a4-b6a0-dcc0d9229eb1@marcan.st>
Date: Mon, 25 Nov 2024 23:14:51 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindgins: display: Add Apple pre-DCP display
 controller bindings
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: Sven Peter <sven@svenpeter.dev>, Alyssa Rosenzweig
 <alyssa@rosenzweig.io>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241124-adpdrm-v1-0-3191d8e6e49a@gmail.com>
 <20241124-adpdrm-v1-1-3191d8e6e49a@gmail.com>
 <ksdp54qj55v7igvvcshl6y2cxpmqy7rlsh4xsixpptjn7s7wlu@76ejtq6ytvbp>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <ksdp54qj55v7igvvcshl6y2cxpmqy7rlsh4xsixpptjn7s7wlu@76ejtq6ytvbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/11/25 16:45, Krzysztof Kozlowski wrote:
> On Sun, Nov 24, 2024 at 11:29:24PM +0100, Sasha Finkelstein wrote:
>> Add bindings for a secondary display controller present on certain
>> Apple laptops.
>>
>> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
>> ---
>>  .../bindings/display/apple,display-pipe.yaml       | 59 ++++++++++++++++++++++
>>  .../bindings/display/panel/apple,summit.yaml       | 24 +++++++++
>>  2 files changed, 83 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/apple,display-pipe.yaml b/Documentation/devicetree/bindings/display/apple,display-pipe.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..bd25ddc6e09dd636c0221c854e594113f6011866
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/apple,display-pipe.yaml
> 
> No, use fallback compatible as filename.
> 
>> @@ -0,0 +1,59 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/apple,display-pipe.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Apple pre-DCP display controller.
>> +
>> +maintainers:
>> +  - asahi@lists.linux.dev
>> +  - Sasha Finkelstein <fnkl.kernel@gmail.com>
>> +
>> +description: |
> 
> Drop |
> 
>> +  A secondary display controller used to drive the "touchbar" on certain
>> +  Apple laptops.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +        - "apple,t8112-display-pipe"
>> +        - "apple,t8103-display-pipe"
>> +      - const: "apple,h7-display-pipe"
> 
> 
> This wasn't tested... Drop all quotes. Do you see any file with quotes?
> Why doing things entirely different than everyone else?
> 
>> +
>> +  reg:
>> +    minItems: 3
> 
> Drop
> 
>> +    maxItems: 3
>> +
>> +  reg-names:
>> +    items:
>> +      - const: be
>> +      - const: fe
>> +      - const: mipi
>> +
>> +  power-domains: true
> 
> List the items instead or maxItems: 1.
> 
>> +
>> +  interrupts:
>> +    minItems: 2
> 
> Drop
> 
>> +    maxItems: 2
>> +
>> +  interrupt-names:
>> +    items:
>> +      - const: be
>> +      - const: fe
>> +
>> +  iommus: true
> 
> 
> maxItems: 1
> 
>> +
>> +  "#address-cells":
>> +    const: 1
>> +
>> +  "#size-cells":
>> +    const: 0
>> +
>> +additionalProperties: true
> 
> This cannot be true. Must be false.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
> 
> This goes before additionalProperties.
> 
> Missing example: that's a strong NAK and prove that this could not be
> even tested.
> 
> Do you see any device schema without example? No. Do not develop things
> differently, Apple is not unique, special or exceptional.

Krzysztof, it is entirely possible to express this same feedback without
being condescending and rude. I'm pretty sure you can do better than this.

> 
> 
>> diff --git a/Documentation/devicetree/bindings/display/panel/apple,summit.yaml b/Documentation/devicetree/bindings/display/panel/apple,summit.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..dc281c1f52c1ed07cc2f7f804dcfd2f3b4239d89
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/apple,summit.yaml
>> @@ -0,0 +1,24 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/apple,summit.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Apple "Summit" display panel.
>> +
>> +maintainers:
>> +  - asahi@lists.linux.dev
>> +  - Sasha Finkelstein <fnkl.kernel@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: apple,summit
> 
> No, too generic. Panels need much more properties, this is heavily
> incomplete. See other panel bindings.
> 
> Best regards,
> Krzysztof
> 
> 
> 

- Hector


