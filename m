Return-Path: <linux-kernel+bounces-445849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5905C9F1C36
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 04:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A485E188C394
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 03:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4241B175AB;
	Sat, 14 Dec 2024 03:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gFFNM8G5"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA91725765
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 03:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734145443; cv=none; b=bzU57gcL4zi4uf6k3YUecxh6KCdhWWXrH2+cU94mfUtlqtlt11QPdfjmKqZN88rDVFTVpkyQJqi1aS6QQP4CxAlPKB7KDApazr2iiGe4H0ozivj9uIrovVhFtRDQmoiFW3proC0Dx9vSS0nspAB9JMAt9hghfgWIidNE9j3E+wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734145443; c=relaxed/simple;
	bh=y+unLlIOQ6rOl7hpgETYDgU3rqQN3RL5YloB0DAHnmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFaazqQ2j6Ldq37k5LojM1t3QZK58Hut0KfZggEX/FDZjBwURQdTByciI/CzRtT31KjfBhAcMu3K0TItAPvey/1NbTTtknTHqGlJIZt4ZvwLPPZp+yt06tgmhc5mkcmsBHflaDjfVOIvMcSDwbTN3vj59DYIjYbwY4nP6tuUx+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gFFNM8G5; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=R1Zia
	9Fz2QARQl8fEmYHofwn16afpQH0+MPKYwrH0LA=; b=gFFNM8G5HXgSrPIxO8nNB
	iY+ljVY0HReH2tatNPzvKUBAvan/zWLXFVS360onsO5r4mRCZc25MV7fYpRz0q+K
	9c01T+n34zUXqQwkdQSnZQAKqtoArYE2ZRkq2nRZCtevqXASbYPVqmo+K08Wmjy8
	f++sfifIhwpk3eOB/McOK0=
Received: from Jerry-PC.. (unknown [36.27.96.116])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXy66Q9VxnpMc9Fg--.7304S2;
	Sat, 14 Dec 2024 11:03:50 +0800 (CST)
From: Jerry <jerrydeng079@163.com>
To: jerrydeng079@163.com
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Jerry <jerrydeng79@163.com>
Subject: 
Date: Sat, 14 Dec 2024 11:03:28 +0800
Message-ID: <20241214030341.4264-1-jerrydeng079@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <em69028b68-d2c5-485d-a2ec-463c4673e723@f742d22a.com>
References: <em69028b68-d2c5-485d-a2ec-463c4673e723@f742d22a.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXy66Q9VxnpMc9Fg--.7304S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrW7uw15Zr4DXF48Kr4kWFg_yoW7JF1xpF
	Wayw1FyrW8JF17WrZ3AayUZF4a93yIkFW7Ary7Ga9IyrsxKF1jkFyavFy0yr1IkrZ8GrWa
	vr45trW7Gr48Cr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U7gAcUUUUU=
X-CM-SenderInfo: xmhu25pghqwiixz6il2tof0z/1tbiNh+122dc5sTkEgAAso

Signed-off-by: Jerry <jerrydeng79@163.com>
---
 mm/backing-dev.c    |  1 +
 mm/filemap.c        |  6 ++++-
 mm/page-writeback.c | 61 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index dd08ab928..0b86bd980 100755
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -878,6 +878,7 @@ void bdi_unregister(struct backing_dev_info *bdi)
 	/* make sure nobody finds us on the bdi_list anymore */
 	bdi_remove_from_list(bdi);
 	wb_shutdown(&bdi->wb);
