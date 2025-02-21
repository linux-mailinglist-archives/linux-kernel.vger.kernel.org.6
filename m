Return-Path: <linux-kernel+bounces-526300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A019AA3FCD7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319441697AA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D16C24BD10;
	Fri, 21 Feb 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="yFd8hA1e"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B72E442F
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157573; cv=none; b=dBGZSmrwdfjxipsbVnVpv2bYVuIiimDnAmjr2AJtv1Yvs29cGEmFhRVQoGSn+7HLwAXKQ/qvktu+AmGSZ+9zjE4XCoHQwMR+VR4dygjqr2K8nlWDH9NWA08h30+jAS+4N7DDXAGRkTbcChwN1VxGtlEgIUAbAK+3uSQyCdaahLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157573; c=relaxed/simple;
	bh=6aTAG33GXbthnOFm9BMutu45WRm+bikg09wcb56nqGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHpX3Gloq1P64TIyjfsBDEyGjQYEPVWd0/U19Ub3g0blmq4/s7y4EFi/CovytFFfQMuhzdNkUooZfViC9bPMH692dXBS8pt55SkUl6vSqL9SuxVNmJfRNo9yKnTG2litTGVvcm5CyFRBLL1H6DIs5pL7tJIdceayr8jefxXZ9+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=yFd8hA1e; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id C9D854265F;
	Fri, 21 Feb 2025 17:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1740157560; bh=6aTAG33GXbthnOFm9BMutu45WRm+bikg09wcb56nqGQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=yFd8hA1eSgRe4Ug0aYqGb7aycPGypHBBQk/E2E1VRzQLd6JVkGVyrAoP/YscN2mGc
	 4hAQUZq8GpSFHGa9K+arnPQHbctCEgBL8ZAC0Epa2fFOYkTSXLP/U2KWYxY/qjDNPY
	 Mg4x+MoSLAYrdd1GqRsCwF2iLC+EDOGkrJIXNhhlGDBAVgZte8p1bek9zMHy80ajE0
	 HoTD8hDCN0x05ccySbXH5z9Q/Ti1jC0kv6XM6xetwWMgVzviSqWPa386XAu+593biT
	 DOHi2820KsRXnN88gu+BGXSt2IzbzuyvDTyHHXobCZ9bJAF/C/zrFh+oiq6+zAmhHZ
	 iVUsmCsljM2mg==
Message-ID: <5f26b440-14ec-42f6-9d29-1657d88cf5a0@marcan.st>
Date: Sat, 22 Feb 2025 02:05:58 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Remove myself
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, asahi@lists.linux.dev, soc@lists.linux.dev,
 David Airlie <airlied@redhat.com>, Simona Vetter <simona.vetter@ffwll.ch>
References: <20250207-rm-maint-v1-1-10f069a24f3d@marcan.st>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <20250207-rm-maint-v1-1-10f069a24f3d@marcan.st>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025/02/07 3:21, Hector Martin wrote:
> I no longer have any faith left in the kernel development process or
> community management approach.

As I was rather brief in my commit message, I feel like I should expand
on my reasons for leaving (particularly given a bunch of people [1]
think everything is resolved after Linus' latest proclamation and we
should just move on).

Many of you are probably familiar with my frustrations [2] with the
kernel process, which form the background motivation, and I'm unlikely
to have any desire to participate in kernel upstreaming again until some
of them are resolved. Similarly, the issue of kernel maintainers
attempting to block project progress, doing the Linux kernel version of
Elon performing the nazi salute [3] (make no mistake, Ted knew exactly
what he was doing with that line, and that it would be plausibly
deniable by the actual nazis and those unaware of the cultural context
or eager to grasp at straws to defend him), or generally being assholes,
certainly had an impact.

However, I should clarify that what pushed me over the point of no
return and to not only resign as a maintainer but also cease all
commitments to work on kernel code [4] was, specifically:

- A pile-on [5] initiated by a kernel maintainer, which was apparently
motivated by what can only be described as a blatant, deliberate
mischaracterization of my words [6]. I can only assume this was a
convenient excuse to lash out pent-up grudges against me in public.
- The hypocrisy of complaining about posting on social media while
posting and flaming about it on social media.
- The mischaracterization of my social media posts as "brigading" (by
three kernel maintainers including Linus, no less), which is a loaded
term [7]. I have been the victim of *real* brigading by the kind of
internet trolls who work to drive people to suicide, including
successfully doing so to one of my friends [8], and it's not funny.
- The accusation that the alleged brigading was a way of generating
attention for donations [9], which is quite frankly disgusting.
- Some even more disgusting stuff that came out in private and I will
not elaborate on here.
- The fact that all this came from kernel maintainers who I *thought* I
could work with, have had multiple discussions with in public and
private, and did not expect to privately hold grudges on me for a long
time while putting on a face, only to release them all in public without
so much as an attempt to discuss them in private.

I can deal with overt assholes, but I cannot deal with people who put on
a friendly face in private only to do a 180° later in public and stab
you in the back.

Sima, I wish you the best in "derailing, sabotaging and maybe improving
the Linux kernel from within" [10], but I have no hope left for your
approach. If you truly believe you've spent more time "handling the
fallout from my brigading" [11] (without ever communicating that to me;
also you really seem attached to that word, perhaps it's time to learn
what it means) than working on your approach lately, maybe it's time to
reflect on whether I'm actually the problem, or the problem is that your
approach also doesn't work.

Best of luck to this community and everyone part of it. I'm going to
take a long, long break myself.

[1] https://fosstodon.org/@airlied/114039656644172292
[2]
https://lore.kernel.org/lkml/208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st/
[3] https://lore.kernel.org/lkml/20250208204416.GL1130956@mit.edu/
[4] https://marcan.st/2025/02/resigning-as-asahi-linux-project-lead/
[5] https://lore.kernel.org/lkml/Z6OzgBYZNJPr_ZD1@phenom.ffwll.local/
[6] https://lwn.net/Articles/1009671/
[7] https://hachyderm.io/@chandlerc/114001000657957325
[8]
https://www.vice.com/en/article/what-i-learned-from-near-an-emulation-legend-and-real-person/
[9] https://lore.kernel.org/lkml/Z6YPfsDSNdRUskvp@phenom.ffwll.local/
[10] https://chaos.social/@sima/113942119012147959
[11] https://chaos.social/@sima/113962228220035362

- Hector


