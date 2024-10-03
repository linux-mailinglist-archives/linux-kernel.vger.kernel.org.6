Return-Path: <linux-kernel+bounces-348545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCBF98E8DD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 05:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F3D1F2748E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 03:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFEB288D1;
	Thu,  3 Oct 2024 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBlnyif7"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2FA45026
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 03:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727926341; cv=none; b=rKLGpRN5NhwkU7k6ORaZZQ/cfXFA+3FbeBkODzKVfnr53ZZvHYjZ+kc/HCHNTwJ3fmT6jg2dv5ur5gwRlpRlWiewCDKnjOFRBqcQTNSpJFsBHABayxvE/lPM0wxDmGG70zvPaY9f9dpMhqANjYugiAYnQSmGxF0PjCZaXHFuCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727926341; c=relaxed/simple;
	bh=pps4CowKC2g1MPGAUyiNHB63/+34fcZ1kliBVZTSOIQ=;
	h=To:Cc:Message-Id:From:Subject:Date; b=Z2OFKKefJxcolvzVDsvc1bad0Pfv96+HwydFmEU4+zGzLWUS5iW6IQe9FzFEfKVEyoBblMYhsL7us2CMi9ZchQ1sD4PzUtXDowpSlwDqfXWloiNWGyAOiz1+S+e4GT2tQPK+S7fz6dijhs8XwpsOtFTu7LPOkF25gRh5lrLx/G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jBlnyif7; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 403E61140254;
	Wed,  2 Oct 2024 23:32:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 02 Oct 2024 23:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:message-id:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1727926339; x=1728012739; bh=rgBThvFYSnV95
	n8aLUXaWQHtLFexqo7ujOupDPef5Go=; b=jBlnyif7r7W3RAzeWQ5Mr0ZXmxDkB
	YiD8L/N2IWnWKbq6VVNSQKwYyvYIfOPgrIlU9acZxgEWN9BJuetrDgkqdBH+VuOH
	aw/SstzldyRZs4h8Thcgicylxv0j1+74B1o9rrhR0lR4XDwm0vQQ1g6x+t7S7ncg
	73wCkKTDvOSSDPMLy02c27S5e9ap+/NGO++EH8ASAkEZjQvnE8mM6xdtUySlFHtk
	noxlcUobjfPWX1AjU2v5rTUcQ0n9SO4iQ8I9y0zJKVnO1qscPl56JGABC9GspTuY
	TwODOy0ISt3NIOkufL0CUjXCXUfvxb7vxEBpxpxHyEYTSTjgJwoLSTSuA==
X-ME-Sender: <xms:QxD-ZnED4ksTnfZ00AFIFuwwgeZOyc8JH3VqsTjihMD2QE35_aXnKg>
    <xme:QxD-ZkUZddANV9vypZ9Hgzu_rSVWDq09s5rshDH84DllSGkiAsZhijuDniTWvQlKD
    zfzpMAE3NUql0xTm_k>
X-ME-Received: <xmr:QxD-ZpIYjA9yWlVIY7NAACH4aoWIZmPpKhVp0pGzgs7wK3xvGUHA1u9sGBGvYtoRO1iy0Phf68YPw02KnrHoeJBG0hmGIvQczgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvtddgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepvfevkffhufffsedttdertddttddtnecuhfhrohhm
    pefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqe
    enucggtffrrghtthgvrhhnpeehfffggeefveegvedtiefffeevuedtgefhueehieetffej
    fefggeevfeeuvdduleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgvggvrhhtsehlihhnuh
    igqdhmieekkhdrohhrghdprhgtphhtthhopegurghnihgvlhestdigtdhfrdgtohhmpdhr
    tghpthhtohepshhtrggslhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhmieekkheslhhishhtshdrlhhinhhugidqmheikehkrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QxD-ZlEONQR0LSTCa3kBcRlUaUeVyAl7YQKkSi2XgKcTd1jmBoh6ig>
    <xmx:QxD-ZtWiYyJLLTztrtXrPGwVLiSc_8v1oLZLzsurFnO06g_lK-GvhA>
    <xmx:QxD-ZgNP-nswSpZuoUvMGsyeQuxC4tMS9y52xDgv9R5JZrDFdAiETA>
    <xmx:QxD-Zs3n8Y-wtiRLI5UuBvSUkXcI_Gzic0SK7l-z5deZYLkWZfNQIA>
    <xmx:QxD-ZjzDufUMSu7XiiPikBq-12SCfZGsRUvyMHrIujGOt7lYwcZT_KVU>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 23:32:17 -0400 (EDT)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Daniel Palmer" <daniel@0x0f.com>,
    stable@kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-Id: <0e7636a21a0274eea35bfd5d874459d5078e97cc.1727926187.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH] m68k: mvme147: Fix SCSI controller IRQ numbers
Date: Thu, 03 Oct 2024 13:29:47 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Daniel Palmer <daniel@0x0f.com>

Sometime long ago the m68k IRQ code was refactored and the interrupt
numbers for SCSI controller on this board ended up wrong, and it hasn't
worked since.

The PCC adds 0x40 to the vector for its interrupts so they end up in
the user interrupt range. Hence, the kernel number should be the kernel
offset for user interrupt range + the PCC interrupt number.

Cc: Daniel Palmer <daniel@0x0f.com>
Cc: stable@kernel.org
Fixes: 200a3d352cd5 ("[PATCH] m68k: convert VME irq code")
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Finn Thain <fthain@linux-m68k.org>
---
 arch/m68k/include/asm/mvme147hw.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/mvme147hw.h b/arch/m68k/include/asm/mvme147hw.h
index 2b147ab1d189..6ad93bac06f9 100644
--- a/arch/m68k/include/asm/mvme147hw.h
+++ b/arch/m68k/include/asm/mvme147hw.h
@@ -76,8 +76,8 @@ struct pcc_regs {
 #define M147_SCC_B_ADDR		0xfffe3000
 #define M147_SCC_PCLK		5000000
 
-#define MVME147_IRQ_SCSI_PORT	(IRQ_USER+0x45)
-#define MVME147_IRQ_SCSI_DMA	(IRQ_USER+0x46)
+#define MVME147_IRQ_SCSI_PORT	(IRQ_USER + 5)
+#define MVME147_IRQ_SCSI_DMA	(IRQ_USER + 6)
 
 /* SCC interrupts, for MVME147 */
 
-- 
2.39.5


