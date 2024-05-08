Return-Path: <linux-kernel+bounces-172928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3C98BF8DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CB651C21EF6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F342254729;
	Wed,  8 May 2024 08:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="hizxVp59"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDD45467E;
	Wed,  8 May 2024 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157511; cv=none; b=XgXYqUnOEBUzHUMB1f9Otj69QPaXs1T2PF7oreUPemsHDciCnNTBkT+RxPGDuwrOjtDVy2fxRsyM6MEwzdJ7nSGWvt8Zsu5CVK/DlMO3RoanTNaGlpGdGlKCSvfdEd3qDrtm0L3+F3yHTqbNIGpakAlrytBZ4ehAHIskyxPonOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157511; c=relaxed/simple;
	bh=X3eE9aXEFnT+IY4udsHePAfcwkQF8cQbEQifjJchhR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkZT4sflAUyruPtTt/XTcRXVpsBinxu3u0wGVZpRLOpvIr/TmR6CsDiWiZ1pahVelLr2c3OsuT2hVFxvxA3+KMEe7WwzcUGISfvnBA4e1QO74B2HzHmzAOgZ9vVmdzVa0sAgrMoK4cXDx2OhCC4L+uTDf0twsEXF5EagmIsq6xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=hizxVp59; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=sXwGXR0FJtuVEciSBc5fk9Oc+dnf3GpQ8oJ3KLUfNrk=;
	t=1715157509; x=1715589509; b=hizxVp5999jSavWVtXStYBIDU2bc9Bw5GXdUTXOPIlz4k2q
	mFGrMgFP3NV+ILqdmqwVsHZonapTZBKjZagbgNAfmbvs0sfHcmJlpV8ChSKKIj/O1aFlLdvmWJukU
	K9V0pAZEQ2bh57yJwkWrW4dbi2r3mK5GPGyXXfDvYX6Roa6Fu69Vkz2We/uf2TKdyv3iYmVXR4ab0
	U4mw3Lk34WkGZYbrINjk6IOlQmt85Bn2x7WPz56OB5cvZGMizt/Nj4nK9FKhBNHqR3O2v7NgZ9leG
	HSL3OW9I0LBCjnzuCwWMoRHdbyc3YJg79L+6q2Lym99bDAEyNRycTCHScbt3d5ww==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s4col-0007xb-8O; Wed, 08 May 2024 10:38:27 +0200
Message-ID: <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info>
Date: Wed, 8 May 2024 10:38:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
To: Thomas Gleixner <tglx@linutronix.de>, Lyude Paul <lyude@redhat.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, Borislav Petkov
 <bp@alien8.de>, Linux kernel regressions list <regressions@lists.linux.dev>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
 <87plumxz4x.ffs@tglx>
 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
 <87le59vw1y.ffs@tglx>
 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
 <87edautcmz.ffs@tglx>
 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715157509;180665cf;
X-HE-SMSGID: 1s4col-0007xb-8O

H! Lyude, Thomas, what's the status here? From here it looks like we
were close to a fix, but then it turned out to be a bad fix -- and
afterwards nothing much seems to have happened. Did it fall through the
cracks, or was this already fixed and I just missed that?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

On 02.05.24 12:33, Mario Limonciello wrote:
> On 4/25/2024 16:42, Thomas Gleixner wrote:
>> On Thu, Apr 25 2024 at 11:56, Lyude Paul wrote:
>>> On Thu, 2024-04-25 at 04:11 +0200, Thomas Gleixner wrote:
>>>>
>>>> Can you please boot a kernel with the commit in question reverted and
>>>> add 'possible_cpus=8' to the kernel command line?
>>>>
>>>> In theory this should fail too.
>>>
>>> Yep - tried booting a kernel with f0551af0213 reverted and
>>> possible_cpus=8, it definitely looks like that crashes things as well
>>> in the same way.
>>
>> Good. That means it's a problem which existed before but went unnoticed.
>>
>>> Also - it scrolled off the screen before I had a chance to write it
>>> down, but I'm -fairly- sure I saw some sort of complaint about "16 [or
>>> some double digit number] processors exceeds max number of 8". Which
>>> is quite interesting, as this is definitely just a quad core ryzen
>>> processor with hyperthreading - so there should only be 8 threads.
>>
>> Right, that's what we saw with the debug patch. The ACPI/MADT table
>> is clearly bonkers. The effect of it is that it pretends that the system
>> has 16 possible CPUs:
>>
>>      [    0.089381] CPU topo: Allowing 8 present CPUs plus 8 hotplug CPUs
>>
>> Which in turn changes the sizing of the per CPU data and affects some
>> other details which depend on the number of possible CPUs.
> 
> At least this aspect of this I suspect is caused by commit
> fed8d8773b8ea68ad99d9eee8c8343bef9da2c2c.
> 
> If you try reverting that I expect the "hotplug CPUs" disappear.
> 
>>
>> But that should not matter at all because the system scaling should be
>> sufficient with 8 CPUs, but it does not for some completely non-obvious
>> reasons.
>>
>> Can you please try to increase possible_cpus=N on the command line one
>> by one and check when it actually starts to "work" again.
>>
>> One other thing to try is to boot with 'possible_cpus=8' and
>> 'intremap=off' and see whether that makes a difference.
>>
>> I really have no idea where to look and not having the early boot
>> messages in case of the fail is not helpful as I can't add meaningful
>> debug to it.
>>
>> I just checked: the motherboard has a serial port, so it would be
>> extremly helpful to hook up a serial cable to this thing and enable
>> serial console on the kernel command line. That way we might eventually
>> see information which is emitted before it fails to validate the timer
>> interrupt.
>>

--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

