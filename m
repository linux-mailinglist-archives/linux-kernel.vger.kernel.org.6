Return-Path: <linux-kernel+bounces-224162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B656911DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9330B251F8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E3C16F295;
	Fri, 21 Jun 2024 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="v4izR6Vw"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A415E16F0F6;
	Fri, 21 Jun 2024 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956587; cv=none; b=YYZDGdDjEuqTJshcc5CvB/qbVe4uk1h6MI5z0DhnFoinmAhej8Es8cNGULkpF65PF5ArfuM3nAa3ZLDYgnK0BD0jIfTpn4kd2VxJmh48PfQJEXRneOie8FjLVbZWRKDIwAiEnnQ7cQLmFjJBidSJ9K1Rjpc1EGAiRZIZsLmK9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956587; c=relaxed/simple;
	bh=6DSQuYQ1uEgRCZGH8rVjkNou/IsHOVw45KGYdtsaMoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9YLJHkU97KBDWVwipUDfaDFxtCL5F50J+VZZ9UY83iZCYavpTBhQr8MFatd3gB1/J/aK3Kzt/uGP0swpuiC0gDI3N3KOHdPBDvRTZUmw7172vxZVoY+2AatQ3BIS5kG2HTL4pCLC9c2Mt6GrJUy+KhB8RUFtrRbebnl6o2432g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=v4izR6Vw; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=EGT5e8L1pNhD0BVhYlvh53zXiul0Yh6rVbmqVvfwN2M=;
	t=1718956584; x=1719388584; b=v4izR6VwdX7WcFq0sBqNkoLtZFS2vmsbmxz3RjZWAietfwr
	pkiTPCgQJKkVTpys8gY26mKRuCwnp8utRgm14uY06DUDDM3nO1Xy5TTbMSdmtGvLREPSAavxdR3nr
	ySvYggBZzZzrOu3wjHL8BsWCF2HMz+g8vWQE5d0gQbFn6xzsTsABeIsl59TQ9RdRRSFzGFX079cm5
	C3sj21Rw5CStBLBwWTenelB6/3U98Jp8nZ6XybXA+7QYsPbL70o5ZKF/4chKihMH3M11qT6c0Gcrn
	k87cl+zStGf2DmKw/dtQ6q+xQOTCFiAVpJIGMCza+e5hga6Kyo9AexrtCC9PVa0Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sKZ8A-0007Fh-7F; Fri, 21 Jun 2024 09:56:22 +0200
Message-ID: <b6c440ca-e63e-429b-af41-5f27d4b8b2a2@leemhuis.info>
Date: Fri, 21 Jun 2024 09:56:21 +0200
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
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>, Rodrigo.Siqueira@amd.com,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <CABXGCsNptxsQO=5=qi-JYiFX=rX8Ok5inK80Gn0qrUFWbtBGng@mail.gmail.com>
 <CADnq5_PDxJ8O1JUQ9RBYRFB9G1WZJos05ZAM4jUKuPBwPxjNkA@mail.gmail.com>
 <CABXGCsNN9LwHc2x2AAEH=5UNwpvkWkBqRYz3OP8MZ6Woy+HDXA@mail.gmail.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CABXGCsNN9LwHc2x2AAEH=5UNwpvkWkBqRYz3OP8MZ6Woy+HDXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718956584;5e20c670;
X-HE-SMSGID: 1sKZ8A-0007Fh-7F

On 09.06.24 23:19, Mikhail Gavrilov wrote:
> On Fri, Jun 7, 2024 at 6:39 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>>
>> --- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
>> +++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.c
>> @@ -944,7 +944,7 @@ void optc1_set_drr(
>>                                 OTG_V_TOTAL_MAX_SEL, 1,
>>                                 OTG_FORCE_LOCK_ON_EVENT, 0,
>>                                 OTG_SET_V_TOTAL_MIN_MASK_EN, 0,
>> -                               OTG_SET_V_TOTAL_MIN_MASK, 0);
>> +                               OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */
>>
>>                 // Setup manual flow control for EOF via TRIG_A
>>                 optc->funcs->setup_manual_trigger(optc);
> 
> Thanks, Alex.
> I applied this patch on top of 771ed66105de and unfortunately the
> issue is not fixed.
> I saw a green flashing bar on top of the screen again.

Hmmm, I might have missed something, but it looks like nothing happened
here since then. What's the status? Is the issue still happening? Any
solution in sight?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke


