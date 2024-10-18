Return-Path: <linux-kernel+bounces-371042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 727449A358C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1ACB1C218C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2FE1865E3;
	Fri, 18 Oct 2024 06:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="a3bd3Lv+"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B91152E1C;
	Fri, 18 Oct 2024 06:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233462; cv=none; b=pD5awvfI50c+VWADrL4k6EJqWDw7D/8YrdSPyLwLZD/4kCzeLItLr52oRbc2VBH5bNCjpQ75jleU2/cg1nWpbp93caMk5v/+5TKLVxnCm4H9aWQtoSSpkUwYgJxd89RlCXPm41JHyojBrPqp4BHgb/iBGoHKDK2GT474SQBgMKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233462; c=relaxed/simple;
	bh=zIeW0kxLgeAsqirnaKhjgUcE28ulwX06MiU/EtFkVLA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aV2CqEf+9o3EaH/r6mwVKIUnwcvadkJtzoir4pB6Xk0bNfJ1yUFJeDIZDINRASpFIHfxLaUzBcmHLl9QmXCKbT6TG9qa/PGqT4phXF+tUQqbkWxlmId6afcf/nsR/0g+GRinE1T1yAYSwIh+7K78jhgGAkpUMm/Fo6BaD1YWVZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=a3bd3Lv+; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1729233457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tQrAlybDcm+BHN6KghRbFaYYrJAEKr0934b1OCxB7wU=;
	b=a3bd3Lv+1DcGM36LvuPPteYTY9SOB1DUVXjq+8nimatWpeQZ3TvAucM5Zb2aDdP5Shnarc
	40EeKhlpz+VGOeD029yG8kDGHIkYgYu0HSyc4uiqPhKf6oQDkE9d8akhY5g4cnUi1qNKme
	q8NZ8OBiCy2o2PLLeGOXjmyFlAG/3njyiERdqKbs+qTwomFUudc4HuaPfpDsiVbGCOI1FT
	xWe2hdkDSPPD/PMfDa/C7apyjcnIxwEqvxR/xE0z2PlZphGlh043hPTA7e6BDzk9MxHtlg
	30nPyeURDSdzJgIUAwSvLhaOmyhmhgAlGwANaq7tg4z6eX5Y2Rh/4gJ4xR0wkw==
Date: Fri, 18 Oct 2024 08:37:36 +0200
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
In-Reply-To: <d2a200aa-1301-4940-a39c-0412fe741994@gmail.com>
References: <20241017025230.28752-1-frawang.cn@gmail.com>
 <ca0ee8752791f53bac23933e1582dd86@manjaro.org>
 <d2a200aa-1301-4940-a39c-0412fe741994@gmail.com>
Message-ID: <ee27926c06bedd62f417dbd7d01ce8b3@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Frank,

On 2024-10-18 08:18, Frank Wang wrote:
> On 2024/10/18 13:02, Dragan Simic wrote:
>> On 2024-10-17 04:52, Frank Wang wrote:
>>> From: Frank Wang <frank.wang@rock-chips.com>
>>> 
>>> Add rockchip,rk3576-vo1-grf syscon compatible, the vo1-grf is
>>> configured in usbdp phy driver.
>>> 
>>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>>> ---
>>> Changelog:
>>> v2:
>>>  - This is a new patch adds rk3576-vo1-grf syscon.
>> 
>> Could you, please, clarify a bit why is this additional patch
>> needed in this series?
> 
> I mentioned in the commit content. The usbdp-phy driver select dp
> lanes via configuring the vo1-grf.

Yes, I already saw that in the patch description.  Though, and
I apologize if I'm missing something obvious, I can't see where
is it actually used in the code?  Is it yet to be used in the
dts(i) files?

I'd appreciate if you could clarify that just a bit further, so
I can hopefully understand it better.

>>> v1:
>>>  - none
>>> 
>>>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
>>>  1 file changed, 2 insertions(+)
>>> 
>>> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>> b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>> index 50d727f4b76c6..fd42217ab85e7 100644
>>> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>>> @@ -33,6 +33,7 @@ properties:
>>>                - rockchip,rk3576-usb-grf
>>>                - rockchip,rk3576-usbdpphy-grf
>>>                - rockchip,rk3576-vo0-grf
>>> +              - rockchip,rk3576-vo1-grf
>>>                - rockchip,rk3576-vop-grf
>>>                - rockchip,rk3588-bigcore0-grf
>>>                - rockchip,rk3588-bigcore1-grf
>>> @@ -283,6 +284,7 @@ allOf:
>>>          compatible:
>>>            contains:
>>>              enum:
>>> +              - rockchip,rk3576-vo1-grf
>>>                - rockchip,rk3588-vo-grf
>>>                - rockchip,rk3588-vo0-grf
>>>                - rockchip,rk3588-vo1-grf
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip

