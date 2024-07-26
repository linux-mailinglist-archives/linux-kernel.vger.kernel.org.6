Return-Path: <linux-kernel+bounces-263193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2476F93D27A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E58CB21EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 11:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D313C83D;
	Fri, 26 Jul 2024 11:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="PcJmO51A"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451813C661;
	Fri, 26 Jul 2024 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721993964; cv=none; b=GweAX4/by1kpTWQbi3bh+jdk1IbiCUppchRD9cSPgpEu3ElaCfri7czGNDmWquWAh9VxK7dB5cRWQ5qrT0tUWdfCGf08CDdkZYKkizB9iRF0rzCvTxv9vGlB4k4hNSxGKDyXs7J9ZOJt4Rh+GCzJGwSFmDHPmPJe6TWHl9sB5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721993964; c=relaxed/simple;
	bh=WWR9rSTpNG8supbvbWJm6lu+54aj9eN83Vu2Ad2qKqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G3pe51JZLB21mZpYr10SnLOXpych69ZqzaN7qS4Dw29+riKj+47r1FjyLmmgrH5x7F9wp+7/PN/d3rjDBKR6k2TnbOsjx3DhJcIlbn1tP2mD/+lUMdaBcdlT5G5QdIHUZITiJGaiiTHIg0+X5Pq/J2tAoygqzxK6OIFQ1oR3XFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=PcJmO51A; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:
	From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=NFMxwY06v7FzFCX4eiVb8WZ0D6Nl6tSXLIIDUyRnca8=; t=1721993962;
	x=1722425962; b=PcJmO51Ay4x9BpN/ENw6hNULYkEqrmc0b4y6cLhqWyC9gPwe8JK1HXL9Xb1iw
	aEI7pNAINOewknXqRtnebMPtHGCj56Lf1yBSdBr0wXg+2iLbq4SHVf5wQV3ZTHJwxT3X0XwxyF7tx
	iaWno0V0LUSO5UhbYaxy9koMPQNBhShg1+fAsAzQ7Oh7obeegJp/71UGBiRHhv1HnIUVRSeD5Jbej
	Ph2T+rjiQAfsqVDOtpzxUJ8QyJl7zhEE4XTYX3GLrl7FaO47Ui9R4yGl/R5b8itjUtk6GH9Ntx/VU
	lWl0PYp8OxmjJ1hEOmVcP4LYUTYAT6RVuW97GzDfOi7pE2SLUg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sXJI7-0005ZC-RA; Fri, 26 Jul 2024 13:39:19 +0200
Message-ID: <a7e57a51-9bf2-48c6-9a73-63db691c9309@leemhuis.info>
Date: Fri, 26 Jul 2024 13:39:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux regressions report for mainline [2024-05-12]
To: Thomas Gleixner <tglx@linutronix.de>, LKML
 <linux-kernel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <171552254677.1971316.17732013113090096417@leemhuis.info>
 <87cyn0wnux.ffs@tglx>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <87cyn0wnux.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1721993962;306d04d2;
X-HE-SMSGID: 1sXJI7-0005ZC-RA

On 26.07.24 10:37, Thomas Gleixner wrote:
> On Sun, May 12 2024 at 14:02, Regzbot wrote:
>> x86/topology: system stopped booting
>> ------------------------------------
>> https://linux-regtracking.leemhuis.info/regzbot/regression/lore/3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com/
>> https://lore.kernel.org/lkml/3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com/
>>
>> By Lyude Paul; 24 days ago; 19 activities, latest 2 days ago.
>> Introduced in f0551af02130 (v6.9-rc1)
>>
>> Recent activities from: Lyude Paul (3), Thomas Gleixner (2), Mario
>>   Limonciello (1)
>>
>> 2 patch postings are associated with this regression, the latest is this:
>> * Re: Early boot regression from f0551af0213 ("x86/topology: Ignore non-present APIC IDs in a present package")
>>   https://lore.kernel.org/lkml/87le59vw1y.ffs@tglx/
>>   22 days ago, by Thomas Gleixner
> 
> This one turned out to be a broken ACPI table and the system came back
> after a BIOS upgrade.

Thx for letting me know, but don't worry, I noticed that and told
regzbot about it weeks ago to mark Lyude's regression as resolved:
http://linux-regtracking.leemhuis.info/regzbot/regression/lore/3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com/

Sometimes I miss things like that, but if that would have been the case
I would have asked for a status update weeks ago. :-D

Ciao, Thorsten

