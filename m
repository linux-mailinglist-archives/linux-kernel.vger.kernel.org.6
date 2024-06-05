Return-Path: <linux-kernel+bounces-201948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F3D8FC5BA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 10:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098B82823E4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 08:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A0A49630;
	Wed,  5 Jun 2024 08:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBSAVBjB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA8549621;
	Wed,  5 Jun 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717575131; cv=none; b=NBghpLYUP4v614mUMU/grpoOo7TMcrWYFvMcJqlef+/VNwZnClBy50zE419H+Bok5xhTaOLom4/5Roi2RMtwppFqnmd2UtCy310045ec5ceLahr2O4IUhguaPFcHY6UJ+3cZl338xO807kLbaqjyrcVWQs0o9spZ606aZFc2X0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717575131; c=relaxed/simple;
	bh=3Cu0rGtiUDZ4fe7lgTvZx3NuR8q2z0tMfYhv6hfQR1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sJyUT4VN9jrtuTwXr0nZfrwfg9Q9Tu7w4vkFCCPxJ6KfDmCWhf0UWA4G2+oVlb+tGbK58bM7TE728inze2iRrQezZDMrw2N2wJFhtS49/RRe/Bycv7UlguEmb/lNouVRviQwdIptSNUKy01/3b5vKGUYXstdPDLrqYe+H4XWQKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBSAVBjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB93BC3277B;
	Wed,  5 Jun 2024 08:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717575130;
	bh=3Cu0rGtiUDZ4fe7lgTvZx3NuR8q2z0tMfYhv6hfQR1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aBSAVBjBUYdLHnP+vCQwiEZhgY4g/CEfaZniAi4hhhR4+NFSoB02G4s4iKtajQ60E
	 RFNe2gvjezxf1c9KzEzBS9EI0arIbJezZBqDwXDZcI1ntAFcm1Zybc48OGOS4IJpje
	 SfpSa0kUUIpSL2Vi3bxvcEvp4NtcEPJfOr6ID0EXADsj5jNnXBIvhxYEAcF//BkTHG
	 /5yZaQqtO+lWh5XxZk5nH3B9jRtIX90c8834SuL3VtboV0djtrJefvXURKAmWdY7UG
	 xnrUMTAzLsYqEnbaGEI00FtXIG4mfxiHmKiZpwdviKYmm0kryUzYYrRlpnowiAE3xp
	 xlCBaTQlVRZuQ==
Message-ID: <75c27bf0-4cc1-41ec-86ed-5c7f3d38f5d8@kernel.org>
Date: Wed, 5 Jun 2024 10:12:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: clock: Add i.MX91 clock support
To: Pengfei Li <pengfei.li_1@nxp.com>, Rob Herring <robh@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, abelvesa@kernel.org,
 mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 ping.bai@nxp.com, ye.li@nxp.com, peng.fan@nxp.com, aisheng.dong@nxp.com,
 frank.li@nxp.com, tharvey@gateworks.com, alexander.stein@ew.tq-group.com,
 gregor.herburger@ew.tq-group.com, hiago.franco@toradex.com,
 joao.goncalves@toradex.com, hvilleneuve@dimonoff.com,
 Markus.Niebel@ew.tq-group.com, m.felsch@pengutronix.de,
 m.othacehe@gmail.com, bhelgaas@google.com, leoyang.li@nxp.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
References: <20240530022634.2062084-1-pengfei.li_1@nxp.com>
 <20240530022634.2062084-2-pengfei.li_1@nxp.com>
 <20240604150306.GA596314-robh@kernel.org>
 <ZmD76mp2dPVv6HeA@pengfei-OptiPlex-Tower-Plus-7010>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZmD76mp2dPVv6HeA@pengfei-OptiPlex-Tower-Plus-7010>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06/06/2024 01:59, Pengfei Li wrote:
> On Tue, Jun 04, 2024 at 10:03:06AM -0500, Rob Herring wrote:
>> On Wed, May 29, 2024 at 07:26:30PM -0700, Pengfei Li wrote:
>>> i.MX91 has similar Clock Control Module(CCM) design as i.MX93.
>>> Add a new compatible string for i.MX91.
>>>
>>> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>
>>> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>  Documentation/devicetree/bindings/clock/imx93-clock.yaml | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/clock/imx93-clock.yaml b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
>>> index ccb53c6b96c1..98c0800732ef 100644
>>> --- a/Documentation/devicetree/bindings/clock/imx93-clock.yaml
>>> +++ b/Documentation/devicetree/bindings/clock/imx93-clock.yaml
>>> @@ -16,6 +16,7 @@ description: |
>>>  properties:
>>>    compatible:
>>>      enum:
>>> +      - fsl,imx91-ccm
>>>        - fsl,imx93-ccm
>>
>> Should fallback to fsl,imx93-ccm? Being a superset should be ok because 
>> your DT should never use the non-existent clocks. If not, where is the 
>> driver change?
>>
>> Rob
>>
> 
> Hi Rob Herring,
> ﻿
> Due to the different maintainers of the CCM framework and DTS, I have separated 
> the CCM driver patch and plan to send the DTS patch first before sending the 
> CCM driver patch. If that's possible, could you help merge this patch first? If 
> this is not allowed, I can also send out the CCM driver patch at the same time.

Binding goes with the driver, not DTS.

Best regards,
Krzysztof


