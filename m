Return-Path: <linux-kernel+bounces-260190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF1F93A459
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C148D1C22935
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29909157E87;
	Tue, 23 Jul 2024 16:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="Jwv7AFz3"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55525157A4F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751877; cv=none; b=bTww2nWglZD3w3mKaNWTfQ5jxPNew4mgpYMEHkP49SH7b03/b4N1TpMLl7TmkOztrGCvJ5fuqbbdvBDIJXX/Z/KwDMzjzQuqWNuRBIgoHE6yEZcSZ4krfi4bOlKlhMlaK196XqsuncBQB78QYiax2HwDdsUhofAJbon6k1ozwLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751877; c=relaxed/simple;
	bh=wvLwwzYrHhNMEY0a2RER3JTiGWI4BVmIq+FIHkHnZzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XxPUlrmR1q6VEZzTXsJF2dyuAjYJ8Kx62gaOFxHsnc9z9CyHyq5KTR51WNBmjSXv9hcywDP8bmmkfYpKzn2K6TUJxpFokplQUJez4fdDjBXGu277OFX/gxlzdmXHSMNjD5XepWynPGIC89GPtmabF1d33Kjpkjc+AQNcYDH4C/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=Jwv7AFz3; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 28D5041E57;
	Tue, 23 Jul 2024 16:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1721751866; bh=wvLwwzYrHhNMEY0a2RER3JTiGWI4BVmIq+FIHkHnZzI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Jwv7AFz316hnUeeBX5Gao/DhsQt99fmbZIit8dDUoQQDFPbc2OqXIVkeIwcIveSgD
	 /rg4W8/EHcZ2aNQaf5OhIu1np7rYKkqXo5eraxsUS9AMUOtecpHl4z4HOs3nix8fg3
	 VOU6e+r8z+c8Fep0DNhP0rSkDHJsr+wNhGjZ/RR70eM+ESWFobpALauntv5E0yeOWV
	 pYhhNxSZduOMB6xk9u3UBWqjIIWEZImJD5X8tfqcMfhOHTD+pvIzQDFNIUMpwxqoYt
	 bMeP3oPIPCVzCqwZNEa2CsBR3IqNIgVICIAq3E+a6/X/IGip2x6GgZV4lTAFESTdDX
	 ylyDr02FCHz/g==
Message-ID: <dbf17fa6-1af6-467b-8b3d-dca8476dc785@marcan.st>
Date: Wed, 24 Jul 2024 01:24:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drivers/perf: apple_m1: fix affinity table for event
 0x96 and 0x9b
To: Will Deacon <will@kernel.org>, Yangyu Chen <cyy@cyyself.name>
Cc: Marc Zyngier <maz@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>, Janne Grunau <j@jannau.net>,
 Asahi Lina <lina@asahilina.net>, asahi@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <tencent_7B71486CE305DF8AE084B6BB6313EE550C06@qq.com>
 <20240701140148.GE2250@willie-the-truck> <87cynxp52o.wl-maz@kernel.org>
 <87bk3hp3z7.wl-maz@kernel.org>
 <tencent_371517268623E4A61194EF4C70497BDC5105@qq.com>
 <8634oshxhj.wl-maz@kernel.org> <20240702121340.GB3542@willie-the-truck>
 <tencent_A6F18ECEB80131BA21638D187C6782F6DA08@qq.com>
 <20240708120026.GC11771@willie-the-truck>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <20240708120026.GC11771@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/07/08 21:00, Will Deacon wrote:
