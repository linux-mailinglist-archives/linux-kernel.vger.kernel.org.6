Return-Path: <linux-kernel+bounces-340287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0667E987109
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0DA1F21E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5AD1AC434;
	Thu, 26 Sep 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+R/aTmv"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6121A726A
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 10:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727345389; cv=none; b=MTYl/1fHm29px2uzKbYjI8Lzt0HD/vDSly7/UCC2jvVQN0OFLqeOSC+uQIelGE+J5oqu/ujRoYuuhEnlbTbjzE/5arU9y8zh9mj1eV/ZgPAqHKKyOv817xmoZIKQEnQ1JupBOHYonNbCIHTXxT/ejK1EZDnxAudECSpI7Omod9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727345389; c=relaxed/simple;
	bh=wtmMxPfXHs1lniflSjfhnjJuGeiH2xDRPoiDdQLkAyI=;
	h=To:Cc:Message-Id:From:Subject:Date; b=e8iHwBFJmq96XPNgkfZ9NgsbuPV/vGqSu64vvEwO5BhhGhMOnXH/XB9nqCWh7woT4v4cCFmBpFEkMPryyoU2seDKQ4PkZnlTRmTjUtm1BIj82GdNJr6CfSinhHF/FY2XEXMsvdF2/ni+hKpKoL3tDnLqRkUOyJkM53+bnH/yQSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z+R/aTmv; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1AE0D138061E;
	Thu, 26 Sep 2024 06:09:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Sep 2024 06:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1727345386; x=1727431786; bh=bvuBPrU/ROkpG
	h+7LGDsKdbS0WAs5mdFAL8FQjUFZgs=; b=Z+R/aTmvqt1yt2i3z+qdWgjNwXo8T
	nrZN3tYhJL6W9FPQvXBAmBCXj1VJrP5GmEiHDWNvpYrz09FAU5Y9P6ACx1K3v6+4
	TplhCxfoyb31N45upBkMRkmMjJu6h9fbeBiMt/4zwY2qs7BDTBEuo0IBmNXcnv/+
	2/nkSGegfNELYzMearYv8MjkUdaVEif3p8pwSLBXYoPzsEjtiZzFFQ7KFMGKFW6x
	N/GUMJIhOPV+f/OAkIgEuUeeovbp6VwXk9FUoLdYaeHssos7PB3P/+a23ln7Gxph
	lA2r8BXSPg7j4HWQc4huBfhiZXw1oHnT3zL7INYlHbWdECQ7aLmtNtzWg==
X-ME-Sender: <xms:6TL1Zilc_JgZnYrvZdWuGQvRmbOKLFnHx7iBbfezHCMcY2Tyz9zm7w>
    <xme:6TL1Zp0vAqo-Arm5BJh5eR2LR1d_AzXvDbTUY8HInDJ8ukY97RHa1K2Zl0pmwW8Ht
    b9rNCdFAPwsd7RU9B4>
X-ME-Received: <xmr:6TL1Zgqs0Vv3SUC73CAA6aPL7OjFxBasFWfVbVVm8q7bVWeAsfEIOqbpVtQZlP-a9H3UfM8o3v2-Mzk9kK8Do_uIN8XUrNPkvNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhm
    pefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqe
    enucggtffrrghtthgvrhhnpeekffejgfehheehkeekffffveekteevvddvveelhffgffet
    teefgfeutdehleetheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhn
    uhigqdhmieekkhdrohhrghdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepshhtrggslhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    vggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihgrmhdrhhhofi
    hlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheplhhinhhugidqmheikehksehl
    ihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6TL1Zmmo8gLhS-6_msm5UytHHfiiyMqWAc66IvYg067tOOybgfZCTQ>
    <xmx:6TL1Zg3Pr8-D9sSIv__YH2OLq44TmZ45KCc1CTSHjRvpnWzDgF_7eA>
    <xmx:6TL1ZttywwiAuXKRFyQ9dYGFuOsVcQfCwr8iiFUUgjF--WgUQmbpyg>
    <xmx:6TL1ZsU66pIRQIAJokIPb0qJXlJS_WjkoJMxi62MrDcfytFEVQTyrw>
    <xmx:6jL1ZjR9HJk2kwzPDeXTkBfc7oZ7aAPdXeQxt2ngTWOm-1_RX50V-c-q>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 06:09:42 -0400 (EDT)
To: stable@kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Liam Howlett <liam.howlett@oracle.com>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-Id: <184ceb0edb5740aa10db7c6f633e434793dd208b.1727345233.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] m68k: Add missing mmap_read_lock() to sys_cacheflush()
Date: Thu, 26 Sep 2024 20:07:13 +1000
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

Cc: stable@kernel.org # <= 5.7.y
Fixes: cd2567b6850b1648 ("m68k: call find_vma with the mmap_sem held in sys_cacheflush()")
Signed-off-by: Liam Howlett <liam.howlett@oracle.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Link: https://lore.kernel.org/r/20210407200032.764445-1-Liam.Howlett@Oracle.com
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
The original commit was backported as far as 5.10.y but never made it into
4.19.y or 5.4.y.

mmap_read_lock() was unavailable prior to v5.8, being introduced in commit
d8ed45c5dcd4 ("mmap locking API: use coccinelle to convert mmap_sem rwsem
call sites"), so this backport uses down_read() instead.
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
 
-- 
2.39.5


