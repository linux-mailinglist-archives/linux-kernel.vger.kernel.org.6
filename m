Return-Path: <linux-kernel+bounces-248893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D9E92E359
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971E31F23FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B17155A52;
	Thu, 11 Jul 2024 09:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Xy8zeInq"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6414F111;
	Thu, 11 Jul 2024 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720689679; cv=none; b=kb3vCGqfq2xUijg3dEfmM76xF5m9NSeCk1GFB5OlQR8CkZKU+4j/0alFgfRBxGEwz6EPp67WDrgMD/m0Uf2XJo2b/+M8921VJomUjt7d0d8fHWLTuq/r9pB+gywpBd11aWe+2RTAdrucAHnP1C8nO/HEwuyuwTtWwTwJtcmBVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720689679; c=relaxed/simple;
	bh=tQJG8NMkrg/xn3s3bUs1n5Z3qe5f9ytiiGMbVgyGTIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gHJixwJg2rearfDnH9S2vjkDs/N77051Rp1p/Ni4Yy9kONVTuWrYftN8btlGJJgDHryOSFvcyZMLtZ9E+SIqE8G+VhyWR9T1npqprsmxj+9lmuPAc1WKBqW5C8UvrAuA4l163BTB8oBQxBgbAOpM50DZibnrRFOUBXq4VaXOvZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Xy8zeInq; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720689675;
	bh=tQJG8NMkrg/xn3s3bUs1n5Z3qe5f9ytiiGMbVgyGTIM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Xy8zeInqd48+wCBkc5QVrJawwT+52nNTL1C+MooVJlMxQKTd0rRFbRbL+kyaEyw0n
	 dl8rOynHmRCEEjrS0uK/VWHdeKddAp6G5EFTD4fwKFSOYKmfKctAhffrvqIh/f28tw
	 X4Kv4sQQylJ6LjB4kN6IsHSV8zNKiOUcscCdIbrJz71O/jksNPCedqTBVUzgXGtwFN
	 aIYBOgEREZPdl9NFzOUQXR9E3NHaPdEbYo9wB0onL0+n/ysyXLxj/d7NsxWR+nhQ1u
	 At6FwucdE0gYXcDuqvAcOhedrJ4Wduu83vB4IuBIUfSYoQjwzQOATADYqDv6vpahG7
	 pnxxvUG6nKFSg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0051137811F4;
	Thu, 11 Jul 2024 09:21:14 +0000 (UTC)
Message-ID: <2dba1638-f155-463b-8f87-421101b8f4f2@collabora.com>
Date: Thu, 11 Jul 2024 11:21:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Probe failure of usb controller @11290000 on MT8195 after
 next-20231221
To: Macpaul Lin <macpaul.lin@mediatek.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 Chen-Yu Tsai <wenst@chromium.org>, Bear Wang <bear.wang@mediatek.com>,
 Pablo Sun <pablo.sun@mediatek.com>
References: <9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano>
 <064935d8-fbda-4eda-b013-8c8fc63b561c@collabora.com>
 <375b2345-657a-4b8f-b5e3-dc16784ffde9@notapiano>
 <da27d957-866f-f055-9e83-cdc362d98dc7@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <da27d957-866f-f055-9e83-cdc362d98dc7@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 11/07/24 06:13, Macpaul Lin ha scritto:
