Return-Path: <linux-kernel+bounces-227126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C489148A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DDB91F226C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA3D13A244;
	Mon, 24 Jun 2024 11:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V+3exPVo"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C005137C2E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719228558; cv=none; b=twhVB1TCCyohNSQuoqCBN12NXcdG5oawUAsv6mVkW8vOEKYp28+adbkAUOAVSqABa+/oK5IHgx2nzxhJJxijiahoU39nhXThg9Gyxup8+lMtcSpMePrBYtgxCcE+wc8PvnJgEGRDB7kH5V5yf9NMBbVGOU/ben9zgVhO1waqbmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719228558; c=relaxed/simple;
	bh=hTxLy8mO7Anc77JfGNkN5gSzBb+4yPjURLOhsckT0Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5kGtiEIyWefbfP6MMtONGGWGVZtjRMU5+5eejr49jg8wRkrFtt7Ov0oI8PIy346DUPHR4Eo7WOaV6KU7yv8Fxmu0zMY+yzIykBnNucSLeYrDKavG09+1sP6sm+CHxoxmaA0D6JNRAqoeQGty5eUPwGpdOwshMdb5wSF6l7IzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V+3exPVo; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719228554;
	bh=hTxLy8mO7Anc77JfGNkN5gSzBb+4yPjURLOhsckT0Vc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V+3exPVo3fN28ivEtBAzZHG6zdNKfQzCR16LvupCem+0C9ynGEJ5dJ6Dn3/J9ekX9
	 bYhYB5oim5Yx7yL1CO+Tse7c7WK97VjoiOkXnY9zfrRHrl/gMMA+4+IMNL1jzTzLC2
	 YCi1Byh5ng8vkHKnsBHoAypLduDwNWasR20qs5pTmnZJu0U8pt8PbjaVcH0zzpGUoD
	 gc/ECsw934Tv+8/XMRANn7oAP2YPcLTNSJD4QbVeu3jXUV0GaxpR2FOuxEWwD3iy0O
	 sHD9UIi9PX1700bRnkFYgTWrsh7Ydym2zmmiQVZLhFE52sT3JDHUlvvD25QzvHt/GY
	 9QdSp7Dv1DD4A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3870C37804C6;
	Mon, 24 Jun 2024 11:29:14 +0000 (UTC)
Message-ID: <4e5d4362-4940-4ba0-95aa-627b82e21e41@collabora.com>
Date: Mon, 24 Jun 2024 13:29:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Move pm_runimte_get and put to
 mbox_chan_ops API
To: Jassi Brar <jassisinghbrar@gmail.com>,
 =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
 "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
 =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20240614040133.24967-1-jason-jh.lin@mediatek.com>
 <20240614040133.24967-3-jason-jh.lin@mediatek.com>
 <CABb+yY2bwj2BcdJLGe1ZYwCrnXL3LtcePMb=wQPaBKorBSs2yA@mail.gmail.com>
 <fc92d51cc6e55301c081ea2d589e1ba6cdd295ee.camel@mediatek.com>
 <CABb+yY1L+YGjf6O9UgPYkS2gWAdo=7QoojSAUNWC_8o7XtZQSg@mail.gmail.com>
 <1f815ff8-2b7a-48de-8b47-0bc9b3cb67ab@collabora.com>
 <CABb+yY1Yy8o3ofAiC-uV+gDrO3QDTWz3_XTUMai_2uyrnj-VrQ@mail.gmail.com>
 <b7ebc021d391452eaf2149976ea2d53fba3d89fc.camel@mediatek.com>
 <CABb+yY3+pnuXDK_jZMDYOAzahdSZ5iig51VqzM=FFHrFpK+9LA@mail.gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CABb+yY3+pnuXDK_jZMDYOAzahdSZ5iig51VqzM=FFHrFpK+9LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 20/06/24 16:39, Jassi Brar ha scritto:
> On Thu, Jun 20, 2024 at 1:33 AM Jason-JH Lin (林睿祥)
> <Jason-JH.Lin@mediatek.com> wrote:
>>
>> On Wed, 2024-06-19 at 10:38 -0500, Jassi Brar wrote:
>>>
>>> External email : Please do not click links or open attachments until
>>> you have verified the sender or the content.
>>>   On Wed, Jun 19, 2024 at 3:18 AM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>> Il 18/06/24 17:59, Jassi Brar ha scritto:
>>> .....
>>>
>>>> For example, when static content is displayed on screen, the CMDQ
>>> mailbox never
>>>> gets shut down, but no communication happens for a relatively long
>>> time; the
>>>> overhead of actually shutting down the mailbox and setting it back
>>> up would be
>>>> increasing latency in an unacceptable manner.
>>>>
>>> Hmm...  in your driver,  startup() is _empty_   and  shutdown() is
>>> all
>>> under a spin-lock with irqs disabled, so that too shouldn't be
>>> expensive. Right?
>>> Then what causes unacceptable latencies?
>>>
>>
>> I found that the BUG report only occurred when opening the camera APP.
>> Maybe something in imgsys_cmdq_sendtask() is too expensive or somewhere
>> else in imgsys driver.
>>
> If you move anything from submit() into startup(), which is once per
> lifetime of a channel, it will only make imgsys_cmdq_sendtask()
> cheaper.
> Btw, the imgsys code is not public, I don't know how it looks.
> 
> 
>> I'm wondering why this BUG report is not occurred in display use case
>> which is more frequent than imgsys use case.
>> Does this mean sleep() is not always called in pm_runtime_get_sync()
>> and if we can guarantee this sleep() won't be called, then using
>> pm_runtime_get_sync() in atomic context is OK?
>>
> Instead of hacking around, maybe try using startup() and shutdown()
> which is for such uses? Maybe request/release channel as part of RPM
> in your client driver if you are worried about the noise?
> 
> 
>>>> This is why I opted for autosuspend - it's only bringing down
>>> certain clocks for
>>>> the CMDQ HW, adding up a bit of power saving to the mix which, for
>>> some use cases
>>>> such as mobile devices with relatively small batteries, is
>>> definitely important.
>>>>
>>>> I'll also briefly (and only briefly) mention that 120Hz displays
>>> are already a
>>>> common thing and in this case the gap between TX and ACK is ~8.33ms
>>> instead, let
>>>> alone that displays with a framerate of more than 120Hz also do
>>> exist even though
>>>> they're less common.
>>>>
>>> I don't know how even busier channels help your point.
>>>
>>>> All of the above describes a few of the reasons why autosuspend is
>>> a good choice
>>>> here, instead of a shutdown->startup flow.
>>>> And again - I can place some bets that PM would also be applicable
>>> to SoCs from
>>>> other vendors as well, with most probably different benefits (but
>>> still with some
>>>> power related benefits!) compared to MediaTek.
>>
>> I agree with Angelo's point!
>>
> Ok, but you or Angelo still don't explain "unacceptable latencies"
> when your startup() and shutdown() are empty. You just want api
> changed, which we can but at least do you part and tell me where the
> bottleneck (unexpected latency) comes from.
> 

"I want numbers" is a sensible request, honestly I would do the same so I totally
understand that.

Jason, can you please perform latency measurements on 60Hz and *especially* ISP/cam
cases while "continuously" calling startup() and shutdown() for every power saving
operation?


Thanks,
Angelo

