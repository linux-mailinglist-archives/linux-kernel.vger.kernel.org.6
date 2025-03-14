Return-Path: <linux-kernel+bounces-561565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D41A61382
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:19:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C9619C2C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 14:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4AC200B8B;
	Fri, 14 Mar 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="Pv90pe6j"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231D120100D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741961938; cv=none; b=dP1fHWyoFsw5QWR8uTjyYgky3EXSSKkAjFSugrfJwv9JNq04fkJyx6bsf7LARY/0vvu8uBqEq7xwCz95/nrpXWgEWqIv8ek1JnSsik/NLMDdjJluRK9YMsa8rKRiLfl4bijwC+F1OyRggNglCA8mplyn3cr0jZanPgQ6UfGHM10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741961938; c=relaxed/simple;
	bh=MMXCvzVSsnXJfTFfmo8AAWVj0LU8f9pVtacOtgvnnyc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lxm82wnPQGJBgPlyaZz7F2BQdV9c9So86Cv7cMbIBEeE7SgTnDr/qVwhPqDVsfNJMSW1og3do1Yv9FUstfhEkQG4YIsNbkD0Jdjs3qhHJi4GUClzKQd6NfRj17eRe9F9bb0TWYZ4JQSs1GyKnUELqyVZDmPVJ6fgkvzJSvTR8e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=Pv90pe6j; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741961921; x=1742566721; i=spasswolf@web.de;
	bh=MMXCvzVSsnXJfTFfmo8AAWVj0LU8f9pVtacOtgvnnyc=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Pv90pe6jWhTcZpGIAaJ57aXgcQhWM+htgS2yzQO1jcfrQUpSvvwS3rCxKalZ78Nd
	 kQI1PxFIo8gP4rwl66+s9cuVbxNq5KOsUOw/bP9brifVshsWRVM8SGCchs+ywHFnF
	 Utxa+zpFzh+8iTQV8hu+41Rlbc2BnymNywFTysyMvJ6rplnYQ1MZGvTgnDF3PZKB9
	 VV6mlSrIVd2ctDRHFJCt331DePV8s9cuse3UsWPvLFTCmyU0T+2j66SnsTk5/IOYn
	 kLZbfG/Qv7dWj8cknaLS2hkrbsdX05ExnvwLgvlFM2aGCIufrGuaSLJ0d85zd1OpM
	 jn/dQvn8jo9RtvTuQA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1d3a-1tDSWG3sLI-00wfdT; Fri, 14
 Mar 2025 15:18:40 +0100
Message-ID: <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
	amd-gfx@lists.freedesktop.org, spasswolf@web.de
Date: Fri, 14 Mar 2025 15:18:40 +0100
In-Reply-To: <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
References: <20250310112206.4168-1-spasswolf@web.de>
	 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
	 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
	 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
	 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
	 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
	 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
	 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
	 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
	 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
	 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
	 <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
	 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
	 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
	 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
	 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
	 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.55.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ebrQGhTuB5IaK/ZPSDR+AZZWCXBtE+KEaS2jLlq4gXD7D9YZ5d8
 Rc+k+6v3Dj5Nkn7wmB3hEzdHWHdSmyb3En2YkkRZsduKLIdAmZXmAuDP7cgq0tXWjEsLSH+
 3LMFqWw8VhOkDLxcoLKebN6lw9pjN0j8UHaSk73wg39qZsq7Sj05dCPmNsYlSLDa6Vc72+F
 6/ZmiRcfqnKBsUKHBHAqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kgV/IjQ466o=;sLMUl1q9J5W54DlH1qiMPCd0+Kx
 Qc+iSgx/iwe8MZDQM5FC5P0rK9Zw+AtE//eGjMyVkcxWAyBwbsHch8z/brUpLPVS0zAtZEGX8
 LSFYs4yUXAv6fCo7wQJmpz5hjgNeM+qghk/Zjxi1aRa5TdsHXHGX3dIObVdkglt/11zStvhKa
 4IyNbLP2J70BqvF6IUOScuHIcu5/YKgVwacVvfBPMLjP2IFOYQ10+Q3+KSZ6M4d6zttTVAKOD
 O4tb76bAEdEX//iI54rHPVQJhSnm8nc/jXb+phu3A8SJrrxbuNbfeqgT6fXQ/oUpHMdyJXu4A
 gkjKgWfc/5JtDCQ8gEAZTcU0YsHZBW3iLB2571EKPU4ZBYRP3JWJWJmz9alG3TD334PwfoPpm
 vNgHyn+9kDgvBpvpm9pihhvO41TH5muTTuzkVqiwzXB3DNp4Zme4VgbbRsBVnUJcxq6orZg+i
 YTYgGLfruIO6lO4Ob9+iGHZVRghLhOCK1WfwxKin/LoDAZoQpu9iNjPaanLq1+zk2y0G6ATsI
 j4qN/7HnhRnpbgps0AykqJdXsgR9I8y94R7oV4md1GSe4pL63hm5cTJHYAg5oZRRgsB5WTtyJ
 guzjN7DySg069D53EIROk4QY5D7DAyxWJcPa91h6wGvWWpHQel1ohKsiUs142hS0wNfKfNGEN
 Gxb9+ZUr5N4CDO8J/HY3oNTSHK00bixxWFDJgGUkkBkG8lSMtXiMD6qkeA84GopEAyvpTi/+m
 IXxYxv0u/pmImUAs+zWUkxrHg3zIkBGkobvFJqr+smXlQlmRvkLTzYT4BIumCiVTT2TrjCvmw
 BB9Wpag6euO0NGA3xVJY7A26XF/5dvAXdc7hEEmEseZ0uvrE39rERAq5ne9uvQJn28FhPWnuC
 6yBWkbCwW+TMm5bc0w946ML0ByxIgW0kRD3WCwCaoocUrFKNcJ+WryxclyFF7i+k+I/rdW9C3
 pIDb0gMdxX1e08ibl4QDx9Jzs25i+VZqQqui1KqLE14zhdiC+JKuyikUo3dRqsK1T6AdcrlBc
 FIqzczRKrjOumBloO2X37ifiDzepDxsyRd9ckF9EEQ7+F5ZcQm/+Lf7GGbcwkzvk4EoP7Hg0T
 cECZvcnZom8RcuY/43/t3PHaTxC8Azx7KQ3riDSw6kIZZiZ1cLzFrxHPLov+IMhvevlsrhaxv
 jzjh9kawZznh8NlX29wu6yMCeLvnW7K/ziosAWdqrofb6N9XpWk6fWYo2BeUOS3565j8RyFoX
 uccbR43DayzZNBT07pgaMcuER/x7cPQg93V13Ljvj+vpXh9rK+ZJJw6RWOMUxBQZhvAbfqxrj
 i3NGR9xHP6EX/feRfmEGwh2pjwJosve56toWn1Zy2nue9NKpl1OYYK7Z8zANwN2v/zQIMjM0Y
 tQ46I7G1Pb63+0psxIGUkaPfmYvrsLOIIUfBjXqxASQYwEF9EvsLxyj4oDgevE1daxzXtZ7w8
 a+pVMOIXw0NoN9VFnGY5+p+STYLk=

