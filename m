Return-Path: <linux-kernel+bounces-390145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B429B7622
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 09:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64ECE282A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04EF7155759;
	Thu, 31 Oct 2024 08:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="TqLnFzFR"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1471531D2;
	Thu, 31 Oct 2024 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362453; cv=none; b=PDrxO75w8xYpcNjyD79rDyUPy22M7UGJpp9qWqy2moNK8njCOMz9ElG4Ly9YbZapO4II4woREQrc32h5sL+drU+koaITXgBkjJi1XaXN26W5+bitsh2Dk0ZjgMMGsMFDRlf2D7S8bm2VZ6yxR34tKd+jI/aLfyp+aygI0yz/CVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362453; c=relaxed/simple;
	bh=8Ry/bqABZG9/VxfV7jo79ufYHQmfC1rvZ3bjnCixvNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=njjTJAKGZ5oOPOVW8fUd+J361JNT4+H4OD/5wsOfitmQou+rTVN4pR9WuqZhMm+guoNWW/Ow3OYQmxOVJttJ9QizX64hI60f9PNr6TuA760HIAcGemCODEHqqUUPiSsWJmpWZIVvbv3IbDHZAxl3HjhMzV1iIiOOoaGJOOCFLBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=TqLnFzFR; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=MsXxYYitRV1/mQ1Di2ImU1do9MFGuz/OZfNqgY/sfVY=; t=1730362449;
	x=1730794449; b=TqLnFzFRxY8E7TEzmX1rmV0NwexfUkkY9KiTvovRObQFyfVod/lGaNbbpuqPP
	Fr3WijM9Q3pHGZCaYjWOhxIqBUI6ctbxhKxA1cFn8pZRIv9WPnhCuWKc66OgBnfaVfaEV0cXoMjIt
	hUmt9cBSWCJlMyTS1XMUXh9vNcvY8i0UHkiVHmCLimz6c734+LncP8z8m85UeH0uAJLFrY103E4kD
	ffh84kceOZWLAE6Q1Zk0V2XA3AkpPwa2hsQb2RKArL7F66XM+yrTfboSmZCBZ8V9nMtAKrBYZC9of
	bfAsbeQemMo5bqRrBqMT81TeoHL+grgjdkCHPMbpRf8sdZchrA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1t6QJZ-0005pZ-Vq; Thu, 31 Oct 2024 09:13:58 +0100
Message-ID: <e6aa8071-e204-45a1-8228-30533ef787bb@leemhuis.info>
Date: Thu, 31 Oct 2024 09:13:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
To: Sasha Levin <sashal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>,
 torvalds@linux-foundation.org, ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org> <ZyAUO0b3z_f_kVnj@sashalap>
 <d75c9c2f-353f-464c-89d3-8c18dbfb4770@leemhuis.info>
 <ZyDHZHjxwmK1Ow9e@sashalap>
 <292de8f0-49e7-49c8-a327-b279924a5794@leemhuis.info>
 <ZyD6QioGPyJUXI5r@sashalap>
 <58c58550-532a-4cfa-947d-ed56c6c5ba4e@leemhuis.info>
 <ZyI-Y00J3DBUkon3@sashalap>
From: Thorsten Leemhuis <linux@leemhuis.info>
Content-Language: en-US, de-DE
Autocrypt: addr=linux@leemhuis.info; keydata=
 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 n7RI
In-Reply-To: <ZyI-Y00J3DBUkon3@sashalap>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1730362449;d626bb05;
X-HE-SMSGID: 1t6QJZ-0005pZ-Vq

On 30.10.24 15:10, Sasha Levin wrote:
> On Wed, Oct 30, 2024 at 07:46:40AM +0100, Thorsten Leemhuis wrote:
>> On 29.10.24 16:07, Sasha Levin wrote:
>>> On Tue, Oct 29, 2024 at 01:46:23PM +0100, Thorsten Leemhuis wrote:
>>>> Hmmm. After all those mails in this thread improving (and maybe even
>>>> separating & somewhat automating[1]) pending-fixes to me still sounds
>>>> like time better spend, as then more things could tested before they
>>>> even read a PR; but yes, I understand, the timing/order of merges can
>>>> mess things up, so testing on PR time has benefits, too.
>>> Automating how? Having it be generated more often?
>>
>> Have the list of -fixes trees which a "no rebases" policy somewhere and
>> a script that regularly merges them into a tree. But as indicated, it's
>> not that easy in practice and can't be fully automated, as there will be
>> merge conflicts occasionally. But Linus wants to see them, so they will
>> happen at pull requests time, too -- doing it constantly has the benefit
>> that you can notice and resolve them ahead of time.
>>
>> How much work this is: no idea, maybe Stephen could help answering that
>> from experiences for pending-fixes. But I expect conflicts should not
>> happen as often as they do when it comes to merging -for-next branches.
>>
>> But that obviously only helps outside of merge windows.
> 
> Do you want to give it ago?
> 
> I've pushed something to
> https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git/
> log/?h=auto-pending-fixes
> , and scripted a bit around it to try and keep it updated.

Cool!

> We can try a model where it tries to avoid rebases as much as it can,
> and if it needs to rebase it will tag the old HEAD before re-creating
> the branch?

So here is the thing: with regression tracking I'm already having a huge
never ending and hard task that creates a lot of work every day -- work
I'm not getting payed for now since months with no concrete funding
solution yet on the horizon. So I don't want to put even more work on my
shoulders with helping in other areas currently, sorry.

That being said: I'm willing to help with creating improvements for our
docs (something along the lines of "you should have a -fixes branches
that is never rebased that is included in the -pending-fixes branch of
-next and -auto-pending-fixes") and even trying to talk maintainers into
that do not yet have such a branch into maintaining one.

Ciao, Thorsten

