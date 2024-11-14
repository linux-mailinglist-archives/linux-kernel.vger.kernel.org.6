Return-Path: <linux-kernel+bounces-408471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 535149C7F36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 01:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180C9282EE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 00:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A611CD02;
	Thu, 14 Nov 2024 00:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LWM49H3G"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F232EC13B;
	Thu, 14 Nov 2024 00:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731543443; cv=none; b=fEjsFst9h6tEVLKkBi1RoKBlqn2zuAzPggTFd1VApwgQV3u6Ku/blq5oC5VEW0VNDcktjLR9+pETBlhq0bzyI7OoDt4f9xkGCVy//9LP0wIJrgyPOy2LM3L+9Kn5ULIa88J62JCT6nZyqtMx5oCICMEQCtiX88MWuLqT2TWT4sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731543443; c=relaxed/simple;
	bh=XHNsAvQC21OhE47FufCcFsVPXtd14pius/9r2yHonYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pT+CkT9kyYMEFZm9K5KdGZ5lRCo88DvSSwvJtkqBf8iJr/jR1AiPlwoEq3LJZXqMi0Lb35awmvsA8vbFlN2NUuV/9jS38HoammILre0Hq+LAvASmlWCcTlC0wmBsxZKM3bLg5ymVA6COuBOGQWvJX8i41IUXulEsLQt/uiXhjTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LWM49H3G; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731543442; x=1763079442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XHNsAvQC21OhE47FufCcFsVPXtd14pius/9r2yHonYY=;
  b=LWM49H3Gid7+S5H4Sxh9ZCH5YhEl5BmSUd6LM/8REvisdfL4c529lDEC
   PSUiPmcpBdbvqa467Iqhc1hoMILO4Kbv/lkyg81NK+MlyGoFPXLofqSbL
   95rA7VyBMjtFW84o7obRbltr8MYHGVHyVx10OqfJSkx93rFDZuMuPzfI9
   Eq7Rzam5SvTVyVsIN6dp6sNdf4BKKTTuxnAndy84kFF/4G8KNjbjd1iTG
   UpjlT8rjRe5rN/HOdxLvoj87iIadozcsRLdGVW3OTI0wJdQOOFkRgZErt
   c4G3D/Tge4gr5+rH0w+I+OKneJROcnfr3anHDtNnfabU1p37s8rjxf2ed
   Q==;
X-CSE-ConnectionGUID: EDA6NKeOTA6EYfB1UenpVw==
X-CSE-MsgGUID: K5pJHvO4TTWFszdRov4zSQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11255"; a="30869480"
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="30869480"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:17:18 -0800
X-CSE-ConnectionGUID: ArU6JcoXS+KWVAQUgPQFoQ==
X-CSE-MsgGUID: MKnWP4CvSumMUWMl4T8sRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,152,1728975600"; 
   d="scan'208";a="92081157"
Received: from agluck-desk3.sc.intel.com ([172.25.222.70])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 16:17:18 -0800
From: Tony Luck <tony.luck@intel.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	x86@kernel.org
Cc: James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	patches@lists.linux.dev,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v9 3/9] x86/resctrl: Modify update_mba_bw() to use per ctrl_mon group event
Date: Wed, 13 Nov 2024 16:17:05 -0800
Message-ID: <20241114001712.80315-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114001712.80315-1-tony.luck@intel.com>
References: <20241114001712.80315-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of hard-coding the memory bandwidth local event as the
input to the mba_sc feedback look, use the event that the user
configured for each ctrl_mon group.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 7ef1a293cc13..2176e355e864 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -752,20 +752,31 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 	u32 closid, rmid, cur_msr_val, new_msr_val;
 	struct mbm_state *pmbm_data, *cmbm_data;
 	struct rdt_ctrl_domain *dom_mba;
+	enum resctrl_event_id evt_id;
 	struct rdt_resource *r_mba;
-	u32 cur_bw, user_bw, idx;
 	struct list_head *head;
 	struct rdtgroup *entry;
+	u32 cur_bw, user_bw;
 
-	if (!is_mbm_local_enabled())
+	if (!is_mbm_enabled())
 		return;
 
 	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl;
+	evt_id = rgrp->mba_mbps_event;
+
+	if (WARN_ON_ONCE(!is_mbm_event(evt_id)))
+		return;
+	if (WARN_ON_ONCE(evt_id == QOS_L3_MBM_LOCAL_EVENT_ID && !is_mbm_local_enabled()))
+		return;
+	if (WARN_ON_ONCE(evt_id == QOS_L3_MBM_TOTAL_EVENT_ID && !is_mbm_total_enabled()))
+		return;
+
 
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
-	idx = resctrl_arch_rmid_idx_encode(closid, rmid);
-	pmbm_data = &dom_mbm->mbm_local[idx];
+	pmbm_data = get_mbm_state(dom_mbm, closid, rmid, evt_id);
+	if (WARN_ON_ONCE(!pmbm_data))
+		return;
 
 	dom_mba = get_ctrl_domain_from_cpu(smp_processor_id(), r_mba);
 	if (!dom_mba) {
@@ -784,7 +795,9 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_mon_domain *dom_mbm)
 	 */
 	head = &rgrp->mon.crdtgrp_list;
 	list_for_each_entry(entry, head, mon.crdtgrp_list) {
-		cmbm_data = &dom_mbm->mbm_local[entry->mon.rmid];
+		cmbm_data = get_mbm_state(dom_mbm, entry->closid, entry->mon.rmid, evt_id);
+		if (WARN_ON_ONCE(!cmbm_data))
+			return;
 		cur_bw += cmbm_data->prev_bw;
 	}
 
-- 
2.47.0


