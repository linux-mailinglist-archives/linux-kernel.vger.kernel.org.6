Return-Path: <linux-kernel+bounces-356771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1C1996662
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387E81C22409
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A518DF74;
	Wed,  9 Oct 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sysprog.at header.i=@sysprog.at header.b="ZAZ3PzxD"
Received: from esgaroth.petrovitsch.at (esgaroth.petrovitsch.at [78.47.184.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A8618B482
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.47.184.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468278; cv=none; b=pl2YVstjCP/f7AYF1/385RDfRYA1eYTwn31ii4pum/iR6wvdEjvwe0ot9bHSK98fCx3WNn17vuh5KF5u+EAnzUUw7U79HtVga49S2eguno1sk5SU2ZuxxCoVLZ+wUWZi6hmDyQkzJgSyLaGobdapP5umQ310KOO8vkPfE/BJkGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468278; c=relaxed/simple;
	bh=CqaxRfdZ3dJ6Yu2xqeidl5BCSSRwlJfj9BG7OSd86f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=Voj67r9uGfkvj96xImFyFT2gHUONZx3e0XJ0P+7o7Cz76Kp99i7gi2iqlw2ZIQFQWeFf1uTw1vY+CYBin4Yc4jNE5Yiy0mBAcBvJ/XASCYksyCrPxW0PvYr9d+ePwKL+t+J0rIFha61lX2dfPCMYgmiArxKQ8IAmjM1xmDp3dtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sysprog.at; spf=pass smtp.mailfrom=sysprog.at; dkim=pass (1024-bit key) header.d=sysprog.at header.i=@sysprog.at header.b=ZAZ3PzxD; arc=none smtp.client-ip=78.47.184.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sysprog.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sysprog.at
Received: from [172.16.0.14] (84-115-223-47.cable.dynamic.surfer.at [84.115.223.47])
	(authenticated bits=0)
	by esgaroth.petrovitsch.at (8.18.1/8.18.1) with ESMTPSA id 4999Ox8C1743586
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Wed, 9 Oct 2024 11:25:00 +0200
DKIM-Filter: OpenDKIM Filter v2.11.0 esgaroth.petrovitsch.at 4999Ox8C1743586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sysprog.at;
	s=default; t=1728465901;
	bh=m354PBNBv5n3YwmsQ6t0WVZ5DKVg/lwuJ7JAvb/LAVA=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=ZAZ3PzxD6zl2YrgA7hfMuNU7T0fHzuAl3p9tCElc4N3ASDJTDtYd+hyIiD2kO3MiA
	 o/5OM/POuf/Z96jvUQhdPrGZh3zJ+q+jTPvH1AE7WXopC76uEjXGYJqoQNcXmQQcA3
	 M83eo1G2nZBsStjy2zAfWdULbjOCs7I6dqxufusk=
X-Info-sendmail: I was here
Message-ID: <93b4c53a-9f15-4c35-965b-ac889b3061c8@sysprog.at>
Date: Wed, 9 Oct 2024 11:24:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: VT-less kernels, and /dev/console on x86
To: nerdopolis <bluescreen_avenger@verizon.net>
References: <2669238.7s5MMGUR32.ref@nerdopolis2>
 <2669238.7s5MMGUR32@nerdopolis2>
Content-Language: en-US
From: Bernd Petrovitsch <bernd@sysprog.at>
Cc: pmladek@suse.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        john.ogness@linutronix.de, gregkh@linuxfoundation.org,
        tglx@linutronix.de, tony@atomide.com, senozhatsky@chromium.org
BIMI-Selector: v=BIMI1; s=default
In-Reply-To: <2669238.7s5MMGUR32@nerdopolis2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DCC--Metrics: esgaroth.petrovitsch.priv.at 1102; Body=9 Fuz1=9 Fuz2=9
X-Virus-Scanned: clamav-milter 1.0.7 at smtp.tuxoid.at
X-Virus-Status: Clean
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
	*      envelope-from domain
	* -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
	*  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
	*      valid
	* -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from author's
	*       domain
	* -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
	*      [score: 0.0000]

Hi all!

On 18.08.24 02:09, nerdopolis wrote:
[...]
> I originally brought this up on linux-serial, but I think it makes more sense
> that it's part of how printk console device selection works. Without VTs, while
> most software is able to handle the situation, some userspace programs expect
> /dev/console to still be responsive. Namely systemd. It calls isatty() against
> /dev/console, and since /dev/console on VT-less systems currently defaults to
> /dev/ttyS0, and when /dev/ttyS0 is disconnected, the ioctl's fail, and it
> refuses to write log messages to it.

What's wrong with fixing systemd?

Kind regards,
	Bernd
-- 
-- 
mobile: +43 664 4416156               http://www.sysprog.at/
Embedded Linux Software Development, Consulting and Services

