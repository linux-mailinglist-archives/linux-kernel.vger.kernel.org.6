Return-Path: <linux-kernel+bounces-412420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC519D08D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 239C4B22709
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0CB13DBB6;
	Mon, 18 Nov 2024 05:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/78JwZe"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A766513D24E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907612; cv=none; b=fm/bfpZnpTqJuwGrGOluXMRMM/lZ/pybnR5DJ5w5d6MpngOZk5pIebI2uIAwBfKKxCrKDiMrcn0wMiIpZmMNKauoqOsRLZKCTRRftenud+BglNhviuH1JMt0ciM4EpydrsK6rbVvDnqI3BxmThMM1ZXkYgcVGTmjIw75Xso78oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907612; c=relaxed/simple;
	bh=PBw+2l4k/U/8zjU5cemT5owgK8Rdjbs+7eB+L9/Ycbc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=YLWsvJhInSiYUv7IoXtToHpyNnrnrN6NvPitwj1VM6q26pUF3ccP/gy8ASlKT6/WRHf2sKLx2EE9h2ceVqgSc1KPAhunDuuiCdlXfjyXj3ZlmlefUtxg1DLFb+7FTBDjZ26UedfMwEhKLqAg1G4F8Qf3tNWo8vfAirbGjs7wObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X/78JwZe; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C57421140108;
	Mon, 18 Nov 2024 00:26:49 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 18 Nov 2024 00:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731907609; x=1731994009; bh=r29dMPQRv+Gn3SilhPT9HklbBYac
	hEKIULVz8FVwt98=; b=X/78JwZeD2SJfi1qUtKfQXBGPt5jy7gAu69wk2BoKPEz
	IIfQ62mKx0NagwKkC8n75f6HU6O63NF71Jm4SxUNwEt1xKytubbhc945jhzFCCbq
	xUdlQKd2LuhVZDF2cjVa2iP7THjYr582gw6F+d62mS1PEhCO85GkC0ASoKEblD6F
	GCD4KcZxYtWgX1Q1arSN77qaxpq2PWKbmMltIUbxtQLdGzROT1S+2yln4WHtU8z9
	F6qSK5d7WyCMlM4oPUSDls0m2X3P52XjxGBr4WjlFZecVySQ2+ftUrrpZlVABMyH
	2eP+UcwI8cBKMYtLsNyTrax57fkFPrjuD80G3f72iQ==
X-ME-Sender: <xms:GdA6Z-gFyvmxUHZxxeHtVE91VLuyJzCdoUd3VUWCSqlkHlBpgS3icQ>
    <xme:GdA6Z_APKcYLg5CPB9632RM32C6x6_0ER4rvH6K3crAyZTa5kMi21hnZduhJWYUPl
    QbWh7Lx2qGTFhaT-k8>
X-ME-Received: <xmr:GdA6Z2HBbQwRFM9n2Y7aXIwYXwyU8SvSUQxTcyTY-KHAi2fk9riiejhTyDLXkvQdPJJZrJeukRlqW2e1pXfPXMROEUZYkU6uBO8>
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
X-ME-Proxy: <xmx:GdA6Z3Tox476_PvVHqJAwIbe4PFe6NyrokN1LalWPkYsk652tc7Ikg>
    <xmx:GdA6Z7z1KYWCoJZcriL_0ZGl1CrZussotL4aNtrKRQMTwS1Z2KW9fw>
    <xmx:GdA6Z14l23fJfT6bTwQYFWJipGzw61TxwMUuMVGBGroDlhoJfKU_XQ>
    <xmx:GdA6Z4zuJlX3gz1OBSOPNC9Dp69w5lM7C5AMrfTpwpWeqc7I4_ZXcA>
    <xmx:GdA6Z9tCW-trumHpJRtiiSjYgOdVjZPnpwkp35WsURfhW7UY3jabFBI8>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 00:26:47 -0500 (EST)
Date: Mon, 18 Nov 2024 16:27:18 +1100
Message-ID: <b2d405a9b410211f27e87f8a0de4b10a@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: stable@kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Al Viro <viro@zeniv.linux.org.uk>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y] m68k: Update ->thread.esp0 before calling syscall_trace() in ret_from_signal
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

