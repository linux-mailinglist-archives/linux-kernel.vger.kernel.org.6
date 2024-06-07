Return-Path: <linux-kernel+bounces-206048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A399900398
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 14:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730041C20AB0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AC41922F9;
	Fri,  7 Jun 2024 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="OhKVJSwR"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E665B15CD6F;
	Fri,  7 Jun 2024 12:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717763398; cv=none; b=Rkfu9MtfdW4esOHMUZJySDhbWo2/zc2vS9ZTlC3ZhwUBacDp+1RblIJnuixoX6+s6qme+WKHoF68fgz3JGSfkZR1PjmShvVlDmXx+oSBGRUjpmoTZosS8qUB1i0VieCL/hmmUXzDtGqi9AFh8kBtt3KrSFWBAu5lf5Xg5VzhPkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717763398; c=relaxed/simple;
	bh=pAjnHiGauws5+CicxJgy02cHibVVY+GtKqdxUCy75/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=LjAfHfeD8iX4HsES5dtpCwgEwqD2oCh0qvzjZyt6NDhm9b4A6BOIEJ46luhfxavjcgjh8EbH1Ouk3o+XCtPxmr7/gPf93e8f1ca/RwFpurn8sDJdQj0ZD6/s50AW9HKON0t1WrzAdHJOmY2HDxZ+Me3+oHPIVryiOlqMZuB1NzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=OhKVJSwR; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:Cc:From:References:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=0b/H9LXWLQSWch5rZCiHKuXD5l8MSK7jrgpIZrym1aA=;
	t=1717763396; x=1718195396; b=OhKVJSwRF9Ssl829vYExG//do6segcHNz1SyJ1kKQb61XSk
	DOiJhtZrwBZiooppqRUL/6HKD6cEn1NoWx27TDF18aZmmUv8sDxm0fWWAyLrEQWNSQQ07qJx2+yTy
	LxtqQPFmVGx1S+UiftNCVAGeWmbRgJ8vATtG9Nyv7vYR8rA/jZcEbjvu631u7Q/1Ro+lVu7zp84np
	ViM5zw0jBZ2nfh27XWMqofkMoIlk97YeNKOzmyXbKW51wDPJNrXWKHHA36vdLjHtrWpisE30GUUE2
	bSM71JVs0SU4DR8aTa0VcWJbrUfpma/DMpIMD4MYJHLwum/aXx9Yp4TpjsndHINw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sFYj6-00021T-4E; Fri, 07 Jun 2024 14:29:48 +0200
Message-ID: <907df295-61b2-4cb4-9bcc-608d1ff2cf18@leemhuis.info>
Date: Fri, 7 Jun 2024 14:29:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.10/bisected/regression - commits bc87d666c05 and 6d4279cb99ac
 cause appearing green flashing bar on top of screen on Radeon 6900XT and
 120Hz
To: "Deucher, Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
References: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
 <CABXGCsN=9UFvGgKztzkkAM1c8cVN-h=TKLLxWhKgTm11h+H-eg@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>, Rodrigo.Siqueira@amd.com,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CABXGCsN=9UFvGgKztzkkAM1c8cVN-h=TKLLxWhKgTm11h+H-eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717763396;458a3126;
X-HE-SMSGID: 1sFYj6-00021T-4E

[CCing the other amd drm maintainers]

On 05.06.24 14:04, Mikhail Gavrilov wrote:
> On Sun, May 26, 2024 at 7:06 PM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
>>
>> Day before yesterday I replaced 7900XTX to 6900XT for got clear in
>> which kernel first time appeared warning message "DMA-API: amdgpu
>> 0000:0f:00.0: cacheline tracking EEXIST, overlapping mappings aren't
>> supported".
>> The kernel 6.3 and older won't boot on a computer with Radeon 7900XTX.

Mikhail: are those details in any way relevant? Then in the future best
leave them out (or make things easier to follow), they make the bug
report confusing and sounds like this is just a bug, when it fact from
your bisection is sounds like this is a regression.

Anyway, @amd maintainers: is there a reason why this report did not get
at least a single reply? Or was there some progress somewhere and I just
missed it? Or would it be better if Mikhail would report this to
https://gitlab.freedesktop.org/drm/amd/-/issues/ ?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>> When I booted the system with 6900XT I saw a green flashing bar on top
>> of the screen when I typed commands in the gnome terminal which was
>> maximized on full screen.
>>
>> Demonstration: https://youtu.be/tTvwQ_5pRkk
>> For reproduction you need Radeon 6900XT GPU connected to 120Hz OLED TV by HDMI.
>>
>> I bisected the issue and the first commit which I found was 6d4279cb99ac.
>> commit 6d4279cb99ac4f51d10409501d29969f687ac8dc (HEAD)
>> Author: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> Date:   Tue Mar 26 10:42:05 2024 -0600
>>
>>     drm/amd/display: Drop legacy code
>>
>>     This commit removes code that are not used by display anymore.
>>
>>     Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>>     Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>>  drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h         |  4 ----
>>  drivers/gpu/drm/amd/display/dc/inc/resource.h                  |  7 -------
>>  drivers/gpu/drm/amd/display/dc/optc/dcn20/dcn20_optc.c         | 10 ----------
>>  drivers/gpu/drm/amd/display/dc/resource/dcn21/dcn21_resource.c | 33
>> +--------------------------------
>>  4 files changed, 1 insertion(+), 53 deletions(-)
>>
>> Every time after bisecting I usually make sure that I found the right
>> commit and build the kernel with revert of the bad commit.
>> But this time I again observed an issue after running a kernel builded
>> without commit 6d4279cb99ac.
>> And I decided to find a second bad commit.
>> The second bad commit has been bc87d666c05.
>> commit bc87d666c05a13e6d4ae1ddce41fc43d2567b9a2 (HEAD)
>> Author: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>> Date:   Tue Mar 26 11:55:19 2024 -0600
>>
>>     drm/amd/display: Add fallback configuration for set DRR in DCN10
>>
>>     Set OTG/OPTC parameters to 0 if something goes wrong on DCN10.
>>
>>     Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
>>     Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>>  drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c | 15 ++++++++++++---
>>  1 file changed, 12 insertions(+), 3 deletions(-)
>>
>> After reverting both these commits on top of 54f71b0369c9 the issue is gone.
>>
>> I also attach the build config.
>>
>> My hardware specs: https://linux-hardware.org/?probe=f25a873c5e
>>
>> Rodrigo or anyone else from the AMD team can you look please.
>>
> 
> Did anyone watch?
> 

