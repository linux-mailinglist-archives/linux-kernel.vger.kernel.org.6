Return-Path: <linux-kernel+bounces-220685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9B090E562
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9E41F21F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B3478C91;
	Wed, 19 Jun 2024 08:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n3CsIwOQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46143224D4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785138; cv=none; b=J34gdpUY2K7IhzULETnuJJg8k+S3/kdKK/vKADukbsjMHaDHoNGw8LyeNNsw2wbkoHZzqFAVcrPpJvysfgv75nPcGWY4LO+bWYSx3TdtsthJ/msoeX/MAfKIq6ZLVknz73IgTypaDf9MgOuoc2eJIP7ROGV2Ya7C57yYEat6IYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785138; c=relaxed/simple;
	bh=oYlLSyjsTtd58Hpnqjjem769849ygCKg/WUYhs0fxjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZ65UkywNtTnlLM1n7OQ3APbfDZC3R7g8OY34AeZX86cNOBDu1SVx9iMzAi7e2SLevX/owbwmw/lSiTzXVwrsLoa6WCDQzPutrpyHXB5qzMM2iu/fXRM3wbxIQfXR8MSx+ik/byeOtjCs+zMgtPUknuoaICUdazZlNp31E9oFdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n3CsIwOQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718785132;
	bh=oYlLSyjsTtd58Hpnqjjem769849ygCKg/WUYhs0fxjo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n3CsIwOQjzqur/lgnMMCJeWF+WdN7WWBQdSJM8x/5Mm4LAA9KuedLEeHCp9xp8JUH
	 lqBdEj531tJ8zD2SsMwBImswIEk8+3/xWMhKwsaPkzfBUCLl6tLyaG4phf3YZTteo4
	 pnPU7NwMTN3Y6ieN7XAaTXGLeWr3Izry9Om11ilgSCcWKY6ADOA0Xhqir9EULW1O5m
	 AF9aRF5CxSb+JcvLah2zSgosdnFd5mE1djnyMHXYwV1N8ISAO6ylVU0N+/AFlpB6tR
	 p/s+kX5KFQ1h6sTDK9z1Lsv9Io23Wvn8ZwbHRcxV0L95xski/bi4vQrJ6w03SnXEGv
	 d4g9I+9g8/dLw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 704B43782176;
	Wed, 19 Jun 2024 08:18:51 +0000 (UTC)
Message-ID: <1f815ff8-2b7a-48de-8b47-0bc9b3cb67ab@collabora.com>
Date: Wed, 19 Jun 2024 10:18:50 +0200
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
Cc: "linux-mediatek@lists.infradead.org"
 <linux-mediatek@lists.infradead.org>,
 =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <CABb+yY1L+YGjf6O9UgPYkS2gWAdo=7QoojSAUNWC_8o7XtZQSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/06/24 17:59, Jassi Brar ha scritto:
> On Tue, Jun 18, 2024 at 3:42 AM Jason-JH Lin (林睿祥)
> <Jason-JH.Lin@mediatek.com> wrote:
>>
>> On Mon, 2024-06-17 at 13:18 -0500, Jassi Brar wrote:
>>>
> ......
> 
>>> As in, how often and long are the "channel idle" periods? And when
>>> active, how many transfers/sec ?
>> Is there any debug logs in mailbox can measure this?
>>
>> This mailbox channel is use to configure display hardware in every
>> VSYNC, so the channel idle periods may be less than 16.66ms.
>>
>> It should call rx_callback() before VACTIVE, but sometimes it will be
>> dropped by mbox_flush() if the new message is coming.
>>
>>> I see every TX is acked by one RX packet. How long is the typical gap
>>> between a TX and its ack?
>>
>> Typical gap between a TX and its ack is less than 16.66ms.
>>
> So basically the usecase is driving some display at 60Hz. And I
> believe the display is driven
> continuously for at least some minutes ?
> If so, RPM between xfers is not really in effect because the
> autosuspend delay is 100ms while you
> get() it every 16.66ms. So all that is happening is some variables
> changed under a spinlock.
> I think you should consider get/put RPM in cmdq_mbox_startup() and
> cmdq_mbox_shutdown().
> 
> Thanks

With at least MediaTek (but surely more than just mtk), a system that is idling
while having display ON doesn't mean that the display is continuously refreshed
by the CPU and with CMDQ messaging.

For example, when static content is displayed on screen, the CMDQ mailbox never
gets shut down, but no communication happens for a relatively long time; the
overhead of actually shutting down the mailbox and setting it back up would be
increasing latency in an unacceptable manner.

This is why I opted for autosuspend - it's only bringing down certain clocks for
the CMDQ HW, adding up a bit of power saving to the mix which, for some use cases
such as mobile devices with relatively small batteries, is definitely important.

I'll also briefly (and only briefly) mention that 120Hz displays are already a
common thing and in this case the gap between TX and ACK is ~8.33ms instead, let
alone that displays with a framerate of more than 120Hz also do exist even though
they're less common.

All of the above describes a few of the reasons why autosuspend is a good choice
here, instead of a shutdown->startup flow.
And again - I can place some bets that PM would also be applicable to SoCs from
other vendors as well, with most probably different benefits (but still with some
power related benefits!) compared to MediaTek.

....And that's the reason why I think that implementing a way to cleanly perform
this kind-of-aggressive power management in mailboxes is something that needs to
be done.

Cheers,
Angelo

