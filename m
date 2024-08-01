Return-Path: <linux-kernel+bounces-271010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ADA94484F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A743C1F26FC5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3EA16FF26;
	Thu,  1 Aug 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yBiRkp4J"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC115884A;
	Thu,  1 Aug 2024 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722504598; cv=none; b=fhHA1U3UxCDngTNFdQh+o/AQnML5WKWhr3sz+cvgJZWl4R9lhTCckjdDRy0t7iy/2e2WH7OnM9IdHY5R5LTy/ugA1eRcasjxmeWlNXVw3XMlYuzlgNYnJ3wujWU5GoYmBSsu/ngy3TVs9oZGmfRldcKrA7iS03TodVGTkFd1E1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722504598; c=relaxed/simple;
	bh=0VScPE/3zoud5ZD9VHOgJa0/AEOuXX/NwbQRuIpUShQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFx/bTfPUmNtOn3CY+H1xuYMMjT/sHI2V4PuQcOM/fmwlZoXzVzNj1SN0QkCUeqKAj2+UHu44NvI8ku7k0ojCnCyYvbT+h51Pg0YybIeaPp20Z8Rveqd7aRgCvo3lsOqbhEHbsu/wOE2nHJ9l/LhDN4sLu5E1yjCxpeJYiP01b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yBiRkp4J; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722504594;
	bh=0VScPE/3zoud5ZD9VHOgJa0/AEOuXX/NwbQRuIpUShQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=yBiRkp4JNCkn4lnDZXQ5wg3WsFUWvDXpdrk00+0wMHLoSAiMBhjAj4L+B0jd6sSln
	 pnI8VbY4vIMPefaQIbWLVNJhXarPsmKMeHjrQNllgla1XDbKioaFFVptByrhknj+fS
	 46qn7C1jv4xzJVQXWM2gA7QGryBbunUCS5u6VSZuiJ7J+9mwNkqhH5FTi0p4xnxd2g
	 JWYXHugwUft3fMvak6CuIDNRlp6FsS/lIcWcTdp6FpqL0HQJDKQ5dPj4RBw+kn8dHC
	 NSUizEfWf6FSEKwwla3ft2TnNc96BBBYbusaRUoLxdz/BC8Y59LXYdNttVnsCd7/BP
	 BrpBZq9IBNOTA==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1711A3781144;
	Thu,  1 Aug 2024 09:29:53 +0000 (UTC)
Message-ID: <e3ce055d-13c9-4e25-a039-dd4a58c8dd7a@collabora.com>
Date: Thu, 1 Aug 2024 12:29:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: display: bridge: Add schema for Synopsys
 DW HDMI QP TX IP
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Alexandre ARNOUD <aarnoud@me.com>,
 Luis de Arquer <ldearquer@gmail.com>
References: <20240801-dw-hdmi-qp-tx-v1-0-148f542de5fd@collabora.com>
 <20240801-dw-hdmi-qp-tx-v1-1-148f542de5fd@collabora.com>
 <ba957155-7a0d-4c88-8326-a1d4d20e4656@kernel.org>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <ba957155-7a0d-4c88-8326-a1d4d20e4656@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/24 11:38 AM, Krzysztof Kozlowski wrote:> On 01/08/2024 04:05, Cristian Ciocaltea wrote:
>> Add dt-binding schema containing the common properties for the Synopsys
>> DesignWare HDMI QP TX controller.
>>
>> Note this is not a full dt-binding specification, but is meant to be
>> referenced by platform-specific bindings for this IP core.
> 
> Please provide an user for this binding. Otherwise it is a no-op.

The first user of this is RK3588 HDMI TX Controller [1].

>>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  .../display/bridge/synopsys,dw-hdmi-qp.yaml        | 66 ++++++++++++++++++++++
>>  1 file changed, 66 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi-qp.yaml b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi-qp.yaml
>> new file mode 100644
>> index 000000000000..d8aee12b121d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi-qp.yaml
>> @@ -0,0 +1,66 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/bridge/synopsys,dw-hdmi-qp.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Common Properties for Synopsys DesignWare HDMI QP TX Controller IP
>> +
>> +maintainers:
>> +  - Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> +
>> +description: |
>> +  This document defines device tree properties for the Synopsys DesignWare
>> +  HDMI 2.1 Quad-Pixel (QP) TX controller IP core.
>> +  It doesn't constitute a device tree binding specification by itself, but
>> +  is meant to be referenced by platform-specific device tree bindings.
>> +
>> +  When referenced from platform device tree bindings, the properties defined
>> +  in this document are defined as follows. The platform device tree bindings
>> +  are responsible for defining whether each property is required or optional.
> 
> Drop this all description and re-write it not to say what bindings are
> or are not. Describe the hardware.

I just tried to keep it similar with synopsys,dw-hdmi.yaml. 

> 
>> +
>> +properties:
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 4
>> +    maxItems: 6
>> +    items:
>> +      - description: Peripheral/APB bus clock
>> +      - description: EARC RX biphase clock
>> +      - description: Reference clock
>> +      - description: Audio interface clock
>> +    additionalItems: true
> 
> ??? What's the point of such common schema if it is not common at all?

The schema is referenced by [1].
 
>> +
>> +  clock-names:
>> +    minItems: 4
>> +    maxItems: 6
>> +    items:
>> +      - const: pclk
>> +      - const: earc
>> +      - const: ref
>> +      - const: aud
>> +    additionalItems: true
>> +
>> +  interrupts:
>> +    minItems: 4
>> +    maxItems: 5
>> +    items:
>> +      - description: AVP Unit interrupt
>> +      - description: CEC interrupt
>> +      - description: eARC RX interrupt
>> +      - description: Main Unit interrupt
>> +    additionalItems: true
>> +
>> +  interrupt-names:
>> +    minItems: 4
>> +    maxItems: 5
>> +    items:
>> +      - const: avp
>> +      - const: cec
>> +      - const: earc
>> +      - const: main
>> +    additionalItems: true
> 
> Sorry, there is no user of this and nothing here is actually common
> except first entries in clocks and interrupts properties.
> 
> I don't see any benefit of this.

Sorry, I should have better indicated this is part of a larger changeset -
the cover mentions this is a reworked version of an initial (larger) series
and the split has been explicitly suggested during the review.

> Best regards,
> Krzysztof

Thanks for reviewing,
Cristian

[1]: https://lore.kernel.org/lkml/20240801-b4-rk3588-bridge-upstream-v2-1-9fa657a4e15b@collabora.com/

