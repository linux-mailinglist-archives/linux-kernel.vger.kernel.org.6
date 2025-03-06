Return-Path: <linux-kernel+bounces-548981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2999A54BB4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CE21897B21
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F62920D4F2;
	Thu,  6 Mar 2025 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="jLTo6eWu"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B96481CD;
	Thu,  6 Mar 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741266850; cv=pass; b=aM+4PQ8c+MdsmQVTcuW+dm5KRwTgX1madNCFteCk8ot6pF5rrK8xVFBModz6mVfMG7IzBTTLPim6fhE2HoK9wI0uTap7FaTO1SNKbQK9/EYmhvFSM8zoKS5G3Ae6SAFrzvWO/PzLcLhUtry3VbQoSrSCYBsqBCkQ9IRkGzppisI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741266850; c=relaxed/simple;
	bh=qC1sceAvf4HSV+PgAQjk9PSnSGXQBhmv0v7HGXQXzXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rhd3qa5I9gfJucLoSbjX0QC69dNN1/TGeRICr8QgdbqvHCJ+6YpnH3hvNQXAmAPdu5+8jtiRa8FeDdhrEFyysR9gLjTA90dVtlQnw5djaRGypZBA75njjbLI5F+pquNOnsIs0BRdRnF/Op20hbL797AgbxCuHCwPlYM3oN0y3Wo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=jLTo6eWu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741266806; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ln67D7B8R/emwNovVLhkaz7xbVh04EGL2fSTkLDhliu0yFF5HPOStn0Fyk7RGUSm6kz3daWv2CrhBsEXy5NJydyy2CaaXI30XHo8uo38Ng0OYX1igVJcmSzIsV3OL1w4E/4RfOr0qKK6iJs+ZrcRuTffIcpmK0FAp0SAVAEM4YQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741266806; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=R/l3297Aly6n/qBAueWz12hEPxnEHvfm6GKPejWJ/Vw=; 
	b=MMm0eR+LmbNeSFSuObeLJGIE34hmTdHHG+dO6tTDWE1hVzlgVjE9tnZIEqsZbRWhIdFXkx/nPiRl+PTGYUaqS22megAsU4oUjwdDdVt9zrkcXLANi2CANfUR3Gl8dxw14v2w/5zlrF3Qc5vLy8dmkkS2IHvEtTwDHQGaMpvi4Vg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741266806;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=R/l3297Aly6n/qBAueWz12hEPxnEHvfm6GKPejWJ/Vw=;
	b=jLTo6eWuwglmC71EtgyEJQ8kL0bFRLESM9jvJbnBxLKoc4vQBGYlIU3eCrW82lcq
	VVceuFNVewMSvTKT54YH8U8WN8NraGIPvbNxZ0XrB47XCseCv3JRCN2U7fAQVMb90wI
	M0/ZAU/gqUDRQ3YvHFtJeQdvnxMJgFKwn+UZxeV0=
Received: by mx.zohomail.com with SMTPS id 1741266806086596.4769996246168;
	Thu, 6 Mar 2025 05:13:26 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Sugar Zhang <sugar.zhang@rock-chips.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, kernel@collabora.com,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Subject:
 Re: [PATCH 3/7] ASoC: dt-bindings: add schema for rockchip SAI controllers
Date: Thu, 06 Mar 2025 14:13:18 +0100
Message-ID: <2376575.ElGaqSPkdT@workhorse>
In-Reply-To: <ffd6287c-cbfd-4ba8-9332-45bad4e60583@kernel.org>
References:
 <20250305-rk3576-sai-v1-0-64e6cf863e9a@collabora.com>
 <20250305-rk3576-sai-v1-3-64e6cf863e9a@collabora.com>
 <ffd6287c-cbfd-4ba8-9332-45bad4e60583@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 6 March 2025 08:42:54 Central European Standard Time Krzysztof 
