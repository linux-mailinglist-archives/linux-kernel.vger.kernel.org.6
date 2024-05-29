Return-Path: <linux-kernel+bounces-194504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDBF8D3D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 19:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF5C1C21E03
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 17:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA2C181D1D;
	Wed, 29 May 2024 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="US4aXRDi"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1CD1B810;
	Wed, 29 May 2024 17:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717002783; cv=none; b=qvNo215WKatesE8tk2q1lRja1RaMweJC41/UXx6BDC6lvqdzNegdItd1bRs88HoTP4KJf+VYS0zrB7P/O2qLOzyvL/I0hkDsfn52wwt9qTzeSEzhSqryubJfodzQftf5cyXWlYJqXfVbbJkQjJB4EnCQUhsM1uDNQ8uKQ3evrkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717002783; c=relaxed/simple;
	bh=aduZMEOEFptOCP3o/CYOAC5kBuOtb+6bYHp4jNqngO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aUP2Hyr0GNZzy2hETFB10M1qkuiOXZ8zE5LLoRg6nDhVnYoysmWdUH0xDvgIXnV0snRGmacmZHsWA2F65qXreSqtzblxpKhy0e2yiNtvLOQou9g0BGu1oogQOfDGTVYMhjt9izEu1PMDMZ2MkRTLZsIUw2D9BKIrNlNBThz4nzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=US4aXRDi; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=7vnzBxHBsBBBhQu6kHV5glDMHyesyS9//BXjyDIRLlE=;
	t=1717002781; x=1717434781; b=US4aXRDiAYPSNZbiNLJF/ZzeMqs910Y1mKR8M3GmcfIjgO0
	1q+xQUAxpWZjbuY3ourzaO66i/QZLpSmXplUln+Y9nVXLvcZ3C1OQeCH9xmWH7htgUMtePYe971x7
	KWvd2DkUmOC8WlelILn9VWiYDNv5oSCrwKFweZN36lOKkjUnp8zqT/LpjtpmoTd6q/c8PgcN9tWOv
	KdACbsOBdGfoJubD+9IHc9xkxTZiPng1IRaG9urE2f9p86oRhFccg4DP0tMexgfmjdF1BjAL85g6P
	WTYTiuEwjqAGtfkR/N7eC2Z5+DJw8NSRWNlVKZXIFMoyZqQtwAIJYHn9JLcbVepg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sCMrB-0003cT-Vz; Wed, 29 May 2024 19:12:58 +0200
Message-ID: <1e38a2b9-ca88-4497-b2b3-2157dd83e479@leemhuis.info>
Date: Wed, 29 May 2024 19:12:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Intermittent inability to type in graphical Plymouth on UEFI VMs
 since kernel 6.9
To: Adam Williamson <awilliam@redhat.com>, Genes Lists <lists@sapience.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-kernel@vger.kernel.org
Cc: jforbes@redhat.com, rstrode@redhat.com
References: <75c17881-68e9-40e7-821c-5655d49d7c0f@redhat.com>
 <8fee69cc8fdd67fd265790c0fa287cb9566c2349.camel@sapience.com>
 <165f7cfd-41bc-4c37-b859-a418a3ccece7@leemhuis.info>
 <c5b3d3ec7701b51dd7b163261c84fb54c778b9bb.camel@sapience.com>
 <8c460997-f8ff-4985-9e8a-09697a647a28@redhat.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <8c460997-f8ff-4985-9e8a-09697a647a28@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1717002781;d8aef374;
X-HE-SMSGID: 1sCMrB-0003cT-Vz

On 29.05.24 17:09, Adam Williamson wrote:
> On 2024-05-29 06:35, Genes Lists wrote:
>> On Wed, 2024-05-29 at 15:01 +0200, Linux regression tracking (Thorsten
>> Leemhuis) wrote:
>>>>
>>>>      cpu i9-12900K  / Raptor Lake-P [Iris Xe Graphics]
>>
>>    Sorry, this should be:  13th Gen Intel(R) Core(TM) i7-1360P
>>>
>>> Does this happen every boot or only sometimes? Could you maybe upload
>>> the full dmesg from a boot where things worked and one where only the
>>
>> For me it is every boot - the first few key strokes are accepted but no
>> asterisks are displayed - and it works fine even though fewer asterisks
>> are displayed than characters typed.
> 
> That sounds different from my case.

Hmm, bummer. That might have made things a lot easier...

> In openQA (and the one time I saw it
> live), the keystrokes do not appear to have any effect - no dots are
> echoed at all, and hitting enter does not submit the passphrase.

And no dmesg for working and non-working I suppose? Argh. :-/

> I have no idea where to send emails reporting kernel bugs. It's a very
> difficult world to penetrate

I totally agree so far.

> if you're not already in it.

Up to a point that's what I'm here for. But right now I'm a bit
uncertain who to involve. The input folks? The drm maintainers? But
without a bit more data I doubt any of them will take a closer look at
the problem.

> A proper bug tracker would make things much easier.

Not really I'd say, as the problem is the same here: someone needs to
triage bugs and assign them to developers that are willing to look into
them.

Ciao, Thorsten

