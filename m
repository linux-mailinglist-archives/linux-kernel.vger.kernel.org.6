Return-Path: <linux-kernel+bounces-341256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F58987D51
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 05:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589841F23C49
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 03:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D1916EBEE;
	Fri, 27 Sep 2024 03:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mb6ACb2m"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377D4690
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 03:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727408693; cv=none; b=h1b8puYG2NYZ3wZK5tZKthYlz9agk7KUY6Ynmuc85bA4JjAPKFtI7kFOUY4/QvzEflmZAUTk0FwYyuf8vnQzGq+5jat5KHnTeQ1gQf9xBllr+5uSwvCPDHtBclXU3Mn0tOhrF+iZnBvsNsAWYIEix9vCCf8mdtZ8AMinruBD3dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727408693; c=relaxed/simple;
	bh=BFTMXjsJUXj5NPaF62A/JFf9/pqXbvdo6o2yyb0p+h0=;
	h=To:Cc:Message-Id:From:Subject:Date; b=gLLYIdyMu7P6VoKISoYkLhhyCCOI2M6/sIPt+kH7MraTUcpjtxiLssY43Cp+RZfG9mBEa9ogu1UkewqmkB4vkTQ4XFp2lT09xgqag6FRdguoooWaA7XZQMPSe/eHk6xTy88OkuRsL3KMZA0+RzUQyYKysLzzQ9dl4toWlNHqf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mb6ACb2m; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D88D011402E2;
	Thu, 26 Sep 2024 23:44:48 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 26 Sep 2024 23:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1727408688; x=1727495088; bh=oGZSHCAHh7Zro
	bVvoT/9SGQPes/DFGJyyldyVI2O+8Y=; b=mb6ACb2mcis/q9hdsxBZ9FV9Dj016
	NEbQFwZzU2vPNUPsoKWsaEnj2srveAzDFeyLZZUiswubuDIJmw5KepFDkOemyKhM
	PU9S09E5Z6pBYUdo+Xld8QrfZmVweweJCH0pEIWJtdOf7p5iprSDRKLFFwo9Ml6V
	FYo3JtGO2QW7ZfRbD5KrGLoBRaFeagqJPh1BSENXMDorLrQ9sQx+dZ88/gfRhVI/
	otVb5X38wAmOHMdUKJSnoUKwrpiDrEC0+RSWfbTsrshwG6egqwmQOjcWBoJLqlfd
	wL6WT2m79xV7ebGQqNyET+5x8LZ2XyVstg4p2f8OQV1NlQdK+KxSz6GfA==
X-ME-Sender: <xms:MCr2Zr-RzJ_ZmUorZ5-t7WWY_WMK_fSPgBaSJEHqPxv5KSyCxDpjiQ>
    <xme:MCr2ZnvEFRslWHXr05z0SFNFKM4u_Qgx74-uArQKWW5fzbPP_WUMQ6xgV2NGQRV_A
    ooX0tJ-jFvOeRF5bQ4>
X-ME-Received: <xmr:MCr2ZpCCj9lTLE6t5D8fxapjP_6emxDX5RGoM6cL_xJTBYOl7FYS68bE7KP_OGHrkWzYie5jA_4QKovKbXcUvO0Lcr9ai7kBLYU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhm
    pefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqe
    enucggtffrrghtthgvrhhnpefhieduudefheetheffgeetgeffvdduleelgeejgeeigfdv
    gfefjedvvddtueduteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgvnhhtrhihrd
    hssgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehf
    thhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeehpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsthgrsghlvgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghgvvghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoh
    epvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehlihhn
    uhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MCr2ZndjCxMcXSdYc3PN6zZFoBLzQx4jnv4Tza-CEkm9w-XJrFvBdA>
    <xmx:MCr2ZgMILndxCqS59B3jRj24D0mjMEQn0VskwUjzEsJJzufeq5ds3w>
    <xmx:MCr2Zpm3dpfcebHasyMGmZ5Ax9xiFj_1SacrrS7xhxKg_l7hnDlHHg>
    <xmx:MCr2ZqszKYgKBCGZlWdeZVbNdPLMl_aU5IeQ9JgS52nDZiYw_jBMrQ>
    <xmx:MCr2ZtpsDyZx1p2I_BbqNnsD9A8q999dHGHmXbLCeo1cibpG0lRt9KWh>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 23:44:45 -0400 (EDT)
To: stable@kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Al Viro <viro@zeniv.linux.org.uk>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-Id: <6f3e4ce6abf8b4b1f451f94ea2213a2977986bda.1727408466.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] m68k: Update ->thread.esp0 before calling syscall_trace() in
 ret_from_signal
Date: Fri, 27 Sep 2024 13:41:06 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 50e43a57334400668952f8e551c9d87d3ed2dfef ]

We get there when sigreturn has performed obscene acts on kernel stack;
in particular, the location of pt_regs has shifted.  We are about to call
syscall_trace(), which might stop for tracer.  If that happens, we'd better
have task_pt_regs() returning correct result...

Cc: stable@kernel.org # <= 5.14.y
Fucked-up-by: Al Viro <viro@zeniv.linux.org.uk>
Fixes: bd6f56a75bb2 ("m68k: Missing syscall_trace() on sigreturn")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Finn Thain <fthain@linux-m68k.org>
Link: https://lore.kernel.org/r/YP2dMWeV1LkHiOpr@zeniv-ca.linux.org.uk
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/entry.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 417d8f0e8962..0d03b4f2077b 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -182,6 +182,8 @@ ENTRY(ret_from_signal)
 	movel	%curptr@(TASK_STACK),%a1
 	tstb	%a1@(TINFO_FLAGS+2)
 	jge	1f
+	lea	%sp@(SWITCH_STACK_SIZE),%a1
+	movel	%a1,%curptr@(TASK_THREAD+THREAD_ESP0)
 	jbsr	syscall_trace
 1:	RESTORE_SWITCH_STACK
 	addql	#4,%sp
-- 
2.39.5


