Return-Path: <linux-kernel+bounces-174438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 219BA8C0EAD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 13:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CADDE1F233F4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E281304BD;
	Thu,  9 May 2024 11:06:29 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C550913049B
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715252788; cv=none; b=X7hxq2wG5jEzm1p2ydC9vGOIMEAq79/GefDLa+1eiSJ8WwDTCLUGI2U3w0YHfBUGt/75sXkgkNCLPp/ofqUmcs/YNVZGDn8syBWAPHrPIfZL7hHASpnnbElHljk4X0+t1HpVZVw9/CXylGOc/teak4rZoY0HysJOb/rmiTBH+cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715252788; c=relaxed/simple;
	bh=ecK8QbwY+FbLhxp6lSCIUfjMi/AkMP6XgV33l1ouTVM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fj20DkNH4Tg/8JoJYabcdA5pn9exqzXLVojjfbienzPcU/e/atBXX041+BsxtWUReMKmg/RzvO2H5p+Vd8UbmjFtqp8SBUywlfdDjgyAml7c4R97RCyhpJv1a8LW8BtYuLehdoLvaTGC7MXppzCb4htQfDQb066kCOfADrh+8xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a387fbc9so184015466b.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 04:06:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715252784; x=1715857584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/LOIjIMPO5ush8EPTSynnMiO8zIIbVtcBE/cd84blNw=;
        b=Yzb3zbpBidxa8eML3gJD8Oir+s+h5geLNGrAMkH43h1rMhs/pwNctbmQwoZSyc19/+
         t6iOzb5myncgbnkPetQ7Dd+j/iHAYU7J/7j/joFtOfRhthOHktfZCUsjJKf3bPm/pW2d
         pMCQDuHQ4VmzK0nId/DjwA59unGPamaZNyX68ODW2FkKushAXewuvB/siaqXFkpWyrWR
         4izmc0qw7xQaXw6+yqSQJdzV+3AZS9w1IF2kr0aFUpJN9FipxUAz1JgbiQXw74V5QK9m
         1PfXviotyCjMAN9lwCdP9PN5gIY3iBUB3wNT7ReKXJ6Wg/zFSFiL198MxZ2iBY1Ahlql
         VE1A==
X-Forwarded-Encrypted: i=1; AJvYcCW1ZWCPo65JJeQ561rN3WP+0KvoTyknKoPwQrr9ZVk3o02kC+2AV5ZXXYFVodUURJkQimCPJSYb4qGFQOnk86k7tvPDKxIYRs3IuR5i
X-Gm-Message-State: AOJu0YylxPshuHeDhp8ZyxhBIWe/B4DC1zqdcH8rw2eOLE8ulfRkY6+X
	MbTB1AS43kNHdnMVuOaGZedR3SizPdkUEzdbFGs82BiBlsyGrCzS
X-Google-Smtp-Source: AGHT+IFv50vbS7G34ZPIAFTwl7ijWXO9Zfn6DELJkCn77gEcJv4UYypJew7dQkQjwEnBcVv4Na7GWA==
X-Received: by 2002:a17:906:e211:b0:a59:ab57:7413 with SMTP id a640c23a62f3a-a59fb9e7488mr309642266b.73.1715252783829;
        Thu, 09 May 2024 04:06:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17892444sm61867766b.76.2024.05.09.04.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 04:06:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: paulmck@kernel.org,
	linux-kernel@vger.kernel.org (open list:DEBUGOBJECTS:)
Subject: [PATCH] debugobjects: Fix potential data race in debug_objects_maxchain
Date: Thu,  9 May 2024 04:06:11 -0700
Message-ID: <20240509110612.768196-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN has identified a potential data race in debugobjects, where the
global variable debug_objects_maxchain is accessed for both reading and
writing simultaneously in separate and parallel data paths. This results
in the following splat printed by KCSAN:

	BUG: KCSAN: data-race in debug_check_no_obj_freed / debug_object_activate

	write to 0xffffffff847ccfc8 of 4 bytes by task 734 on cpu 41:
	debug_object_activate (lib/debugobjects.c:199
			       lib/debugobjects.c:564 lib/debugobjects.c:710)
	call_rcu (kernel/rcu/rcu.h:227
		  kernel/rcu/tree.c:2719 kernel/rcu/tree.c:2838)
	security_inode_free (security/security.c:1626)
	__destroy_inode (./include/linux/fsnotify.h:222 fs/inode.c:287)
	evict (fs/inode.c:310 fs/inode.c:682)
	iput (fs/inode.c:1769)
	dentry_unlink_inode (fs/dcache.c:401)
	__dentry_kill (fs/dcache.c:?)
	dput (fs/dcache.c:846)
	__fput (fs/file_table.c:431)
	____fput (fs/file_table.c:451)
	task_work_run (kernel/task_work.c:181)
	do_exit (kernel/exit.c:879)
	do_group_exit (kernel/exit.c:1027)
	__pfx___ia32_sys_exit_group (kernel/exit.c:1038)
	x64_sys_call (arch/x86/entry/syscall_64.c:33)
	do_syscall_64 (arch/x86/entry/common.c:?)
	entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)

	read to 0xffffffff847ccfc8 of 4 bytes by task 384 on cpu 31:
	debug_check_no_obj_freed (lib/debugobjects.c:1000 lib/debugobjects.c:1019)
	kfree (mm/slub.c:2081 mm/slub.c:4280 mm/slub.c:4390)
	percpu_ref_exit (lib/percpu-refcount.c:147)
	css_free_rwork_fn (kernel/cgroup/cgroup.c:5357)
	process_scheduled_works (kernel/workqueue.c:3272 kernel/workqueue.c:3348)
	worker_thread (./include/linux/list.h:373
			kernel/workqueue.c:955 kernel/workqueue.c:3430)
	kthread (kernel/kthread.c:389)
	ret_from_fork (arch/x86/kernel/process.c:153)
	ret_from_fork_asm (arch/x86/entry/entry_64.S:257)

	value changed: 0x00000070 -> 0x00000071

Include READ_ONCE()/WRITE_ONCE() annotations on the accesses to
debug_objects_maxchain to prevent potential data corruption, explicitly
indicating that this data is shared across two parallel data paths.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 lib/debugobjects.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fb12a9bacd2f..fbd262aa6b29 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -195,8 +195,8 @@ static struct debug_obj *lookup_object(void *addr, struct debug_bucket *b)
 		if (obj->object == addr)
 			return obj;
 	}
-	if (cnt > debug_objects_maxchain)
-		debug_objects_maxchain = cnt;
+	if (cnt > READ_ONCE(debug_objects_maxchain))
+		WRITE_ONCE(debug_objects_maxchain, cnt);
 
 	return NULL;
 }
@@ -997,8 +997,8 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 		}
 		raw_spin_unlock_irqrestore(&db->lock, flags);
 
-		if (cnt > debug_objects_maxchain)
-			debug_objects_maxchain = cnt;
+		if (cnt > READ_ONCE(debug_objects_maxchain))
+			WRITE_ONCE(debug_objects_maxchain, cnt);
 
 		objs_checked += cnt;
 	}
-- 
2.43.0


