Return-Path: <linux-kernel+bounces-405835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F69C5A00
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA61B25B81
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE7E1F779E;
	Tue, 12 Nov 2024 12:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="QA2eTu6q"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE5F2309AA;
	Tue, 12 Nov 2024 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414889; cv=none; b=vFVy27UNjOdgI235kyeSXYdNLywcbeOmgLb63NwTCvyDdJIU7VKah3GDsJA1YbFIXlBX+bQABTC8vZuqcA8QzrUCzpojFYUVz7CwzR3x0k+NwyEEHeGEfuKNudgNG7UdyPL0lOPfEeXqldK3JMuOfU+IIrIiNOP/1Ev1p2fDAj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414889; c=relaxed/simple;
	bh=6hkOHTi8msLKBFkT1SnNQ3GCUtzhy4GYbjtYNMSNWYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Fiv8GRnOVTGaZhmhyMWIcJrRSh49v2Q2IQ33JrDdKCzfMlw9wDyQp5ybRr5mVbosDqPSdKPH50+C0bhtRGNw0974dFSUHebHWhCQdxOjaQqS0ob8XNZT6lq3IGVr90pTHSkiuhI/Yz0yx5t1f9zjn1uIZOegkyo9bxOu/THpiek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=QA2eTu6q; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=bz78wy1Ojt/VhaI70iMSW/EP3C6fegnHr1blD2YOME4=;
	t=1731414887; x=1731846887; b=QA2eTu6qVQN7ib/10x6fCaf2SWEfJ7wWjNiurLcloIKcPhL
	lZq6fJPlrS+z0Z9JMyVLHwQj8eSpQPJ74MFEOfX7kqjEl7H34S8FvJ097IitUzzVeWB6uM1xXPdPo
	HoIFf8vlYHE27xUE2vfC2usgkmrikrat1535RFbYNXiJQIOSdGNNu51QQI2W8exb3M8bApW8e1INC
	mRbbzP/T1oanOmu7ar5gY3psxH/JTTXpT75rT2hmJE/BPCEaoHtmQeXOS8mM+Qfr2D4hvDQR9Az9J
	HoARq+dqp+46VE2PQIqJB+XWNhYpxe5f4lzoa8PqE3eCKeVlMUbztvykebrvDTGg==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1tAq6T-00042N-MY; Tue, 12 Nov 2024 13:34:41 +0100
Message-ID: <44c39c87-90e2-4a74-a185-752c14f6d711@leemhuis.info>
Date: Tue, 12 Nov 2024 13:34:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] GM20B pmu timeout
To: airlied@gmail.com
References: <20241010133253.30311-1-diogo.ivo@tecnico.ulisboa.pt>
 <041511ee-4556-422a-8604-30b5e0dfd21c@leemhuis.info>
 <D5DDUQJOZ4HW.1XDOASECJR714@tecnico.ulisboa.pt>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-MW
Cc: kherbst@redhat.com, linux-kernel@vger.kernel.org, dakr@redhat.com,
 lyude@redhat.com, bskeggs@nvidia.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Danilo Krummrich <dakr@kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <D5DDUQJOZ4HW.1XDOASECJR714@tecnico.ulisboa.pt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1731414887;99190aed;
X-HE-SMSGID: 1tAq6T-00042N-MY

[CCing Danilo, who committed the culprit]

On 04.11.24 13:11, Diogo Ivo wrote:
> On Tue Oct 15, 2024 at 7:13 PM WEST, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 10.10.24 15:32, Diogo Ivo wrote:
>>>
>>> Somewhere between 6.11-rc4 and 6.11-rc5 the following error message is displayed
>>> when trying to initialize a nvc0_screen on the Tegra X1's GM20B:
>>>
>>> [ 34.431210] nouveau 57000000.gpu: pmu:hpq: timeout waiting for queue ready
>>> [ 34.438145] nouveau 57000000.gpu: gr: init failed, -110
>>> nvc0_screen_create:1075 - Error allocating PGRAPH context for M2MF: -110
>>> failed to create GPU screen
>>
>> Thx for the report. Hmmm. No reply so far. :-/
>>
>> Diogo, maybe report this here as well:
>> https://gitlab.freedesktop.org/drm/nouveau/-/issues/
>>
>> Afterwards drop a link to the ticket here. Reporting nouveau issues via
>> email should work, but maybe you have more luck there.
> 
> Gentle ping on this topic.

@airlied: I missed this earlier (and I assume you did, too), but seems
this regression is caused by the following change of yours:
9b340aeb26d50e ("nouveau/firmware: use dma non-coherent allocator")

For the full report see the start of the thread here:
https://lore.kernel.org/all/20241010133253.30311-1-diogo.ivo@tecnico.ulisboa.pt/

Diogo submitted an issue to the nouveau tracker as well:
https://gitlab.freedesktop.org/drm/nouveau/-/issues/391

Another user just joined and reported seeing similar problems.

And I just noticed there is another regression report bisected to the
same change:
https://gitlab.freedesktop.org/drm/nouveau/-/issues/388

Two users there are affected by the change; one of them in the 6.6.y
series and a revert there was able to fix this.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

