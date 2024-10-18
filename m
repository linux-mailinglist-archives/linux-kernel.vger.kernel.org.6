Return-Path: <linux-kernel+bounces-371520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D0B9A3C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:54:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA28D1C21B9B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CB2202F9A;
	Fri, 18 Oct 2024 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="sW2za9oG"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B08E202F7B;
	Fri, 18 Oct 2024 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248761; cv=none; b=OKEU/t7Agb+yvQ6p3FDVvBZAQ5Oqq1V2ogm3TeDoIatp6K1OBzS604fpQqOYNjr35CrYGU9QGcLIs/QiYYfo30s15A9lvwi1rJOwme8VGikkXI3YpxvFX4EzOsSG5jinrNs67fIR5tceCn+6AuHHUUMCoOzQr7kJznhJ9syfYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248761; c=relaxed/simple;
	bh=WeLj5Q6mLGVX6uIa0uQK/eue8seMS98Gd0FVJcgXVpQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HKynWi9ezp/nPJhc89mmHoOgt+COeEdVnjoP2DLh+q6QOYCqY3ADXTVwMq8nfuI3pHbX+eL1glA12EN4mWNf8/6FSPG+pPvI0n626mwSLevMwMiwO8vQ89XrQyj/Bcjj2p/QmB4q12RDkWdhmplFbZTpcj5wy6zJmig7B8HnLss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=sW2za9oG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1729248756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSgaCXhYCTyaqW7QXeST4qmKxHMaP1eI9yKLIfIiBVU=;
	b=sW2za9oGS9xzHI/cAhOXgA55SqvcaRZd4ZjEW9S05evi598emFFzmbR51pWaFAqaxgSFT6
	cmwASG3LXRhOaqKHfE2M4ppss24PwAUIiFjs6FfFQz2Xtz6nQPtQp5q7yha6Nch253qcb6
	8M9r3ssLT9MQPu8t7VwvYTLlBKDBM2Ggd+2jdiT7gs+1u+TgeT50Yf2LDZN0quT7xPU14y
	KBmkgvLU2ovN9kRpRuUYmtLsyatdSsGljMPKYrASNqwz+2yELdr0OekF9pX8ad5H6BpEFF
	U2mDEPKY0E5LfDdUuYCyrWoPOeBVlYkh+nh8Xg2LaBLeaaEIXKvR+VhDIRKDiw==
Date: Fri, 18 Oct 2024 12:52:35 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Frank Wang <frawang.cn@gmail.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, yubing.zhang@rock-chips.com, Frank Wang
 <frank.wang@rock-chips.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: soc: rockchip: add rk3576 vo1-grf
 syscon
In-Reply-To: <3cd260c8-86e5-4833-b23e-b73dc6417f81@gmail.com>
References: <20241017025230.28752-1-frawang.cn@gmail.com>
 <ca0ee8752791f53bac23933e1582dd86@manjaro.org>
 <d2a200aa-1301-4940-a39c-0412fe741994@gmail.com>
 <ee27926c06bedd62f417dbd7d01ce8b3@manjaro.org>
 <3cd260c8-86e5-4833-b23e-b73dc6417f81@gmail.com>
Message-ID: <5175d8a9b007ce1c6c12bcc09d78dfda@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Frank,

On 2024-10-18 09:34, Frank Wang wrote:
> On 2024/10/18 14:37, Dragan Simic wrote:
>> On 2024-10-18 08:18, Frank Wang wrote:
>>> On 2024/10/18 13:02, Dragan Simic wrote:
>>>> On 2024-10-17 04:52, Frank Wang wrote:
>>>>> From: Frank Wang <frank.wang@rock-chips.com>
>>>>> 
>>>>> Add rockchip,rk3576-vo1-grf syscon compatible, the vo1-grf is
>>>>> configured in usbdp phy driver.
>>>>> 
>>>>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>>>>> ---
>>>>> Changelog:
>>>>> v2:
>>>>>  - This is a new patch adds rk3576-vo1-grf syscon.
>>>> 
>>>> Could you, please, clarify a bit why is this additional patch
>>>> needed in this series?
>>> 
>>> I mentioned in the commit content. The usbdp-phy driver select dp
>>> lanes via configuring the vo1-grf.
>> 
>> Yes, I already saw that in the patch description.  Though, and
>> I apologize if I'm missing something obvious, I can't see where
>> is it actually used in the code?  Is it yet to be used in the
>> dts(i) files?
>> 
>> I'd appreciate if you could clarify that just a bit further, so
>> I can hopefully understand it better.
> 
> Yes, the usbdp_phy node in dts(i) will assign the vo1-grf phandle like 
> this:
> 
> usbdp_phy: phy@2b010000 {
>         ...
>         rockchip,vo-grf = <&vo1_grf>;
> };
> 
> And the usbdp-phy driver parses it and assign to udphy->vogrf, it uses
> in rk_udphy_dplane_select().
> 
> The related codes have already existed in the current driver, so for
> RK3576, just only need to do a configuration.

Great, thanks for the detailed explanation!  This confirms
my latest assumption and everything is looking good, so please
free to include:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

>>>>> v1:
>>>>>  - none
>>>>> 
>>>>>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
>>>>>  1 file changed, 2 insertions(+)
>>>>> 
>>>>> diff --git 
>>>>> a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>>>> b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>>>> index 50d727f4b76c6..fd42217ab85e7 100644
>>>>> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>>>> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>>>> @@ -33,6 +33,7 @@ properties:
>>>>>                - rockchip,rk3576-usb-grf
>>>>>                - rockchip,rk3576-usbdpphy-grf
>>>>>                - rockchip,rk3576-vo0-grf
>>>>> +              - rockchip,rk3576-vo1-grf
>>>>>                - rockchip,rk3576-vop-grf
>>>>>                - rockchip,rk3588-bigcore0-grf
>>>>>                - rockchip,rk3588-bigcore1-grf
>>>>> @@ -283,6 +284,7 @@ allOf:
>>>>>          compatible:
>>>>>            contains:
>>>>>              enum:
>>>>> +              - rockchip,rk3576-vo1-grf
>>>>>                - rockchip,rk3588-vo-grf
>>>>>                - rockchip,rk3588-vo0-grf
>>>>>                - rockchip,rk3588-vo1-grf

