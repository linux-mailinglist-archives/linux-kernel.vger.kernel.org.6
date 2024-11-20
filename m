Return-Path: <linux-kernel+bounces-415607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAEC9D38E0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A6F283B88
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4581A7259;
	Wed, 20 Nov 2024 10:56:57 +0000 (UTC)
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EE31A303C;
	Wed, 20 Nov 2024 10:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732100217; cv=none; b=sAwRc0UrrVxxPXnbAfQDFmd9t4fKd1fXZ1T0fHEQm5V40OXNL7otqNCfm6rq6Ea98J6lCJyJMWUNmpyUyYF5IH3fVMbxejxPI/IwMm88QgazjfUsqcxmNbMXC0z9iFUXGgSGJKyuSxLXYR34zqO/YiKn/rNNMg1zNqO7S7o4O38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732100217; c=relaxed/simple;
	bh=9qVZPgCv88FAGuli8j25XcIf3zlG5e7cpzSCT+OuZmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jDWKlre490znTrZhN2tBQ+a/uz+zf4RfM9CLIhLxzbhzGeECIFmK2CtAd5xl6+Y0e1n71PZw/L7lE3H+rHrWCHvd08dQRF7/wLYSZjH7mYGCeaj8qbwW0VcSf7Rl/AQ6Ut6xdQL+zDjFdKxaqLee3B6dP7bpA20jaYPrzOfNy5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from sun-VirtualBox..(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aGmppe8_1732100206 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Nov 2024 18:56:46 +0800
From: Frank Sae <Frank.Sae@motor-comm.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com,
	hua.sun@motor-comm.com,
	Frank.Sae@motor-comm.com
Subject: [PATCH net-next v2 16/21] motorcomm:yt6801: Add a Makefile in the motorcomm folder
Date: Wed, 20 Nov 2024 18:56:20 +0800
Message-Id: <20241120105625.22508-17-Frank.Sae@motor-comm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Makefile in the motorcomm folder to build yt6801 driver.

Signed-off-by: Frank Sae <Frank.Sae@motor-comm.com>
---
 drivers/net/ethernet/motorcomm/yt6801/Makefile | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 drivers/net/ethernet/motorcomm/yt6801/Makefile

diff --git a/drivers/net/ethernet/motorcomm/yt6801/Makefile b/drivers/net/ethernet/motorcomm/yt6801/Makefile
new file mode 100644
index 000000000..72e0acd65
--- /dev/null
+++ b/drivers/net/ethernet/motorcomm/yt6801/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Motor-comm Corporation.
+#
+# Makefile for the Motorcomm(R) 6801 PCI-Express ethernet driver
+#
+
+obj-$(CONFIG_YT6801) += yt6801.o
+yt6801-objs :=  yt6801_desc.o yt6801_ethtool.o yt6801_hw.o \
+		yt6801_net.o  yt6801_pci.o
-- 
2.34.1


