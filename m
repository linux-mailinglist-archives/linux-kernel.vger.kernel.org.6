Return-Path: <linux-kernel+bounces-539382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1F2A4A393
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C83519C1B72
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205CF27F4EE;
	Fri, 28 Feb 2025 20:02:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC5E27F4CF
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772973; cv=none; b=g0W69GlOgsS/Sb1iDvttWm4dYhBmdz78od1bpAsrzPUTpHIyxL0o5wCdcOmMvyoUdmCnq+zFBBRZt4cIN14YRGxz3XEFBcj1H6qLZSBzNaZrAykBcvyFcfXX0mYj66/wgdOWUQRMP/yQcxm4br1cNNdGPnswMIEXQ3Epnz9trq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772973; c=relaxed/simple;
	bh=Q+n6OsaiUCzZ1PAACvk4PgavmHC8f1kXdKot+DKRGOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uAo2/xHWRS6/ceL37zN5SWmzo8ZHUfF4PVr5ywVBC5J6WdwmSwSvC1F3njRrTqn1zcpf/qriwJy6ZX30Fhk4+z+LDv/tNQM20b8m8bBftfiVf8EWcmYP1d20rFX5zfzLWXiXdn8XZL8lj1lmf3rEXDWlcGN73wy3OiJygSpQoSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2FDE19F0;
	Fri, 28 Feb 2025 12:03:06 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 946B33F5A1;
	Fri, 28 Feb 2025 12:02:48 -0800 (PST)
From: James Morse <james.morse@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	James Morse <james.morse@arm.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	peternewman@google.com,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>,
	Dave Martin <dave.martin@arm.com>,
	Koba Ko <kobak@nvidia.com>,
	Shanker Donthineni <sdonthineni@nvidia.com>,
	fenghuay@nvidia.com
Subject: [PATCH v7 48/49] fs/resctrl: Change internal.h's header guard macros
Date: Fri, 28 Feb 2025 19:59:12 +0000
Message-Id: <20250228195913.24895-49-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250228195913.24895-1-james.morse@arm.com>
References: <20250228195913.24895-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code in internal.h was moved by a script. The script didn't know to
change the header guard macros. Do that.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v6:
 * This patch is new.
---
 fs/resctrl/internal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index f1763a13715f..ec3863d18f68 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_RESCTRL_INTERNAL_H
-#define _ASM_X86_RESCTRL_INTERNAL_H
+#ifndef _FS_RESCTRL_INTERNAL_H
+#define _FS_RESCTRL_INTERNAL_H
 
 #include <linux/resctrl.h>
 #include <linux/sched.h>
@@ -432,4 +432,4 @@ static inline int rdtgroup_pseudo_lock_create(struct rdtgroup *rdtgrp)
 static inline void rdtgroup_pseudo_lock_remove(struct rdtgroup *rdtgrp) { }
 #endif /* CONFIG_RESCTRL_FS_PSEUDO_LOCK */
 
-#endif /* _ASM_X86_RESCTRL_INTERNAL_H */
+#endif /* _FS_RESCTRL_INTERNAL_H */
-- 
2.39.5


