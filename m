Return-Path: <linux-kernel+bounces-332187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ACD97B695
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 307A3286503
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 01:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C0B9443;
	Wed, 18 Sep 2024 01:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LW6kbAHC"
Received: from mail-m3286.qiye.163.com (mail-m3286.qiye.163.com [220.197.32.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450B923B0;
	Wed, 18 Sep 2024 01:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726623375; cv=none; b=i9BLkSRaeCIzeXeUCC3P8Lh3if3cOGCgv5hFJ7ORTfCS408q3Auhb+rfbc7AIShmks6t2GcVp9AdEDoa/AViq5R2/s4uOoU4UFYoYKInQ2WW/jI1Q9N3ITjVe3CZ8rcdTvZHMy20Y5cVbFiX+V8jis3KfesJWxah0nCK4m6PFDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726623375; c=relaxed/simple;
	bh=I4DOH1yoCq6jGAu1f1uGUgoF0OpVVzjyR4RgOinZi/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWL8VOnG5eeB/b4+tBJNgLbGNYgbVLU3rgIzYWgkpLPSs1DqKDGaZ9ML1EA8I2O2ZrGK1/SFWv2Y41WaMBdkBJGH8pBx33GvYi/MGQ85MgwzCwnQ9XCYURmyO+5c4hRoGA72bORmiACgwNwwc1PNtRP4CtAthvAfypLWiMH2ytw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LW6kbAHC; arc=none smtp.client-ip=220.197.32.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
DKIM-Signature: a=rsa-sha256;
	b=LW6kbAHC+5GXY2OfZMS5sTuDv1f1PUf2Jokq7SwLNMcVkKd5XYcfbfTqPkpzRhq+C84wAq72EZ75gfWTCIxw97GfBr9nLOywtphVyrlgsYkCDJo+6PFQdke69l3JSZV3+nfdSnMiJiP0yiasl5A0BLRAM859TRaxru7J4jFeWlo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=TVkZycR1rpHNLPIXL884jOUJnJVbwEfw2KUOAdKWNS8=;
	h=date:mime-version:subject:message-id:from;
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 8307810032A;
	Wed, 18 Sep 2024 09:35:03 +0800 (CST)
Message-ID: <d8161786-24b1-408e-af8e-f942598fa50a@rock-chips.com>
Date: Wed, 18 Sep 2024 09:35:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] dt-bindings: arm: rockchip: Add RK3588S EVB1 board
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, macromorgan@hotmail.com, jonas@kwiboo.se,
 tim@feathertop.org, knaerzche@gmail.com, efectn@protonmail.com,
 andyshrk@163.com, jagan@edgeble.ai, dsimic@manjaro.org, megi@xff.cz,
 sebastian.reichel@collabora.com, alchark@gmail.com,
 boris.brezillon@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240914095456.2347532-1-damon.ding@rock-chips.com>
 <20240914095456.2347532-2-damon.ding@rock-chips.com>
 <krfo47rjxks7gouirhmcfwa67sy3vztq2ktdcs4kkikhtwgbv3@ofvnobfyqzhf>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <krfo47rjxks7gouirhmcfwa67sy3vztq2ktdcs4kkikhtwgbv3@ofvnobfyqzhf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkfSFZCH0gZGUoZTB5JGk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	JVSktLVUpCS0tZBg++
X-HM-Tid: 0a9202c4cb9203a7kunm8307810032a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORg6ERw4LzIrKwsPTUMKMw8h
	CQtPCy1VSlVKTElNTUlISEtOSUJIVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITE5JNwY+

Hi Krzysztof:

On 2024/9/16 16:49, Krzysztof Kozlowski wrote:
> On Sat, Sep 14, 2024 at 05:54:55PM +0800, Damon Ding wrote:
>> Add devicetree binding for the Rockchip RK3588S evaluation board.
>>
>> RK3588S EVB1 board features:
>> - Rockchip RK3588S
>> - PMIC: RK806-2x2pcs+DiscretePower
>> - RAM: LPDDR4/4x 2pcsx 32bit
>> - ROM: eMMC5.1+ SPI Falsh
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>> ---
>>
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation: Please add
> Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
> or above your Signed-off-by tag. Tag is "received", when provided
> in a message replied to you on the mailing list. Tools like b4 can help
> here. However, there's no need to repost patches *only* to add the tags.
> The upstream maintainer will do that for tags received on the version
> they apply.
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 
> 

Thank you for your friendly reminder and the detailed explanation about 
the tag. I did forget to add the tag in v5 patch, and I will pay more 
attention to this in future updates.

Best regards,
Damon


