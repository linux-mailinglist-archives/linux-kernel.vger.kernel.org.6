Return-Path: <linux-kernel+bounces-263957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E797493DD26
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 05:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8951C2356E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 03:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8112C4A15;
	Sat, 27 Jul 2024 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Drjj4RLL"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241154688
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722052028; cv=none; b=WgqxhuTEHCloturRf7NgpPei8beIeWxi7k5NJZcoo5QSHskGlJRArIHlwkDIhoMW+ALPhTBtp27fbyS7jXS6Xh9ePD3Tniv2LZYFuLeF+aX+LJQc3H3kXfSGbfG3o+bietFuL/yUuamBKJXUZePGR2ChwLzYX51yOZOEMeVxoos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722052028; c=relaxed/simple;
	bh=jqfPqtNrdaF/ZNPy73R69QrgWFH2f23wPfxQBz0Ybow=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=j9jw2/lntELA7mBnqhNrTIVKqAdsKoQmThkYgfuoUlPHR1q6jkWu4N9gvW4iNeOYnQ4rnz9JJ6EnU6OpKX6l4KznA2XzkYrv8kX4STp7Bt3lLJZNIl8psFlQVSzzvhT0woknO3brFpRsNzPZr+OcSnkp/ZLdgM4yoYJdDBSoJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Drjj4RLL; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722052022; bh=4kw4FEjK/LFE9ABNC4tf2hdkrKwnOkwYBNAouFRPs18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Drjj4RLLjZBOMwzmTwfl9ICbr6NiWSVDBlHjur5WIauS0a0t7zcowGoQ5xNNgjVNM
	 L3Dk/ziccFphTHmh0SNkxXJC70xK8VW545R/lranuAMAoUmDqy8AcQ0N7prJmq3Qk7
	 QB7ksAsyIbWQ8A7vOwzPESCA2rZWOMEIrWI6b/8A=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 9B3AAC6B; Sat, 27 Jul 2024 11:38:51 +0800
X-QQ-mid: xmsmtpt1722051531tq2sa4lvi
Message-ID: <tencent_42384B7F1B3425E4BA97BB4133B29E341B08@qq.com>
X-QQ-XMAILINFO: NaP/9vkEGeDXotafcCvUxv3o3u3zsAZC/CiXoThYtHM052hC47WOV4fGETt0Jb
	 aKVrkIu4zyqjKlFS6ySSnhOGQA9cKfLf/8qleWNOxBbAJ2FamAWerSRyjFrN+RZDl96oyPP6yb4F
	 iy6/GShF1autOzJmQAYPRP6vv+nSaiQ1EHtcQHZ4nnk9Rq3Ulol+l/rVPWMPUxwrpw9B1ROjPMQc
	 OHhNTHFss86I7UmOykCoBHYQEIZdRCaypnH1HEtzlOiLypQcaesCWBWBap7Cf5hED93mSjaSePF2
	 5mCCnp3d12ltb4oy5YwKajeoTF5UOzDLOZA/Oj/aJjaccWHVe3vOfPMOZHbOHdYMNuaw13ZWLNab
	 UhTMz5K1ilpz79Q8gWPMtykA52cYLg+LUHpaiXSN+5ZhYng9mpFZ26ExjAiREROit4pB8HaxSWyc
	 ucoUI+uxur/bqAP6JKf4sjJlMpgEmebw4rr5KOYp2wzWOwnCB03gaxkD/qbZjc3MYSMYXqPCWhWD
	 EZ48F2rIQU5Yl7akzAhIBK+K8ygW/ng9oejLeURmpo4nMDMMOMSJoyki3SwtaVlXZVhVccPfXeF8
	 SskiMpIiCRt96e0Ia8qlj0lDNUcMv8eBBcaF3BzzDvg5AlNXOxIeqjZiu25tNjxUr5jLwnQvh7NX
	 qpGxjpd30WGlhJsE80v1AiA2DruBPg3xNC+36sTQcH7vvmIuV9c+TMkdRtdcD/3KKmZx6CLebbGI
	 rPyRnz7+sPIvdRdIpqDjpgLMx6aAi6x6pOmVU83A33kXPLMwgDGQ5Lvw99p+/6NYvIR/LvJ7rEfx
	 m6DNlLleg3q/zkrwzcx0MwK/dnN+kHeaprHLWxe0K4DgYlXEOyAaoSE9FTBLhbmzA9TJBs+HKDu3
	 EujVSAgF1SzdpdSEEY7SNOGQ3ijQ6Bx4tqC9tRGhZbslmDs3+KstpwCKy8NoDy5GiAWcRtjQ4Q
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1a8e2b31f2ac9bd3d148@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [f2fs?] KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
Date: Sat, 27 Jul 2024 11:38:52 +0800
X-OQ-MSGID: <20240727033851.2570282-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000005c7ccb061e032b9b@google.com>
References: <0000000000005c7ccb061e032b9b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add mutex sync remount and shutdown

#syz test: upstream 2c9b3512402e

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 6066c6eecf41..a624e8271fbc 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -27,6 +27,7 @@ static struct kmem_cache *victim_entry_slab;
 
 static unsigned int count_bits(const unsigned long *addr,
 				unsigned int offset, unsigned int len);
+static DEFINE_MUTEX(gc_lock);
 
 static int gc_thread_func(void *data)
 {
@@ -203,10 +204,13 @@ int f2fs_start_gc_thread(struct f2fs_sb_info *sbi)
 
 void f2fs_stop_gc_thread(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_gc_kthread *gc_th = sbi->gc_thread;
+	struct f2fs_gc_kthread *gc_th;
 
-	if (!gc_th)
+	guard(mutex)(&gc_lock);
+	gc_th = sbi->gc_thread;
+	if (!gc_th || gc_th->f2fs_gc_task < PAGE_OFFSET)
 		return;
+
 	kthread_stop(gc_th->f2fs_gc_task);
 	wake_up_all(&gc_th->fggc_wq);
 	kfree(gc_th);


