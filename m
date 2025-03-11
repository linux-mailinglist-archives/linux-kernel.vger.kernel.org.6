Return-Path: <linux-kernel+bounces-556712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF143A5CDD1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892BA3AD067
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2FB2638B5;
	Tue, 11 Mar 2025 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="MWlsdKlX"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD8263881
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717483; cv=none; b=laMo/HSekJ3gwnUINexBuysxdymz9Nhz53rbSLwv+3QCVmJ5b1Js+6xYWa+34OdfsVDKkco50ReQzuQgJMUt8RdQLemZxcnoIAUYKDoP9sMpKcyKgiTHCPhW3eMFAVo/rLbuRqKEeQz+yEF/QEx/Ebskn7TkAkUS/TFXsh/aBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717483; c=relaxed/simple;
	bh=ws00/KSlWMUqOqwMWeSSkto3d7SCa05qwYr4LDARqKI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OYE0iN27GZC7F5CErh5vQQmvtIprEcLavUIc69uzgxQeuqG6TVG/iLUmnm+794Ia2+MFXKMSGAzQKB+gILGcZyM+sl060iquGijjzta4o+xGKoXc6WI0gwRZHsZmbwaNIYG/t7bXZFW0XkHQ1CuDrXpKDRLE6CUNVnN+y7aTTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=MWlsdKlX; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741717470; x=1742322270; i=spasswolf@web.de;
	bh=hmhxzDcTXD3VnWxKQXgu6Sjvi9IxwJMhwcvW+32Cdoo=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MWlsdKlXRGFiYw7W77qo9uLNZCsjV10i16mH2vxQ5yFRkZ+nZFSXTUN5NRPPOwgf
	 sdKUQLZnyH3e3vjxr21J0/XQAmPVZxFhzj/Xx8Nl5Z5qjKeyBMnxq2EwRJPoiU6eC
	 SCbsOgiTCPj84943NDkQ7E1wFOXwWxfxcdzU6WmFMC9iJbgACp/BCdr4skMno/HwS
	 Ics66CgDgsdaRv4g6a2Uf1uQaswIKoWRUNy8s5Ssf2fZs/b/do5swPu33XKGdXGWX
	 e/Py/wIHlu3j1bUGpzkuLldExPur3KzpEnITyVsyuH1dSLAkqQQIIPGLfoP52zT/1
	 mAuxbIIkYSsjXJ9TDw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQPZj-1tWFzw41MP-00XOd3; Tue, 11
 Mar 2025 19:24:30 +0100
Message-ID: <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Date: Tue, 11 Mar 2025 19:24:29 +0100
In-Reply-To: <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
References: <20250310112206.4168-1-spasswolf@web.de>
								 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
								 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
			 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.55.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KGILkSxqxGz+59q0FKPEM8LP6GMBk0VjwHuU8ueEphXhQwX9E4i
 M03Rb9pc7pgiDSJQa3ldYqzZoP44FUn2928wNTd6/tuAwM20DdNwEtgVoci4A5p58mf+scd
 57yh6PIpywNEg9j+KnMyUgRUPQWxMcpU2fDTcHGL4qLhnMCkf9NBY0Pw8l59mnvKpFUMZG5
 JQ9/RW1viL+HCx1Z3Gj9A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FEpLhmoQCLI=;sTnXhJ6Nf21irCV4f7pti3RCTmg
 2J2eSU11F0/iYCGk86RHN963EN+fBt+LK9u/xIb09FNJQ2ozLkRoLfOCToMVojGHW7JDopSrj
 dX4Fm4M8+Ud9rF3UrvFvv2bAJ+tCyZHPXHIJK8SHtS4vKKIjXuc9vq2+FpcsvZmhSs+JtVXBg
 hlIZhmrWpFPDrDKnkBOg4B+K2gMtnJHFUH25jwDd4TjiGgMcxgYQ8POMQhCU4bchCFR/P5gQA
 jslKPv5LYV5kDA5dBbC/eAZVMsHh1cDubvyg43OU1Q7r+xfN9OCIIjeKtwEL4mhbvyfA1gwmq
 6g0bbdWI9awbO+KTCMCpGmKLdRGCPCsSPDhO5dCA/i10gEThuij4qY40uFOu6Ptr3E7KujW39
 QvukeNyGvoDKrmL5BJo7prHXPlBu94qYJVbacQ5RLFQxPq5YN68wSf4VlzENk0cFihinm+t47
 QwgAMV0rJ2d7vqlg2DyTZKbY1PT+eUd4N1EIwPHFKXJrvvA1aX1pP+rCwB04nn2WXOMHaoz+a
 hS7tFPcC6G3p5M5t5OgrrAvkZm+h1h/D/J3kNCZ10+tcYofn4a1o3c8Ge44XcakekCiP93+cN
 on2BgeTkSk6gr58OWGkGERe/qVn+tvIDg9CKaabAONu+pVV0I1t5EDs7eeZ70Grw1Z3qjOKaL
 6Nbfea+3nzyhEcrgWS9gmDq0smzAmes+eFTptw0JzXf1O8SiZM7vCOB0c1yG0ar7VaHrHkE2L
 1cgL4kuypP0ixrQXCPkoLc1HERMaqUIheJqLFShyhyA9VI0C3X0jCOezNEYrq9BS1HYKwxVkg
 IcsA7fHstMQw0sToCHo6zc48THPoVagAYmFUo7YXwnJ8PKLzYgV7N+VOvA+/Ix3TF+zO9MuZL
 pAs4b82vKMVZY+aXvBjLzatIrAzdkqvFCjTrIL1O2ezITmMaPR/JzkI8M+Fm+Sot1UImhK/yq
 CJfqvkwkBYw78h2IDJsUVXwUmxx9oAz5wPYcRVrcXzNTKfxzRTUe1wF+oqueWF+l5H+Ye/8ij
 fHM9Orzw0NdQacwh1fFf0YkDnUVVeYf1wKXnT0PpD2gMhhgYNl12nDrmH5gYooSiBhWGZ6u1q
 jY4At+NjQqkNl8vjgo2Tl6MCbgj13fnpiX9IX48lG5qo4Iy6WY/cvLati5iemujfDq/HdGqPG
 bviauooIDd6shyKSLgpKPPcdKsdsBSBysQqKvM61VzpgyqO6nfEc4B2JZdglh5OhecX0LzSt1
 MEL3/WnnNacGtZs/xu5Vxg9BMg8fwAcCvve4GqCSfs5Y32SvC0h3lJPZUKZ+p4kqWiOOZGtAt
 j+3YJ5gtLHRPnukeBwBGrFXFfRWm/8jKzwBb+mEHX749Oc72sFlH5hwwOh+Rf+PQ4F243DAMw
 7XsFK92AZh4DYC32VqHk5xr1a2ZtmZeutooKV3BSC0fPbcRsHDJJANk50Y

