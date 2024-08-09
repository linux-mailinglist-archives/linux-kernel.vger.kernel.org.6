Return-Path: <linux-kernel+bounces-280825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7062294CFB4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 14:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 099CAB2312A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61100194094;
	Fri,  9 Aug 2024 12:00:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CDD194085;
	Fri,  9 Aug 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723204831; cv=none; b=kFIO+kT4TRSDM76j4Nm7BdDJqkmrhP1W31550ONYF8BZpqPSCaTGOGQGnL/AgRSHZMII2PGn/JUXMRiK42T3dR+GSLwC8arybk1e2C3akI1UrXPEEC19bD3m05i0xfBR2svX1VvCNKBunMkkNSjNwr3L+JL3VwspprKEFJlm4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723204831; c=relaxed/simple;
	bh=GWVASxbGyv+H6U7tfbAr4CKEu+FH17mr3LRov5P2PDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SBoTXkyOyLPrUE40a7g0z1u1u8ILV0WHa6yvR7o95Rs22xi3+gMK1j5Eh18f85RKnC3HhHLQDwTQBAsOcgRLUC0awrlyMGn+YZlTAOepGjamjBXtIOlQD3p+0TQBKnh25XQoDzLLmVZuLZOVdP+g4diuRlR/n6qMmeKecLqx/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BF7513D5;
	Fri,  9 Aug 2024 05:00:53 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA72D3F6A8;
	Fri,  9 Aug 2024 05:00:26 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH] firmware: arm_scmi: Update Base protocol version
Date: Fri,  9 Aug 2024 13:00:14 +0100
Message-ID: <20240809120014.724959-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Base protocol version had been increased with SCMI v3.2. Update accordingly
the supported version define in the kernel stack, since all the mandatory
Base commands are indeed already supported.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 97254de35ab0..9939b1d84b7a 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -14,7 +14,7 @@
 #include "notify.h"
 
 /* Updated only after ALL the mandatory features for that version are merged */
-#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20000
+#define SCMI_PROTOCOL_SUPPORTED_VERSION		0x20001
 
 #define SCMI_BASE_NUM_SOURCES		1
 #define SCMI_BASE_MAX_CMD_ERR_COUNT	1024
-- 
2.45.2


