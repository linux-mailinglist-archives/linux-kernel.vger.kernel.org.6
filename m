Return-Path: <linux-kernel+bounces-255221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3C6933D9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4EFB2415F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BDD1802D3;
	Wed, 17 Jul 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="exeJu63z"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7FE1802B2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721222917; cv=none; b=ZuseyHMLPNO4CtTsz7YG70mpSDNJxkPCBjBJEGyeP6S8lWULhuL5qjYTq+MqkEZucRkBqO/BqY/F/6pvgICcEKds9qoFYRawh9jTp5AO3xzJ93m3xSUjn8qtqg63jsb3jRsb4lzGZDOLE58zl8pBCuOzMX8luhkBGioG6eAGg2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721222917; c=relaxed/simple;
	bh=k4Lsi9TzISpSKVirxInoxjrE0QFIe83GF7y1SyUaTRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENwkq0OYhnPaHESqgn7PMA/7uWzysP5uAoE8PD8IS2A1GDxZGd9OKWmJ1chzBxMNNei7mt+yUKI+aY1HflP/WM77++tP8TDBydhUDo0GosR7bpbGrbhmmBwXScXjIg+w1oy6fVXE/bjBC9HWbB+1Sov1OTCGhbnaJB290j0gCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=exeJu63z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721222914;
	bh=k4Lsi9TzISpSKVirxInoxjrE0QFIe83GF7y1SyUaTRs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=exeJu63zcIjjr4WkG5mWgtT8xc/4/b3WRzy+dkUe6luE1hm4Qsz+YLGUhUWVnXGvk
	 Qt6OCTdYE9UC0NV3aQKYsTjVuCiV8n1urSEnbVEzbu/EDyaS+ocyfi0AtMYbj0vm2t
	 pJOL4kSs4oDw5lsYpWSVkaTi7hGrLNcjs69UAhY9j5kzjo3phmRmezPkmkohcU6DTi
	 WVGBWhU/Kvgd2xllxW9OS+TDTQESbXNujEhPunxAN8Ofpq+csAX+oy0HmNZ9n575bV
	 5bXmwbgXYXXiEHoR4+LRUC3nNRy+MuTSr00w6BrMWKVob0XP/zSFAYPWWSmSDbii0I
	 TLRD+oUFBl3jg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 63A7D37805D6;
	Wed, 17 Jul 2024 13:28:33 +0000 (UTC)
Message-ID: <aa1cfc45-b271-43fa-85fc-264ea16574d9@collabora.com>
Date: Wed, 17 Jul 2024 15:28:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: mtk-cmdq: Add unregister mailbox controller in
 cmdq_remove()
To: =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
 "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20240613150626.25280-1-jason-jh.lin@mediatek.com>
 <8ef254cb-ac65-405d-bcee-d0990536fb32@collabora.com>
 <44f6308379a8b6c834df6ff0604c652bf1f7a4b7.camel@mediatek.com>
 <47f1c2c79ad03094ebf411e13516cca47054c962.camel@mediatek.com>
 <a681e496-4979-4f4a-9f79-9636d9496fa3@collabora.com>
 <470f96fc0dd48ad0ad6bedb235a2e510c808e3e7.camel@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <470f96fc0dd48ad0ad6bedb235a2e510c808e3e7.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 17/07/24 05:44, Jason-JH Lin (林睿祥) ha scritto:
