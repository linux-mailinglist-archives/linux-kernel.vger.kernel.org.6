Return-Path: <linux-kernel+bounces-518471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DA4A38FA9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 00:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E782188C455
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 23:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF171A8404;
	Mon, 17 Feb 2025 23:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JEO/bCNB"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E493D19E999;
	Mon, 17 Feb 2025 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739835221; cv=none; b=Iqpfzc8/HHCHluGicAEiTbpEVYLL2fngpMh/ykqRD14sji1zHlePvbv6QkiutwNiyiE6TDZRcjlAOod1TdzXodPRTHnFCL0aEDwEq0VdCXJmuh7OMyOwMw5AqwK70kVvXnGJA0nOV6dXcEClq8RBlSdJwAnrzrLDK0gnSz+D5gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739835221; c=relaxed/simple;
	bh=LdoZzq7qtMiglzhu00kRaJtsesikQFQgmqj4oShgtzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENvPmfIV9nViH5oshmSA3pYhL5DxMCNM7J14SN4oNXzfK7dyaz8wnh26sg3roPOE2bR5VPnRnvv82KjuOWgmwQa26uy+sU+VhPX406TXMO9p+OSJakmjW0u0lDmQ3hfxawxn3Cz2kVfHhTjl1ayfoKfBPB4ZCBoXFmiTR2ONlQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JEO/bCNB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739835218;
	bh=LdoZzq7qtMiglzhu00kRaJtsesikQFQgmqj4oShgtzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JEO/bCNBZRdX7mbbM65vYVr4iQyWDeUcojAo9kKT3nJWtW9bZsprxtF2kpXRSeUpO
	 /v4uzzlJeo1l68SC389qUGWLSL8D6a8q76DWWoSw/OMbq4l+yvrPP+AreJPqV5eW2b
	 V1ISv89z9tPP8yI8Ggb/BYCgu98EnxTtmOrDhmAobhI5omeOMTJiO/4OOmEajWUCpH
	 JY7KP94rvSz5hip/8oAZ//z4w1Ef1MPWauAagzgqzWqB+Ojmk0NTJZpQq71/SC7N4I
	 hsZ76kKXobhqrhEza/hNUdtDeue+AWq3nAGeOhWg7gpZMDpA1OtoDkdjYn13cX5lbw
	 lCGnQBTCaDC2A==
Received: from [192.168.1.143] (144.232.221.87.dynamic.jazztel.es [87.221.232.144])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9D17617E1553;
	Tue, 18 Feb 2025 00:33:36 +0100 (CET)
Message-ID: <1b3234ce-4526-4735-b9c0-c242e6cc3cf0@collabora.com>
Date: Tue, 18 Feb 2025 01:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arm64: dts: rockchip: Add HDMI1 PHY PLL clock source
 to VOP2 on RK3588
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Jianfeng Liu <liujianfeng1994@gmail.com>
Cc: airlied@gmail.com, andy.yan@rock-chips.com, conor+dt@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 hjc@rock-chips.com, kernel@collabora.com, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robh@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
References: <20250215-vop2-hdmi1-disp-modes-v1-3-81962a7151d6@collabora.com>
 <20250217024437.35155-1-liujianfeng1994@gmail.com> <5190979.MSiuQNM8U4@diego>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <5190979.MSiuQNM8U4@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/17/25 4:33 PM, Heiko Stübner wrote:
> Am Montag, 17. Februar 2025, 03:44:37 MEZ schrieb Jianfeng Liu:
>> Hi Cristian,
>>
>> On Sat, 15 Feb 2025 02:55:39 +0200, Cristian Ciocaltea wrote:
>>> The HDMI1 PHY PLL clock source cannot be added directly to vop node in
>>> rk3588-base.dtsi, along with the HDMI0 related one, because HDMI1 is an
>>> optional feature and its PHY node belongs to a separate (extra) DT file.
>>>
>>> Therefore, add the HDMI1 PHY PLL clock source to VOP2 by overwriting its
>>> clocks & clock-names properties in the extra DT file.
>>
>> There are boards that only use hdmi1 such as ROCK 5 ITX. So there are two
>> choices for this board:
>>
>> 1, Enable hdptxphy0 as dependency of vop although it is not really used.
>>
>> 2, Overwrite vop node at board dts to make it only use hdptxphy1 like:
>>
>> &vop {
>> 	clocks = <&cru ACLK_VOP>,
>> 		 <&cru HCLK_VOP>,
>> 		 <&cru DCLK_VOP0>,
>> 		 <&cru DCLK_VOP1>,
>> 		 <&cru DCLK_VOP2>,
>> 		 <&cru DCLK_VOP3>,
>> 		 <&cru PCLK_VOP_ROOT>,
>> 		 <&hdptxphy1>;
>> 	clock-names = "aclk",
>> 		      "hclk",
>> 		      "dclk_vp0",
>> 		      "dclk_vp1",
>> 		      "dclk_vp2",
>> 		      "dclk_vp3",
>> 		      "pclk_vop",
>> 		      "pll_hdmiphy1";
>> };
>>
>> What do you think of these two method?
> 
> Going by the code in patch1 (+drm-misc) we have:
>   vop2->pll_hdmiphy0 = devm_clk_get_optional(vop2->dev, "pll_hdmiphy0");
> +
>   vop2->pll_hdmiphy1 = devm_clk_get_optional(vop2->dev, "pll_hdmiphy1");
> 
> So the clock-reference to hdptxphy0 should just result in vop2->pll_hdmiphy0
> being NULL and thus ignored further on?

Yep, that is the intended behavior.

@Jianfeng: Did you encounter any particular issue with the current approach?


