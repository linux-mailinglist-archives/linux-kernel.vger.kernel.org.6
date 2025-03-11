Return-Path: <linux-kernel+bounces-555950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7519A5BEAA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81BE416CC1F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8092250C1D;
	Tue, 11 Mar 2025 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="DVrVGPfe"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA35238D39
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691758; cv=none; b=Ga7X8WjhahfrmoqWQeACYkO0hRIP9gkhJ22odUro1/ynHDqdpIuvReCyB5iAOvAmGJqRwYgfL4pf46FMX/X7tevTYTB0YSM2QEmbBe2OQXZMiawqtSSoozkiX3MvtvXRZwZaQRLRuy3k6KfCZ4IEIb4Bn57ER17K4Ihr35r1X8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691758; c=relaxed/simple;
	bh=EEAtXMwXjmBPLIl4fVxwfi5mNYmnFCsyHFaJ2CT8kEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=slSyzqYi8Mcab3WgOJgd5u0gtzFkUWdpeeNxH5r1L6sSUFLI2G0Fbv8ClkDgvOmHomF6/3HYNwHm4pMCe0eUw690KjoE4KfvpZh1ol7eS4i84jhr9rSQBCCTM0rYzjJ8NlMIN8xL9OGTHQKOgQNDqc2I/PYY3aJxh6Vr42N9sI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=DVrVGPfe; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741691733; x=1742296533; i=spasswolf@web.de;
	bh=Garf7SQM72nGjjYcxKr4PRAu7hm8882kDVj2af+03Xg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=DVrVGPfeVENeiYhFg/DdHs8EVBlCNw5wKIgau0QvkcNSXXMFBpXjeqYUEUlkiKIU
	 HH8ePGHLB8EWrD9FDJBhVjfXfysMDMRFS4RVr4Q2UzAyPbDGrUOCBD4sQKSlDNjyj
	 ey1/YhySRNSRk8P1ovuTjYAr7vcljRagvDsAisBJeYO4xYRITB6KTIcB4FT9352L3
	 uEufY5R6B7UG5Nma1F3aufrjCHUM/goYML8rknMO5KqnGHCpBQ3uUUoODQyr5KF9z
	 PApolFar8EhDvZMLGQ/kJ4bvfEmCHaXHLGeOEV1L9Lb+3El37fO15Qu5zGcddtOCR
	 mvrk7kbGZbtKjbNeig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mv3UY-1t1Mzl1pzs-00rzo5; Tue, 11
 Mar 2025 12:15:33 +0100
Message-ID: <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Date: Tue, 11 Mar 2025 12:15:32 +0100
In-Reply-To: <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
References: <20250310112206.4168-1-spasswolf@web.de>
					 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
					 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.55.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E87BY3QVpWptTSPR8Obeim8+Vtt0mN4uR24DtwazkvoP72J6Lis
 BQIPts0ER73eooi423t+CVBBSt3ioYFW/DghIpAb58Qi/yO1fI5bw2MY4r5fSTCBzXsAWk4
 dV0MCTMYrb5eYLnB7bt39+XL02U7u+2fQKn5WDhFDY3wsRVcizw8PcgrkDzlAMllrefpFEQ
 Ho0bnTndG/lO7lA8DzYCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QDT7DY+AgTM=;7+MYpkRAsGv8ouUBDWW/57nQcK9
 Zh6jT6OrNYDH2yn5CdiTmXgcheTy9wQLxizQTBtFI8GJAO0sD4S8k7Ab7OOek/fL/PYKs/i8i
 vEiCA+939mM737LXgv6NCBO6fMU4EKbp9SJoxfrptOEaHyDXyKEGD665WvcacP3UoniE8ZgBN
 g+4SHm2oOC3RBYz4l8XMI7JejPqsWIj6KfD0042x5+O3v3kl3CG7YPVgPq3hGHbXewDVRmnnS
 US25tERGdtX3nJOf0F4LfZXcrphs/XIBEFVqo3jNkYDwVnzMEiqChkRTPahwjAYviXezxwjIs
 rSH5rBv4v5SAO/wnIDZGWSFW6VyzKPtckETWIEpMl640GD6Pts1uqMqFWfWzMxTirgHTV6ncq
 Vep8IziBJy9Yj1/LJWUNO6bh42mm/ZHqsXKkijjJ2qbTf845rlrJWbC36pv8D0WgVok52zacR
 xydr28VHLC3kFZrVr2CcGrhqSZ2POuwpQcJ25o0jZwVHtUU5eyabOryVPgd4/80u1++iQkFxP
 tQZnAUMoMAKoETCYj4VbKXaFqLhsya8eCy/NNLkWkDNe9OgaMfFP1igYIKSGHluCIUhBuwp7V
 P2gRUrKxYIrgwk0BaAjsuJtjrA2oZJ9dBkLjZZcl42Ws9Usm7+bTHM7j1SsHswsYjvzbpqb8F
 YyqxYsi5v53SKIA3T4Izc9vcMzMjqdXIYop/6cFB0pbfks9eVDWBzi3du4GryMfdPrwERSkqs
 Yw9iDUxppZkX9UQRGHWSha2gFkoQh89tFLNtIDBReBfgGbBWdQ/WPSQcnGfs65HzkGw9D6kVI
 /HHOAhG0SOUuzITJ27tAVPFP1ZpR/Ujzjg3yYwYOMlRexSwdEtm6JHUge3gD7DkgFQ6YLNfrj
 uvfXMg0mYh6MWc2IImA5Bol65x7kOKoNYBL3wWKDEI9JEGsGJQ5aaMbbu8s25bh7EvL0QAHFH
 bsA6IPgKvbO5abSnVUUSKzxJBvCZMJa4KIi0Rjk1jrTFQYCtodmaZMKqdv1cTNajEWiK2ok9Q
 Mk8EOiRWz7e/0/ZnOk8esXBQM4HZ/nKEcgqVfSQc8NQNn57WZVtelv8ql+cjq8zU8jW7DA8b4
 ykVwdjw7qBi3fL+ZxVqppypkUvvlbL8tNwobiHla6NY0Krv/6xffofbhKevYb0nv3wUFwF3t+
 TTfJlqCP3pzSvnPzX0og7uipbAoluwYb7H2kOYdCxD1Q4/bZDFJkWkCQCkeQzrscMRI6RzBOt
 dMhX1bHnYek5473V8/0ukZq8oCC+c1LNPfnB+oY/vwPwjgCjvFhCvR+cnG1m54sY1bdF2D/3c
 yWISPuhcf2uzswsopi9De4ob8F0mMJNBSuegHQ+IEDkS6AZhPvIzQrVL2x78uHfWPGs+XRrDG
 YTDFF6tcMVJqlwIzOscqaSytTHC2koVgf+C3Iu8IWc/PE73yp5sJYMExO/hYdU2t8WuCN0jKY
 A6ZovKA==

