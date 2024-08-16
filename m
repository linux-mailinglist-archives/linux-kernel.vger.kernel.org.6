Return-Path: <linux-kernel+bounces-290019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E92954E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 18:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A8D1F20CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 16:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2BF41BE250;
	Fri, 16 Aug 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="TEPYnjX1"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E151BE235
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824654; cv=none; b=p0BG/YSwG3rcPbNUyfimaHoNdlMp0jRYwTFI4Z48qEQ8c/PT68cQi+Q4iuvAoV0GyDrnhqBAroskp2YteJ65SaCaTa6Q0+dSvV9c/Oazff2gIZ5PvemXJ7q1L3NuE3gzJpkArTjA6MaLSSsJmM/c4goKyiwyYWZFXQJJBzc7kfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824654; c=relaxed/simple;
	bh=0LMgY1vZ6fGXRxFnkCzE+P34DoKZrV+36NlSpw6iXVg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=j4ixI9MBBUwEbPRQgREBWTsHImwi2AETvNiRHt1ToQ+25xaKwDGxaf9O2nfPu3o7NkLhM6Gso+llHH8LFY4/eOACgiXQeRjjDfeNHu6dHXnGMj/YPIfdywNR6vLNtAUXL0nNz9xnuzNVtDD/4D1hpoS7MkhpI9pDzK4lQYwLWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=TEPYnjX1; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1723824644; x=1724429444; i=spasswolf@web.de;
	bh=XHeSc4EmQEyvh1Xp4MeSDRuGugN27ZqCYg6lFm5zXkw=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:In-Reply-To:
	 References:Content-Type:MIME-Version:Date:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TEPYnjX1mbsCUnunMTrszooQJtAa50thEBVJeeEzp91TyCHG7jk5Qb+uBdTux1AA
	 NoU3/hZkZcO1y+aijbNGmNY9USLzLDxGnLEvpBHXy3opNZweoJVhgSlLr8um3/jyC
	 Au1gQuK+rJnipVSTjYks4IXKu5Q92fTDQ+9aPRWiVAoY2Up3jZreLIqkGAO4abWrO
	 LzDGuQJhVKvVtGH6XNLEyPtNsTjjfjkRqReFHGf9OdOcr0Mtqp3Sc5jjlYiAm5dRT
	 L6eJWW2/xVVkU1A5zg1NpVxDVxgYJjQFXrRrYclUujpBbVHQQjhe1vPWsoD0eTUVx
	 eWrF+u5bSzJLHUIWxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkElP-1rucF31YwT-00eAAr; Fri, 16
 Aug 2024 18:10:44 +0200
Message-ID: <0d377467c50cf60a4d008d7986d4402eecb8c94a.camel@web.de>
Subject: Re: [PATCH v5.1 00/19] Rebase v5 patchset to next-20240816
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <5fa31825-e7dc-4d58-b218-d54ed6d86507@lucifer.local>
References: <20240816111405.11793-1-spasswolf@web.de>
		 <5fa31825-e7dc-4d58-b218-d54ed6d86507@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 16 Aug 2024 13:55:33 +0200
User-Agent: Evolution 3.53.2-1 
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KJ/tHxtS9QD8WiaE74h81FWnlfsSwU9ypMpgMZY1ephZteF4pGY
 rJ5ELc/PbkVlq09aa9bWLTgdYa/Me94S6qLDo/0P4AkQRDhNfxkoXY52uxRAjv91hkOMpsw
 IpNWjlpZpDn4U+cJDu3Xu/01Fx638E8HofpnxYV0tOzZmuCOTo3u/PmAIbpF8rNHlmvk3v+
 NPcIM68wM5x5QdzfrMiAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VAXjOzJTUWs=;vAmCcuA/HBBM31mr+nugY7mx3zR
 EEXQbBHQj4CI2WtP8grSMQCOP+IbJrXsRg14HAjwAJ8/NY2ZWZ5zFQdDBdZfFAjR2yZJqsNht
 Vs625ib95qMeBYKtGrDvKnpSOSERUZFYOniZRiEupX2uayPfVEVOi7hsntbqXQqh9FSF8XPbF
 agGv3skdZadGcW4MQKG3BgHF8fto6YAV3vUxnU5fAhIDX0S8WYz3sxNuIqobDm9+7IjJ6AUED
 cVn4HFgqMB0LYxkanvAWWodMrw8o84yFJxFRr3jQyiSEPaFx4uHqp2s26yjT/dhS1ZaPgKe5h
 cau/hoTgVYcm1yEj1rcfPMVCPnC13C5jq/0eruwoUD64v7vjLITO7gwiFxJnowz+wZZLhaAZ1
 nVn39A2+VVjhYSVVBIpGmEUlA9oBX6CPc2A1Y1kjTDQFtgjO0egQN+cJ1eDSLVovg1PGKNrd1
 kC2awslXfqS1Kq/40eayQKeho4tUcRzUVCTsQ5LFICM3w8V5sw8pP0fUkJlOjBMzYgZW21CoY
 U3tqBpOY/eEcohPHgqQYb5BiHSHCBr4W2rdMalJQb7s6bwD/TfBN4QJ8oK3o5kn86yHyEnpWu
 +/FmY57pP6tp9SNGSucgqrNLCBfoLrooMZQbDsAdXMgVcsdEbnAYpDXPUaL34Vg13xsOF+Dej
 jCBUoALvjszMA11ZLghiMPecKiNaVaJQQzs/Qchv0vf1//fAXIReNgnDWNvl8sPHiarWHMnMP
 vX9QTIWHX4tX8iu5a4aDvww5f5OjAmwmYdjdrkYixPXXckhX45g2Tn+pGhkP3qVtfx+s753EG
 ecAWWGvifJj5lzIm2xiVxHjg==

