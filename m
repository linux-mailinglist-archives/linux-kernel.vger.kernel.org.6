Return-Path: <linux-kernel+bounces-290645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B319556CF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 11:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E105DB21D7D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 09:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C4C881E;
	Sat, 17 Aug 2024 09:36:21 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357CC1494B0;
	Sat, 17 Aug 2024 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723887380; cv=none; b=qsBML5oXY+LyTylYagMWxYAbzMu1cCV66BIG3gyethJVt3A99KIfHRYOYuGxF88EjkXmNCLkOitTLoEymQjA1xm+KzWxmZOdoQZ9Fccv9e/Rba2EUCnQ5SGJ5Cbi6UtARY/LcAo2vRjRvHXDI0d3WgjwqtqCAssdWY2sKRyA5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723887380; c=relaxed/simple;
	bh=wzegZNh/JQ/vmkSWDX+aXKIV+AEH9C5s2h3okCrEYBQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lxc5ZFIQIiGqABOcCQBFkY9Smfq6AUFBkhtKwWxeucfRx4hYW1NVGjS9d089HjKmAMP04YWDEyXqy28dk4pNIhdE0q0XgiXuw7baOPAq4KLSdLqA1a4/+VSuV8hqGUIsCDXeq+mhZdYFzZOEdpZfMz3t0m9GRoxd8xevpk46oWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WmDBZ5mfSz2CmPV;
	Sat, 17 Aug 2024 17:31:18 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 98DDB140154;
	Sat, 17 Aug 2024 17:36:14 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 17 Aug
 2024 17:36:14 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>, <yuehaibing@huawei.com>,
	<arnd@arndb.de>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ALSA: seq: Remove unused declarations
Date: Sat, 17 Aug 2024 17:33:34 +0800
Message-ID: <20240817093334.1120002-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemf500002.china.huawei.com (7.185.36.57)

These functions are never implemented and used.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 include/sound/seq_kernel.h          | 4 ----
 sound/core/seq/oss/seq_oss_device.h | 4 ----
 sound/core/seq/seq_queue.h          | 1 -
 sound/core/seq/seq_timer.h          | 2 --
 4 files changed, 11 deletions(-)

diff --git a/include/sound/seq_kernel.h b/include/sound/seq_kernel.h
index c8621671fa70..00c32eed2124 100644
--- a/include/sound/seq_kernel.h
+++ b/include/sound/seq_kernel.h
@@ -86,10 +86,6 @@ static inline size_t snd_seq_event_packet_size(struct snd_seq_event *ev)
 /* interface for OSS emulation */
 int snd_seq_set_queue_tempo(int client, struct snd_seq_queue_tempo *tempo);
 
-/* port callback routines */
-void snd_port_init_callback(struct snd_seq_port_callback *p);
-struct snd_seq_port_callback *snd_port_alloc_callback(void);
-
 /* port attach/detach */
 int snd_seq_event_port_attach(int client, struct snd_seq_port_callback *pcbp,
 			      int cap, int type, int midi_channels, int midi_voices, char *portname);
diff --git a/sound/core/seq/oss/seq_oss_device.h b/sound/core/seq/oss/seq_oss_device.h
index f0e964b19af7..98dd20b42976 100644
--- a/sound/core/seq/oss/seq_oss_device.h
+++ b/sound/core/seq/oss/seq_oss_device.h
@@ -116,10 +116,6 @@ __poll_t snd_seq_oss_poll(struct seq_oss_devinfo *dp, struct file *file, poll_ta
 
 void snd_seq_oss_reset(struct seq_oss_devinfo *dp);
 
-/* */
-void snd_seq_oss_process_queue(struct seq_oss_devinfo *dp, abstime_t time);
-
-
 /* proc interface */
 void snd_seq_oss_system_info_read(struct snd_info_buffer *buf);
 void snd_seq_oss_midi_info_read(struct snd_info_buffer *buf);
diff --git a/sound/core/seq/seq_queue.h b/sound/core/seq/seq_queue.h
index c69105dc1a10..74cc31aacdac 100644
--- a/sound/core/seq/seq_queue.h
+++ b/sound/core/seq/seq_queue.h
@@ -84,7 +84,6 @@ void snd_seq_check_queue(struct snd_seq_queue *q, int atomic, int hop);
 int snd_seq_queue_check_access(int queueid, int client);
 int snd_seq_queue_timer_set_tempo(int queueid, int client, struct snd_seq_queue_tempo *info);
 int snd_seq_queue_set_owner(int queueid, int client, int locked);
-int snd_seq_queue_set_locked(int queueid, int client, int locked);
 int snd_seq_queue_timer_open(int queueid);
 int snd_seq_queue_timer_close(int queueid);
 int snd_seq_queue_use(int queueid, int client, int use);
diff --git a/sound/core/seq/seq_timer.h b/sound/core/seq/seq_timer.h
index 3b906064bde1..c8803216a3a4 100644
--- a/sound/core/seq/seq_timer.h
+++ b/sound/core/seq/seq_timer.h
@@ -109,8 +109,6 @@ static inline void snd_seq_inc_time_nsec(snd_seq_real_time_t *tm, unsigned long
 struct snd_seq_queue;
 int snd_seq_timer_open(struct snd_seq_queue *q);
 int snd_seq_timer_close(struct snd_seq_queue *q);
-int snd_seq_timer_midi_open(struct snd_seq_queue *q);
-int snd_seq_timer_midi_close(struct snd_seq_queue *q);
 void snd_seq_timer_defaults(struct snd_seq_timer *tmr);
 void snd_seq_timer_reset(struct snd_seq_timer *tmr);
 int snd_seq_timer_stop(struct snd_seq_timer *tmr);
-- 
2.34.1


