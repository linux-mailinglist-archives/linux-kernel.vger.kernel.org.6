Return-Path: <linux-kernel+bounces-559095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8700AA5EF7B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2B63BDAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94FE1EA7F0;
	Thu, 13 Mar 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="FSFDk+xr"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42513261398
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857810; cv=none; b=XRlGYEVJXgEKQkoLNEBFtTr3Ube65YAFkMh6Z2gnDZ6LY7+zsQ0mQB7eBIikpzDSUczoIBLm/gXEYJQKPauicGAjMVi2OV1dJ7l6//y7xGdty8wViD3hP43kr8uIVUr1mazU02BfwdqskhSBaSxWmFvpQG8E5Zg4WpBKfyzGKQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857810; c=relaxed/simple;
	bh=cs474VhcPI7t3tkfrTw36JqTIy+bKA2J9+FdsPImD9s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TCKysZowLNxWfL6fHDPeN37da26TFOj/nKpHhJBwsFxD8JLl7/6zyMRoeTI8kmhUfR0KcKfJstLjZOxWgf6hHTAwnOmjayGRM0M3LSF/DP1OgZd75LLnHo6cUuTDqBQ/rTtNMV8Cg3o9d2lu5LkE1QiA4T5bA9U+8xX097riHFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=FSFDk+xr; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741857777; x=1742462577; i=spasswolf@web.de;
	bh=pYpuvv3ulxmuz+oME4r4W7lHEM+O3DhRjxPNwprJx2k=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FSFDk+xrUrm1IDushjeGh6BmDXnQunU34z4X3u3M2KqV9c5RKIzSkWHd0JOPJrb6
	 yyEWWLlR7ethXJL+4nRdQhZHCXnuSjdA+TJSy1QgGFGt4nXbroulTCskLWQD2F1S8
	 gxn6ECPOmwcPxhgnPfk6RlLqmZiIxhBtIuFinMKEfhxNUd4p4mBcFOvibmYRLyapG
	 SwUbWlBAsb3HAn8SAQpN30ahYwm5X4CrmkHbgvIJRWLF4Nzj7skOcqtdm7GQiRcte
	 rTnJ27+2uUqlI/DPVb20YifRjVw0+x6cUyHtDOq3v+LvzPGYv7OwbnCKx7nyAbt7G
	 EXnzKnOPb9BgTRG25w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MV2OY-1tkRYF2GgA-00Tkj1; Thu, 13
 Mar 2025 10:22:57 +0100
