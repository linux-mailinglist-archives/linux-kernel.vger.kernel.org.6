Return-Path: <linux-kernel+bounces-268370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC349423D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00C2B23D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A329C79DC;
	Wed, 31 Jul 2024 00:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uiuwddvq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1A01AA3C3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722385833; cv=none; b=nIYfEXjYoHltvia2o9oVRD6x16+1bZXPNHH+EwqcYv/c/jxiac0MfnVCt9fqLYMgafTKbBeW9wBpsTap/91lIzy33IUxsTeWkKkXyPPfUMzElV0waJKAttrytRRdHaHjUtTp8GU5FZ/KGomqmcz9Jn87SQ4TNBRtridVkbsdjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722385833; c=relaxed/simple;
	bh=g59QcdS841R2ElrGLaqTv8bw9mQqMYsEaa2rIjEi6K4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xn/CWdgRl5vLkpGG9yNKUSetUpr0QCWuwuiZ1jH+FkuO2O7cxIVE41wDjbLoN9/G9y7fvpq5i38R1QaBDhdBfsc3kpcWmBOrjkT3t4qn6jMkwsJF7GdX+WqtjK8JKFOdGsbXX9WlXI0YEy1eFFK6hVj3C6NGLSv4idJpBuhf21s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uiuwddvq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722385832; x=1753921832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g59QcdS841R2ElrGLaqTv8bw9mQqMYsEaa2rIjEi6K4=;
  b=UiuwddvqLQ0dbqhzVSYNPDMOy29cEMJ/sE301lRRDx21SZvuWu85kOHN
   f8pcf5/md23Hm6wilEhpZTY3vfEgQaVjK455oCWiWRYIC0x21qB+Zbuwd
   aoCjsLIeJpWNHyrbTVgw+llPHh81Da9yVaMid0uI6SqwsT2dnVYWitpK6
   2a+ZRIUY5ifBUL8ktO3yk0M4w3/KKDxa0ew7mAEKGALFw0lL8WrSxHnPy
   mJN+WdLPDrbnEZR4ZAl58sKkNNiEbi3ZcoXvB9Cy6E/AC9MCFSArVFyoL
   zhYnn9CqeX2KbN0u8H7xx+ZhvaU4mKfLet487s17oayKNuAc8/OQTcm6T
   A==;
X-CSE-ConnectionGUID: FVROUE9fTMGEPJv0xKa2Wg==
X-CSE-MsgGUID: zuM6We+YQteVJNZg0Cn4tQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="23156075"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="23156075"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:30:31 -0700
X-CSE-ConnectionGUID: xjpDosHyThOcHkcd7ZCarw==
X-CSE-MsgGUID: g+wMVQZpRgysvmnxiUlolQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="77781797"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 17:30:30 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	jiangshanlai@gmail.com,
	christian.koenig@amd.com,
	ltuikov89@gmail.com,
	daniel@ffwll.ch
Subject: [PATCH v2 1/5] workqueue: Split alloc_workqueue into internal function and lockdep init
Date: Tue, 30 Jul 2024 17:31:15 -0700
Message-Id: <20240731003119.2422940-2-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731003119.2422940-1-matthew.brost@intel.com>
References: <20240731003119.2422940-1-matthew.brost@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will help enable user-defined lockdep maps for workqueues.

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 kernel/workqueue.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 3fbaecfc88c2..c9bdd6a23a2b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5657,9 +5657,9 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 }
 
 __printf(1, 4)
-struct workqueue_struct *alloc_workqueue(const char *fmt,
-					 unsigned int flags,
-					 int max_active, ...)
+static struct workqueue_struct *__alloc_workqueue(const char *fmt,
+						  unsigned int flags,
+						  int max_active, ...)
 {
 	va_list args;
 	struct workqueue_struct *wq;
@@ -5725,12 +5725,11 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	INIT_LIST_HEAD(&wq->flusher_overflow);
 	INIT_LIST_HEAD(&wq->maydays);
 
-	wq_init_lockdep(wq);
 	INIT_LIST_HEAD(&wq->list);
 
 	if (flags & WQ_UNBOUND) {
 		if (alloc_node_nr_active(wq->node_nr_active) < 0)
-			goto err_unreg_lockdep;
+			goto err_free_wq;
 	}
 
 	if (alloc_and_link_pwqs(wq) < 0)
@@ -5762,9 +5761,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 err_free_node_nr_active:
 	if (wq->flags & WQ_UNBOUND)
 		free_node_nr_active(wq->node_nr_active);
-err_unreg_lockdep:
-	wq_unregister_lockdep(wq);
-	wq_free_lockdep(wq);
 err_free_wq:
 	free_workqueue_attrs(wq->unbound_attrs);
 	kfree(wq);
@@ -5773,6 +5769,25 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	destroy_workqueue(wq);
 	return NULL;
 }
+
+__printf(1, 4)
+struct workqueue_struct *alloc_workqueue(const char *fmt,
+					 unsigned int flags,
+					 int max_active, ...)
+{
+	struct workqueue_struct *wq;
+	va_list args;
+
+	va_start(args, max_active);
+	wq = __alloc_workqueue(fmt, flags, max_active, args);
+	va_end(args);
+	if (!wq)
+		return NULL;
+
+	wq_init_lockdep(wq);
+
+	return wq;
+}
 EXPORT_SYMBOL_GPL(alloc_workqueue);
 
 static bool pwq_busy(struct pool_workqueue *pwq)
-- 
2.34.1


