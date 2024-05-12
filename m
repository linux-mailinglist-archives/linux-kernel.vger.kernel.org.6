Return-Path: <linux-kernel+bounces-176894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C108C36C6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 16:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16ABE281586
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 14:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA97A28E17;
	Sun, 12 May 2024 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="s4rAuDGV"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53227219ED;
	Sun, 12 May 2024 14:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715522584; cv=none; b=V0erL59yX7yqTwWbwy5UkIXBbH0udc3v9KcHuzf4VvbKzVxX1A7a9M1I9eWmMDcoZ21Zo8778lc75CDGfcbp4f15S+ImvZ3Sop5/seBcR9XrQU/YoDvPssqHfWRDRiaWbUJd2yCQcGHy4op9vaWMSDdUBnBw1FYLHXtMgSbStQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715522584; c=relaxed/simple;
	bh=wbFT9utNSEH/L/vkqC+0ZuxiPd/qFJTXXTam5wlJcIo=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A+NSdBo4xEnZ5A/RauxzGQcfCoA/lzJBTCfQzpo0YpBug8ZUk+QI8cJxZUUi6TZzkNnQjVujhGk7xJ1B/CfX3j1kws4NxOpE9FgOvBiWnh3eHKOktuZKPVz+4AiCF77ikOF4oRrfkGvWUSU04m6K+4gPbBOFVuYYSeNrRYoEc3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=s4rAuDGV; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	Content-Type:Message-ID:Date:Subject:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=5QJY3R0SXDIVLVdbgpATvoUh32upThfo2I5AV5/927E=; t=1715522582; x=1715954582;
	 b=s4rAuDGVDm5U1EuW+Y50cY0nbErcrIQcWOdeatiEHw+Z3E0RmuoxOgSQ37UipPZRcbKDAGSC8Y
	SRyHGxJV05pKsGpRWjolKk7MXB6lpdyAgVpaw/Zd/N+IPb4XzLehJZ7/f+qm67jQGjkhI9xMaA6xF
	OsHYAXJGqm66v/vJjYYBV1cisPNxrq/1xg264Vc5p1e2T25DNYCXAVV1kOo12mWAYctJXCJD7WXQd
	2nPpY8/SiPF+Z4V0v9wZflIZoeUVv0WvH+uLaI0xjReuSqoahuEjK4aRyb1oxG1FeMXan2iDc01JD
	vW5G6lTO1Urnm3iA9ipMXWossG7fW2zNynwQQ==;
