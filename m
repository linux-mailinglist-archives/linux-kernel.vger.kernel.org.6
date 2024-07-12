Return-Path: <linux-kernel+bounces-250344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A0892F6BD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 10:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2C3283E69
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 08:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E7813FD66;
	Fri, 12 Jul 2024 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hwXvxf93"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F4913D8B5;
	Fri, 12 Jul 2024 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771964; cv=none; b=MBFAGkibFQFxFnPXnVwD9/3NOLB3Gd54qvfA4RpyEFslAKUxyIxjC1RpN4I1jAAORlST1ZFdE3bZ8kRfl6hFvRK2/vcH8LOM6RhZtgSVeBrgangiY5dgZgNyv54b6V6EXSu33yUE5YD1OJ3wxexmHcXtNHKeWpDZ2fvvLLfRvP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771964; c=relaxed/simple;
	bh=kFiBpebulkYfmvLg4+ljIHfgNRn3APPEyanZMEO28Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TB/WjF5G99gcIYzun8om/HyxHaR2W8KhiWZEt2HH3nASqyGg7GkKT4/9i7wGPqJgznLRLcMSs19KWjxly0QYtUcpzFK3nE2/Vl8wr/SwZlm5M6TIPJAwSzCdT8S5BMgi0jrnGX9wRFa9Y+p5uCDC640lvqR+Jv1kwWjclIpFVVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hwXvxf93; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720771961;
	bh=kFiBpebulkYfmvLg4+ljIHfgNRn3APPEyanZMEO28Mo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hwXvxf93LIkvwJSW/PiKLlKVHGhZ9aAMskv/wP3eQHrsqSIF9rEBY4HYntis/q2Ji
	 KdbkU3yqI3Fnju3gmmEow9sje6llQcD/MALXah5hIj4+J+ry4/XwGPKQcDoLUUd1rS
	 oQ8xMV6yjX/DnacjTIsbxvJtTVhR0VCNU805hb1FEroJLvXP7pGm83YOEU7L0hdAWo
	 WKYa+DapuO1MlyzhPasfr3LVxigLe81iY3Lxgz32fygVkgr8qazkF9Y6w79Kcht43T
	 fVl+ESkO7vhGkW+GPzMFX2JeT9n+FU6ld+4xKkpfzN5jSb8HpjBj1U4OH69eM2qgJZ
	 gtEUWzKLEPpKg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 83BCD3780BDB;
	Fri, 12 Jul 2024 08:12:40 +0000 (UTC)
Message-ID: <ac0d1ba5-1ed0-4d4d-a287-1d3e6efadc0a@collabora.com>
Date: Fri, 12 Jul 2024 10:12:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Probe failure of usb controller @11290000 on MT8195 after
 next-20231221
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Macpaul Lin <macpaul.lin@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 Chen-Yu Tsai <wenst@chromium.org>, Bear Wang <bear.wang@mediatek.com>,
 Pablo Sun <pablo.sun@mediatek.com>
References: <9fce9838-ef87-4d1b-b3df-63e1ddb0ec51@notapiano>
 <064935d8-fbda-4eda-b013-8c8fc63b561c@collabora.com>
 <375b2345-657a-4b8f-b5e3-dc16784ffde9@notapiano>
 <da27d957-866f-f055-9e83-cdc362d98dc7@mediatek.com>
 <2dba1638-f155-463b-8f87-421101b8f4f2@collabora.com>
 <521df3a8-5bc2-4e81-a819-02b755c88d3a@notapiano>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <521df3a8-5bc2-4e81-a819-02b755c88d3a@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 11/07/24 18:33, Nícolas F. R. A. Prado ha scritto:
