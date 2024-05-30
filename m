Return-Path: <linux-kernel+bounces-195097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18C78D478C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D85C1F22494
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77A06F310;
	Thu, 30 May 2024 08:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusipp.de header.i=osmanx@heusipp.de header.b="Npr4RdNt"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBED1761BF;
	Thu, 30 May 2024 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717059246; cv=none; b=ba54QbpdLjiTXxkT8nTXN08kJbaCcMVcG+VARf82kXlX8QzbEoQ7F03JhknqpDFDkbSWdmh5jeO+SOZAVYukSZDv7ftXebdnJ1XHGzoFQ5Uej4IDZP6JOHgHP/mx4he3agZX9ZXQ4HZ9AgJdrNxv4IleVUMS+im1rV5si/YtDbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717059246; c=relaxed/simple;
	bh=OiPXOYqVDdLsZkYedWaVvRrpJe0cx5AuAOz/naYPWjE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tEco8bC3gwu9+qPLJGy84/gYQrOPJKF2Gk2HrsDNlPRPcOkl7fxzkK0IPzaPnusUu/cn0I3p3Q5dzZoQejoY9Ah5zkUf4dka0vMacKnlnfJToWGmkpI+hcSFObVxiW8P9tm5PemVSjCjtGN1L/nwtrW56fNkTykz1MGdzoOjns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusipp.de; spf=pass smtp.mailfrom=heusipp.de; dkim=pass (2048-bit key) header.d=heusipp.de header.i=osmanx@heusipp.de header.b=Npr4RdNt; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusipp.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusipp.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusipp.de;
	s=s1-ionos; t=1717059224; x=1717664024; i=osmanx@heusipp.de;
	bh=OiPXOYqVDdLsZkYedWaVvRrpJe0cx5AuAOz/naYPWjE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Npr4RdNtY55Jk8MtA7iGYZlMk+fOCmMPnjKgmsFZTiMI4H7B1OKcZpDt3VnplkXs
	 SM9oRq20+Flf2YAiRYE+xsJKJaAxAJZz+qt8QY0x83ctV6g7bNkSqz8mcqcjIKkjF
	 o9Z9+117NY/hZI5Fvkjk4Fj27ljDlIEkcs0vEDBQKC7J7GpA/5r0NGlh2XVrRWq3U
	 c8x++Z8yyhlXqn29d9zFzs/OclcTyO3xj8/7cOil2VueuBi9UC/rRrECuI8EILkWU
	 aY3ouvj0Wr8F4GF0bPAhi0+Z44jkWKc84vAwg9K9/eSccWO1becWMNM2QxM2lN47I
	 x0fWBBUHpzOkaVKE3w==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.178.90] ([91.62.108.110]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N8VkX-1sZ1yo1lkP-014Xap; Thu, 30 May 2024 10:47:19 +0200
Message-ID: <5e31cad3-ad4d-493e-ab07-724cfbfaba44@heusipp.de>
Date: Thu, 30 May 2024 10:45:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] commit fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6
 (Linux 6.7+) crashes during boot
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Adam Dunlap <acdunlap@google.com>,
 1071378@bugs.debian.org
References: <ebb0791c-60a5-4fe3-bc85-4921ad026605@heusipp.de>
 <4611b3c8-0ef6-4951-8b34-10a1c7262355@leemhuis.info>
Content-Language: en-US
From: =?UTF-8?Q?J=C3=B6rn_Heusipp?= <osmanx@heusipp.de>
In-Reply-To: <4611b3c8-0ef6-4951-8b34-10a1c7262355@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TH5Rj8IDETzGF7pUOEsDoQfRqaiaWyTdAXIj2gLCYvG4cs93TLH
 qirAWYb3jzHboshA3g7QUf3yAiqeiM0WDKF8nQby/DCGGOmpQXZ4Sycy2Tu5m4VySg/aNzE
 FdhXHwAjqXQT5pdrIzsHbmOQ21ac45SZXhEuj9KJiLcRHog8ZdT/Mq5nTOE6KMtGAsEwshl
 npzs5T36VcPVgWDYJH5+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MBSDXgNKHTU=;z2YdmhNWzRwp5qolDSwAdFk1mtL
 6uLeuYZHJMqAK5G4juvCo3YTKEEMPQgYVJpZYZ8wALCJQlr9SFCIxnD99kk/F/bFkQehOLbl/
 mr7e0pY2mVf9rfThdA224xPjFGxM4ryUy/B8W7u9GdfP2BjvOaGCDdduAgpGRpys5RKMZL+jA
 9xKJnVLAIQC1pq9MHxYvuQQJLp1WyfzAEInXn3qHsqE4fGTh2ROHRN8dZcvzA8M/elONIrgSo
 CSSy+Ifskp2mLZIBiADeUFuuX9W11sVtQT+5cnvTJNk/LHuxagXv7UJLnj6gyc3KFsQtU5N4E
 DbXtknFJzRMbwYJ2SvR+f1CUy1JYMwCmoxRMI3Nv5RPJ5MlRjz0VuPchDveHh+XiJ+9LPMRbA
 rQF/+XsZqa1Zbhr50hc+OtyP5kMBz1e57Z2XPlo825t1pZksCsqPSyFUL4ECk612P+hGUONRl
 GFZy7mLAkTo0m3Rh306ye9AAsMfILQgIW9H+PweES33WFo4YUkgHhw+VZnzoCjWOqWp3qDkdV
 uD1ogN3cFx7Bo9vv0ZA3HzIILfpHwOq9628zO/JOCECE/it9YtIg6UJiaMNF6LpscTV2ukKLa
 e50B5PbbA/8xUVfFakUmcw2XLThblqaLMOdwsmDgVBnbICzliuJ6QsR3reG2UmHUB3+YBRcw1
 CstgOv7eTUozuoClvl8cgdbDN/827PKDweBP1vxg8kNl4anU0TxvtXnilROHloVL3gtbkdvSB
 7KXaWJzvdazLGgcKN3imGia7KDwI2LWHsF/HcM8ZZNVl9MWrHyoagU=


Hello!

On 30/05/2024 09:27, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 30.05.24 08:55, J=C3=B6rn Heusipp wrote:

>> commit fbf6449f84bf5e4ad09f2c09ee70ed7d629b5ff6 ("x86/sev-es: Set
>> x86_virt_bits to the correct value straight away, instead of a two-phas=
e
>> approach") crashes during boot for me on this 32bit x86 system.
>
> FWIW, not my area of expertise, but there is a patch from Dave with a
> Fixes: tag for your culprit up for review:
> https://lore.kernel.org/all/20240517200534.8EC5F33E@davehans-spike.ostc.=
intel.com/

That did not apply cleanly to 6.10-rc1, but I figured it out manually. I
can confirm that it fixes the issue.

Best regards,
J=C3=B6rn

