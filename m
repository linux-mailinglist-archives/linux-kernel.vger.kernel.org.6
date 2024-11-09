Return-Path: <linux-kernel+bounces-402678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC95E9C2A73
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901D32820F3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 05:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654F713B2A2;
	Sat,  9 Nov 2024 05:52:05 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8901E529
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 05:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731131525; cv=none; b=BHb0T857RxYlDgSN/bJvyosAtm7c0GqTHJhMeh1Now8GgWEPkJQ7uF0kD4/SUU7ZUZzQ07/PF9qiT0m7fCOPPXRj92nDKBWSI/lIaAqi/7iLPhGRMuzQ+en+l2ZaF20X8vC7xdAs9opua56ReQjzhirUZ8g8m9PZOlWn9JvtTRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731131525; c=relaxed/simple;
	bh=qnNeF//y7Ja25NXZOlO1mhvLSD16A2N3lhZ6IyxfiFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ouRCcsZbsZf88c+B+exNDrYwfRBVa9bwlpt7cIVfxDY8+1xE8BPRuicLnslq55+oSNK1D5/vDpRbYRacOtQXQc2hk9cQytciq/NfzOSZ9weB6hEjcqYPKBAAWTQkebeFQzsQic4xoFsv2xR7DbLESG3tmOKpmSS3bEvivY1UXUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee7672ef87ad6a-f6d80;
	Sat, 09 Nov 2024 13:51:57 +0800 (CST)
X-RM-TRANSID:2ee7672ef87ad6a-f6d80
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee2672ef874356-bc53f;
	Sat, 09 Nov 2024 13:51:57 +0800 (CST)
X-RM-TRANSID:2ee2672ef874356-bc53f
From: guanjing <guanjing@cmss.chinamobile.com>
To: mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	guanjing <guanjing@cmss.chinamobile.com>
Subject: [PATCH v2] firewall: remove misplaced semicolon from stm32_firewall_get_firewall
Date: Sat,  9 Nov 2024 13:50:49 +0800
Message-Id: <20241109055049.269163-1-guanjing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove misplaced colon in stm32_firewall_get_firewall()
which results in a syntax error when the code is compiled
without CONFIG_STM32_FIREWALL.

Fixes: 5c9668cfc6d7 ("firewall: introduce stm32_firewall framework")
Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
---
 include/linux/bus/stm32_firewall_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bus/stm32_firewall_device.h b/include/linux/bus/stm32_firewall_device.h
index 18e0a2fc3816..5178b72bc920 100644
--- a/include/linux/bus/stm32_firewall_device.h
+++ b/include/linux/bus/stm32_firewall_device.h
@@ -115,7 +115,7 @@ void stm32_firewall_release_access_by_id(struct stm32_firewall *firewall, u32 su
 #else /* CONFIG_STM32_FIREWALL */
 
 int stm32_firewall_get_firewall(struct device_node *np, struct stm32_firewall *firewall,
-				unsigned int nb_firewall);
+				unsigned int nb_firewall)
 {
 	return -ENODEV;
 }
-- 
2.33.0




