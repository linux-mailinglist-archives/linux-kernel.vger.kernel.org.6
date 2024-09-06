Return-Path: <linux-kernel+bounces-318453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9FE96EE3B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7805C1F219E1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437521591F3;
	Fri,  6 Sep 2024 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="eqVeUe+x"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98659158DC5;
	Fri,  6 Sep 2024 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611660; cv=none; b=YntXcppjfnFu8WCRjvKNGJyZjZ/5G+bAO7IVNZ79cV5H06hAOHU5+xdaN94LUiSHqrA16rENsXFwPRyKH4W9/t5SLe2JK0y/ouzP6CqqjB5xEdzsvFYM1ZOPxTindsm2ycPHTW+azH75KTOyTkrPNJXhm/nnET3ntxSFqIFMbgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611660; c=relaxed/simple;
	bh=tVkGjaPlTCwQz7vP6OpxYYgTGSZPrWM+CDAfcGjqRu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FolDbanrr5umsd2O6YVIl05En+GChHfRC/wBxOg6kp8sEfv54rwEy+Uq00hGXXvLGgfOvfyGaVJRFBEaz90YxwYoFRrGqSQd0GAY48sIedlPcViISDcSeAC1FKm3/0Sk3VvHXEZJWRjCMPLLYMk0o/Os+Zbt0WyPRaYH8DO5vyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=eqVeUe+x; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=x58mUqqMv7fTODPP5sh7PU8fmtbAwiPVZtxmDJwpmjI=;
	t=1725611658; x=1726043658; b=eqVeUe+x8yBZrL0lTzEMSAqakAjSNcKPJhcxHSvnDpWj2ip
	cvUO78Op2rNsiIp0C2p4IdBkBEt8jSiNeI8a3lDCdqcxjEyXCgICeYLqOPqcaxSvonsrYMeR5fgvd
	hum3Hz4AqfhEEL7gzcQHit5LLKBb4PKKUHIm4/kTxdfXmekbaHfKfui30rXvoGCRGt8iezEvuZwue
	g6nPNp/GGdPLw3WVU8uw/8ebtMrDG2LwhjA8oRNFPBkG882LnvryTVSq3XW2+QOWsDHOhnk78kHEu
	556PrXTmIu9/xFFifoqC+Xa/Sabo1KN05MkPRdRVGw8oHyKqNLjbE/+Y9PpxeU4g==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1smUPx-0008Do-Sd; Fri, 06 Sep 2024 10:34:09 +0200
Message-ID: <fb5d23fc-2d47-4142-be88-701c4209fc7a@leemhuis.info>
Date: Fri, 6 Sep 2024 10:34:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/apic: Remove logical destination mode for 64-bit
To: Borislav Petkov <bp@alien8.de>, Christian Heusel <christian@heusel.eu>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob <rob@durendal.co.uk>,
 regressions@lists.linux.dev, x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
 Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 Paul Menzel <pmenzel@molgen.mpg.de>, Lyude Paul <lyude@redhat.com>
References: <ZqQSmw51ihns03ob@vendhya2> <ZqQl79UhhSQ5IobX@vendhya2>
 <8734nvuvrs.ffs@tglx> <ZqTufKvJKvotC-o_@vendhya2> <87cymyua9j.ffs@tglx>
 <877cd5u671.ffs@tglx> <ZqZ3Kp2NVctgstxs@vendhya2>
 <c7b68723-6ecb-42be-a9f8-14d64c696283@heusel.eu> <87jzgpubxj.ffs@tglx>
 <d9cbe524-ad83-4c48-b6f4-3376ff3172d4@heusel.eu>
 <20240905140446.GCZtm6fu_H5JH_aP-D@fat_crate.local>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240905140446.GCZtm6fu_H5JH_aP-D@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1725611658;ea1232da;
X-HE-SMSGID: 1smUPx-0008Do-Sd

On 05.09.24 16:04, Borislav Petkov wrote:
> On Thu, Sep 05, 2024 at 03:28:47PM +0200, Christian Heusel wrote:
>> Now since it's summer people are maybe on vacation and I hope it got
>> stuck there because of cocktails on the beach and so on 😆🍹
> 
> Yep, check. :)
> The patch is on its way to 6.12:
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/apic&id=838ba7733e4e3a94a928e8d0a058de1811a58621

Hmmm. Please help me out here: why was that fix queued for -next and not
for this cycle?

Was that patch when it was committed considered too dangerous for
mainlining this cycle (at this point of the cycle I guess it might)? I
mean, it's afaics (not totally sure here, the change is missing a Fixes:
tag as well as Closes: tags pointing to the report) fixing a regression
with f0551af02130 that Christian reported (see start of this thread, e.g.,
https://lore.kernel.org/all/12df8b45-6100-4c8b-b82a-a6a75bed2e05@heusel.eu/
). And f0551af02130 is from v6.9-rc1, so given what Linus wrote in
https://lore.kernel.org/all/CAHk-=wis_qQy4oDNynNKi5b7Qhosmxtoj1jxo5wmB6SRUwQUBQ@mail.gmail.com/
that fix should likely have been (or still should be?) merged in this
cycle, unless it's really dangerous.

Or did I misunderstood something here?

Ciao, Thorsten

P.S.: While at it:

#regzbot fix: x86/apic: Remove logical destination mode for 64-bit

