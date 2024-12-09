Return-Path: <linux-kernel+bounces-437143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2469E8F97
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FF93283686
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3992163AB;
	Mon,  9 Dec 2024 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qIiERnIv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB8B174EDB;
	Mon,  9 Dec 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733738609; cv=none; b=XVZ1qNXHIoGe6F13+N4u/o1W28nyBCjr6gEy3drs6cWoNbqzSJEpFLw2cWRTQD9PntOaoPZoY7SZLdxUm2rRYxoV8kUwLn3IsXV6N/LL4IuIAmCsSwfWn3LbCaUm6T3YeodTvnUGAdbrP1lwtD2a+7Zi4VutxKXzcISRwmsp0OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733738609; c=relaxed/simple;
	bh=uxDhJyLY3sygy6QpU5RBbCWc5T7HouoogqahrUoEgVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bkJWV3aEjJZzLvOxI9tTHOMcaDOurt/AsOUIkR/mEDBbF/lamq6YdbwOm47V47RXp6141FzOH5jyAwSCM8MDwzZQek9KPzxa/8WWrZl9lkpTCMVYWT2i4dd2gAfXia7zb00jxH5KvTUccJXgMwnk5diqN4cv0zHRQ/HGOe7G1k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qIiERnIv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733738604;
	bh=uxDhJyLY3sygy6QpU5RBbCWc5T7HouoogqahrUoEgVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qIiERnIv919/ESyVCG3CtCp2T2qIXTi3k40L/ZXlh5p7nfHQZ7Yk+8lR6/xjB6wVE
	 3AkTXm61EaKoSdY9cBflFmGUoz/kE1gc0EP45KxaSUT+b/lND0VeAnOUwjnuGAa6OT
	 LyN2sB3DdfIzAlWtQqHzzqnN1Wwg0lrGiW2hHKA0a0sNcuzVp3IdA/9vL/KOZH5dbR
	 3o60pvkY6uXerlXMK0djbTSxzTSQarvHIyZ7FCt01xA7ka7HJ+4q2iI4sMfY8CN+tz
	 uijQPuSyo9iuEeuzA3R3fc8X2pJhm/vMP6Lm/Wj0SPwjUtMq+1+GJGQArr4oNnl+YO
	 9FVZFihrAB3cA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2474717E3625;
	Mon,  9 Dec 2024 11:03:24 +0100 (CET)
Message-ID: <c7407eef-d5dd-4380-ba5e-1defa37ee742@collabora.com>
Date: Mon, 9 Dec 2024 11:03:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] MT8516/MT8167 dtsi fixes
To: Val Packett <val@packett.cool>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Fabien Parent <fparent@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241204190524.21862-1-val@packett.cool>
 <7bf536a5-30c1-43d8-9ea3-3aaea65c6b0a@collabora.com>
 <VVS3OS.MZCWW6ICFFUB3@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <VVS3OS.MZCWW6ICFFUB3@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/12/24 04:11, Val Packett ha scritto:
> 
> On Thu, Dec 5 2024 at 01:27:01 PM +01:00:00, AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com> wrote:
>>> I strongly suggest you to also send one that achieves basic boot with UART console
>> as a first step for upstreaming your board, and then go for incremental changes
>> everytime you get a new feature working.
> 
> Wanted to get the PMIC in first but sure, could try splitting out the initial 
> version without the PMIC.
> 

We all want to get XYZ in first, but then, you'll see that sometimes having at
least something will help you justify other changes....

If there's nothing upstream, understanding your changes becomes increasingly
difficult (depending on the nature of those changes, of course) - so... just
take the advice: sending the initial DT will help you later in the process ;-)

> Oh! One dts/dtsi question: pretty much all MTK devices so far have all pinctrl 
> configurations defined per-device. But on this SoC, pin assignments have their 
> "canonical" function in the pin name e.g.: MT8167_PIN_58_SDA0__FUNC_SDA0_0 and on 
> this device they are used as-is. Would it be fine to place these default pinctrl 
> configs for SD/MMC, I2C etc. in the SoC dtsi?
> 

No, because even though this is the default on many boards, it's still something
board specific, as other boards may define different functions.

Please define that in your board DT.

>>> Generally, if the patches are only simple additions, you could send the original
>> patches without any author variation (and fixing that MT6392_IRQ_numbers enum
>> in the original ones because lower case please!) and then your patches on top
>> with your additions.
> 
> Right, I was mostly unsure if the email workflow supported just sending someone 
> else's patches, but I guess that was silly - of course git-send-email should do the 
> right thing!
> 
>> The upstream driver just gained support for configuring the display paths
>> entirely in the devicetree as those are obviously device specific.
>>
>> You can make use of that for upstreaming your tablet after adding the display
>> nodes (and bindings, if required) as if you go for the default configuration
>> that's probably not going to work because it's for the pumpkin boards which
>> will most probably have a different display pipeline compared to your board.
> 
> The pipeline seems to be the same.. The pumpkin board was brought up with DSI as 
> well, the main pipeline I can find in the Android source is the same (+ PWM).
> 
> I am still struggling to get it to work though: DSI command mode configuration gets 
> acknowledged fine, but in burst mode, the vblank never arrives. Tried fiddling with 
> various things (CMDQ or not, mutex as vblank source since there was an Android 
> commit doing that, etc.), nothing helped.
> 

DSI command mode is not supported upstream - only video mode... and that's why you
can't get your display to work. There's no WDMA driver...

Convert it to video mode and it's gonna work just perfect :-)

P.S.: Also check if your mmsys+mutex configuration is correct!

>>> By the way, is anyone familiar with PSCI cpuidle/hot-unplug issues on
>>> Mediatek Android devices from around this time? [..]
>>
>> I did have some issues with an older bootloader on the Xperia M5 smartphone
>> and would even lock up at boot, because on the old firmwares the power
>> domains for the CPUs are not managed automatically by FW.
> 
> Interesting, thanks for the pointer!
> 
> In the Android kernel sources I could find though, there are no CPU domains in the 
> mtk-scpsys-mt8167 driver, and the only references I could even find to the related 
> register bits are from code that *reads* the status of the CPU power domains to 
> make decisions about sleep states (only_one_cpu_online in mtk_idle). Trying to add 
> those to the driver anyway, did not succeed so far.
> 

Downstream, you will find references to "mtcmos" (or anyway cpu mtcmos) - that's
how power domains are called there (I think. At least, in older downstream kernels
that's how they're called - and that's the "real" hw name btw).

Cheers,
Angelo

> ~val
> 
> 
> 


