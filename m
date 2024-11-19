Return-Path: <linux-kernel+bounces-415053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A276E9D3119
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02DD5283F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 23:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7B21C4A3F;
	Tue, 19 Nov 2024 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.rarity.fan header.i=@mail.rarity.fan header.b="Dr3LDJrb"
Received: from m42-7.mailgun.net (m42-7.mailgun.net [69.72.42.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A45A1BD9F3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.72.42.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732060569; cv=none; b=SpFBtVksONwg4IQbvYS49nUAOZSK2/1J8bYo1UWept6I8Euibr+zlNeJp7iV2CpEQR4mM9D+NX1UfAaTSpE2elo+90d/nutw3KVxStQYpGTU6iibSRnJQqRjCGBWSCBOl6DBjpQTu7zr/OUm1PStRtDUsnYGrXZA0QSWUgPnUeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732060569; c=relaxed/simple;
	bh=9+G3nlY/0AsG3XH6HOtqosPaw/LSasEDLngHYFqrMbU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TKUyAERbzSB/0REz0neFmETmgN8gQs6xNIZ1H9CVQQEOM97PqFFxvoFxHk+nY8CCamsDlCa5t1bVjh2OP4fEYaYlqSJHr/FnBhiOEgd2QP0l24UeQMDDvzBZ5grc8I/cWUK+DlGjf7fdicyMnmBtcplmm732k5V3Lo38DSWNZ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rarity.fan; spf=pass smtp.mailfrom=mail.rarity.fan; dkim=pass (2048-bit key) header.d=mail.rarity.fan header.i=@mail.rarity.fan header.b=Dr3LDJrb; arc=none smtp.client-ip=69.72.42.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rarity.fan
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.rarity.fan
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mail.rarity.fan; q=dns/txt; s=pic; t=1732060565; x=1732067765;
 h=Content-Type: MIME-Version: References: Message-ID: In-Reply-To: Subject: Subject: cc: To: To: From: From: Date: Sender: Sender;
 bh=abo8xd/+uPlCfatlMXS8vYzBOfTD44gFeOEs3G2z0u0=;
 b=Dr3LDJrbB8v5S0SHy2SbAHR85zesTbHnn9dLZUrIMi3XwDXQXqLrySySPFfwOy7UF+GZCgT/m2rM8WPdONjVoX3+6PVDMANYNyV/CkrHw/+Rbh2ESXGEOPJ+UKpJDYlWn2Oe9pq3cP6dgc5v2mdcrY2ps6VcRtcJ51ynp944a56cwJ+Qz4GmqjexvWH/pWlgGG6XfxSC/swgCSabIn2acYRwBWm+1mZ22RHz+WZtB6Wno0fRYxpeLXTi3Iq7mJbmDCudhk5chKRSlt+etMvrL+SDx2XNrHvL864ckpT8qRAXIpzyrEdoWeq4S+BJKqc0hLMom9d6A2O0PNShz6Xz2Q==
X-Mailgun-Sending-Ip: 69.72.42.7
X-Mailgun-Sending-Ip-Pool-Name: 
X-Mailgun-Sending-Ip-Pool: 
X-Mailgun-Sid: WyI4MmIyMCIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCI4NmFiY2IiXQ==
Received: from 79-126-23-27.dynamic.mts-nn.ru (79-126-23-27.dynamic.mts-nn.ru
 [79.126.23.27]) by f7cff81043c6 with SMTP id 673d2595a1b016ee1fec1010
 (version=TLS1.3, cipher=TLS_AES_128_GCM_SHA256); Tue, 19 Nov 2024 23:56:05
 GMT
Sender: me=rarity.fan@mail.rarity.fan
Date: Wed, 20 Nov 2024 02:56:31 +0300
From: gldrk <me@rarity.fan>
To: Ingo Molnar <mingo@kernel.org>
cc: Dave Hansen <dave.hansen@linux.intel.com>, 
    Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
    x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Check return value from
 memblock_phys_alloc_range()
In-Reply-To: <ZzxzCk9LIPkFqcqK@gmail.com>
Message-ID: <76fc49d-2c45-e45-60bc-5579cfc72c6@rarity.fan>
References: <94b3e98f-96a7-3560-1f76-349eb95ccf7f@rarity.fan> <ZzxzCk9LIPkFqcqK@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

> Just curious: what type of system has < 4 MiB of contiguous free memory
> available in early boot? Or was it something intentionally constrained
> via qemu?

Yes, I was able to boot a basic Alpine system off virtiofs with a few MiB
total and a stripped-down config.  I happen to have a memory-starved 486
machine that is technically "supported", but it's not running Linux just
yet.

Here's an updated patch.

Signed-off-by: Philip Redkin <me@rarity.fan>
---
  arch/x86/mm/init.c | 9 +++++++--
  1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index eb503f5..6c4ec4f 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -640,8 +640,13 @@ static void __init memory_map_top_down(unsigned long map_start,
  	 */
  	addr = memblock_phys_alloc_range(PMD_SIZE, PMD_SIZE, map_start,
  					 map_end);
-	memblock_phys_free(addr, PMD_SIZE);
-	real_end = addr + PMD_SIZE;
+	if (!addr) {
+		pr_warn("Failed to release memory for alloc_low_pages()");
+		real_end = max(map_start, ALIGN_DOWN(map_end, PMD_SIZE));
+	} else {
+		memblock_phys_free(addr, PMD_SIZE);
+		real_end = addr + PMD_SIZE;
+	}

  	/* step_size need to be small so pgt_buf from BRK could cover it */
  	step_size = PMD_SIZE;
-- 
2.34.0