Am Dienstag, dem 11.03.2025 um 12:15 +0100 schrieb Bert Karwatzki:
> Am Dienstag, dem 11.03.2025 um 18:19 +1100 schrieb Balbir Singh:
> > On 3/11/25 08:48, Balbir Singh wrote:
> > > On 3/10/25 22:22, Bert Karwatzki wrote:
> > > > Using linux next-20250307 to play the game stellaris via steam I n=
oticed that
> > > > loading the game gets sluggish with the progress bar getting stuck=
 at 100%.
> > > > In this situation mouse and keyboard inputs don't work properly an=
ymore.
> > > > Switching to a VT and killing stellaris somewhat fixes the situati=
on though in
> > > > one instance the touchpad did not work after that. I bisected this=
 between
> > > > v6.14-rc5 and next-20250307 and got this as the first bad commit:
> > > >
> > > > 7ffb791423c7c518269a9aad35039ef824a40adb is the first bad commit
> > > > commit 7ffb791423c7c518269a9aad35039ef824a40adb (HEAD)
> > > > Author: Balbir Singh <balbirs@nvidia.com>
> > > > Date:   Fri Feb 7 10:42:34 2025 +1100
> > > >
> > > >     x86/kaslr: Reduce KASLR entropy on most x86 systems
> > > >
> > > > Reverting commit 7ffb791423c7 in next-20250307 fixes the issue for=
 me.
> > > >
> > >
> > > Thanks for the report! Could you also share the dmesg? Do you have a=
ny proprietary
> > > modules loaded? Could you also share the output of /proc/iomem (capt=
ured as sudo)?
> > > The lspci output is useful, lspci -vvv (captured with sudo) would he=
lp see where
> > > the BAR regions are, specifically before and after the patch. Could =
you also share
> > > the kernel config?
> > >
> > > I assume your config has CONFIG_PCI_P2PDMA enabled. Did the system e=
ver work with
> > > nokaslr for you?
> > >
> > > I am a little surprised that reducing the entropy causes these issue=
s and having
> > > a larger direct map causes these issues.
> >
> > Hi, Bert
> >
> > I tried to reproduce the issue at my end, but could not. I am new to S=
team and my
> > hardware/games are also different. From what I could gather, Steam is =
a 32 bit
> > application that uses SDL. For my testing I used Xorg, not wayland
> >
> > In addition to the above?
> >
> > 1. Could you confirm if the mouse/keyboard work outside of Steam?
> > 2. Does evtest /dev/input/<mouse device> show anything?
> > 3. We could run the kernel with nokaslr and see if the issue reproduce=
s?
> > 4. As a test, we could try disabling CONFIG_PCI_P2PDMA in the kernel c=
onfig,
> > build boot and test, this has the same effect has not having the patch
> >
> > Balbir
> >
>
> 1. The problem is not with steam but specifically with the game stellari=
s (which
> can be started without steam). As long as stellaris is running there is =
a ~2s
> delay in keyboard and mouse input (for everything), killing stellaris re=
stores
> input to normal.
> 2 evtest /dev/input/event{1,3,4} (keyboard, touchpad, mouse) seems to sh=
ow the
> same output whether stellaris is running or not, only if it's running th=
ere's
> the mentioned delay.
> 3. For some weird reason my kernel does not recongnize the nokaslr cmdli=
ne
> parameter, so I build a kernel without CONFIG_RANDOMIZE_BASE and this do=
es NOT
> fix the issue.
> 4. Most surprisingly removing CONFIG_PCI_P2PDMA also does NOT fix the is=
sue.
>
> Bert Karwatzki

I've done more experimenting regarding 4.:
next-20250307 with "CONFIG_RANDOMIZE_BASE=3Dy" AND "CONFIG_PCI_P2PDMA is n=
ot set"
works as expected (i.e. no input lag when stellaris is running)

next-20250307 with "CONFIG_RANDOMIZE_BASE is not set" AND "CONFIG_PCI_P2PD=
MA is
not set" also shows the buggy behaviour (i.e. input lag when stellaris is
running) (this was the configuration I tested before)

As a sidenote, I've tested several kernel with nokaslr as command line par=
ameter
(6.1.128, 6.8.12, 6.12.17 (the debian sid distributional kernel)) and noka=
slr is
not recognized as a command line parameter in any of them


Bert Karwatzki

