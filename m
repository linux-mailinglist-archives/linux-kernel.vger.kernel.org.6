Return-Path: <linux-kernel+bounces-282063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D694DF4A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 02:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515411F21A2D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 00:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CDCA50;
	Sun, 11 Aug 2024 00:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cu2R13ZT"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDD34A00
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 00:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723334709; cv=none; b=IGnq/BWEu8xvSB1UwBxqTJ21VbaSwJkOI/Quefgiyb48hvxhQrZvNDTKlbFOjmHNImZj1utMEbFs5UeacRBLB1eVyL1OOqNtJ0z013q2+kzYRCEuB0hN4du5CZTEmv4NtdGgzkWNdrO6BD18ZnwW6VNI6lstj6yZPcS+ls1R/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723334709; c=relaxed/simple;
	bh=+WKdIuC+p530GHPOQlXZIux1ngHdwRNECGfQ0w2ExHg=;
	h=To:Cc:Message-Id:From:Subject:Date; b=ViDCwuXocwukV5O+neCpMXgQLhGiL2IY8bLvm4U5eLdTNnuwSjYME+NsUobqpjOKDYJ5UkPL/gX5kKOSN9wRbN+gGByOo2x5fnZu4haEQL0gj8RijpzWflVH4vCErnhsQaD8wASNay+RI+qQ+H8mAJr9hBBzuWPoNrpn8eh2HdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cu2R13ZT; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 41B121151B81;
	Sat, 10 Aug 2024 20:05:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 10 Aug 2024 20:05:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1723334706; x=1723421106; bh=9vmpys9j51EiE
	NEz8IFCUMk8fjEsJF6w5WceFyF82OM=; b=cu2R13ZTI7LDu7lqIwdX0gF1Tw2dP
	5M+xIFq8gDQx8mkwjF+vS58RNYI7Qp3rBKJBiosNWOIUbSlTJI38iGbXCNCt5Ri1
	5AtmWnfhuL/X+4jypMy7OunQGvTBjwWOvg/sbZZW1VMNU5rupriBAWPo68IfqhxH
	ZQtel1A1ZJtETsXzzcucIeFeAlXSdrGj1J7acU1faAtZBch9AkERvU1zwT6a4iAK
	9LhsPRhjac9ZV5LMEf9usoOjKfYKm8uAWjdOWCOKAvpKGUgnzd6Q+/vGMKTu/tWY
	vWMKtgLr2wTTy3ZxUbSY/XRht25K8iQwngP8xOoYCzZDbUpZq6NkoQiXg==
X-ME-Sender: <xms:MgC4ZlbROzMe4cNdFWtbIw4xyG8h8idhjiq3hllSwtkc2aZYgHgMHw>
    <xme:MgC4ZsaByWV8_OnucDTuC5reWL5guqfSOBiMB2x04IYXS9c0CbQp-m-QyzFaZ01aF
    5InmHJs8F8k2wVDT84>
X-ME-Received: <xmr:MgC4Zn99TK8ARKcpj-PfJEgJeiijBEnnk5qrpHgrJVH8dpx3JqiTpzoBRVzuQkgTAnYoxjy16xZ7Zi0ZiwPhjS5GYEiCIrEeIpE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleejgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefvvefkhffuffestddtredttddttdenucfhrhhomhep
    hfhinhhnucfvhhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqne
    cuggftrfgrthhtvghrnhepffeuieelgeffgedtheevfeekffevffeiudegfeevuedvtedt
    feeiffelgfetgeeunecuffhomhgrihhnpeguvggsihgrnhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhu
    gidqmheikehkrdhorhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopehgvggvrhhtsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthho
    pegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgvghrgheslhhinh
    hugidqmheikehkrdhorhhgpdhrtghpthhtohepuhhsvghrmhehjeeshigrhhhoohdrtgho
    mhdprhgtphhtthhopehlihhnuhigqdhmieekkheslhhishhtshdrlhhinhhugidqmheike
    hkrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:MgC4Zjr1SHSu_WWv4GSvBCsid7Lnz_glVPl4Ejs5nv-YGpPnAcWN9w>
    <xmx:MgC4ZgpKHqmeYFfxccAXVFGj3IpdkaFN84JSCSqfaAvzgyviESaheQ>
    <xmx:MgC4ZpQeiabalLZ0WziK0N-m0UzftWuvBfiI3RA3bZ3XNwezth0W2Q>
    <xmx:MgC4ZoqO6BQ1i2XgiA_8HlBM2sX-Jf8oJiARMx1_uCJHGwbErLE-bQ>
    <xmx:MgC4ZlCBfde6AxC2LisduDfcHOckbscnfa7RsPUhta080cqB9Phx4nlS>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Aug 2024 20:05:03 -0400 (EDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christian Brauner <brauner@kernel.org>,
    Greg Ungerer <gerg@linux-m68k.org>,
    Stan Johnson <userm57@yahoo.com>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-Id: <0a3abf529ab9e47a136c2216af1c9d33b2b7dae3.1723334660.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v2] m68k: Fix kernel_clone_args.flags in m68k_clone()
Date: Sun, 11 Aug 2024 10:04:20 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Stan Johnson recently reported a failure from the 'dump' command:

  DUMP: Date of this level 0 dump: Fri Aug  9 23:37:15 2024
  DUMP: Dumping /dev/sda (an unlisted file system) to /dev/null
  DUMP: Label: none
  DUMP: Writing 10 Kilobyte records
  DUMP: mapping (Pass I) [regular files]
  DUMP: mapping (Pass II) [directories]
  DUMP: estimated 3595695 blocks.
  DUMP: Context save fork fails in parent 671

The dump program uses the clone syscall with the CLONE_IO flag, that is,
flags == 0x80000000. When that value is promoted from long int to u64 by
m68k_clone(), it undergoes sign-extension. The new value includes
CLONE_INTO_CGROUP so the validation in cgroup_css_set_fork() fails and
the syscall returns -EBADFD. Avoid sign-extension by casting to u32.

Cc: Stan Johnson <userm57@yahoo.com>
Reported-by: Stan Johnson <userm57@yahoo.com>
Closes: https://lists.debian.org/debian-68k/2024/08/msg00000.html
Fixes: 6aabc1facdb2 ("m68k: Implement copy_thread_tls()")
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
Changed since v1:
 - Cast to u32 instead of using lower_32_bits() as suggested by Geert.
---
 arch/m68k/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
index 2584e94e2134..fda7eac23f87 100644
--- a/arch/m68k/kernel/process.c
+++ b/arch/m68k/kernel/process.c
@@ -117,7 +117,7 @@ asmlinkage int m68k_clone(struct pt_regs *regs)
 {
 	/* regs will be equal to current_pt_regs() */
 	struct kernel_clone_args args = {
-		.flags		= regs->d1 & ~CSIGNAL,
+		.flags		= (u32)(regs->d1) & ~CSIGNAL,
 		.pidfd		= (int __user *)regs->d3,
 		.child_tid	= (int __user *)regs->d4,
 		.parent_tid	= (int __user *)regs->d3,
-- 
2.39.5