Kozlowski wrote:
> On 05/03/2025 22:24, Nicolas Frattaroli wrote:
> > Rockchip introduced a new audio controller called the "Serial Audio
> > Interface", or "SAI" for short, on some of their newer SoCs. In
> > particular, this controller is used several times on the RK3576 SoC.
> > 
> > Add a schema for it, with only an RK3576 compatible for now. Other SoCs
> > may follow as mainline support for them lands.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> > 
> >  .../devicetree/bindings/sound/rockchip,sai.yaml    | 151
> >  +++++++++++++++++++++
> Filename based on compatible.

Sure, but more compatibles will follow. Are you certain you want a file named 
rockchip,rk3576-sai.yaml to then contain rockchip,rk3528-sai? If so then I do 
not understand the reason behind this policy.

> 
> >  MAINTAINERS                                        |   6 +
> >  2 files changed, 157 insertions(+)
> 
> ...
> 
> > +
> > +  dma-names:
> > +    minItems: 1
> > +    maxItems: 2
> > +    oneOf:
> > +      - const: tx
> > +      - const: rx
> > +      - items:
> > +          - const: tx
> > +          - const: rx
> 
> Why all combinations are possible?

Because they are. sai5 in rk3576 is rx only. sai7 is tx only. Others are both 
tx and rx. Do you want me to enforce that those with both are always tx 
followed by rx?

> 
> > +
> > +  clocks:
> > +    items:
> > +      - description: master audio clock
> > +      - description: AHB clock driving the interface
> > +
> > +  clock-names:
> > +    items:
> > +      - const: mclk
> > +      - const: hclk
> > +
> > +  resets:
> > +    minItems: 1
> > +    maxItems: 2
> > +    description: resets for the mclk domain and ahb domain
> 
> List the items instead with description and minItems: 1.

Will do

> 
> > +
> > +  reset-names:
> > +    minItems: 1
> > +    items:
> > +      - const: m
> > +      - const: h
> > +
> > +  port:
> > +    $ref: audio-graph-port.yaml#
> > +    unevaluatedProperties: false
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  "#sound-dai-cells":
> > +    const: 0
> > +
> > +  rockchip,sai-rx-route:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description:
> > +      Defines the mapping of the controller's SDI ports to actual input
> > lanes, +      as well as the number of input lanes.
> > +      rockchip,sai-rx-route = <3> would mean sdi3 is receiving from
> > data0, and +      that there is only one receiving lane.
> > +      This property's absence is to be understood as only one receiving
> > lane +      being used if the controller has capture capabilities.
> > +    maxItems: 4
> > +    items:
> > +      enum: [0, 1, 2, 3]
> > +
> > +  rockchip,sai-tx-route:
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    description:
> > +      Defines the mapping of the controller's SDO ports to actual output
> > lanes, +      as well as the number of output lanes.
> > +      rockchip,sai-tx-route = <3> would mean sdo3 is sending to data0,
> > and
> 
> I understand this is only example because = <3> would not be allowed
> (test it).

I'll have to look into that, I was fairly certain I tested it, but maybe I 
forgot to run a CHECK_DTBS with it in.

> 
> > +      that there is only one transmitting lane.
> > +      This property's absence is to be understood as only one
> > transmitting lane +      being used if the controller has playback
> > capabilities.
> > +    maxItems: 4
> > +    items:
> > +      enum: [0, 1, 2, 3]
> > +
> > +  rockchip,always-on:
> > +    type: boolean
> > +    description:
> > +      The hardware requires this controller to remain turned on.
> 
> How hardware requires this? You rather miss proper PM domain handling or
> some other resources.

This isn't about power domains. It's about the FS/SCLK generator inside the 
IP. I'll remove it in the next revision since downstream only uses it for a 
different IP on the RK3588, and I'd rather not get bogged down by discussions 
as to whether SAI should be modelled as a clock provider.

> 
> > +
> > +
> 
> Just one blank line.

Will do

> 
> > +required:
> > +  - compatible
> > +  - reg
> > +  - dmas
> > +  - dma-names
> > +  - clocks
> > +  - clock-names
> > +  - "#sound-dai-cells"
> > +
> > +unevaluatedProperties: false
> 
> Best regards,
> Krzysztof

Cheers,
Nicolas Frattaroli




