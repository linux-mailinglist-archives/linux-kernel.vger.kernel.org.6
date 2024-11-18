Return-Path: <linux-kernel+bounces-412434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CF39D08FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D623A281E65
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0AB13D279;
	Mon, 18 Nov 2024 05:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GMaQ+UtW"
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8AF2AE8A
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731908382; cv=none; b=iQ4pabt9PuvSZqViaK1OGN5OsMRd6Unjfi0nmCUchPqbR5mFCbO2+UxvXhDyKkMp4YhXy1S6D7O5v3Fwxiv2sK4xJClDtT82T8CnFowup5W1h5Bo1+7upQIgMgL4m162R6eArcqdyaosQoOWEn/yycXU5HAtrni0M3upPXPIODg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731908382; c=relaxed/simple;
	bh=z/X55CJ4Amiz0wZbkHt0gq98rMad9RgnWcfw7QI1kL4=;
	h=Date:Message-ID:From:To:Cc:Subject; b=Qv92VPfYJDT4OD3fz1Jfg3Q5+ToavLTDR/lJpq8Gkzs0cHSgvjxpnm8KidIiANXZjPcM2WwmROo2Gn2MCohs3ItgfD6X0XpO80LzcRBKaiXva/iNp91cwP/Sdb4CF9bIg1nVelTT8VnVrWPFNAESSJveBv3EWWKwc4p8Dk4ENJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GMaQ+UtW; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B2F852540099;
	Mon, 18 Nov 2024 00:39:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 18 Nov 2024 00:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731908379; x=1731994779; bh=Kpjd1dlpYPRSKTDwyzlMgPlazmO2
	anW6vzHpGHs+Oh4=; b=GMaQ+UtWu3EumEAvQ0CoHB6QMIELv2EPRb8uoWQq5PG+
	+dMqAkJN3tsJQQ4evmD3/jDWbHyeVuZK8PPqgM34qcoEmZTRbxD5fCfWB76tCf1d
	jqabBNmOtrNh9Mv1IRN+loBdkWlqry6thWJXfR9oGk66H8pE0m0hoi7QRcA5k2Eb
	sYkj4ICnGO+rKbLzn+PYTYxFRYDcHg+xQ+RmLar7FXrlqu+ujH+U8OZw0Jgk4I1W
	Yb9V8+n4NVroKbsafsDqvN/IhjOLEGmtaETBbOwrE5IDWmFRDP80Ykq5fp/9/w9s
	nsoD4AYQVIbiwTFbi33o6rmmzFUJX4iDtUjkY+qdTw==
X-ME-Sender: <xms:G9M6ZyaWynhx7vCZTAehhKGHaPRcSdMrF9QoRvECRqC_kwnxKRzlqg>
    <xme:G9M6Z1YuJhioltcH27kj6PR2gz_7pWh0x-l3iflNOj_eSyc7o_kXYRvoIVC6-ZRNg
    U9kRAdSFEIvwCUEb7s>
X-ME-Received: <xmr:G9M6Z89Wi9ipoRMauFLiPJxROb5zHu33cjVlgYrWMRs-X5c2Dc5JhwDaSaiYLpPn3uR_6GS9Vqpm4EHSGPalFVexMqseqAfe13Y>
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
X-ME-Proxy: <xmx:G9M6Z0pcCTFGgbcJdnzMMAP68nXoLUp7TFmDgP-_CZrTXCTa6-YYgQ>
    <xmx:G9M6Z9qLYsb6P5Zn-T1jabTr9avbGuTzpS29xCoSen8RHh7M6X3obg>
    <xmx:G9M6ZyQEenu2ZMVBFejBMU1pOhiAXvty2JAQQh7Wv-_9ln9c2S_yjg>
    <xmx:G9M6Z9qsea4PdHfmvU706ossuLmNsvQ71SvtVn_ircz4Fpvk1IHjAQ>
    <xmx:G9M6Z2A7jlcnbJODSYzmZatx80jR5QM57Ex42HkfiZuo0sgUFRPKOQjX>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 00:39:36 -0500 (EST)
Date: Mon, 18 Nov 2024 16:40:05 +1100
Message-ID: <5ebf14205f64602dad0af8a80428398c@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: stable@kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Eric W. Biederman <ebiederm@xmission.com>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4.19.y] signal/m68k: Use force_sigsegv(SIGSEGV) in fpsp040_die
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
[ Pass 'current' to force_sigsegv() as was done prior to v5.3 ]
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
+	force_sigsegv(SIGSEGV, current);
 }
 
 #ifdef CONFIG_M68KFPU_EMU