Received: from [2a02:8108:8980:2478:5054:ff:feb3:8f48] (helo=regzbot.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1s69n1-0003vh-8B; Sun, 12 May 2024 16:02:59 +0200
From: "Regzbot (on behalf of Thorsten Leemhuis)" <regressions@leemhuis.info>
To: LKML <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Linux regressions report  for mainline [2024-05-12]
Date: Sun, 12 May 2024 14:02:58 +0000
Message-ID: <171552254677.1971316.17732013113090096417@leemhuis.info>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715522582;81455b15;
X-HE-SMSGID: 1s69n1-0003vh-8B

Hi Linus, here is the weekly report for regressions introduced during
this cycle. The short story: we have quite a few regressions for which
fixes are available (most of them reviewed or even in -next), but only
queued for 6.10 (most of them) or not yet fully ready.

This starts with the three fixes I mentioned in my extra report on
Thursday[1]. Dave send a revert[2] for the nouveau regression mentioned
in that report, but he didn't copy you, so I guess this is meant to
wait, too. Side note: the problem from Lyude I mentioned in that report
still needs more debugging. 
[1] https://lore.kernel.org/all/4c7be436-8a5d-469f-b88e-bfe17bafb991@leemhuis.info/
[2] https://lore.kernel.org/all/20240512121630.23898-1-wangjinchao@xfusion.com/

Fixes for a ath11k regression fall through the cracks and will likely be
merged soon[3]; the fix for another ath11k regression only reported on
Friday exists, but will only be formally submitted in the next few days[4].
[3] https://lore.kernel.org/linux-wireless/20240424064019.4847-1-quic_bqiang@quicinc.com/
[4] https://lore.kernel.org/linux-wireless/D15TIIDIIESY.D1EKKJLZINMA@fairphone.com/
and https://lore.kernel.org/linux-wireless/4d60ccf3-455d-4189-9100-d35488b00236@quicinc.com/

For the record: Kalle yesterday reported a suspend regression that made
stress test stalls within 30 minutes, but that one is not bisected yet[5].
[5] https://lore.kernel.org/lkml/87o79cjjik.fsf@kernel.org/

Ciao, Thorsten

---

Hi, this is regzbot, the Linux kernel regression tracking bot.

Currently I'm aware of 10 regressions in linux-mainline. Find the
current status below and the latest on the web:

https://linux-regtracking.leemhuis.info/regzbot/mainline/

Bye bye, hope to see you soon for the next report.
   Regzbot (on behalf of Thorsten Leemhuis)


======================================================
current cycle (v6.8.. aka v6.9-rc), culprit identified
======================================================


[ *NEW* ] ath11k: connection to 6 GHz AP fails
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/87wmo0k71i.fsf@kernel.org/
https://lore.kernel.org/linux-wireless/87wmo0k71i.fsf@kernel.org/

By Kalle Valo; 1 days ago; 1 activities, latest 1 days ago.
Introduced in bc8a0fac8677 (v6.9-rc1)

Fix incoming:
* wifi: ath11k: move power type check to ASSOC stage when connecting to 6 GHz AP
  https://lore.kernel.org/regressions/0834b74a-b360-4404-994b-7f20c89d7257@leemhuis.info/


[ *NEW* ] ath11k: WCN6750 firmware crashes during initialisation
----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/D15TIIDIIESY.D1EKKJLZINMA@fairphone.com/
https://lore.kernel.org/linux-wireless/D15TIIDIIESY.D1EKKJLZINMA@fairphone.com/

By Luca Weiss; 2 days ago; 10 activities, latest 1 days ago.
Introduced in f019f4dff2e4 (v6.9-rc1)

Recent activities from: Carl Huang (5), Luca Weiss (3), Kalle Valo (2)

2 patch postings are associated with this regression, the latest is this:
* Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
  https://lore.kernel.org/linux-wireless/4d60ccf3-455d-4189-9100-d35488b00236@quicinc.com/
  2 days ago, by Carl Huang


[ *NEW* ] nouveau: init failed, no display output
-------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240506182331.8076-1-dan@danm.net/
https://lore.kernel.org/stable/20240506182331.8076-1-dan@danm.net/
https://lore.kernel.org/stable/20240506185910.17917-1-dan@danm.net/

By Dan Moulding and Dan Moulding; 5 days ago; 4 activities, latest 2 days ago.
Introduced in 52a6947bf576 (v6.9-rc7)

Recent activities from: Dan Moulding (2), David Airlie (1), Linux
  regression tracking (Thorsten Leemhuis) (1)


x86/topology: system stopped booting
------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com/
https://lore.kernel.org/lkml/3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com/

By Lyude Paul; 24 days ago; 19 activities, latest 2 days ago.
Introduced in f0551af02130 (v6.9-rc1)

Recent activities from: Lyude Paul (3), Thomas Gleixner (2), Mario
  Limonciello (1)

2 patch postings are associated with this regression, the latest is this:
* Re: Early boot regression from f0551af0213 ("x86/topology: Ignore non-present APIC IDs in a present package")
  https://lore.kernel.org/lkml/87le59vw1y.ffs@tglx/
  22 days ago, by Thomas Gleixner


net: Bluetooth: firmware loading problems with older firmware
-------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/20240401144424.1714-1-mike@fireburn.co.uk/
https://lore.kernel.org/lkml/20240401144424.1714-1-mike@fireburn.co.uk/

By Mike Lothian; 40 days ago; 12 activities, latest 3 days ago.
Introduced in 1cb63d80fff6 (v6.9-rc1)

Fix incoming:
* Bluetooth: btusb: Fix the patch for MT7920 the affected to MT7921
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=5e970bdf73e619935a8977f9f22b581480211164


Ryzen 7840HS CPU single core never boosts to max frequency
----------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/bugzilla.kernel.org/218759/
https://bugzilla.kernel.org/show_bug.cgi?id=218759

By Gaha; 20 days ago; 45 activities, latest 4 days ago.
Introduced in f3a052391822 (v6.9-rc1)

Fix incoming:
* cpufreq: amd-pstate: fix the highest frequency issue which limit performance
  https://lore.kernel.org/regressions/0834b74a-b360-4404-994b-7f20c89d7257@leemhuis.info/


leds: hangs on boot
-------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/
https://lore.kernel.org/lkml/30f757e3-73c5-5473-c1f8-328bab98fd7d@candelatech.com/

By Ben Greear; 39 days ago; 29 activities, latest 4 days ago.
Introduced in f5c31bcf604d (v6.9-rc1)

Fix incoming:
* wifi: iwlwifi: Use request_module_nowait
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=master&id=3d913719df14c28c4d3819e7e6d150760222bda4


kbuild: deb-pkg and bindeb-pkg: build failure (and slowness, too)
-----------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/ZjcRPelwZP34N42s@gmail.com/
https://lore.kernel.org/lkml/ZjcRPelwZP34N42s@gmail.com/

By Ingo Molnar; 7 days ago; 5 activities, latest 7 days ago.
Introduced in 1d7bae8f8c85 (v6.9-rc1)


===================================================
current cycle (v6.8.. aka v6.9-rc), unknown culprit
===================================================


[ *NEW* ] x86: mitigations: suspend stress test stalls within 30 minutes
------------------------------------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/87o79cjjik.fsf@kernel.org/
https://lore.kernel.org/lkml/87o79cjjik.fsf@kernel.org/

By Kalle Valo; 0 days ago; 4 activities, latest 0 days ago.
Introduced in v6.9-rc3..v6.9-rc6

Recent activities from: Kalle Valo (2), Borislav Petkov (2)


net: Beaglebone Ethernet Probe Failure In 6.8+
----------------------------------------------
https://linux-regtracking.leemhuis.info/regzbot/regression/lore/Zh/tyozk1n0cFv+l@euler/
https://lore.kernel.org/netdev/Zh%2Ftyozk1n0cFv%2Bl@euler/

By Colin Foster; 24 days ago; 8 activities, latest 13 days ago.
Introduced in v6.8..v6.9-rc5

One patch associated with this regression:
* Re: Beaglebone Ethernet Probe Failure In 6.8+
  https://lore.kernel.org/netdev/Zicyc0pj3g7%2FMemK@euler/
  19 days ago, by Colin Foster


=============
End of report
=============

All regressions marked '[ *NEW* ]' were added since the previous report,
which can be found here:
https://lore.kernel.org/r/171491873337.1284823.18146984489788770141@leemhuis.info

Thanks for your attention, have a nice day!

  Regzbot, your hard working Linux kernel regression tracking robot


P.S.: Wanna know more about regzbot or how to use it to track regressions
for your subsystem? Then check out the getting started guide or the
reference documentation:

https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The short version: if you see a regression report you want to see
tracked, just send a reply to the report where you Cc
regressions@lists.linux.dev with a line like this:

#regzbot introduced: v5.13..v5.14-rc1

If you want to fix a tracked regression, just do what is expected
anyway: add a 'Link:' tag with the url to the report, e.g.:

Link: https://lore.kernel.org/all/30th.anniversary.repost@klaava.Helsinki.FI/