Am Dienstag, dem 11.03.2025 um 18:19 +1100 schrieb Balbir Singh:
> On 3/11/25 08:48, Balbir Singh wrote:
> > On 3/10/25 22:22, Bert Karwatzki wrote:
> > > Using linux next-20250307 to play the game stellaris via steam I not=
iced that
> > > loading the game gets sluggish with the progress bar getting stuck a=
t 100%.
> > > In this situation mouse and keyboard inputs don't work properly anym=
ore.
> > > Switching to a VT and killing stellaris somewhat fixes the situation=
 though in
> > > one instance the touchpad did not work after that. I bisected this b=
etween
> > > v6.14-rc5 and next-20250307 and got this as the first bad commit:
> > >
> > > 7ffb791423c7c518269a9aad35039ef824a40adb is the first bad commit
> > > commit 7ffb791423c7c518269a9aad35039ef824a40adb (HEAD)
> > > Author: Balbir Singh <balbirs@nvidia.com>
> > > Date:   Fri Feb 7 10:42:34 2025 +1100
> > >
> > >     x86/kaslr: Reduce KASLR entropy on most x86 systems
> > >
> > > Reverting commit 7ffb791423c7 in next-20250307 fixes the issue for m=
e.
> > >
> >
> > Thanks for the report! Could you also share the dmesg? Do you have any=
 proprietary
> > modules loaded? Could you also share the output of /proc/iomem (captur=
ed as sudo)?
> > The lspci output is useful, lspci -vvv (captured with sudo) would help=
 see where
> > the BAR regions are, specifically before and after the patch. Could yo=
u also share
> > the kernel config?
> >
> > I assume your config has CONFIG_PCI_P2PDMA enabled. Did the system eve=
r work with
> > nokaslr for you?
> >
> > I am a little surprised that reducing the entropy causes these issues =
and having
> > a larger direct map causes these issues.
>
> Hi, Bert
>
> I tried to reproduce the issue at my end, but could not. I am new to Ste=
am and my
> hardware/games are also different. From what I could gather, Steam is a =
32 bit
> application that uses SDL. For my testing I used Xorg, not wayland
>
> In addition to the above?
>
> 1. Could you confirm if the mouse/keyboard work outside of Steam?
> 2. Does evtest /dev/input/<mouse device> show anything?
> 3. We could run the kernel with nokaslr and see if the issue reproduces?
> 4. As a test, we could try disabling CONFIG_PCI_P2PDMA in the kernel con=
fig,
> build boot and test, this has the same effect has not having the patch
>
> Balbir
>

1. The problem is not with steam but specifically with the game stellaris =
(which
can be started without steam). As long as stellaris is running there is a =
~2s
delay in keyboard and mouse input (for everything), killing stellaris rest=
ores
input to normal.
2 evtest /dev/input/event{1,3,4} (keyboard, touchpad, mouse) seems to show=
 the
same output whether stellaris is running or not, only if it's running ther=
e's
the mentioned delay.
3. For some weird reason my kernel does not recongnize the nokaslr cmdline
parameter, so I build a kernel without CONFIG_RANDOMIZE_BASE and this does=
 NOT
fix the issue.
4. Most surprisingly removing CONFIG_PCI_P2PDMA also does NOT fix the issu=
e.

Bert Karwatzki

