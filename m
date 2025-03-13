Return-Path: <linux-kernel+bounces-558735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBF7A5EA25
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 106E518991FC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF8F78F54;
	Thu, 13 Mar 2025 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BPnJ1y7J"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD73A92E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741836872; cv=none; b=NNHJD4wZhkRc+u2LUF7by68522eQaYDkr79jGyZl69mJvcIBBsPII+DETH/h5mYC2eRBd51nrXVXB0DqD2BRtVkAf8ddQFISB46+lLoR3kj42qEm50TujAB8y6pZr1jhYbYKNO/ZiFh1EgGbqkp8r7nxuM/6Z7OTnXXojOlf8V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741836872; c=relaxed/simple;
	bh=TNTg47qZROW0WppXAxZZzNCelLLyziUBjKjAdeuuDYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=THyKoXmkdhzssGMoNLmMsZ2hHVGCIJi/lLsWWgowOn+oocGW/udQeAPqwr3IkszEfVOoV604fYHRU+ZY7yyits07LJBz9PiYI8Bb1+1100XW/rVz9F4Dnk/wCufyRCLzw6PH7fGBmWlNxy0uK7BVmvezni5KtdY7OjguB/07HXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BPnJ1y7J; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741836868;
	bh=TNTg47qZROW0WppXAxZZzNCelLLyziUBjKjAdeuuDYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BPnJ1y7JxkNqwB5O9TwhT/tNs3RtxRBV0KHeFVtwlZe6+1lg0AksfSxutLRLNmv0L
	 N3d78EnC88eG/3JL4bizSLiZYlvmrLAzAZ8fOp045oSyr8ztO6Vr8pWtjlm6IYlkrO
	 TdjECDS9TGc2648yJCmokdHVF2Mbn3xW20JbtsX3Iag1vzfyjjv/RNoR8m4GVI+ol3
	 deFXdwLZEI8nSLI5yvVTMqeQkGBgT8yQATj1K+A/zvkN516n15frFK38NI8lh1SLaF
	 /P15qaRCPlW83UDp7p8ODwMKD+EfD2izKQExvFGtCMfy8c2AS0xoffxGehBk1xnpVD
	 3DIipChxDcYRw==
Received: from [192.168.50.250] (unknown [171.76.87.92])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1E5B817E0B46;
	Thu, 13 Mar 2025 04:34:25 +0100 (CET)
Message-ID: <7c39436c-3f23-41cf-97aa-06d9f9d20e61@collabora.com>
Date: Thu, 13 Mar 2025 09:04:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm64: defconfig: mediatek: enable PHY drivers
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: linux-mediatek@lists.infradead.org, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
 krzk@kernel.org, daniels@collabora.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250312041943.25676-1-vignesh.raman@collabora.com>
 <5706c76e-7558-4405-a4c6-cab9cb5ddf65@notapiano>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <5706c76e-7558-4405-a4c6-cab9cb5ddf65@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Nícolas,

On 12/03/25 19:55, Nícolas F. R. A. Prado wrote:
> On Wed, Mar 12, 2025 at 09:49:26AM +0530, Vignesh Raman wrote:
>> The mediatek display driver fails to probe on mt8173-elm-hana and
>> mt8183-kukui-jacuzzi-juniper-sku16 in v6.14-rc4 due to missing PHY
>> configurations.
>>
>> Enable the following PHY drivers for MediaTek platforms:
>> - CONFIG_PHY_MTK_HDMI=m for HDMI display
>> - CONFIG_PHY_MTK_MIPI_DSI=m for DSI display
>> - CONFIG_PHY_MTK_XSPHY=m for USB
>>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>> ---
>>
>> v2:
>>    - Include board details in the commit message.
>>    - Sort newly added PHY configs in defconfig.
>>
>> ---
>>   arch/arm64/configs/defconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 1f25423de383..87e8cbd3fd26 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1572,7 +1572,10 @@ CONFIG_PHY_HI6220_USB=y
>>   CONFIG_PHY_HISTB_COMBPHY=y
>>   CONFIG_PHY_HISI_INNO_USB2=y
>>   CONFIG_PHY_MVEBU_CP110_COMPHY=y
>> +CONFIG_PHY_MTK_HDMI=m
>> +CONFIG_PHY_MTK_MIPI_DSI=m
> 
> This isn't the expected ordering. I imagine you manually added these configs in
> the defconfig.

Yes, I added them manually.

> 
> To get the right ordering, after you've added the configs anywhere in this
> defconfig, do a 'make defconfig', then a 'make savedefconfig', and copy the
> generated 'defconfig' file at the root to this location, then you can add just
> this hunk to the commit, and it'll be in the correct order.

Thanks for the explanation. I will follow this approach.

Regards,
Vignesh

> 
> Thanks,
> Nícolas


