Return-Path: <linux-kernel+bounces-320141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9C4970694
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C066FB216B0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9379514C5A4;
	Sun,  8 Sep 2024 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="AjWNE9n5"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B1F14A0A0;
	Sun,  8 Sep 2024 10:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725791301; cv=none; b=In1UQhFzfNzAJwgL6WCRsqMWsGlDSWph8zWAE4MGPQ83fu5UNRnUdr1w65mQkhHm5J2UII7HJGNo8f9Ld8VYOwzjTRRVoX/eqeSUeFSI5+WhsNOb4UUzPqIgPXf1wL08zKFva5WHbIWdx6GWwg9/FYJrJj1U/d3BXyjG27RAkjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725791301; c=relaxed/simple;
	bh=0aGUpa0cTQoQd5vb3VcZYKrfMFGlogBnCLdhJJJFBmA=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Mpd5tKEHxWBmZ865gAeZKz5Hav6IKPDtFhfhP6dIb+EFcmQNB5W9WymOsKjs1qp0EUiTRyYWWeKaF5IOrfjiVx4RKRHs6r6nAuW6JafWYpZC5QWxCthhpeywO8B4dj0oqcbTV6jMrZvcv0tsMzFav1Ruf6Q77B9FR8M7vau6Df0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=AjWNE9n5; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Subject
	:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0aGUpa0cTQoQd5vb3VcZYKrfMFGlogBnCLdhJJJFBmA=; t=1725791299; x=1726223299;
	 b=AjWNE9n5TU/dbjX/pTaBkQ3hhehX6YOTWmAIctD7XpmUse0qfcJjiqobq4XaPqwOJN1UH2S6Hm
	O+4Au2RT0C5X2modRRn72VZvYcQa5kBfv7bF8QsRcfKAhQnwJsMhtwFUbQ+7iu0DHpr5M/9A48ItO
	3bAATf84q61puLA5gNiJI8P4JFGlUCf5cv+cQ9/WKQ15c5NPCqSH5mbkWxktKUL3aJ9m1p3mOt4/1
	LgtJ2eRFlAVGlEpwiDjjfl22jDWaS9TzaAc/jS+LlYp5FFcbggOtmZ+Srnew9Cho7qI7LpUYLFR9s
	AK4LZALt0dIid93mM71djd5K0UCB0Xxvdystw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1snF9Q-0003rp-3p; Sun, 08 Sep 2024 12:28:12 +0200
Message-ID: <f31bcc2a-20c5-4182-8b32-fb9ede8712b5@leemhuis.info>
Date: Sun, 8 Sep 2024 12:28:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Linux regressions report for mainline [2024-09-08]
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1725791299;a6646d2b;
X-HE-SMSGID: 1snF9Q-0003rp-3p

Hi Linus! Tried to approach regression tracking a bit differently this
cycle, which is why I didn't send any reports in the past few weeks. But
as we are nearing the end of the cycle, let me quickly compile a report
for afaics unresolved regressions that were reported and bisected to a
change in this or the previous cycle.

I only mentioned those I found noteworthy for one reason or another,
most of the time because there is a lack of progress. But I track more
regression, for example 12 others from this cycle. See
https://linux-regtracking.leemhuis.info/regzbot/mainline/ for
details[1]. But people are working busily on fixing those afaics; and
none of them seem to affect a lot of users. Will send a more detailed
report next week due to the pending release.

Ciao, Thorsten

[1] ignore any pre-6.10 stuff for now, I lacked time to re-check if
there was any progress that was not properly tagged (which is frequent)
and thus missed by regzbot.


mainline regressions introduced during development of 6.11
==========================================================

* Marc Payne 18 days ago reported that btusb fails to initialize on
MT7921AUN since ccfc8948d7e4d9 ("Bluetooth: btusb: mediatek: reset the
controller before downloading the fw") [v6.11-rc1] but did not get even
a reply from a developer yet:
https://lore.kernel.org/lkml/ZsTh7Jyug7MbZsLE@mdpsys.co.uk/

* Mikhail Gavrilov five weeks ago reported that launching some RenPy
games causes hangs since 1b04dcca4fb10d ("drm/amd/display: Introduce
overlay cursor mode") [v6.11-rc1]. Fell through the cracks, now being
worked on.
https://lore.kernel.org/lkml/CABXGCsNgx6gQCqBq-L2P15ydaN_66sM9CgGa9GQYNzQsaa6Dkg@mail.gmail.com/

* Chris Li six weeks ago reported swap stress tests now running into OOM
since 33dfe9204f29b4 ("mm/gup: clear the LRU flag of a page before
adding to LRU batch") [v6.11-rc1]. Fell through the cracks, but after
prodding from my side recently posted a patch to fix this:
https://lore.kernel.org/all/CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com/
https://lore.kernel.org/lkml/20240905-lru-flag-v2-1-8a2d9046c594@kernel.org/


mainline regressions introduced during development of 6.10
==========================================================

* Seven weeks ago someone reported that mpu6050 gyroscopes stopped
working; a fix is in -next for 15 days now and hopefully will make it to
you soon:
https://lore.kernel.org/linux-iio/0ea167a1-75d0-469d-a79f-ff2cb5e81bdc@gmail.com/
0a3b517c8089aa ("iio: imu: inv_mpu6050: fix interrupt status read for
old buggy chips") [next-20240819 (pending-fixes)]

* Two people three and a half weeks ago reported problems (like crashes
on receiving large data over virtio_net under memory and IO load) due to
f9dac92ba90810 ("virtio_ring: enable premapped mode whatever
use_dma_api") [v6.10-rc1]; there will likely be a few reverts heading
your way to fix this:
https://bugzilla.kernel.org/show_bug.cgi?id=219154
https://lore.kernel.org/netdev/8b20cc28-45a9-4643-8e87-ba164a540c0a@oracle.com/
https://lore.kernel.org/netdev/20240906123137.108741-1-xuanzhuo@linux.alibaba.com/

* Six weeks ago someone reported massive stuttering when GPU is almost
100% load since b7a1a0ef12b819 ("drm/amd/amdgpu: add pipe1 hardware
support") [v6.10-rc1]; four weeks ago a partial revert was discussed to
fix the issue, but not merged -- and from here it looks like the issue
is not yet resolved yet and stalled for three weeks now:
https://gitlab.freedesktop.org/drm/amd/-/issues/3519

* Since about six seeks it's known that 4df96ba6676034
("drm/amd/display: Add timing pixel encoding for mst mode validation")
[v6.10-rc1] caused issues for some users with 4k displays connected via
a dock; no fix in sight yet afaics. :-/
https://lore.kernel.org/amd-gfx/872a3e83-9bc5-47de-8514-48abe8ff03c5@typeblog.net/
https://lore.kernel.org/stable/d74a7768e957e6ce88c27a5bece0c64dff132e24@holm.dev/
https://gitlab.freedesktop.org/drm/amd/-/issues/3513

* Since about four weeks it's known that 6f31d6b643a32c ("igc: Refactor
runtime power management flow") [v6.10-rc1] causes suspend to fail on
the second attempt; at least two people seem to be affected; progress is
slow, no fix in sight, revert seems to fix this (it's not totally clear):
https://bugzilla.kernel.org/show_bug.cgi?id=219143



