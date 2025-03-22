Return-Path: <linux-kernel+bounces-572407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A338A6CA0B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 13:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03CDC3BF506
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 12:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7B1F873F;
	Sat, 22 Mar 2025 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="scpQSNmm"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ACC3C0B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742645348; cv=none; b=U67BR3IyuB21lEpn5qMM/kicELEiTJWjLl3YpTl6J0jmV1hS9USf0Yfs8HB4T0PvEw3Ay43ABCocevkBq8DayH8EuR/2EZL5eR1ZRpcyZpo3Tf1Nk8Y+8ciQEyipGIefSYl/lpgbYo8NuF4sZjWnEAzA8SknevoWZJxW6/x+OJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742645348; c=relaxed/simple;
	bh=lOk6Q9GbItcYjS3MyQ2GK7v6nUZ3MsxnhrLSQqkoSn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkNoylAf7KsqFc/AF2QOfcwMk5PxFcYhfC4LfeAWBFZyLDUg7BRxYoupUZx7zFsG+vc8usrkRzdTPUXFea2PtPps2/ZM34qtBcoZhRnpvbFDaA+VMybPM+hGb0URH8rAlVCTH6EhJ2pPeXGkL1tKuZelpfiO8tSg/8TaFGayM8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=scpQSNmm; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZKdQJ5Thzz9scX;
	Sat, 22 Mar 2025 13:08:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1742645336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=91wz1uo9Id/8A84KilyrJxRxRY/FSqueMAvb4k7NbuE=;
	b=scpQSNmmV5h7qXt4zht+44hnygyu97Au3IBpe5arny41xi5IZjFqenBxnfZfk+1gEJqDHX
	7Wphdiee4SR1OzSN0gG2OL1Y2tpPGd/CpAVnFWX5Tm1VpQDrU/0qfup9tZ5l2JAWgea7I0
	tcMFUgpuLx2cY4uRQR5KzWAbIqR5eI9BfdjomXLvFqqTed6P3IAwlB85y72BS/C7fEtOuZ
	HmU02obOJ+Jz00YcXnHRcD/1AOEacvSibsPBtdQgSLP4iP/Td9a4kZQ8g8WvxrrqBmPiWz
	myLH6HvtHEEBWyn7T0nX2AEQuIjK9VFVDoKqjdT2/oyrXtdXpnavy7QPagZjDA==
Message-ID: <9f0da222-f75b-46a2-97d6-24f6e2da7abd@mailbox.org>
Date: Sat, 22 Mar 2025 13:08:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] arch/x86: Add an option to build the kernel with
 '-march=native' on x86-64
To: Arnd Bergmann <arnd@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <20250321142859.13889-1-torvic9@mailbox.org>
 <e37ee471-0b10-48d4-ad20-871e585c98f6@app.fastmail.com>
Content-Language: en-US
From: Tor Vic <torvic9@mailbox.org>
In-Reply-To: <e37ee471-0b10-48d4-ad20-871e585c98f6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 75cbc98373174601a47
X-MBO-RS-META: 165a7snimqmtf9ywdriggyyo69gz4uk5



On 3/22/25 12:40, Arnd Bergmann wrote:
> On Fri, Mar 21, 2025, at 15:28, Tor Vic wrote:
>> Add a 'native' option that allows users to build an optimized kernel for
>> their local machine (i.e. the machine which is used to build the kernel)
>> by passing '-march=native' to the CFLAGS.
>>
>> The idea comes from Linus' reply to Arnd's initial proposal in [1].
>>
>> This patch is based on Arnd's x86 cleanup series, which is now in -tip [2].
> 
> Thanks for having another look at this and for including the
> benchmarks. I ended up dropping this bit of my series because
> there were too many open questions around things like
> reproducible builds, but there is clearly a demand for having
> this included.
> 
>>        hackbench (lower is better):
>>        102.27 --> 99.50                         (-2.709 %)
>>
>>    - stress-ng, bogoops, average of 3 15-second runs:
>>        fork:
>>        111'744 --> 115'509                      (+3.397 %)
>>        bsearch:
>>        7'211 --> 7'436                          (+3.120 %)
>>        vm:
>>        1'442'256 --> 1'486'615                  (+3.076 %)
> 
> 3% in userspace benchmarks does seem significant enough to
> spend more time on seeing what exactly made the difference
> here, and possibly including it as separate options.

I didn't have a lot of time, so I only started 3 runs, and that is 
probably not enough to get accurate results as some tests are quite 
fluctuating.
I'm also not sure if those stress-ng tests are appropriate for this kind 
of testing, but I decided to include the results.

Suggestions for other benchmarks are welcome!

> 
>> +ifdef CONFIG_NATIVE_CPU
>> +        KBUILD_CFLAGS += -march=native
>> +        KBUILD_RUSTFLAGS += -Ctarget-cpu=native
>> +else
>>           KBUILD_CFLAGS += -march=x86-64 -mtune=generic
>>           KBUILD_RUSTFLAGS += -Ctarget-cpu=x86-64 -Ztune-cpu=generic
>> +endif
> 
> I assume that the difference here is that -march=native on
> your machine gets turned into -march=skylake, which then turns
> on both additional instructions and a different instruction
> scheduler.

IIRC, '-march=native' on Skylake turns into '-march=skylake -mabm' with gcc.

> 
> Are you able to quickly run the same tests again using
> just one of the two?
> 
> a) -march=x86-64 -mtune=skylake
> b) -march=skylake -mtune=generic
> 

Unfortunately that poor old laptop is quite slow, but I intend to run 
more tests on my much faster Zen2 machine next week.
I'll report back.

>      Arnd


