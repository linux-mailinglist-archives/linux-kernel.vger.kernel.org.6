Return-Path: <linux-kernel+bounces-569192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD8BA69FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F12189D6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E831E2611;
	Thu, 20 Mar 2025 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZA4c8He"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7DE15A8;
	Thu, 20 Mar 2025 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742451980; cv=none; b=ke+zi36Z7VZ/xWiWC91PwD6HJbEZAQLsY83eod5TX5ZN6BDYmWpMkBttMqJHE6t8sFLwlAik+RaazmL/wiiR3bnNwoPgIvJCgT5Glyzj1gZEF3H2pUwcJRPl2RkX/CssKD7xE/O/UQWu3O8gHym0DNpuLVlX3qaLoQa5SsRBba8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742451980; c=relaxed/simple;
	bh=OTeO1mDZ68FB/NGRuVKX7yUGtO4Y8nHFoWrewcm0+uE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cQNjzBnk/Ia2A2f28ImDXeo3zZ9duSiDxoUTXXYEsgM5fSh+3BWU7GhUFK4B9gjS4qcXmxwZe8ZFiZVGfMCfeoe1MJDhfShSl5Ya1+vYfUuTIwngjv0zwLZxNGJ8R2MU+W+3U8TFbTo1Pw8NUOT/VHnAbA6O3gOXgZx/bpyVpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZA4c8He; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7458AC4CEE7;
	Thu, 20 Mar 2025 06:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742451978;
	bh=OTeO1mDZ68FB/NGRuVKX7yUGtO4Y8nHFoWrewcm0+uE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HZA4c8HeCtpv6R6PzglcHMonN2ZkRlzOXLiQqGyP3xq28btIYjh80FLIwO0lOjD8J
	 HHlH/kqHGyOfPedR0y8+kaokEHEbO2+RD91wqiTL0LxPV7YQbOYP2pw9yHlYhAUoh3
	 8uD5b9F3wB3QNRbWqVpE4E1XCarYmSteCUmtx2B1q610plXe5lGyMv2YoAzELxUTsp
	 6KmrX2LNLZ7om2re2OuAbjd9UYMne+f6nvL/VPRpSmXUHCK4Ax9+U4nXDcreJkXmJU
	 cMDPaKODAbyNOxJ5Cikj/l6Rej5/ehct4IZZ0kFXxFtaQ6YZoZJdxqUlInd4JfX4AA
	 STyvR4EHTj0qg==
Message-ID: <1367aa41-3829-4cf7-9012-e3cb0ca42b58@kernel.org>
Date: Thu, 20 Mar 2025 07:26:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 55/57] docs: irq-domain.rst: Simple improvements
To: Randy Dunlap <rdunlap@infradead.org>, tglx@linutronix.de
Cc: maz@kernel.org, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20250319092951.37667-1-jirislaby@kernel.org>
 <20250319092951.37667-56-jirislaby@kernel.org>
 <4c71b7bd-5264-4a64-81bc-297dcf1c81a1@infradead.org>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <4c71b7bd-5264-4a64-81bc-297dcf1c81a1@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19. 03. 25, 18:54, Randy Dunlap wrote:
> Hi,
> 
> On 3/19/25 2:29 AM, Jiri Slaby (SUSE) wrote:
>> The improvements include:
>> * Capitals in headlines.
>> * Added commas: for easier reading, it is always desired to add commas
>>    at some places in text. Like before adverbs or after fronted
>>    sentences.
>> * 3rd person -> add 's' to verbs.
>> * End some sentences with period and start a new one. Avoid thus heavy
>>    sentences.
>>
>> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> ---
>>   Documentation/core-api/irq/irq-domain.rst | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
>> index 775dd43b3340..c2f2728b1a35 100644
>> --- a/Documentation/core-api/irq/irq-domain.rst
>> +++ b/Documentation/core-api/irq/irq-domain.rst
>> @@ -1,19 +1,19 @@
>>   ===============================================
>> -The irq_domain interrupt number mapping library
>> +The irq_domain Interrupt Number Mapping Library
>>   ===============================================
>>   
>>   The current design of the Linux kernel uses a single large number
>>   space where each separate IRQ source is assigned a different number.
>>   This is simple when there is only one interrupt controller, but in
>> -systems with multiple interrupt controllers the kernel must ensure
>> +systems with multiple interrupt controllers, the kernel must ensure
>>   that each one gets assigned non-overlapping allocations of Linux
>>   IRQ numbers.
>>   
> 
> (I'm OK with all of the changes here except this one:)
> 
>>   The number of interrupt controllers registered as unique irqchips> -show a rising tendency: for example subdrivers of different kinds
>> +shows a rising tendency. For example, subdrivers of different kinds
>>   such as GPIO controllers avoid reimplementing identical callback
>>   mechanisms as the IRQ core system by modelling their interrupt
>> -handlers as irqchips, i.e. in effect cascading interrupt controllers.
>> +handlers as irqchips. I.e. in effect cascading interrupt controllers.
> 
> I would just add a comma after "i.e.". In the new + line, the "I.e." part
> is not a sentence.

Thanks. Of course, so now, I have:

The number of interrupt controllers registered as unique irqchips
shows a rising tendency. For example, subdrivers of different kinds
such as GPIO controllers avoid reimplementing identical callback
mechanisms as the IRQ core system by modelling their interrupt
handlers as irqchips, i.e., in effect cascading interrupt controllers.


-- 
js
suse labs

