Return-Path: <linux-kernel+bounces-539381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C95DA4A38D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E41788158F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B66F27F4D4;
	Fri, 28 Feb 2025 20:02:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B246C27F4CA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772970; cv=none; b=L6doijOwMnwufCq3a1DzhoClqRNqEuz/0i4WaDBU5iXSqa3PceXO8i8XgCPDraEimDoFiaoOtGb2u3LtSqTA1XFRJ8gqP7a1Mua57KiE6J/P7aHrryv1K/19Yuh12r5w8N/oTDcTTfrf+kuiaMmW7/J8mV66ONXqKubVMnWcmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772970; c=relaxed/simple;
	bh=R6B/FTtlXgLps01pzs5tLUJl0jqmSd2VuzRa3cmOXWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aUPhwqXYQrXz+f2Umzq7gmHXbVokBnOezhEIGlp24PILCVwtn2vxNpH/MDuAfjqQS0LbMEGcFiSdToUf9anx4jLx5JPC6c8umAnf0ndnzmLdW5rCkCqeqkmOcXRKlQn85qnkMhAWpL6zCvCMpngRWbsIYiQl65vKM2z/y+QoKLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DF641A25;
	Fri, 28 Feb 2025 12:03:03 -0800 (PST)
Received: from merodach.members.linode.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F56D3F5A1;
	Fri, 28 Feb 2025 12:02:45 -0800 (PST)
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
Subject: [PATCH v7 47/49] fs/resctrl: Remove unnecessary includes
Date: Fri, 28 Feb 2025 19:59:11 +0000
Message-Id: <20250228195913.24895-48-james.morse@arm.com>
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

When splitting and moving the resctrl code to live in fs/resctrl and
arch/x86, some code was duplicated. This was done to keep the parser
in the script that does the moving simple. These extra includes are
harmless on x86.

Remove them to allow other architectures to start using fs/resctrl.

Signed-off-by: James Morse <james.morse@arm.com>
---
Changes since v6:
 * This patch is new.
---
 fs/resctrl/monitor.c     | 2 --
 fs/resctrl/pseudo_lock.c | 1 -
 2 files changed, 3 deletions(-)

diff --git a/fs/resctrl/monitor.c b/fs/resctrl/monitor.c
index d37324f9f95f..3fe21dcf0fde 100644
--- a/fs/resctrl/monitor.c
+++ b/fs/resctrl/monitor.c
@@ -23,8 +23,6 @@
 #include <linux/sizes.h>
 #include <linux/slab.h>
 
-#include <asm/cpu_device_id.h>
-
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index d26cc1a2a84a..3bee26b8c07d 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -27,7 +27,6 @@
 #include <asm/cpu_device_id.h>
 #include <asm/perf_event.h>
 
-#include "../../events/perf_event.h" /* For X86_CONFIG() */
 #include "internal.h"
 
 /*
-- 
2.39.5


