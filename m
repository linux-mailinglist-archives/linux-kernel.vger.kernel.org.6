Return-Path: <linux-kernel+bounces-570528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABA7A6B1BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88172486682
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 23:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6167822CBC9;
	Thu, 20 Mar 2025 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAHWac1Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7222B8C6
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 23:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742514194; cv=none; b=sBoB/AChTTqh0J73smODVR2myIDJljt8yDDtEI+/EueREn5m0bZuKYVzyHXQc0YDh0BRiPwCYlM1Lve34Vyab+rLzdyUriIHH5hGQrVQFw7+uBROcG55lG9Yb9/6r5TEum4j0/4wI/NFjGgykQi9E4xYnI2zj+bYGQ5DjASACyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742514194; c=relaxed/simple;
	bh=vnXIpSLZTNEu4ZeR7wVUXuTusggA8dL6xryMPk7B+6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8PJBkiAkl9QdWmjfe71BamQKjNVhmDuKpnv3S9xEp/YvZk2qEJJ2s/gb+qmRrSFUYMV2PAGggKVaxvAuAuacS61wumkF8zU3FqU478WfgskkAf2Cf9w4u4EJcV/0zXs/yvSaoGyaDMQZzXgcNUg93RWP9OW1vO5xMK8GMuqL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAHWac1Z; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742514193; x=1774050193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnXIpSLZTNEu4ZeR7wVUXuTusggA8dL6xryMPk7B+6g=;
  b=lAHWac1ZeDqvWIyidkDWtfoSvoKqNkHujAxkXgVtJySbxrV4NWqToGHU
   lAbVPc62Rn1NBBkjAXyDtnk6d4zQkciu5d0l9jTkDSFRDB3YTv2iWWb2b
   v4Z6Pd4cI4INhjXFgSDOJ7pw69bc3ieBDfzWSRyipbAtigFl0sgCIYiYh
   9gxsyTYEz2DgZJMNQLzVD+kJbcbGlQkwS7IrPWngk6p+pm3YG49qqp98Y
   rdCN/R5WoV35S9pnR0BIxJdT9WKYBZGd3cfOUeeb5OD5nRbmS5dDRZ7d7
   7rf4FcuOFpLBkNDBp12EpxC1Rdk962XXLtAGA2gcDDR53HVZxRdHpn9Wb
   g==;
X-CSE-ConnectionGUID: ualJM1aET4iFosSlSnw+Og==
X-CSE-MsgGUID: rs44eFxvQEulNxSGNY40kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43502588"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="43502588"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 16:43:13 -0700
X-CSE-ConnectionGUID: 3zyTXTI3TgiSK7151ezx5A==
X-CSE-MsgGUID: HjvTWyfzTxWgh1xamkjY8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="122962947"
Received: from cbae1-mobl.amr.corp.intel.com (HELO cbae1-mobl.intel.com) ([10.124.161.68])
  by orviesa009.jf.intel.com with ESMTP; 20 Mar 2025 16:43:12 -0700
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	chang.seok.bae@intel.com
Subject: [PATCH RFC v2 3/9] x86/fpu/xstate: Adjust XSAVE buffer size calculation
Date: Thu, 20 Mar 2025 16:42:54 -0700
Message-ID: <20250320234301.8342-4-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250320234301.8342-1-chang.seok.bae@intel.com>
References: <20250227184502.10288-1-chang.seok.bae@intel.com>
 <20250320234301.8342-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current xstate size calculation assumes that the highest-numbered
xstate feature has the highest offset in the buffer, determining the size
based on the topmost bit in the feature mask. However, this assumption is
not architecturally guaranteed -- higher-numbered features may have lower
offsets.

With the introduction of the xfeature order table and its helper macro,
xstate components can now be traversed in their positional order. Update
the non-compacted format handling to iterate through the table to
determine the last-positioned feature. Then, set the offset accordingly.

Since size calculation primarily occurs during initialization or in
non-critical paths, looping to find the last feature is not expected to
have a meaningful performance impact.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
---
 arch/x86/kernel/fpu/xstate.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 1e22103a8e17..93f94013b094 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -581,13 +581,20 @@ static bool __init check_xstate_against_struct(int nr)
 static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
 {
 	unsigned int topmost = fls64(xfeatures) -  1;
-	unsigned int offset = xstate_offsets[topmost];
+	unsigned int offset, i;
 
 	if (topmost <= XFEATURE_SSE)
 		return sizeof(struct xregs_state);
 
-	if (compacted)
+	if (compacted) {
 		offset = xfeature_get_offset(xfeatures, topmost);
+	} else {
+		/* Walk through the xfeature order to pick the last */
+		for_each_extended_xfeature_in_order(i, xfeatures)
+			topmost = xfeature_uncompact_order[i];
+		offset = xstate_offsets[topmost];
+	}
+
 	return offset + xstate_sizes[topmost];
 }
 
-- 
2.45.2


