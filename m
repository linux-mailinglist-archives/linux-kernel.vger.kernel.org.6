Return-Path: <linux-kernel+bounces-412435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D522B9D08FE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9EF1F21935
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7A12AE8A;
	Mon, 18 Nov 2024 05:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X06QFUt1"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D690C13CA95
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731908396; cv=none; b=tqddUvcCFnFfdDd0Q/g4U3SM7uiyfosZds0lDoeHQKAOe3Yu6+B9U59ODku6sGFejpR0DK7ntQbBoDwfgXhOV4Mx1vtqmQ6iSq6ojkZNa8x5HIkUXCoeF5U1d+lWPRAIEVpa8kBo1alW1IhoBKmEafpiCrV/K/QoLROS8MXNSsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731908396; c=relaxed/simple;
	bh=xrG9LIF/fHfeOPNdl6wGssMUkqv/ZQNpmH3fhzp0TT0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=dvF+Ai6cGXi3wbJXqU1+cRPCop6CTgft4clmvWKGLo3Bf15Zx2HtSXKcAAiiLRzd7q6KxypyFJf0vUwdaqV1vfi8QH6i2WCzun+693w8x1yeZNGxIZ3LgQ+Dbx+Q0J48docN7lqI7RuBP2qYyAFAT4YapIHe7+vBgvqKeaJQt+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X06QFUt1; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B7FC11400F5;
	Mon, 18 Nov 2024 00:39:54 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 18 Nov 2024 00:39:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731908393; x=1731994793; bh=8lLsJIqL/6PoxS2ijobyqT6bj4Vf
	imlESCZI8eca0q0=; b=X06QFUt14LpL+qOR14S0+2iHhkGjQd3bDcMQVZnXJN4E
	Tfa8TdPybkUPlm5gaoRrnyVLH+9jLtIf1bIE0V9DZV8f60zVh1UI7B8XAc/mF3je
	KGwi2ZDu5hB5yCQaaUyn6dnNyo52o5jFANdSYu/yTTud4N4lcW2lSgL9Q8VwcTHB
	c+WD8Wj0d8N0gglnyzIkL+Ld0Kc1NnsyKAMThnzy9WIaeyNAIjJAFvKxbMeqvArj
	g65AIMTU0YnKZgXEfAyadT12lpetaC2RBGnaWos6LYk1Xl00iSYa5WRHbsHEgf4f
	BQ36M9UkC3KLX2zCzUUj4z8xbIGuro/ndChWs7T2Hg==
X-ME-Sender: <xms:KdM6Z-uf6Q1XSkQCb49g0p1pfu7aa_Or-02drSgsH6ZBHse5txutmA>
    <xme:KdM6ZzdVwFCUcgAFjWUMmLBNHv3XyccAknNNauaf-b_tGskxS9Q44xCv--zyw4rNH
    qz1xR2Gdo6jOtzKvbQ>
X-ME-Received: <xmr:KdM6Z5wKiGYc2gbsGO4L8wQGXbuhMu4nfGXWpXxofyi9JgrfhHTa1eddRuiHPAeKRfvbcLrCrZuE0Ax_5BogJri4mu0mTX_vNrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffkffhvfevufestddtjhdttddttdenucfhrhhomhep
    hfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqne
    cuggftrfgrthhtvghrnheptdfhleduudejjefgvdetfeeijedtfeeukeduteeuffeuveej
    ieevhefgleeuffffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpshhkvghlvghtoh
    hnrdhssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeehpd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpth
    htohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:KdM6Z5MYKDY4bj-IP_yP12zpH91AiBIiefna5wicRRw4jGxgiZ-UCg>
    <xmx:KdM6Z-9M7nIeExbSWlTVVpoSGLTLvBUowLGw7Wu1bV6KTpQx6Iyk1Q>
    <xmx:KdM6ZxUY0Ldf6bJr4zFBpPzNG2TTLajjgBAeknm5nc1_8pSEl4IbdA>
    <xmx:KdM6Z3ewNhVAcZBRL2wGlbWTsqFV7ZgIdpNZ8vr2a9hZ6SB9KzjtbQ>
    <xmx:KdM6ZyY3y3LLO3GiFam18fXZTdno1aXz50dWymtsG6L0CsSPLj_eGNno>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 00:39:51 -0500 (EST)
Date: Mon, 18 Nov 2024 16:40:20 +1100
Message-ID: <a154b51c4bff7aa15bf26e4404605e7a@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: stable@kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Eric W. Biederman <ebiederm@xmission.com>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.4.y] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
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