Am Freitag, dem 16.08.2024 um 12:33 +0100 schrieb Lorenzo Stoakes:
> On Fri, Aug 16, 2024 at 01:13:41PM GMT, Bert Karwatzki wrote:
> > Since the v5 patchset some changes have taken place in the linux-next =
tree
> > which make it impossible to cleanly apply that patchset. The most impo=
rtant
> > of these changes is the splitting of the mm/mmap.c into mm/mmap.c and =
mm/vma.c
> > and the splitting of mm/internal.h into mm/internal.h and mm/vma.h. Al=
so
> > arch_unmap() has already been removed from mm/mmap.c in next-20240816 =
so
> > there's no need to take care of that.
> >
> > When testing this with `stress-ng --vm-segv 1` dmesg show errors like
> >
> >  [   T3753] coredump: 3753(stress-ng-vm-se): over coredump resource li=
mit, skipping core dump
> >  [   T3753] coredump: 3753(stress-ng-vm-se): coredump has not been cre=
ated, error -7
> >  [   T3754] coredump: 3754(stress-ng-vm-se): over coredump resource li=
mit, skipping core dump
> >  [   T3754] coredump: 3754(stress-ng-vm-se): coredump has not been cre=
ated, error -7
> >  [...]
> >
> > this is most likely not a problem of the patchset but instead caused b=
y
> > a more verbose coredump introduced in the following patch:
> > https://lore.kernel.org/all/20240718182743.1959160-3-romank@linux.micr=
osoft.com/
> >
> > Changes since v4:
> >  - rebase on next-20240816
> >  - some functions which were static in the original v5 patchset
> >    are now non-static as they're used in both mmap.c and vma.c
> >    (an alternative approach to this would have been to leave
> >    them as "static inline" and put them into vma.h (at least if
> >    they're only used in mmap.c and vma.c))
> >
> > Bert Karwatzki
> >
> > Liam R. Howlett (19):
> >   mm/mmap: Correctly position vma_iterator in __split_vma()
> >   mm/mmap: Introduce abort_munmap_vmas()
> >   mm/mmap: Introduce vmi_complete_munmap_vmas()
> >   mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
> >   mm/mmap: Introduce vma_munmap_struct for use in munmap operations
> >   mm/mmap: Change munmap to use vma_munmap_struct() for accounting and
> >     surrounding vmas
> >   mm/mmap: Extract validate_mm() from vma_complete()
> >   mm/mmap: Inline munmap operation in mmap_region()
> >   mm/mmap: Expand mmap_region() munmap call
> >   mm/mmap: Support vma =3D=3D NULL in init_vma_munmap()
> >   mm/mmap: Reposition vma iterator in mmap_region()
> >   mm/mmap: Track start and end of munmap in vma_munmap_struct
> >   mm/mmap: Clean up unmap_region() argument list
> >   mm/mmap: Avoid zeroing vma tree in mmap_region()
> >   mm/mmap: Use PHYS_PFN in mmap_region()
> >   mm/mmap: Use vms accounted pages in mmap_region()
> >   mm/mmap: Move can_modify_mm() check down the stack
> >   ipc/shm, mm: Drop do_vma_munmap()
> >   mm/mmap: Move may_expand_vm() check in mmap_region()
> >
> >  include/linux/mm.h |   6 +-
> >  ipc/shm.c          |   8 +-
> >  mm/mmap.c          | 146 ++++++++---------
> >  mm/vma.c           | 397 +++++++++++++++++++++++++++++++-------------=
-
> >  mm/vma.h           |  61 ++++++-
> >  5 files changed, 403 insertions(+), 215 deletions(-)
> >
> > --
> > 2.45.2
> >
>
> I appreciate the effort taken in rebasing, but this is quite confusing,
> it's like you've re-sent the series (with tags...) as if you were
> submitting it, which I'm sure isn't your intent.
>
> You've also cc'd Andrew as if it were a submission and everybody else on
> thread...
>
> It's probably worth marking the series to make it totally clear you're j=
ust
> doing this as a favour or for testing purposes (I know you at least chan=
ged
> the title of the series accordingly). At the very least RFC it...
>
> Also you should mark that this is based on -next, as mm work is based on
> mm-unstable (for this series, likely the same).
>
> Liam is working on a rebase/rework of the series in parallel also so we
> should definitely be careful to avoid any confusion here.
>
> (Oh and as a side note - please do not send email to my personal address=
,
> all kernel mail should go to my Oracle one please).
>
> To avoid any confusion:
>
> NAK this whole series in this form (+ wait for Liam's next version...)
>
> Nacked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Yes, this done for testing purposes (linux-next had several NULL pointer e=
rrors
(unrelated to the patchset) and as these are resolved since next-20240814,=
 I
wanted to try the patches again, which I last tried on linux-next-20240730=
).

I should have taken more care in marking this as unofficial testing. (and =
not CC
everyone)

> (Oh and as a side note - please do not send email to my personal address=
,
> all kernel mail should go to my Oracle one please).

Ok, I just copied it from the Cc of Che old patches (like the other addres=
ses.)

Also patches 16 to 19 of the set are currently stuck as smtp.web.de curren=
tly
refuses to send them.

Bert Karwatzki