Am Samstag, dem 15.03.2025 um 00:34 +1100 schrieb Balbir Singh:
> On 3/14/25 17:14, Balbir Singh wrote:
> > On 3/14/25 09:22, Bert Karwatzki wrote:
> > > Am Freitag, dem 14.03.2025 um 08:54 +1100 schrieb Balbir Singh:
> > > > On 3/14/25 05:12, Bert Karwatzki wrote:
> > > > > Am Donnerstag, dem 13.03.2025 um 22:47 +1100 schrieb Balbir Sing=
h:
> > > > > >
> > > > > >
> > > > > > Anyway, I think the nokaslr result is interesting, it seems li=
ke with nokaslr
> > > > > > even the older kernels have problems with the game
> > > > > >
> > > > > > Could you confirm if with nokaslr
> > > > > >
> > > > > Now I've tested kernel 6.8.12 with nokaslr
> > > > >
> > > > > > 1. Only one single game stellaris is not working?
> > > > > > 2. The entire laptop does not work?
> > > > > > 3. Laptop works and other games work? Just one game is not wor=
king as
> > > > > expected?
> > > > >
> > > > >
> > > > > Stellaris is showing the input lag and the entire graphical user=
 interface shows
> > > > > the same input lag as long as stellaris is running.
> > > > > Civilization 6 shows the same input lag as stellaris, probably e=
ven worse.
> > > > > Magic the Gathering: Arena (with wine) works normally.
> > > > > Valheim also works normally.
> > > > > Crusader Kings 2 works normally
> > > > > Rogue Heroes: Ruins of Tasos (a Zelda lookalike) works normally.
> > > > > Baldur's Gate I & II and Icewind Dale work normally.
> > > > >
> > > > > Also the input lag is only in the GUI, if I switch to a text con=
sole (ctrl + alt
> > > > > + Fn), input works normally even while the affected games are ru=
nning.
> > > > >
> > > > > Games aside everything else (e.g. compiling kernels) seems to wo=
rk with nokaslr.
> > > > >
> > > >
> > > > Would it be fair to assume that anything Xorg/Wayland is working f=
ine
> > > > when the game is not running, even with nokaslr?
> > > >
> > > Yes, Xorg (I'm normally using xfce4 as desktop) works fine. I also t=
ested with
> > > gnome using Xwayland, here the buggy behaviour also exists, with the=
 addtion
> > > that mouse position is off, i.e. to click a button in the game you h=
ave to click
> > > somewhat above it.
> >
> > So the issue is narrowed down to just the games you've mentioned with =
nokaslr/patch?
> >
> > >
> > > > +amd-gfx@lists.freedesktop.org to see if there are known issues wi=
th
> > > > nokaslr and the games you mentioned.
> > > >
> > > >
> > > > Balbir Singh
> > > >
> > > > PS: I came across an interesting link
> > > > https://www.alex-ionescu.com/behind-windows-x64s-44-bit-memory-add=
ressing-limit/
> > > >
> > > > I think SLIST_HEADER is used by wine as well for user space and I =
am not sure
> > > > if in this situation the game is hitting this scenario, but surpri=
singly the other
> > > > games are not. This is assuming the game uses wine. I am not sure =
it's related,
> > > > but the 44 bits caught my attention.
> > >
> > > Stellaris is a native linux game (x86_64), the one game (MTGA) I tes=
ted with
> > > wine worked fine.
> > >
> >
> > Thanks for the update! I wonder if there are any game logs. If you can=
 look for any
> > warnings/errors it might be interesting to see where the difference is=
 coming from?
> >
>
> In addition to the above, does radeontop give you any info about what mi=
ght be
> going on? I am also curious if

This got me to test stellaris and Civ6 using the discrete Graphics card:
03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi 23
[Radeon RX 6600/6600 XT/6600M] (rev c3)
 (with DRI_PRIME=3D1) and here the problems do not occur.

This is the CPU-builtin GPU, which I normally use to play stellaris as gra=
phics
aren't very demanding, here the problems occur when using nokaslr
08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI]
Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)

> nokaslr and pci=3Dnocrs works for you?

pci=3Dnocrs does not change the situation.

> Balbir

Bert Karwatzki