> On Thu, Jul 11, 2024 at 11:21:14AM +0200, AngeloGioacchino Del Regno wrote:
>> Il 11/07/24 06:13, Macpaul Lin ha scritto:
>>>
>>>
>>> On 7/11/24 03:15, Nícolas F. R. A. Prado wrote:
>>>> On Fri, Jan 19, 2024 at 10:12:07AM +0100, AngeloGioacchino Del Regno wrote:
>>>>> Il 18/01/24 19:36, Nícolas F. R. A. Prado ha scritto:
>>>>>> Hi,
>>>>>>
>>>>>> KernelCI has identified a failure in the probe of one of the USB controllers on
>>>>>> the MT8195-Tomato Chromebook [1]:
>>>>>>
>>>>>> [   16.336840] xhci-mtk 11290000.usb: uwk - reg:0x400, version:104
>>>>>> [   16.337081] xhci-mtk 11290000.usb: xHCI Host Controller
>>>>>> [   16.337093] xhci-mtk 11290000.usb: new USB bus
>>>>>> registered, assigned bus number 5
>>>>>> [   16.357114] xhci-mtk 11290000.usb: clocks are not stable (0x1003d0f)
>>>>>> [   16.357119] xhci-mtk 11290000.usb: can't setup: -110
>>>>>> [   16.357128] xhci-mtk 11290000.usb: USB bus 5 deregistered
>>>>>> [   16.359484] xhci-mtk: probe of 11290000.usb failed with error -110
>>>>>>
>>>>>> A previous message [2] suggests that a force-mode phy property that has been
>>>>>> merged might help with addressing the issue, however it's not clear to me how,
>>>>>> given that the controller at 1129000 uses a USB2 phy and the phy driver patch
>>>>>> only looks for the property on USB3 phys.
>>>>>>
>>>>>> Worth noting that the issue doesn't always happen. For instance the test did
>>>>>> pass for next-20240110 and then failed again on today's next [3]. But it does
>>>>>> seem that the issue was introduced, or at least became much more likely, between
>>>>>> next-20231221 and next-20240103, given that it never happened out of 10 runs
>>>>>> before, and after that has happened 5 out of 7 times.
>>>>>>
>>>>>> Note: On the Tomato Chromebook specifically this USB controller is not connected
>>>>>> to anything.
>>>>>>
>>>>>> [1] https://urldefense.com/v3/__https://linux.kernelci.org/test/case/id/659ce3506673076a8c52a428/__;!!CTRNKA9wMg0ARbw!jtg5drII8WUPwTiL4sWZiSRPXN-EBN8ctTGI85sirqvkmaUbA5z-wrLqPPfxlZZkQ7NItOWDT97OSdENT5oGHKY$
>>>>>> [2] https://lore.kernel.org/all/239def9b-437b-9211-7844-af4332651df0@mediatek.com/
>>>>>> [3] https://urldefense.com/v3/__https://linux.kernelci.org/test/case/id/65a8c66ee89acb56ac52a405/__;!!CTRNKA9wMg0ARbw!jtg5drII8WUPwTiL4sWZiSRPXN-EBN8ctTGI85sirqvkmaUbA5z-wrLqPPfxlZZkQ7NItOWDT97OSdENi-d0sVc$
>>>>>>
>>>>>> Thanks,
>>>>>> Nícolas
>>>>>
>>>>> Hey Nícolas,
>>>>>
>>>>> I wonder if this is happening because of async probe... I have seen those happening
>>>>> once in a (long) while on MT8186 as well with the same kind of flakiness and I am
>>>>> not even able to reproduce anymore.
>>>>>
>>>>> For MT8195 Tomato, I guess we can simply disable that controller without any side
>>>>> effects but, at the same time, I'm not sure that this would be the right thing to
>>>>> do in this case.
>>>>>
>>>>> Besides, the controller at 11290000 is the only one that doesn't live behind MTU3,
>>>>> but I don't know if that can ring any bell....
>>>>
>>>> An update on this issue: it looks like it only happens if "xhci-mtk
>>>> 11290000.usb" probes before "mtk-pcie-gen3 112f8000.pcie". What they have in
>>>> common is that both of those nodes use phys that share the same t-phy block:
>>>> pcie uses the usb3 phy while xhci uses the usb2 phy. So it seems that some of
>>>> the initialization done by the pcie controller might be implicitly needed by the
>>>> usb controller.
>>>>
>>>> This should help to narrow down the issue and find a proper fix for it.
>>>>
>>>> Thanks,
>>>> Nícolas
>>>
>>> 'force-mode' should only applied to the boards which require XHCI
>>> function instead of a PCIE port.
>>>
>>> For example, mt8395-genio-1200-evk.dts requires property 'force-mode' to
>>> fix probe issue for USBC @11290000.
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux.git/commit/?h=v6.10-next/dts64&id=666e6f39faff05fe12bfc64c64aa9015135ce783
>>>
>>> 'force-mode' should be no need for tomato boards and the behavior should
>>> be the same as before.
>>>
>>> Another possibility is the firmware change on tomato boards. I'm not
>>> sure if there is any changes on tomato's recent firmware for tphy of
>>> this port, which could also be a reason causes this kind of failure.
>>> I don't have tomato boards on hand.
>>>
>>
>> Hello Macpaul,
>>
>> it's just about the usb node missing a power domain: as the PCIE_MAC_P1 domain
>> seems to be shared between USB and PCIe, adding it to the USB node fixes the
>> setup phase.
>>
>> I'll send a devicetree fix soon.
> 
> Hi,
> 
> As I replied to that patch
> (https://lore.kernel.org/all/20240711093230.118534-1-angelogioacchino.delregno@collabora.com)
> it didn't fix the issue for me, but I have more updates:
> 
> I confirmed the pcie was doing some required setup since disabling the pcie1
> node made the issue always happen, and that also made it easier to test.
> 
> I was able to track the issue down to the following clock:
> <&infracfg_ao CLK_INFRA_AO_PCIE_P1_TL_96M>
> 
> Adding it to the clocks property of the xhci1 node fixed the issue.
> 

Clocks is what I tried first, and didn't do anything for me...

..anyway, can you at this point try to run that solution on the multiple
devices that we have in the lab through KernelCI?

That would help validating that you're not facing the same false positive
as mine from yesterday...

> I'm just not sure from a DT perspective what's the right way to describe this
> clock. The node doesn't have the frmcnt_ck, is this that clock? Or is it
> another clock that currently isn't described in the dt-bindings and driver?
> 

That's the PCI-Express Root Port (RP) Transaction Layer (TL) clock... and I have
no idea why this has anything to do with USB.

MediaTek, is that a hardware quirk? What is the relation between this clock and
the USB controller at 11290000?

Thanks,
Angelo

> Thanks,
> Nícolas


