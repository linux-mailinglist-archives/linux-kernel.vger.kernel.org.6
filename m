Return-Path: <linux-kernel+bounces-195147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDB18D482D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B209282DD2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB7F18397F;
	Thu, 30 May 2024 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="dEKR10ft"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F366183970;
	Thu, 30 May 2024 09:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717060447; cv=none; b=t/8gvcR6SzXsLyOnLM0pMq8z2MBoPBt4jWAsCQ40mMC6AAI3mdu6Uvruzq95phI8esllYJb2kfo0bKt7Ni/NBarkgfJ9MUl1+rceXWJqvT08pRD+HUOYWLMW17B0Nt03xbL6+1ZFM53gvhaa4gtTYtj6I7aG5fMYd04s6H15zMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717060447; c=relaxed/simple;
	bh=A2aV9xGJ6LW10FiPRaoqQ0PipJ2/sH52upDc+kyhscs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ttDWjqiMQdbfBbZ6IcHmRk6KbbZBNBCnpBQcQhe0WpYnm/WT1B4aOdtljzebxfzAsxb/kHn/g60CRqsOBKuUvjsSxcfvUlFMyoPaW5MruteCpmGiBR0QPpoV1tamh+k+l+Vege/Y/sShUGL9u/xyY4yobQEtmoqNw5gRuvGQiRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=dEKR10ft; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Rjfa4YBlzCW8NkUtWIU6YqmFfTRFUqSA1THCpC8EBoQ=;
	t=1717060445; x=1717492445; b=dEKR10ftxql9j4qa56ExvhL2yr8BwUkp1gmD8PXoRLhVhMm
	WBNFFG0mZTPmrSdFauIKQdB5wF/tmS14EoAGb0visXXWWKpuqJNL7j/uzH6ox+qWlUcU1BlNgiwEG
	Ge3H+eKoKfBmThNQf0kt3AqK+ycsMRAVdrydqcHiHNihdcZn0KCQfkqNW5DUzfoGy4uVd4yfCLRvb
	Zy4zQxutUL37c1dq2G3GlXaNxRSbBuOjLy41lyR9ZR6n74qzq60r3xT5+87+JClsIqkSBHGD0mbK5
	gmNFdYS2KjEqk96EVrZO4shv8D8mN9qqa9DaDcZrjCA6NkmSMGWSjO9vcq+mZwcQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sCbrA-0003Ur-0w; Thu, 30 May 2024 11:13:56 +0200
Message-ID: <4532ae8d-b72e-4d76-894f-144910370f97@leemhuis.info>
Date: Thu, 30 May 2024 11:13:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] commit fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6
 (Linux 6.7+) crashes during boot
To: =?UTF-8?Q?J=C3=B6rn_Heusipp?= <osmanx@heusipp.de>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Adam Dunlap <acdunlap@google.com>,
 1071378@bugs.debian.org
References: <ebb0791c-60a5-4fe3-bc85-4921ad026605@heusipp.de>
 <4611b3c8-0ef6-4951-8b34-10a1c7262355@leemhuis.info>
 <5e31cad3-ad4d-493e-ab07-724cfbfaba44@heusipp.de>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <5e31cad3-ad4d-493e-ab07-724cfbfaba44@heusipp.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717060445;41eaa14e;
X-HE-SMSGID: 1sCbrA-0003Ur-0w

On 30.05.24 10:45, Jörn Heusipp wrote:
> 
> On 30/05/2024 09:27, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 30.05.24 08:55, Jörn Heusipp wrote:
>>> commit fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6 ("x86/sev-es: Set
>>> x86_virt_bits to the correct value straight away, instead of a two-phase
>>> approach") crashes during boot for me on this 32bit x86 system.
>>
>> FWIW, not my area of expertise, but there is a patch from Dave with a
>> Fixes: tag for your culprit up for review:
>> https://lore.kernel.org/all/20240517200534.8EC5F33E@davehans-spike.ostc.intel.com/
> 
> That did not apply cleanly to 6.10-rc1,

Maybe something changed since then.

> but I figured it out manually. I
> can confirm that it fixes the issue.

Cool. Guess Dave in that case might be happy about a "Tested-by" tag
from you:
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot dup:
https://lore.kernel.org/all/20240516173928.3960193-1-andriy.shevchenko@linux.intel.com/
#regzbot fix: x86/cpu: Provide default cache line size if not enumerated
#regzbot related:
https://lore.kernel.org/all/20240517200534.8EC5F33E@davehans-spike.ostc.intel.com/

