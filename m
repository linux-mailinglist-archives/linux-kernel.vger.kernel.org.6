Return-Path: <linux-kernel+bounces-394190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 686689BAB9A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:48:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CD8528236F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 03:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214D4165F04;
	Mon,  4 Nov 2024 03:48:27 +0000 (UTC)
Received: from mail.quantum.ru (mail.quantum.ru [213.170.105.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE8420326
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 03:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.170.105.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730692106; cv=none; b=Kls671DDF1sK6qg3v8//HE/wWq0ZCX6Y11UJOKduZ5zDgaXYVBQWHp7V2tAh7z61T0r/nheQDyVKrXXM4Z/78Az5uMBs0M24aZB0mP9AGewpzVndfjeklrMj+m8fA19sLQZ1QvsrtDw2yXnONiuF8Vi2nqbIoJeR5xQ7WomNaeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730692106; c=relaxed/simple;
	bh=IulaKoYCP3mDFSYzMq1xWggszc3Qfod5RC01fXTRN5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pd61I+tQny0j5mwhGoJN6+6JOsFy3WKrX5fJtZ8sATYXQ173ayhJk3+b3YL3uwvumnDbl1Tq/7tXA75IDQ2c6kK5oJjnSX6EEgIK2xw619YyKlQEZXaB2AI1QwGjKVk++LY6boDtvTqyX29UWj6gFRYXOMAeLt7rGNzM9k8F0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quantum.ru; spf=fail smtp.mailfrom=quantum.ru; arc=none smtp.client-ip=213.170.105.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quantum.ru
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=quantum.ru
Received: from [10.8.0.4] (mama.quantum.ru [213.170.105.102])
	by mail.quantum.ru (Postfix) with ESMTP id 82797E6169;
	Mon,  4 Nov 2024 06:29:01 +0300 (MSK)
Message-ID: <e94595f1-5c70-446b-8574-5be7c4fe3751@quantum.ru>
Date: Mon, 4 Nov 2024 06:29:01 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Politware vs Free Software [WAS [PATCH] Remove Huawei]
To: metux <metux@gmx.de>, Theodore Ts'o <tytso@mit.edu>,
 quake <quake.wang@gmail.com>, redaktion@golem.de, phoronix@phoronix.com,
 linux-kernel@vger.kernel.org
References: <70148bf0-389c-4942-a34f-7ceb5449aebb@gmx.de>
Content-Language: en-US, ru, ru-RU
From: Morozov <morozov@quantum.ru>
In-Reply-To: <70148bf0-389c-4942-a34f-7ceb5449aebb@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 188956 [Nov 03 2024]
X-KLMS-AntiSpam-Version: 6.1.1.7
X-KLMS-AntiSpam-Envelope-From: morozov@quantum.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dmarc=none header.from=quantum.ru;spf=none smtp.mailfrom=quantum.ru;dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;quantum.ru:7.1.1;127.0.0.199:7.1.2;213.170.105.102:7.1.2,7.5.0, FromAlignment: s, ApMailHostAddress: 213.170.105.102
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: not scanned, disabled by settings
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, not scanned, disabled by settings

I don’t understand either
Why would someone in such a prominent position act this way?
It’s hard to believe
Linus Torvalds has set a dangerous precedent, turning Linux into a 
political organization

While everyone talks about peace, Linus is adding fuel to the conflict 
with these exclusionary decisions

I’ve been a Linux user since 2001, and open-source principles should 
stand above politics

If they don’t—then why even use open source?
Take Microsoft, for example—they’re focused on profit, and that’s fine

But we’ve put up with Linux for decades, believing in its principles. 
And now, this?

It just goes against the spirit of open source

What’s next?
Are we going to see support for the Russian language removed from 
projects? Or all contributions from Russian developers disregarded?

This direction feels wrong to me and goes against the very principles 
that built the open-source community.

I think Linus is just being ignorant or short-sighted here. But he has a 
lot of influence.

Don't even try to fork linux.
Russian contributors is not a problem, it just exist.
Linus is a problem. His vision is the issue
Not a faulty software or hardware or Ukraine or etc.
LinuS

-- ME

On 10/30/24 16:17, metux wrote:
> On 24.10.24 18:49, Theodore Ts'o wrote:
> 
>> These exemptions may not apply in different countries, and for
> 
> The *may* - so you aren't exactly sure ?
> 
> We're still waiting to the exact legislation that's prohibiting
> Russians from taking part in international scientific discourse
> or even just mentioning them in the CREDITS file (that part is
> probably the worst).
> 
> And if so, how can Linux still call itself "free software" ?
> Or shall we better call it politware ?
> 
>> different sanctioned entities.  I will note that China is not
>> currently attacking Taiwan militarily at the moment, while Russian
>> misiles and drones, some of which might be using embedded Linux
>> controllers, *
> 
> *might* be using it.
> 
> Do you have any actual evidence ?
> 
> And if so, does banning those Russian maintainers has any practical
> impact on the SW running on that drones ?
> 
> What's coming next ? Geoblocking on kernel.org ?
> 
>> are* actively attacking another country even as we speak.
> 
> Sure. Did we ban maintainers from US/NATO when they attacked
> other countries ?
> 
>> Finally, please remember that kernel developers don't make the rules.
> 
> Unless we're seeing actual evidence of the corresponding legislation
> and how exactly it forbids Russians being maintainers, we all have to
> assume that the LF clique is making these rules.
> 
> OTOH, if we have that evidence, then at least every US citizen who
> values free software and free speechs now knows whom to vote against
> in a few days.
> 
> In chess that's called a fork:
> 
> a) the Linux leadership takes the guilt and is responsible for all of
> this - and thus a danger for Linux community and FOSS as such
> 
> or
> 
> b) it's pointing fingers directly to the US govt., and so accepting that
> we're dealing with a rogue govt. that's an existential thread to FOSS
> as such and thus needs to be removed on election day.
> 
> choose your poison :P
> 
>> P.S.  This has always been the case, even before one country invaded
>> another;
> 
> Linux didn't exist *before* that. The US is built on genocide and wars
> of aggression.
> 
> Just one of many interesting examples: the attack on the spy ship
> USS liberty - coordinated between US WH and Isreal - that was a set up
> to blame Egypt and bring the US into war against Egypt - there even were
> plans for using nuclear bombs (!!!). Other examples are several wars of
> aggression against Iraq, Serbia, etc with using weapons of mass
> destruction. (yes, by UN definition DU munition *is* a WoMD).
> 
> Let's be realistic: Russia isn't the only bad actor in the world.
> And "the West" isn't the good guys.
> 
> 
> Turning the once greatest FOSS project of known history into politware
> doesn't help making peace and stop the dying. It just errects an iron
> curtain and so making things even worse, for the whole world.
> 
> 
> --mtx

