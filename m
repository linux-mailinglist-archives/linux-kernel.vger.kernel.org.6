Return-Path: <linux-kernel+bounces-191822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8408F8D14A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14FF0B210F8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586B76D1A9;
	Tue, 28 May 2024 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="SNerNKpz"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8553E1BDD3;
	Tue, 28 May 2024 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878797; cv=none; b=C1y1YRxIszN6UFyprVH72NJB+8omaU6V53ADXBw//4A4o1z8oO4E4omySXPod3tIHx9GwONzZoVW9OUUvlkuq02R+AcVaKP0YxHZSCfFUTErN/ElHaj8SELdgnOpNe0AbAzLpzqOHfHVUY0dycnriduou514P4SefhXXd5+knlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878797; c=relaxed/simple;
	bh=YzpjJPP0ULvrVx15xyLfh6oMxnTDM3239lcJvqG4GZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nMlBLbpih62hjQUq3CmJ6g6+My8MK9r6Vg7iLSHKz/EpTz8CTL62Mnu7y26u5pFPiYGBis0oezyUXkVfLkdX/xdRu5df+BnaEmsBq/AqXnTN7FvcjLa9NqdOldzEmhSMuwpZEMACgQi815JlUxFHk2H0EFIkJ0kohjs+PCFaOJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=SNerNKpz; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=Om+3DdDNz34eTk9PGG2WbSavGEIpa9Fm2b7xW+H1qWQ=;
	t=1716878795; x=1717310795; b=SNerNKpzgzhW167byRKb3qIOxohQSXsC4as9txGrallQAiZ
	UajY7PLKyBA/fd0PjfedZbJelP7cbe0FEtwvbksZk2TYpMsVzBkNtMAhjcqiOi6PKTKJYhq74NQjg
	ghkSygGx93ytyqOWiK1UgZOapwWVtVlsPcXFUEhf+7usXk0dYrRje2lTHb/NlrWsnDMmh3Q80WMGa
	/PEAn6k3uqGZdmRj500U5CFWVoGuFLKsLeyeGFlTn7TdLMttLE9YuVraPqH8OGoNcZV1YXkU1fa94
	bhWbUw56khNTSKk8PMQmn0rlQr8tt39UzK/OoceyaKXJ7muUM9e7GaTqAWNOzceQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sBqbP-0007a4-SQ; Tue, 28 May 2024 08:46:31 +0200
Message-ID: <de703fe7-1cf8-4f51-a282-bdca4a3c6634@leemhuis.info>
Date: Tue, 28 May 2024 08:46:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.10/regression/bisected commit c4cb23111103 causes sleeping
 function called from invalid context at kernel/locking/mutex.c:585
To: Chris Bainbridge <chris.bainbridge@gmail.com>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: regressions@lists.linux.dev, vasant.hegde@amd.com,
 suravee.suthikulpanit@amd.com, jgg@nvidia.com, jroedel@suse.de,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Borislav Petkov <bp@alien8.de>
References: <CABXGCsN1z2gj99zSdhQWynpTXBymrqHejDfF8axxxoiZ_0g_-g@mail.gmail.com>
 <Zk5hJrY_lGmuW1G9@debian.local>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Zk5hJrY_lGmuW1G9@debian.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716878795;de243872;
X-HE-SMSGID: 1sBqbP-0007a4-SQ

On 22.05.24 23:18, Chris Bainbridge wrote:
> On Tue, May 21, 2024 at 02:39:06PM +0500, Mikhail Gavrilov wrote:
>> Yesterday on the fresh kernel snapshot
>> I spotted a new bug message with follow stacktrace:
>> [    4.307097] BUG: sleeping function called from invalid context at
>> kernel/locking/mutex.c:585
> I am also getting this error on every boot. Decoded stacktrace:

TWIMC & for the record: Boris also reported this; Vasant Hegde replied
and said a fix is in the works:

https://lore.kernel.org/all/898d356d-ec7d-41de-82d8-3ed4dc5598b3@amd.com/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot dup:
https://lore.kernel.org/all/CABXGCsN1z2gj99zSdhQWynpTXBymrqHejDfF8axxxoiZ_0g_-g@mail.gmail.com/

