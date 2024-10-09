Return-Path: <linux-kernel+bounces-357717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E689974A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92BEAB2558A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883641E7C13;
	Wed,  9 Oct 2024 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="PotCID+t"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E648D1E9076
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497462; cv=none; b=NzSJH77Noj/fX6BjXxXh6d82azaQlNdiP4PrybKaYWj1sTc5Hxey4D9YRsV31OOcbfBi7EgBj/vQPZdVi7PZPAMM44u83AWg4PEimR79sAgvUV6JOAV3PqMM06/8CJ+NXV1avNMan8DaA6ON5Ug9Ea8/WXsdmULaSkUge0JlUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497462; c=relaxed/simple;
	bh=7e7E6KSEAoZLxHAx6Emp9XwpMIrqyJB0z04i+XPayTQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=B+cXuEj/w3G1GtLWJWfAGOpKwA7AdrixlpjAPWY6Nz9g2BDrdzZF1dTkjR3Q9GstoVzIsNnjyl1y5uNcDczd3kQhHsKPx8TcnH0CenvPz/lO1fJZLZOSUa2pezHqFIfDfxRPvQagfN/SgZF7yaJJ8zZXeRv2Gu4HRE7fQZd2oF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=PotCID+t; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id EF58334009A;
	Wed,  9 Oct 2024 18:10:58 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 6D6BF13C2B0;
	Wed,  9 Oct 2024 11:10:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6D6BF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728497458;
	bh=7e7E6KSEAoZLxHAx6Emp9XwpMIrqyJB0z04i+XPayTQ=;
	h=Date:To:Cc:From:Subject:From;
	b=PotCID+tLuhlOE4Apt0dhUgB0S7sX05vkcUdOywGr+09q3iS0kDZACCNNlbmL/FeX
	 0h58vwnGLJtffzGFav+nWnZ6t+Zex1sSrEvB+k+M5WdTbty3t0zpwZwd3AZ9MgtwyQ
	 bL9YvTrWd+msDyjdafjUH+VNJS29WSdxQTzTZ+rg=
Message-ID: <e945621d-2eff-0621-7508-f39ce3412135@candelatech.com>
Date: Wed, 9 Oct 2024 11:10:58 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>
Cc: boqun.feng@gmail.com
From: Ben Greear <greearb@candelatech.com>
Subject: lockdep: Not able to find what holds lock.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1728497459-lVOqscvv-sVf
X-MDID-O:
 us5;ut7;1728497459;lVOqscvv-sVf;<greearb@candelatech.com>;6c138645f43e3e6cf5dc3e20b8d3b1ed
X-PPE-TRUSTED: V=1;DIR=OUT;

Hello,

I'm debugging a lockup related to wifi, and have some questions on lockdep.

Part of the output looks like this.  From what I can tell, this first kworker
holds rtnl, and is trying to acquire the wiphy.mtx and is blocked there.

Showing all locks held in the system:
4 locks held by kworker/0:1/10:
  #0: ffff888110061548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0xf16/0x1750
  #1: ffff888112bbfd80 (reg_work){+.+.}-{0:0}, at: process_one_work+0x7d6/0x1750
  #2: ffffffff856a2ee8 (rtnl_mutex){+.+.}-{4:4}, at: reg_todo+0x13/0x770 [cfg80211]
  #3: ffff888144150768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: reg_process_self_managed_hints+0x6b/0x180 [cfg80211]
3 locks held by kworker/u32:0/11:
  #0: ffff888110071948 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0xf16/0x1750
  #1: ffff888112bcfd80 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x7d6/0x1750
  #2: ffffffff856a2ee8 (rtnl_mutex){+.+.}-{4:4}, at: linkwatch_event+0x5/0x50
4 locks held by kworker/u32:1/66:
1 lock held by khungtaskd/67:
...

Nothing else in the printout shows any wiphy.mtx held, but there are some processes
skipped, evidently because they are running but not the current task.  Is there any real
harm in adding a patch like this to maybe show what actually holds the lock in question?

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 3468d8230e5f..fc7c1c7e0d8f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -781,6 +781,7 @@ static void print_lock(struct held_lock *hlock)
  static void lockdep_print_held_locks(struct task_struct *p)
  {
         int i, depth = READ_ONCE(p->lockdep_depth);
+       const char* rnc = "";

         if (!depth)
                 printk("no locks held by %s/%d.\n", p->comm, task_pid_nr(p));
@@ -792,9 +793,10 @@ static void lockdep_print_held_locks(struct task_struct *p)
          * and it's not the current task.
          */
         if (p != current && task_is_running(p))
-               return;
+               rnc = " Not reliable: Running-Not-Current: ";
+
         for (i = 0; i < depth; i++) {
-               printk(" #%d: ", i);
+               printk(" %s#%d: ", rnc, i);
                 print_lock(p->held_locks + i);
         }
  }


And, when a process is printing out its 'held' locks, it seems it is also printing out the one
it wants to be holding but is blocked acquiring.  Is there a way to have lockdep print
the process information (preferably including backtrace) for the process that actually
owns the lock currently?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


