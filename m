Return-Path: <linux-kernel+bounces-412415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439F69D08CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41EC1F229C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 05:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D485B13C69E;
	Mon, 18 Nov 2024 05:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPCP0wl4"
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AE13C9B8
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 05:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731907373; cv=none; b=uMUHnD8JH5//MfwpyOKJgB/Jj7lcHsIZgQ4dD7Jksui2jrXsm47fA1zZ3vMD2CEC+qHKRI/ieIfA8qYvH1NB+CtN/ipD6ZeG2ZsyCBG+oBwrKY0F24kpWaf44xNgHE6TvLd9VCBOVevdU8HsTk2VoYNhLoNmoIAIYR/lgeIeDnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731907373; c=relaxed/simple;
	bh=KelfrUEDKn1STr/uyl6Wn/gXFShtj7LS2NXx40teaXU=;
	h=Date:Message-ID:From:To:Cc:Subject; b=dGInRn4o2nwnjqXVYP2A9H/LZtrChPmPCCgfz7MxvxsaM4r4ZlM2IMCzy5Xqp1MAMjKAe1HYM5vi1VE0QksHyxt3Wpn5QpxWqv20b3Ug+WUgKWEIC2VjtlnZYuw85fsR+APkgOAQrwU87+Zl+2qkN17imGDhfxnrHGLa+daXjlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPCP0wl4; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 4258E114011A;
	Mon, 18 Nov 2024 00:22:50 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 18 Nov 2024 00:22:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731907370; x=1731993770; bh=2pmDU7e3MlYtu8haZn4roILPX83I
	3ITd6BRmfCF1ljE=; b=FPCP0wl417Yh0xaRiGtO+HJKqiD/wLfQVbNbWqEXlqv4
	nzUrRBM8YO0HAHHLV2zzZJI+6hekHaCRKUJWEfw6ztKjMTM5Utp3Ym2L3DR7QRki
	sdo1C7ImuGtMZvWLPzqYNCC5jQuZ9g/u8juh26iF1H3KrmTSrpiV4oWjZX1N8s2a
	Df2MVjOSIOxN+Balg28RXXPj0Y/DFvxxA/3LNSN2TGFIGGjYvKTNUBo39zH0xXiI
	ONYSR1dARkks2gUFNHfPw7bOhN6ZxMmaQIZ274eXQAMChEvzUUuIjDu3rQHfB6EL
	hxhp8eJ3+6obmjg517/ASj6noKnEv72oXJyNbbFFsg==
X-ME-Sender: <xms:Kc86Z7IQfltj3MRoIBYYj0LQbUaPVHqTD4XhTjKvQPbKopkXYee7Nw>
    <xme:Kc86Z_Ijuz86OcqQEIABrilhEJavFHMW4GbK5uHUb4mlVhLN2SSUshqPErq6rV-BD
    4VF3CXtcFDDDli8J9s>
X-ME-Received: <xmr:Kc86ZzsScjsQu3IhravUTabWijEBMMoWJ0t8G3XgLDmhtWUUlFNkMv42KoLT0T6MUNYIlxeLFs-1sljx23H1fOFlDMCONNlcZAM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdelgdekvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffkffhvfevufestddtjhdttddttdenucfhrhhomhep
    hfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqne
    cuggftrfgrthhtvghrnhepiedugfduhffgheekjeekffduueejudevffehiedtledttdek
    veekuefhvdfftedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhu
    gidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehsthgrsghlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghgv
    vghrtheslhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhirghmrdhhohiflh
    gvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhmieekkheslhhi
    shhtshdrlhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Kc86Z0YxOglhFzPN2j0fEDehz8oqxU7NrC-WfppLvH18e0C03lfCEA>
    <xmx:Kc86Zyaj15LeZkjRqmJhhfM4h0GKhiwQFFVggfE3EjynErCgRgNSww>
    <xmx:Kc86Z4A3Ux6RChzYJAwoIXseFSpt_ttmvR7N762MflkZLJyJqzpdNQ>
    <xmx:Kc86ZwYz6UkHwkw2oJuY3nOZi-S7ibn_XwteI8Kj887Az3lnYLqxMg>
    <xmx:Ks86Z5Xcj8zUIoVAWsEkihdK8e8Zjfb0K0dRR7VCPQF_ugrj0JxMlu7h>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 00:22:46 -0500 (EST)
Date: Mon, 18 Nov 2024 16:23:16 +1100
Message-ID: <6280f364e7773aafabdd388a68c99eb4@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
To: stable@kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Liam Howlett <liam.howlett@oracle.com>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.4.y] m68k: Add missing mmap_read_lock() to sys_cacheflush()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Liam Howlett <liam.howlett@oracle.com>

[ Upstream commit f829b4b212a315b912cb23fd10aaf30534bb5ce9 ]

When the superuser flushes the entire cache, the mmap_read_lock() is not
taken, but mmap_read_unlock() is called.  Add the missing
mmap_read_lock() call.

Fixes: cd2567b6850b1648 ("m68k: call find_vma with the mmap_sem held in sys_cacheflush()")
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20210407200032.764445-1-Liam.Howlett@Oracle.com
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
[ mmap_read_lock() open-coded using down_read() as was done prior to v5.8 ]
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/kernel/sys_m68k.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index 6363ec83a290..38dcc1a2097d 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -388,6 +388,8 @@ sys_cacheflush (unsigned long addr, int scope, int cache, unsigned long len)
 		ret = -EPERM;
 		if (!capable(CAP_SYS_ADMIN))
 			goto out;
+
+		down_read(&current->mm->mmap_sem);
 	} else {
 		struct vm_area_struct *vma;
 

