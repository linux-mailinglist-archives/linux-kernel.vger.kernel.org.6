Return-Path: <linux-kernel+bounces-539383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A75A4A390
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9F317CB58
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD1628136A;
	Fri, 28 Feb 2025 20:02:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BB027F4CD
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772977; cv=none; b=u6f0n9do+hyr8knZtS3tQnm84D8dcOmXjwQ+EJZy69z40Lopums7cz1vLQY08eaKVrXWnk422XkhnH+FC8iZ+74I4PYM4BLnyK+1KuzSdkOZ8C8N/SrebVh+UCI4iKCZGy45nYm0KZUSWq59pPsRL1zj5HVFvZ7ljFvtd1EE30U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772977; c=relaxed/simple;
	bh=oWipp4b7XP/LWjrOVNtZMWjBbNlhCiTREU16scxbXYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n2pQQVvb+jF2vaR+m/xvrzagrJ7OBU4HHai05TkoQyVwbcxoTIKE57iS5CuDqDTXeUtEGGVRZX5Uu1gYsReZn75S8EQu8cXutGqKMd9Lzp9G8a5Ln5Ar4BCsScaHl8xGP8dEPft+igxTW3xH896m2NJvdtutJDXW7eomGLikE9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54D041A2D;
	Fri, 28 Feb 2025 12:03:10 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 14C013F5A1;
	Fri, 28 Feb 2025 12:02:51 -0800 (PST)
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
Subject: [PATCH v7 49/49] x86,fs/resctrl: Move resctrl.rst to live under Documentation/filesystems
Date: Fri, 28 Feb 2025 19:59:13 +0000
Message-Id: <20250228195913.24895-50-james.morse@arm.com>
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

The filesystem code has moved from arch/x86 to fs. Move the documentation
too.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v6:
 * This patch is new.
---
 Documentation/arch/x86/index.rst                    | 1 -
 Documentation/filesystems/index.rst                 | 1 +
 Documentation/{arch/x86 => filesystems}/resctrl.rst | 0
 MAINTAINERS                                         | 2 +-
 arch/x86/kernel/cpu/resctrl/monitor.c               | 2 +-
 fs/resctrl/Kconfig                                  | 2 +-
 6 files changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/{arch/x86 => filesystems}/resctrl.rst (100%)

diff --git a/Documentation/arch/x86/index.rst b/Documentation/arch/x86/index.rst
index 8ac64d7de4dc..00f9a99689fb 100644
--- a/Documentation/arch/x86/index.rst
+++ b/Documentation/arch/x86/index.rst
@@ -31,7 +31,6 @@ x86-specific Documentation
    pti
    mds
    microcode
-   resctrl
    tsx_async_abort
    buslock
    usb-legacy-support
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 2636f2a41bd3..239e44babf6d 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -113,6 +113,7 @@ Documentation for filesystem implementations.
    qnx6
    ramfs-rootfs-initramfs
    relay
+   resctrl
    romfs
    smb/index
    spufs/index
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/filesystems/resctrl.rst
similarity index 100%
rename from Documentation/arch/x86/resctrl.rst
rename to Documentation/filesystems/resctrl.rst
diff --git a/MAINTAINERS b/MAINTAINERS
index 433ba4a5a84a..b0193b07d26f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19878,7 +19878,7 @@ M:	Fenghua Yu <fenghua.yu@intel.com>
 M:	Reinette Chatre <reinette.chatre@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-F:	Documentation/arch/x86/resctrl*
+F:	Documentation/filesystems/resctrl.rst
 F:	arch/x86/include/asm/resctrl.h
 F:	arch/x86/kernel/cpu/resctrl/
 F:	fs/resctrl/
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 800e52845b1d..163174cc0d3e 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -43,7 +43,7 @@ unsigned int rdt_mon_features;
 static int snc_nodes_per_l3_cache = 1;
 
 /*
- * The correction factor table is documented in Documentation/arch/x86/resctrl.rst.
+ * The correction factor table is documented in Documentation/filesystems/resctrl.rst.
  * If rmid > rmid threshold, MBM total and local values should be multiplied
  * by the correction factor.
  *
diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
index 478a8e2ad99f..21671301bd8a 100644
--- a/fs/resctrl/Kconfig
+++ b/fs/resctrl/Kconfig
@@ -21,7 +21,7 @@ config RESCTRL_FS
 	  On architectures where this can be disabled independently, it is
 	  safe to say N.
 
-	  See <file:Documentation/arch/x86/resctrl.rst> for more information.
+	  See <file:Documentation/filesystems/resctrl.rst> for more information.
 
 config RESCTRL_FS_PSEUDO_LOCK
 	bool
-- 
2.39.5