> On Tue, Jul 02, 2024 at 08:43:16PM +0800, Yangyu Chen wrote:
>>
>>
>>> On Jul 2, 2024, at 20:13, Will Deacon <will@kernel.org> wrote:
>>>
>>> On Tue, Jul 02, 2024 at 11:58:00AM +0100, Marc Zyngier wrote:
>>>> On Tue, 02 Jul 2024 11:22:21 +0100,
>>>> Yangyu Chen <cyy@cyyself.name> wrote:
>>>>>
>>>>>> Yangyu, can you please clarify how you came to the conclusion that
>>>>>> these events didn't count anywhere other than counter 7?
>>>>>>
>>>>>
>>>>> IIRC, I came across some web page that says events 0x96 and 0x9b
>>>>> can only be installed on counter 7 to count Apple AMX, but I can't
>>>>> find the page now. Since AMX is not usable in Linux, I don't know
>>>>> if this will affect some other instructions that are usable in
>>>>> Linux.
>>>>
>>>> As you said, AMX cannot be used with Linux, and that's unlikely to
>>>> ever change. But when it comes to the standard ARM ISA, we can only
>>>> witness counters 5,6 and 7 being incremented with at the exact same
>>>> rate.
>>>>
>>>> So reading between the lines, what I understand is that AMX
>>>> instructions would only have their effects counted in counter 7 for
>>>> these events, while other instructions would be counted in all 3
>>>> counters.
>>>>
>>>> By extension, such behaviour could be applied to SME on HW that
>>>> supports it (wild guess).
>>>>
>>>>> There are some other reasons, but I can't say in public.
>>>>
>>>> Fair enough, I'm not asking for the disclosure of anything that isn't
>>>> public (the least I know, the better).
>>>>
>>>>> Even though I can't find the actual usage, I think using count 7
>>>>> only for these 2 events is safer. If this reason is insufficient,
>>>>> we can ignore this patch until we find other evidence that this
>>>>> affinity affects some instructions usable in Linux.
>>>>
>>>> I honestly don't mind.
>>>>
>>>> The whole thing is a black box, and is more useful as an interrupt
>>>> generator than an actual PMU, due to the lack of freely available
>>>> documentation. If the PMU maintainers want to merge this, I won't
>>>> oppose it.
>>>
>>> I'd rather leave the code as-is than tweak specific counters based on
>>> a combination of guesswork and partial information.
>>>
>>> Of course, if somebody who knows better wants to fix up all of the
>>> mappings (because this surely isn't the only corner-case), then we can
>>> take that. But at least what we have today has _some_ sort of consistent
>>> rationale behind it.
>>
>> Actually, anyone who has macOS software can learn the whole affinity
>> table of PMU. The detailed information can be extracted from a plist
>> file stored in the macOS root filesystem. I also provide that script
>> [1] to extract this information.
>>
>> However, I can't directly use this information for legal concerns.
>> Would this be acceptable if the information I provide matches Apple's
>> information? I can't say whether it matches or not in public. I can
>> only say we can easily find someone who uploaded this file to the
>> internet.
>>
>> [1] https://github.com/cyyself/m1-pmu-gen
> 
> I can't say I feel hugely comfortable with this, so I'll leave the code
> as-is unless a patch shows up fixing all the events.
> 
> Thanks for the reply, though. You've clearly spent a bunch of effort on
> this and it's a pity we can't easily apply your results to the driver :/
> 
> Will
> 

Putting on my "reverse engineering hardware for over a decade" hat on:
Facts about hardware are not copyrightable. If they were, our entire
effort would be legally questionable to begin with (as would all Linux
porting efforts to undocumented hardware).

Data files can be, but if the information contained within them is
purely non-copyrightable (as an affinity mapping for PMU events would
be), then it is entirely legal and acceptable to use that information to
create a patch, as long as the information itself was legitimately
obtained (which it can be for any macOS user, which by extension means
any owner of an AS Mac since macOS is implicitly licensed).

In other words, if you have macOS, and you run those scripts and
generate some patches for Linux that add the event definitions and
mappings, then it would not cause any copyright infringement concerns
for the Linux kernel side and they can be licensed GPLv2.

I have acquaintances who have consulted lawyers about this issue and am
very confident in this interpretation. More specifically, I'm told there
is legal advice that hardware register names are not copyrightable
(which goes beyond pure hardware facts as there is some freedom to
choose naming schemes). PMU event names are analogous here.

The big no-nos are ripping and redistributing files from macOS verbatim
(when that is necessary, we treat it as firmware and already have a
process in place to avoid redistribution, e.g. what we do for camera
sensor calibration blobs, but that is not the case here), using
*leaked/stolen* information (not legitimately obtained, e.g. actual
internal documentation that was stolen), and potentially
decompiling/reverse engineering actual executable code (things get very
complicated in this case, but it is not impossible to do legally).

For more details, we have a page on our copyright policy for the Asahi
project and how to avoid running into legal issues:
https://asahilinux.org/copyright/

TL;DR I would not have any copyright concerns about submission of a
patch adding all the PMU definitions (general event names and affinity
mappings).

- Hector

