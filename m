Return-Path: <linux-kernel+bounces-411106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2750D9CF30F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55D91F28C56
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AFA1D63CF;
	Fri, 15 Nov 2024 17:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.rarity.fan header.i=@mail.rarity.fan header.b="KKkR+N7P"
Received: from so254-54.mailgun.net (so254-54.mailgun.net [198.61.254.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E081D61A4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 17:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.61.254.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731692189; cv=none; b=CN5puiXPo2Zl3Gvf6jnUvzywk+4ul3NSdRaKUFLRuyzlDSM9wjcVwPZsh9IBrkEeJfraNdkFnGxv+ADX+UP8qzsfQhPp2oOPK1/dCaR55Eb15F+WKsvHqkMEB27PaJVrg4Rcd0MvWFGlQurO3zCyIoYIyUC5NzX7iQiuH/WN8pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731692189; c=relaxed/simple;
	bh=SnO4p4dNKukr62VNDO+93FBRVFDQDrCzUThgfxJgAvM=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=YatIJkG2zGDVcdTthX5hMmRNscX+0Nw+AyHMaABfGHTIsa/97UXYw1ALCvXrsgMr66izdP8lqSJcbcclryJ2HCzz7ENGINihlk1Wg4U8ngFjWJsZgvD/xVdYNK8+AOLm2ptUhBz7p3etYkg+zkLsNUKVwIm6Fcto4aW6XWiMs24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rarity.fan; spf=pass smtp.mailfrom=mail.rarity.fan; dkim=pass (2048-bit key) header.d=mail.rarity.fan header.i=@mail.rarity.fan header.b=KKkR+N7P; arc=none smtp.client-ip=198.61.254.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rarity.fan
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.rarity.fan
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mail.rarity.fan; q=dns/txt; s=pic; t=1731692184; x=1731699384;
 h=Content-Type: MIME-Version: Message-ID: Subject: Subject: cc: To: To: From: From: Date: Sender: Sender;
 bh=2FrTp4VYt1CjS5B5El+XQlzklQncWc53/Wj418ZaeCE=;
 b=KKkR+N7PffrPFaIAuGUs8jzb4sPvRsl2hNYwWcdX1562oO62ZVvS3WvT1Ra9dPR1k9+5V0g6N8X6xkx1OzQVuY9STBihFyCT0bjnqoLOnYyEvbsag5YAdNykce6Ew+KXP1amgRWC5kMW1ShsYjlwNLzaY0fdESKjPtPij3UjUT11RVwqhNo1wpN6xNKwPGkwGs0HFrKM3us61eNai3Eq21Ae7qd1dzvtGKbyNy3Cyg1qObyBSrPYPBJ/JtoSQ/26rcfIbGKkulBIgMbL12IaIOsnTCnQ+NBP0xMB4wlPrU5vZSISAXSJFDksu3QIac808NBc4sOLU6BAEtUWhFMJ8Q==
X-Mailgun-Sending-Ip: 198.61.254.54
X-Mailgun-Sending-Ip-Pool-Name: 
X-Mailgun-Sending-Ip-Pool: 
X-Mailgun-Sid: WyI4MmIyMCIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI4NmFiY2IiXQ==
Received: from 79-126-23-27.dynamic.mts-nn.ru (79-126-23-27.dynamic.mts-nn.ru
 [79.126.23.27]) by 324f4e6314b2 with SMTP id 67378698b64c4812b20c9987
 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256); Fri, 15 Nov 2024 17:36:24
 GMT
Sender: me=rarity.fan@mail.rarity.fan
Date: Fri, 15 Nov 2024 20:36:59 +0300
From: gldrk <me@rarity.fan>
To: Dave Hansen <dave.hansen@linux.intel.com>, 
    Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    x86@kernel.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: Check return value from
 memblock_phys_alloc_range()
Message-ID: <94b3e98f-96a7-3560-1f76-349eb95ccf7f@rarity.fan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

At least with CONFIG_PHYSICAL_START=0x100000, if there is < 4 MiB of contiguous
free memory available at this point, the kernel will crash and burn because
memblock_phys_alloc_range returns 0 on failure, which leads memblock_phys_free
to throw the first 4 MiB of physical memory to the wolves.  At a minimum it
should fail gracefully with a meaningful diagnostic, but in fact everything
seems to work fine without the weird reserve allocation.

---
  arch/x86/mm/init.c | 9 +++++++--
  1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index eb503f5..3696770 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -640,8 +640,13 @@ static void __init memory_map_top_down(unsigned long 
map_start,
  	 */
  	addr = memblock_phys_alloc_range(PMD_SIZE, PMD_SIZE, map_start,
  					 map_end);
-	memblock_phys_free(addr, PMD_SIZE);
-	real_end = addr + PMD_SIZE;
+	if (unlikely(addr < map_start)) {
+		pr_warn("Failed to release memory for alloc_low_pages()");
+		real_end = ALIGN_DOWN(map_end, PMD_SIZE);
+	} else {
+		memblock_phys_free(addr, PMD_SIZE);
+		real_end = addr + PMD_SIZE;
+	}

  	/* step_size need to be small so pgt_buf from BRK could cover it 
*/
  	step_size = PMD_SIZE;
-- 
2.34.0