+	wake_up(&(bdi->wb_waitq));
 	cgwb_bdi_unregister(bdi);
 
 	/*
diff --git a/mm/filemap.c b/mm/filemap.c
index 3b0d8c6dd..3282840f0 100755
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3300,6 +3300,7 @@ ssize_t generic_perform_write(struct file *file,
 	long status = 0;
 	ssize_t written = 0;
 	unsigned int flags = 0;
+	errseq_t err = 0;
 
 	do {
 		struct page *page;
@@ -3368,8 +3369,11 @@ ssize_t generic_perform_write(struct file *file,
 		}
 		pos += copied;
 		written += copied;
-
 		balance_dirty_pages_ratelimited(mapping);
+		err = errseq_check(&mapping->wb_err, 0);
+		if (err)
+			return err;
+		
 	} while (iov_iter_count(i));
 
 	return written ? written : status;
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index b2c916474..e013a6d01 100755
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -146,6 +146,16 @@ struct dirty_throttle_control {
 	unsigned long		pos_ratio;
 };
 
+
+
+struct bdi_wq_callback_entry {
+	
+	struct task_struct *tsk;
+	struct wait_queue_entry  wq_entry;
+	int bdi_unregister;
+};
+
+
 /*
  * Length of period for aging writeout fractions of bdis. This is an
  * arbitrarily chosen number. The longer the period, the slower fractions will
@@ -1567,6 +1577,22 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
 	}
 }
 
+
+static int wake_up_bdi_waitq(wait_queue_entry_t *wait, unsigned mode,
+				int sync, void *key)
+{
+
+	struct bdi_wq_callback_entry *bwce = 
+		container_of(wait, struct bdi_wq_callback_entry, wq_entry);
+	
+	bwce->bdi_unregister = 1;
+	if(bwce->tsk)
+		wake_up_process(bwce->tsk);
+	
+	return 0;
+}
+
+
 /*
  * balance_dirty_pages() must be called by processes which are generating dirty
  * data.  It looks at the number of dirty pages in the machine and will force
@@ -1574,7 +1600,7 @@ static inline void wb_dirty_limits(struct dirty_throttle_control *dtc)
  * If we're over `background_thresh' then the writeback threads are woken to
  * perform some writeout.
  */
-static void balance_dirty_pages(struct bdi_writeback *wb,
+static int balance_dirty_pages(struct bdi_writeback *wb,
 				unsigned long pages_dirtied)
 {
 	struct dirty_throttle_control gdtc_stor = { GDTC_INIT(wb) };
@@ -1595,6 +1621,16 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
 	struct backing_dev_info *bdi = wb->bdi;
 	bool strictlimit = bdi->capabilities & BDI_CAP_STRICTLIMIT;
 	unsigned long start_time = jiffies;
+	struct bdi_wq_callback_entry bwce= {NULL};
+	int ret = 0;
+
+
+	if (!test_bit(WB_registered, &wb->state))
+		return -EIO;
+
+	init_waitqueue_func_entry(&(bwce.wq_entry), wake_up_bdi_waitq);
+	bwce.tsk = current;
+	add_wait_queue(&(bdi->wb_waitq), &(bwce.wq_entry));
 
 	for (;;) {
 		unsigned long now = jiffies;
@@ -1816,6 +1852,12 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
 		wb->dirty_sleep = now;
 		io_schedule_timeout(pause);
 
+		/* bid is unregister NULL, all bdi memory is illegal */
+		if (bwce.bdi_unregister){
+			ret = -EIO;
+			break;
+		}
+
 		current->dirty_paused_when = now + pause;
 		current->nr_dirtied = 0;
 		current->nr_dirtied_pause = nr_dirtied_pause;
@@ -1843,12 +1885,15 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
 		if (fatal_signal_pending(current))
 			break;
 	}
+	
+	if (0 == bwce.bdi_unregister)
+		remove_wait_queue(&(bdi->wb_waitq), &(bwce.wq_entry));
 
 	if (!dirty_exceeded && wb->dirty_exceeded)
 		wb->dirty_exceeded = 0;
 
 	if (writeback_in_progress(wb))
-		return;
+		return ret;
 
 	/*
 	 * In laptop mode, we wait until hitting the higher threshold before
@@ -1859,10 +1904,12 @@ static void balance_dirty_pages(struct bdi_writeback *wb,
 	 * background_thresh, to keep the amount of dirty memory low.
 	 */
 	if (laptop_mode)
-		return;
+		return ret;
 
 	if (nr_reclaimable > gdtc->bg_thresh)
 		wb_start_background_writeback(wb);
+
+	return ret;
 }
 
 static DEFINE_PER_CPU(int, bdp_ratelimits);
@@ -1944,8 +1991,12 @@ void balance_dirty_pages_ratelimited(struct address_space *mapping)
 	}
 	preempt_enable();
 
-	if (unlikely(current->nr_dirtied >= ratelimit))
-		balance_dirty_pages(wb, current->nr_dirtied);
+	if (unlikely(current->nr_dirtied >= ratelimit)) {
+		
+		if( 0 > balance_dirty_pages(wb, current->nr_dirtied))
+			errseq_set(&(mapping->wb_err), -EIO);
+
+	}
 
 	wb_put(wb);
 }
-- 
2.43.0


