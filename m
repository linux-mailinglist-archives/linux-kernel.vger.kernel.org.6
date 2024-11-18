Return-Path: <linux-kernel+bounces-412436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19B29D08FF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D7751F21C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34B813D508;
	Mon, 18 Nov 2024 05:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O1BUZdTa"
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC34F13CA9C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731908417; cv=none; b=WNYIls1C7JsOO5t2VgSKHXZIxVLfVPmegRj0JTCiCdFkbVQZeGhnipkwIDf3+TZVMZnP6z9Xp9qY3mrUcVEitzAc0CqiFDjItyecF5Jko/sdtMJAPh8Kc85z//7B5rB+XjcXS5HRXlEibRNVBo1ngh7HHb1yodQe+8mPxXcyxEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731908417; c=relaxed/simple;
	bh=xrG9LIF/fHfeOPNdl6wGssMUkqv/ZQNpmH3fhzp0TT0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=H/FLAtZC2P5jeqRWunf68+SRYDmvaxnlkpR9cbLo1qI2dVci1HQGv1C8pvhAwcOdkfxSe2qa8D+ZMd2h6vTn2od3Ty5Wx6E1gkSxsWmpzVkMEFKlqKX4ce/DC4RMYYkKWszAMX5Pi6Xu0AiZHfeGN7kaWInG8LC3IBclCkZnsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O1BUZdTa; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 180712540108;
	Mon, 18 Nov 2024 00:40:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 18 Nov 2024 00:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731908414; x=1731994814; bh=8lLsJIqL/6PoxS2ijobyqT6bj4Vf
	imlESCZI8eca0q0=; b=O1BUZdTaFbQQy0+W7WVrSbVLEGCblmxWJmjSXLAFK89C
	qxdB/PIVOVzNeL5cwbCcvd7aRUCZ9e8znSscDm8GhjieHZlhOmHn9l5kNPlslscS
	Sw5Z6BAeCD+r010w9P/F1jyXdLPYc0wEkoVzACMZkk6AMIyg/eRsf/7+YYw44sz5
	Kl1G0fj79G27MOI33rP1a0A3dV3T4Eby/bJjxvE2yG28X7Suro0a0dQnme6IE/ps
	nfmb+/LcsI4QIVWvQ1+y9uYlK/65dfOGmCjqBzy6KCb7CXpNmv1LsDQuy7bUbQWt
	X1XaXTJkkM5F3UKrJcrvHeohN/C4ACmT2HUjAghqSg==
X-ME-Sender: <xms:PtM6Z6PPQRb1nlNPs8ZZwbRQ6PT3UEYahNZGMs4PlJ3c_c2c_KRyqw>
    <xme:PtM6Z4_2y6YDWvaNi2LJr9Tl0WhJ89U4bRA24-Azc6LHm2b3mhUxTyvOhYz57K46m
    AYIz34UawSB_vKZZ9Q>
X-ME-Received: <xmr:PtM6ZxTNkImUHz2rbuCq7IB3_HZgZAZkpVlMXp2NOFeAMMutDKm5T1iB80qviAN4L9MWdtzcTMqgkBZmXvJSUMWNTbUzz7EVGmE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffkffhvfevufestddtjhdttddttdenucfhrhhomhep
    hfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqne
    cuggftrfgrthhtvghrnheptdfhleduudejjefgvdetfeeijedtfeeukeduteeuffeuveej
    ieevhefgleeuffffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpshhkvghlvghtoh
    hnrdhssgenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeehpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpth
    htohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PtM6Z6u1OlYOtWDCL0WiZz2k-LvZvItcD3HOZ11JEcVKHeYV5PERCg>
    <xmx:PtM6ZyfAHnbBi9znwTz9_LujCjRlMAPRbLj5tLmup6rwhe7HTx5u1Q>
    <xmx:PtM6Z-12lWJjwXmiV_gs5t_jdtwnpr5r6VG7OWGi8j-_Ps4T05JDsA>
    <xmx:PtM6Z28ilt1Uvrl5DIwXaDF7Y6NuOTnYiFDL9wKYSGBWv1sA7xBVUQ>
    <xmx:PtM6Zx7wuQ-lZEVCzdQDCwjkZeUR3a7uv4E0XL_u9R5CFrbqLSw-JyHz>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 00:40:12 -0500 (EST)
Date: Mon, 18 Nov 2024 16:40:41 +1100
Message-ID: <256fabf7d7f3712896bafc0deac0303e@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: stable@kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Eric W. Biederman <ebiederm@xmission.com>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: "Eric W. Biederman" <ebiederm@xmission.com>

[ Upstream commit a3616a3c02722d1edb95acc7fceade242f6553ba ]

In the fpsp040 code when copyin or copyout fails call
force_sigsegv(SIGSEGV) instead of do_exit(SIGSEGV).

This solves a couple of problems.  Because do_exit embeds the ptrace
stop PTRACE_EVENT_EXIT a complete stack frame needs to be present for
that to work correctly.  There is always the information needed for a
ptrace stop where get_signal is called.  So exiting with a signal
solves the ptrace issue.

Further exiting with a signal ensures that all of the threads in a
process are killed not just the thread that malfunctioned.  Which
avoids confusing userspace.

To make force_sigsegv(SIGSEGV) work in fpsp040_die modify the code to
save all of the registers and jump to ret_from_exception (which
ultimately calls get_signal) after fpsp040_die returns.

v2: Updated the branches to use gas's pseudo ops that automatically
    calculate the best branch instruction to use for the purpose.

v1: https://lkml.kernel.org/r/87a6m8kgtx.fsf_-_@disp2133
Link: https://lkml.kernel.org/r/87tukghjfs.fsf_-_@disp2133
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/fpsp040/skeleton.S | 3 ++-
 arch/m68k/kernel/traps.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
index 31a9c634c81e..081922c72daa 100644
--- a/arch/m68k/fpsp040/skeleton.S
+++ b/arch/m68k/fpsp040/skeleton.S
@@ -502,7 +502,8 @@ in_ea:
 	.section .fixup,"ax"
 	.even
 1:
-	jbra	fpsp040_die
+	jbsr	fpsp040_die
+	jbra	.Lnotkern
 
 	.section __ex_table,"a"
 	.align	4
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 35f706d836c5..c6f18dc5884b 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -1155,7 +1155,7 @@ asmlinkage void set_esp0(unsigned long ssp)
  */
 asmlinkage void fpsp040_die(void)
 {
-	do_exit(SIGSEGV);
+	force_sigsegv(SIGSEGV);
 }
 
 #ifdef CONFIG_M68KFPU_EMU