Message-ID: <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Date: Thu, 13 Mar 2025 10:22:53 +0100
In-Reply-To: <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
References: <20250310112206.4168-1-spasswolf@web.de>
	 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
	 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
	 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
	 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
	 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
	 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
	 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.55.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hm88DMByuin05tl6BRWZUDMGa+++Ie5GTImESR7eVkeSkS7hZAV
 8WdT5ARDb1geVlfwMNVmqwCbOejEcUnLz4u+S/8WsJz0Bi6Cmm8/F+4WkFoPpZFfRhFqbHM
 tl7tcESz6Kj7ZvWEGV9rZ/yK6z5PJgTQn+4i4Dt2cIXF8Rx4bQ7DLpVgPb9eDZX9v+1Ejlf
 hfmvsOuKv0hxqEdeZE4nQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:icYF9Nsijpg=;pi9D9Es9ppxtixb7j0ZLijERGds
 pN2pvF8UlMrOz3OzGkMRE08514nE5bi2UOdOWBXmHa9Yz4tC1lE1mXKefaWu7TyntDJVMVipz
 H+VHTIcO78XDbV9bwer0N/FZdb7w1gozib5cz8oPW0/1gf7c38Bap2p3XCzy8agp4xbBk8oK6
 3D4LnsoxiAlZx+4YTNdoBGAY4grkiXVljgTxpBUlELHm7kc1pC6kz06aMb6xQNmMYI0xArkD/
 jNQ2ikSYvXvJadzISuHGN3criKTySFXHqTyb9cKTlv4oMwQpdP3w09QSBTGxEi/gJp7h3Me3s
 PAOpeNjVBEBjNVco/t8EBepHalZBhjR1p3BAKudXTfoUOoxOFXZCA2krPaM1pzGeXqjrSDCKx
 pZ95pl0qoyWVbtIhhpKJVSa++Q3+azM00FFHA8VHaIomYN4Nki25DhZsuzqsz8k1Lwr7v19gC
 t6FJjVJ6Sw7ztnyY6o4tx6fow8xJ/aZHvt+Z9TOMGauFzbe4eVNWcphnvTEh8p86aGA7BePXx
 nRhFwdUud1fvctixjMp+WDG/EK7oaWEbYmY31vtakkxdCMGrRLdHNGxtQ0hvbmRxY/FcU5EAt
 dmztUBPitzHHGXofdyusnAeUZUuv9Vd8BLecsWUMhCYUpPrfRmFluzMzWwyZxJ+jiClADChIb
 XV53AJwTkR1Rvs4bC7VwkRg6XJbGa3Yjgqs3/5+BjAYQz8fmMYrsHgje1lVer5YG9BSFlnpfV
 5Ar/ncU0MpbbGsg1U33uQLmjmP9AhoB7ZqvkRYWTM1I/Md2rmYEuM2cLqtwmpIWGMXNuyNt7r
 8Io9thGMzjA2COoYfqwhTFzAD+5zua0Hv9UV9iqVJnZ80YEmZovyJq9serCtEqV+6dys1tMQf
 7qyqnvKZJjLhVRqsMYS7EP7kgGYrScSpd9eyHbOgBqTRLhD4mk4v1o7ySsdJ5+qG6ubHXD47A
 /qPz5IYVo9haTIh3rVrUuwhu5gmjKn4b4L+y1PK3lFDJGDeiVUcHIXYJBvKFHI6JDnilUg052
 3IJ5dkHi5ay3q+bI6jB1I/1kvnvGtcGvZeDSoMDa6HrkBg3nfbk+DiEg8UB60NzhKdXl7tWcc
 rITEV3pcLW62GgL3Zr1DzciJ9V/2DSvamBqkfVr/frGjAVMzpzAgkbP2/Hxz53TRMBLumwq9U
 d+zNoXDGw083Ww48DlEdcUY+LyyeNzIEUAiP1ZLizW9bAhUbohNDtZyRkvek3EGvOJL0oIqJ+
 JSGNfXTQd75xFyubDhquboypOoTAqmLKiYm7f1QGXI+wUj2AuSQP8Vn+xWk0/D2VjvQdNsggv
 TEBw+7i/zM7+ozjhUwOUscfEeZx37DMG827dcQG2PtQ/1O4S6mrA63VJX33/qTzSxCwBgt/xR
 AhT5atVOa8L+1ITf2bKVx8VS1qX67xYttmIJO/kqK2UzmRp4A8X/lmtSzXFMWM/o1g0cVim6G
 BDHKyCj7ZxeC03pOs+rSbExiG6Qs=

Am Mittwoch, dem 12.03.2025 um 12:24 +1100 schrieb Balbir Singh:
> > >
> > > >
> > > > As a sidenote, I've tested several kernel with nokaslr as command =
line parameter
> > > > (6.1.128, 6.8.12, 6.12.17 (the debian sid distributional kernel)) =
and nokaslr is
> > > > not recognized as a command line parameter in any of them
> > > >
> > >
> > > Please see my comment above about booting. How did you check if noka=
slr is being
> > > recognized, is it via looking up dmesg?
> > >
> > When I boot with nokaslr I get the following messages in dmesg
> > [    T0] Unknown kernel command line parameters "nokaslr
> > BOOT_IMAGE=3D/boot/vmlinuz-6.14.0-rc5-next-20250307-master", will be p=
assed to
> > user space.
> >
> > This also happens when I use the debian kernel with standard .config
>
> That is quite strange, I can see nokaslr handling in choose_random_locat=
ion() in
> arch/x86/boot/compressed/kaslr.c (which depends on CONFIG_RANDOMIZE_BASE=
)
>
> Thanks,
> Balbir

The command line parameter nokaslr does actually work, I tested that by bo=
oting
the kernel with and without nokaslr and checked /proc/iomem for the physic=
al
address of the kernel. With nokalsr it's always at 0x1200000.

The warning message in the code
	if (cmdline_find_option_bool("nokaslr")) {
		warn("KASLR disabled: 'nokaslr' on cmdline.");
		return;
	}
on the other hand is not shown, because warn is basically __putstr() which
outputs to the serial console and the screen, not the log buffer (Which we=
 do
not have this early in boot anyway, I assume).

So with this solved I tested stellaris with a kernel without CONFIG_PCI_P2=
PDMA
and nokaslr and found the same buggy behaviour (i.e. laggy input while ste=
llaris
is running).

Bert Karwatzki



