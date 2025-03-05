Return-Path: <linux-kernel+bounces-546166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B522A4F730
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 07:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6987B188D323
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 06:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BADC1DB924;
	Wed,  5 Mar 2025 06:36:39 +0000 (UTC)
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2011078F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 06:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156598; cv=none; b=C1M7EkTgeLqOL2UwRvRzbN5CLsQOrXeFYWOGrgiA/B6HUoKdBlcWb7gopcjlEZ+cARre9exTwwWno+NgYi5irZMvaBYdQ2Kaj6HcfEwAIJy86cEAm0/nB2qxHY7HeHrDdyCzJhNTa/peXJnUjM0oTogNMIt/SkL5MPM7sKR2oUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156598; c=relaxed/simple;
	bh=0kdexJ+Louma7BZaTiIL3N8ymj6ogv49ggVLAOi/90s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XoxtwD9M7FguTR3acdq5lZXHa2LG7dJvwJc3siiwrfVSAmf3eNhJB/3FBkmH1BwiewabIH4jQmejbNdTOAEC9Yau9PNpHB/iUzlnLG2+6+8aXXOapSZ/jvl+J54zpo5gz5F22WDRdqzxeFaNxImQy4e/COktM1zQ5Kork0l3an0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201617.home.langchao.com
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id 202503051435174829;
        Wed, 05 Mar 2025 14:35:17 +0800
Received: from jtjnmail201607.home.langchao.com (10.100.2.7) by
 Jtjnmail201617.home.langchao.com (10.100.2.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 14:35:18 +0800
Received: from locahost.localdomain (10.94.3.63) by
 jtjnmail201607.home.langchao.com (10.100.2.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 5 Mar 2025 14:35:17 +0800
From: Charles Han <hanchunchao@inspur.com>
To: <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>, Charles Han <hanchunchao@inspur.com>
Subject: [PATCH] x86/delay: fix inconsistent indenting warning
Date: Wed, 5 Mar 2025 14:35:14 +0800
Message-ID: <20250305063515.3951-1-hanchunchao@inspur.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Jtjnmail201613.home.langchao.com (10.100.2.13) To
 jtjnmail201607.home.langchao.com (10.100.2.7)
tUid: 2025305143517530fd40100995191fd90d73aa745cef0
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

Fix below inconsistent indenting smatch warning.
smatch warnings:
arch/x86/lib/delay.c:134 delay_halt_mwaitx() warn: inconsistent indenting

Signed-off-by: Charles Han <hanchunchao@inspur.com>
---
 arch/x86/lib/delay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/delay.c b/arch/x86/lib/delay.c
index 23f81ca3f06b..e86eda2c0b04 100644
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -131,7 +131,7 @@ static void delay_halt_mwaitx(u64 unused, u64 cycles)
 	 * Use cpu_tss_rw as a cacheline-aligned, seldom accessed per-cpu
 	 * variable as the monitor target.
 	 */
-	 __monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
+	__monitorx(raw_cpu_ptr(&cpu_tss_rw), 0, 0);
 
 	/*
 	 * AMD, like Intel, supports the EAX hint and EAX=0xf means, do not
-- 
2.43.0


