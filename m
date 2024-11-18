Return-Path: <linux-kernel+bounces-412417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F9D9D08CF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCAB21F22EBA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BE613C9D9;
	Mon, 18 Nov 2024 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k7NwoTbW"
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3052213A863
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907584; cv=none; b=LfxkwjaegL/wp+Uy17h8N2VDszc3OaehvHQ+zNGZx2kjIqsLtUr9czfaSy1fzOzne65R2iYxfywkfakkblYBzfTGutUGfyikexCScXMudz17WV78CPoru4T8A3UffD3TTCrk4vIHiZgM3jnE1T8niApxcykA/Fuh6AYgo1X+uvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907584; c=relaxed/simple;
	bh=PBw+2l4k/U/8zjU5cemT5owgK8Rdjbs+7eB+L9/Ycbc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=AF+XZLUbMFoEBAKIM+UR9vmlDKuFuEY3A1dXiKEfNR5MKcJFdZR46rUoc8Qn9gMwtG3QLMxhlBmkQYV1ClGnYA12KyfXFIjIs8Ji+Nn6UkgsDu9SQAaTIoDg0rzyKBuiP5nB1euJ7LzKV2Q/eGmQUQ59cVJpLOjzW+IEDF4WK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k7NwoTbW; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C7932540119;
	Mon, 18 Nov 2024 00:26:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 18 Nov 2024 00:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731907582; x=1731993982; bh=r29dMPQRv+Gn3SilhPT9HklbBYac
	hEKIULVz8FVwt98=; b=k7NwoTbW69mVKGydqbzLqZOLwbnxd/Q6r980KWc1Y8Df
	otUwgllcAyx2ZbPDDUNjm7LrWS/U5FmG09vM/AKkryooRsdCJ5h2Zjl1NMjhooEP
	hC3T/l+uSdtPgrIKE6KrAOo0HqiDUfXTZEcdyASfh2c3TUxZnBJPzMqpMRezqa4f
	z8OkrbOK6Bb0Fgrp85xRkMpoTVWAkngkVB9kw2gfTlC0lVddpcGeSaXZURDEMFiD
	Ff5LTcJIVGPv5DTkDQI5eW8Q7bneLf6f7ps8AMJ575ci9uuIkMyAAAJm+/O+3RFG
	dNowIf2lTECpap5FKh4EHDQ6oHaMPtkggbjPhBBWjA==
X-ME-Sender: <xms:_c86Z-nppbNlBAN3HW9LhvBqQWtpqYoAzoJPAP9DWjfHZjFWADuw8A>
    <xme:_c86Z10KjobDkxTWd4y0ZXAZPgwisr8fhEZtRHTfDVeu3QvGRVNs-dMXXKr9zLqbe
    RpaAedrNcqlMk4asGI>
X-ME-Received: <xmr:_c86Z8pP5hLbM_s-ykr26uaN4lznYyv6GrFGs7puUnrDM5kAalsvoEEARy402o1j0Fa0uFgoHkIMBfcBC39sa4pM8QFHqD4Goc8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffkffhvfevufestddtjhdttddttdenucfhrhhomhep
    hfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqne
    cuggftrfgrthhtvghrnhepheetuddufffgfeekkeejudeivdfgfedtleetkeduleekueef
    hfevueekkeeftdeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpvghnthhrhidrsh
    gsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhht
    hhgrihhnsehlihhnuhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepshhtrggslhgvsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhope
    hvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhu
    gidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhope
    hlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:_c86Zynh2vbWVaZMwFGzijK3ECVZ90sf8Rx7OhDsYExA4jIpYj1JCw>
    <xmx:_c86Z814jB2THHzekG-OxCtJAbDa07IG9FlbqBsk-jY5fqyBZJhElw>
    <xmx:_c86Z5s5Om1p5moGEH1x5ykvTMtqhswRIyLtkC2XFPl3sC5EHS8OWg>
    <xmx:_c86Z4VaDcnKdNaJSTzKUbCA3cnTfaIKYa94h7Rt3G1hMyc65ZLMPQ>
    <xmx:_s86Z_TUGztPjDAlCPJacAiNc8nFkA1GfNMlPJx9uLG86Hx9CAxRb-a6>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 00:26:20 -0500 (EST)
Date: Mon, 18 Nov 2024 16:26:49 +1100
Message-ID: <768fa5661596788cd8e49b46cca853d3@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: stable@kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4.19.y] m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal
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

