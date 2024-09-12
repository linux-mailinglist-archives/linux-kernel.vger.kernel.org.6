Return-Path: <linux-kernel+bounces-326558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B26B9769EF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 15:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E78B216A1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 13:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF3A1AD245;
	Thu, 12 Sep 2024 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="gM6wwWaj"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0921AB6DC;
	Thu, 12 Sep 2024 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726146219; cv=none; b=YN9/mZfbeMee5cJSDtncg0l7w6TmHA1ma63ySwfyHAMN3/nMY7FhKcUV6CJJqAAi9zStQ9fI14LTWN+J89NDtkmRDgsPAG3W+hhQuVZDVUeAw1yDWA46BitQQPvg7K9BOSLaN0ExI8xqKcMJA0uoGgR/jY9YL0et/ZKq/fxVYZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726146219; c=relaxed/simple;
	bh=0wVaLAj1LkuDQ1eAUwHk5RJUlLtMjsDvq/kB7dZwzs8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=OuriFwKxA0mtuQa5157pY2l6zInkDCZVOj8m9aEDk+jaB5PRTg11r6EeiPiXAvFg7QDUmah5rczDRnKksgw71snBPJVqyumZAg2RV0OCclCwXikNX/078MCWzrMjvSKjmLNifU9R4egsld3bT8dKmQD5M3Y325sRE2iYdP/FCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=gM6wwWaj; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To:Subject:Date:
	Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9gMPRE3dusYnLgHmnQkJgE3ee3DErva04V0juSuoAfU=; t=1726146216; x=1726578216;
	 b=gM6wwWajJstePQ4WW50eNJEGeNTQBczw8cxXT0eMUygTuOKCVkXZ7kiFWMylJm7bzOpz3X+eyz
	jMF0mstyY5WhIjwGsQ9OY+udahZtwHSeTTtCj1ywoLfflBFE77J0CoAgNACeCK0qgX4LbSgOTUXx6
	ubW+tkWjk+C0uGA6wykJN5b5ju8jBFroCaAbEnoxAD2um8iv7fDdp1Hlfys5qm1FfhEnWYH4BFNAG
	S9s2O03qltReWaLHzeC42lmg+5WhCC+sv7NIv4S8eypPiH/h1GZVqOIn9SdfQC7Wfe9oqn8lh280E
	nJmyvSbBEdiuavjJ2JA1IasoBsYy2mXzWt77g==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sojTt-0003y2-Ac; Thu, 12 Sep 2024 15:03:29 +0200
Message-ID: <97802bf0-d090-4063-91e8-74724c3b096c@leemhuis.info>
Date: Thu, 12 Sep 2024 15:03:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Subject: Linux regressions report for mainline [2024-09-12]
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1726146216;8d5671d4;
X-HE-SMSGID: 1sojTt-0003y2-Ac

Hi Linus! Due to the pending 6.11 release a quick and brief extra
report about regressions from this cycle. For more details and a
few regressions I did not find noteworthy, see:
https://linux-regtracking.leemhuis.info/regzbot/mainline/

Ciao, Thorsten


6.11-rc regressions with available fixes in -next that will likely make it to you 
=================================================================================

* reported 7 weeks ago: mm: swap stress test now runs into OOM
https://lore.kernel.org/lkml/CAF8kJuNP5iTj2p07QgHSGOJsiUfYpJ2f4R1Q5-3BN9JiD9W_KA@mail.gmail.com/

Fix: 0885ef47056079 ("mm: vmscan.c: fix OOM on swap stress test")
[next-20240912 (pending-fixes)]

* reported 27 days ago: block: hang when when setting echo noop > /sys/
block/sda/queue/scheduler
https://bugzilla.kernel.org/show_bug.cgi?id=219166 and   
  https://lore.kernel.org/all/0a43155c-b56d-4f85-bb46-dce2a4e5af59@kernel.org/

Fix: https://lore.kernel.org/all/20240908000704.414538-1-dlemoal@kernel.org/
[the fix was in -next but is gone now, but I'm pretty sure Jens will
sent it straight to you before Sunday]

* reported 24 days ago: drm: amdgpu: certain operations are much slower
https://gitlab.freedesktop.org/drm/amd/-/issues/3569

Fix: 578aab4ecc7347 ("drm/amd/display: Do not reset planes based on crtc zpos_changed") [next-20240911]

* reported 9 days ago [affects stable, too]: soundwire: audio broken for
Meteor Lake-P HD Audio Controllers
https://lore.kernel.org/lkml/b6c75eee-761d-44c8-8413-2a5b34ee2f98@linux.intel.com/

Fix: 233a95fd574fde ("soundwire: stream: Revert "soundwire: stream: fix
programming slave ports for non-continous port maps"") [next-20240912 (pending-fixes)]


6.11-rc regressions with available fixes in -next 
=================================================

* reported 7 days ago: arm64: dts: qcom: msm8939: boot broken on msm8939
platforms 
https://lore.kernel.org/lkml/2a15105f-67e2-42f6-b624-562485b0bee2@kernel.org/

Fix: d92e9ea2f0f918 ("arm64: dts: qcom: msm8939: revert use of APCS mbox
for RPM") [next-20240912]


6.11-rc regressions with available fixes up for review:
=====================================================

* reported 18 days ago: firmware: qcom: scm: smc: msm8960 SoC fails to
boot
https://lore.kernel.org/lkml/692cfe9a-8c05-4ce4-813e-82b3f310019a@gmail.com/

Fix: https://lore.kernel.org/all/20240911-tzmem-null-ptr-v2-0-7c61b1a1b463@linaro.org/

* reported 4 days ago: power: supply: sysfs: permissions wrong
https://lore.kernel.org/linux-pm/20240908144414.82887-1-hdegoede@redhat.com/

Fix: https://lore.kernel.org/all/20240908185337.103696-1-hdegoede@redhat.com/


6.11-rc regressions without any fixes I'm aware of
==================================================

* reported 5 weeks ago: amdgpu: launching some RenPy games causes hangs 
https://lore.kernel.org/lkml/CABXGCsNgx6gQCqBq-L2P15ydaN_66sM9CgGa9GQYNzQsaa6Dkg@mail.gmail.com/

* reported 23 days ago: btusb: driver fails to initialize MT7921AUN on
v6.11-rc4
https://lore.kernel.org/lkml/ZsTh7Jyug7MbZsLE@mdpsys.co.uk/

* reported 13 days ago: KVM: VMX: wayland starting and failing right away
https://lore.kernel.org/lkml/877cbyuzdn.fsf@redhat.com/

* reported 11 days ago [affects stable, too]:video/aperture: suddenly
two displays appear as connected, but only one display is connected
https://bugzilla.kernel.org/show_bug.cgi?id=219217
https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12160

* reported 6 days ago: net: booting from nfs root on an arm64 fvp model
broke
https://lore.kernel.org/netdev/ZtsTGp9FounnxZaN@arm.com/

* reported 5 days ago: iwlwifi: resume error
https://lore.kernel.org/linux-wireless/CAP-bSRbMbZe9LCE15SCbYNTGZjE_xiAm29qzO_WNVjHsJ6oyyg@mail.gmail.com/

