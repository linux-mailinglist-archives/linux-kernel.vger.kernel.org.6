Return-Path: <linux-kernel+bounces-194124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F329E8D36F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 15:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFDD228B21A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADC9D2EE;
	Wed, 29 May 2024 13:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="wTJizbAx"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74903748D;
	Wed, 29 May 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987675; cv=none; b=sDg10EB8iIJglmKEeAzsmiL+ll7jfDmZlLe9s7ys79hPi3V7Zi1D4MhX8AdxSOIeG3GP5aYzlrnHB2tplDDX3js4Vvi+3gx8+UZHn2uNvOggqa09o85CUlUMtHc2URCxjebYzcRWV4Q9ehHAXDKCZdUM7b/y2nk7dXGtYoCshoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987675; c=relaxed/simple;
	bh=5ci8D0ELZpBeOFG3Fs2KkfNrgLQAA2tui9D3C9nTdaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8hJ9cLfac5fmuqP/FXir6IsZSGBZYbYTGx3ADYEix9iywpD8ZyJSS1UG1NXpo4t9uHHrNsVL2tubOHiBRlgfwuHp1nAuoQTOzINRVDvg60PSDCazaU+orL+n3zad9dMI3HDdFtmpye012ZsROuN6VPnfBsnZNW+j/ZdXWwT+sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=wTJizbAx; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=NSB6YE+it0l2b05RFg46sN7An5czysdG9ZAFAMnJWow=;
	t=1716987673; x=1717419673; b=wTJizbAxNjyhwHGlcxY4qc1F/Iz66e767YtbGjPLklT4D45
	uGB3XTGiOEUwjEFz3/CM8EIq2jRnqbcJGpzrCM8Yk2TE3A/FItb2DedElHjQyRgiudzWSIpKKpGwK
	71MLiK8nwuiaVsaVA+dn5l4QoubPK/END6qURohHODlgzQovs3dd6QOY+zouIxe8mun8k7m5hHnWe
	bbnqxgsPmewJkgtOVr0/704SGO4Yweb81bshX1VHFLUbDkFPzW/XPLuDuGlFyD54hEwKA1P3ILo03
	oC4xP7Ug7Ca10nhkdNVmCsqDCOqJJh6FZjbY8MEVhin1i+pEOxTOJLqDSndaM0aw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sCIvU-0000C2-PR; Wed, 29 May 2024 15:01:08 +0200
Message-ID: <165f7cfd-41bc-4c37-b859-a418a3ccece7@leemhuis.info>
Date: Wed, 29 May 2024 15:01:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Intermittent inability to type in graphical Plymouth on UEFI VMs
 since kernel 6.9
To: Genes Lists <lists@sapience.com>, Adam Williamson <awilliam@redhat.com>,
 linux-kernel@vger.kernel.org
Cc: jforbes@redhat.com, rstrode@redhat.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <75c17881-68e9-40e7-821c-5655d49d7c0f@redhat.com>
 <8fee69cc8fdd67fd265790c0fa287cb9566c2349.camel@sapience.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <8fee69cc8fdd67fd265790c0fa287cb9566c2349.camel@sapience.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716987673;11a43648;
X-HE-SMSGID: 1sCIvU-0000C2-PR

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

Side note: a bug report just to the LKML (e.g. w/o any subsystem lists
or maintainers) is unlikely to gain traction; I considered adding the
DRM folks, but lets try one thing first:

On 27.05.24 17:18, Genes Lists wrote:
> On Fri, 2024-05-24 at 09:08 -0700, Adam Williamson wrote:
>> Hi, folks. Please CC me on replies, I'm not subscribed to the list.
>> The 
>> downstream bug report for this is 
>> https://bugzilla.redhat.com/show_bug.cgi?id=2274770 .
> 
> 1) FYI : I see same thing booting dell xps 13 9320 laptop (no VM) on
> mainline 6.10-rc1 (started sometime early 6.9 as far as I recall)
> 
>     bios 2.11.0
> 
>     cpu i9-12900K  / Raptor Lake-P [Iris Xe Graphics]
>     Boot using systemd-boot
> 
> dmesg (trimmed) attached. 

Does this happen every boot or only sometimes? Could you maybe upload
the full dmesg from a boot where things worked and one where only the
text UI came up? It's just a shot in the dark, but maybe that will tell
us where the root of the problem might be.

> 2) Note there is a crash later in boot (in mei_csi_probe). Assume this
> crash is a separate issue.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: let me add this to the regression tracking

#regzbot report: /
#regzbot introduced: v6.8..v6.9
#regzbot summary: Intermittent inability to type in graphical Plymouth
on UEFI VMs since kernel 6.9