> On Tue, 2024-06-18 at 13:47 +0200, AngeloGioacchino Del Regno wrote:
>> Il 18/06/24 05:28, Jason-JH Lin (林睿祥) ha scritto:
>>> Hi Angelo,
>>>
>>> On Fri, 2024-06-14 at 00:52 +0800, Jason-JH.Lin wrote:
>>>> Hi Angelo,
>>>>
>>>> On Thu, 2024-06-13 at 17:10 +0200, AngeloGioacchino Del Regno
>>>> wrote:
>>>>> Il 13/06/24 17:06, Jason-JH.Lin ha scritto:
>>>>>> Add unregister mailbox controller in cmdq_remove to fix cmdq
>>>>>> unbind
>>>>>> WARN_ON message from pm_runtime_get_sync() in
>>>>>> cmdq_mbox_shutdown().
>>>>>>
>>>>>> Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ
>>>>>> driver")
>>>>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>>>>>
>>>>> Hello,
>>>>>
>>>>> I think you forgot about...
>>>>>
>>>>>
>>>>
>>>>
>>>
>>>
> https://lore.kernel.org/all/6fcd48b14e865c25e6db7559fe6b946537bfa0ce.camel@mediatek.com/
>>>>>
>>>>
>>>> I'll send this series next week after testing it.
>>>>
>>>>
>>>>> ...as that would also resolve this one without any hacks.
>>>>
>>>> I thought it was another problem, so I sent this patch.
>>>>
>>>> After looking to the kerneldoc of
>>>> devm_mbox_controller_unregister(),
>>>> I
>>>> found that it's not necessary to call this anywhere.
>>>>
>>>> I'll drop this patch. Thanks for the review.
>>>
>>> I found that the series of "Move pm_runimte_get and put to
>>> mbox_chan_ops API" can not fix this unbind crash issue.
>>>
>>> It seems they are 2 different issues.
>>>
>>> So I think calling devm_mbox_controller_unregister() in
>>> cmdq_remove()
>>> can ensure the CMDQ device is not removed and be paired to
>>> cmdq_probe().
>>>
>>
>> Can you please paste the stack trace of that warning that you're
>> seeing when
>> calling cmdq_remove()?
>>
>> I'm not convinced that this is the best solution - it might be, but I
>> have
>> a hunch that there might be a better way to address this issue.
>>
> 
> After tracing the stack trace again, I found this call trace warning is
> caused in WARN_ON(pm_runtime_get_sync(cmdq->mbox.dev) < 0). The return
> value of pm_runtime_get_sync() is -13(-EACCESS) that's caused by
> calling pm_runtime_disable() before calling pm_runtime_get_sync().
> 
> CMDQ driver uses devm_mbox_controller_register() in cmdq_probe() to
> bind the cmdq device to the mbox_controller, so
> devm_mbox_controller_unregister() will automatically unregister the
> device bound to the mailbox controller when the device-managed resource
> is removed. That means devm_mbox_controller_unregister() and
> cmdq_mbox_shoutdown() will be called after cmdq_remove().
> 
> CMDQ driver also uses devm_pm_runtime_enable() in cmdq_probe() after
> devm_mbox_controller_register(), so that devm_pm_runtime_disable() will
> be called after cmdq_remove(), but before
> devm_mbox_controller_unregister().
> 
> 
> To fix this problem, we need to make devm_pm_runtime_disable() be
> called after devm_mbox_controller_unregister().
> 
> I've tried 2 ways can fix this problem:
> - Swap the sequence of devm_mbox_controller_register() and
> devm_pm_runtime_enable() in cmdq_probe()
> - Change to use mbox_controller_register() in cmdq_probe() and use
> mbox_controller_unregister() in cmdq_probe()
> 

Hey.

That's a nice conclusion here!
If the first one has no issues, go for the first one: that's just about
moving a call upwards, noiseless and pretty.

Cheers!
Angelo

> Which one do you think is better?
> 
> Regards,
> Jason-JH.Lin
> 
>> Thanks!
>> Angelo
>>
>>> Regards,
>>> Jason-JH.Lin
>>>
>>>>
>>>> Regards,
>>>> Jason-JH.Lin
>>>>
>>>>>
>>>>> Cheers,
>>>>> Angelo
>>>>>
>>>>>> ---
>>>>>>     drivers/mailbox/mtk-cmdq-mailbox.c | 2 ++
>>>>>>     1 file changed, 2 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c
>>>>>> b/drivers/mailbox/mtk-cmdq-mailbox.c
>>>>>> index 4aa394e91109..1399e18a39a4 100644
>>>>>> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
>>>>>> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
>>>>>> @@ -371,6 +371,8 @@ static void cmdq_remove(struct
>>>>>> platform_device
>>>>>> *pdev)
>>>>>>     {
>>>>>>     	struct cmdq *cmdq = platform_get_drvdata(pdev);
>>>>>>     
>>>>>> +	devm_mbox_controller_unregister(&pdev->dev, &cmdq-
>>>>>>> mbox);
>>>>>> +
>>>>>>     	if (cmdq->pdata->sw_ddr_en)
>>>>>>     		cmdq_sw_ddr_enable(cmdq, false);
>>>>>>     
>>>>>
>>>>>
>>
>>