> 
> 
> On 7/11/24 03:15, Nícolas F. R. A. Prado wrote:
>> On Fri, Jan 19, 2024 at 10:12:07AM +0100, AngeloGioacchino Del Regno wrote:
>>> Il 18/01/24 19:36, Nícolas F. R. A. Prado ha scritto:
>>>> Hi,
>>>>
>>>> KernelCI has identified a failure in the probe of one of the USB controllers on
>>>> the MT8195-Tomato Chromebook [1]:
>>>>
>>>> [   16.336840] xhci-mtk 11290000.usb: uwk - reg:0x400, version:104
>>>> [   16.337081] xhci-mtk 11290000.usb: xHCI Host Controller
>>>> [   16.337093] xhci-mtk 11290000.usb: new USB bus registered, assigned bus 
>>>> number 5
>>>> [   16.357114] xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
>>>> [   16.357119] xhci-mtk 11290000.usb: can't setup: -110
>>>> [   16.357128] xhci-mtk 11290000.usb: USB bus 5 deregistered
>>>> [   16.359484] xhci-mtk: probe of 11290000.usb failed with error -110
>>>>
>>>> A previous message [2] suggests that a force-mode phy property that has been
>>>> merged might help with addressing the issue, however it's not clear to me how,
>>>> given that the controller at 1129000 uses a USB2 phy and the phy driver patch
>>>> only looks for the property on USB3 phys.
>>>>
>>>> Worth noting that the issue doesn't always happen. For instance the test did
>>>> pass for next-20240110 and then failed again on today's next [3]. But it does
>>>> seem that the issue was introduced, or at least became much more likely, between
>>>> next-20231221 and next-20240103, given that it never happened out of 10 runs
>>>> before, and after that has happened 5 out of 7 times.
>>>>
>>>> Note: On the Tomato Chromebook specifically this USB controller is not connected
>>>> to anything.
>>>>
>>>> [1] 
>>>> https://urldefense.com/v3/__https://linux.kernelci.org/test/case/id/659ce3506673076a8c52a428/__;!!CTRNKA9wMg0ARbw!jtg5drII8WUPwTiL4sWZiSRPXN-EBN8ctTGI85sirqvkmaUbA5z-wrLqPPfxlZZkQ7NItOWDT97OSdENT5oGHKY$
>>>> [2] https://lore.kernel.org/all/239def9b-437b-9211-7844-af4332651df0@mediatek.com/
>>>> [3] 
>>>> https://urldefense.com/v3/__https://linux.kernelci.org/test/case/id/65a8c66ee89acb56ac52a405/__;!!CTRNKA9wMg0ARbw!jtg5drII8WUPwTiL4sWZiSRPXN-EBN8ctTGI85sirqvkmaUbA5z-wrLqPPfxlZZkQ7NItOWDT97OSdENi-d0sVc$
>>>>
>>>> Thanks,
>>>> Nícolas
>>>
>>> Hey Nícolas,
>>>
>>> I wonder if this is happening because of async probe... I have seen those happening
>>> once in a (long) while on MT8186 as well with the same kind of flakiness and I am
>>> not even able to reproduce anymore.
>>>
>>> For MT8195 Tomato, I guess we can simply disable that controller without any side
>>> effects but, at the same time, I'm not sure that this would be the right thing to
>>> do in this case.
>>>
>>> Besides, the controller at 11290000 is the only one that doesn't live behind MTU3,
>>> but I don't know if that can ring any bell....
>>
>> An update on this issue: it looks like it only happens if "xhci-mtk
>> 11290000.usb" probes before "mtk-pcie-gen3 112f8000.pcie". What they have in
>> common is that both of those nodes use phys that share the same t-phy block:
>> pcie uses the usb3 phy while xhci uses the usb2 phy. So it seems that some of
>> the initialization done by the pcie controller might be implicitly needed by the
>> usb controller.
>>
>> This should help to narrow down the issue and find a proper fix for it.
>>
>> Thanks,
>> Nícolas
> 
> 'force-mode' should only applied to the boards which require XHCI function instead 
> of a PCIE port.
> 
> For example, mt8395-genio-1200-evk.dts requires property 'force-mode' to fix probe 
> issue for USBC @11290000.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux.git/commit/?h=v6.10-next/dts64&id=666e6f39faff05fe12bfc64c64aa9015135ce783
> 
> 'force-mode' should be no need for tomato boards and the behavior should be the 
> same as before.
> 
> Another possibility is the firmware change on tomato boards. I'm not sure if there 
> is any changes on tomato's recent firmware for tphy of this port, which could also 
> be a reason causes this kind of failure.
> I don't have tomato boards on hand.
> 

Hello Macpaul,

it's just about the usb node missing a power domain: as the PCIE_MAC_P1 domain
seems to be shared between USB and PCIe, adding it to the USB node fixes the
setup phase.

I'll send a devicetree fix soon.

Cheers,
Angelo

> Thanks
> Macpaul Lin


