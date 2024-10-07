Return-Path: <linux-kernel+bounces-353115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F6E9928CF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:08:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5233285D89
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94A418BBAD;
	Mon,  7 Oct 2024 10:08:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9291E18B49E
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728295723; cv=none; b=n5KGRxMSSi2F89Us8ETTs3Jset9Ps22xLQpzrTai4uTZOmDF4ZsyyXfjTpfjsIIEHNea4pHZ334lNhHs9KQrM52hbSvyueZnQnMx93cFUr1Wde2JQTCB5TeC3jfDKT6P+OEhQYuDe/m6l7CcicBsvg1MG5jjTClkxrhrQHK6h+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728295723; c=relaxed/simple;
	bh=0iKbGcK8Gu21dj7bTG5zPF2A6di+vap8fzuuwKIifK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZakKUcICw4ZSA1DG5gb9fZ8SAto+rBecUucicJjacZtxN7PQ16Y1ViQSHtus8aYhWNxfudPdaqcXj9T27GrDUb2LjK91qhW6a/4QTUBgbXoaNvGoTMK4StF+/JkX6lpYPzDl7GM+dqiZnvBmUM+jV0lY/9DLag1un8bbUT/1J5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 542A9FEC;
	Mon,  7 Oct 2024 03:09:08 -0700 (PDT)
Received: from [10.1.26.21] (unknown [10.1.26.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9EF03F64C;
	Mon,  7 Oct 2024 03:08:37 -0700 (PDT)
Message-ID: <7d19367b-a4ac-4c65-a543-9a4d614bec44@arm.com>
Date: Mon, 7 Oct 2024 11:08:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel/sched/core.c:1361:21: warning: 'uclamp_mutex' defined but
 not used
To: kernel test robot <lkp@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <202410060258.bPl2ZoUo-lkp@intel.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <202410060258.bPl2ZoUo-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/5/24 19:58, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   27cc6fdf720183dce1dbd293483ec5a9cb6b595e
> commit: d2d6422f8bd17c6bb205133e290625a564194496 x86: Allow to enable PREEMPT_RT.
> date:   3 weeks ago
> config: x86_64-buildonly-randconfig-002-20241006 (https://download.01.org/0day-ci/archive/20241006/202410060258.bPl2ZoUo-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241006/202410060258.bPl2ZoUo-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410060258.bPl2ZoUo-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/seqlock.h:19,
>                     from include/linux/dcache.h:11,
>                     from include/linux/fs.h:8,
>                     from include/linux/highmem.h:5,
>                     from kernel/sched/core.c:10:
>>> kernel/sched/core.c:1361:21: warning: 'uclamp_mutex' defined but not used [-Wunused-variable]
>     1361 | static DEFINE_MUTEX(uclamp_mutex);
>          |                     ^~~~~~~~~~~~
>    include/linux/mutex.h:101:22: note: in definition of macro 'DEFINE_MUTEX'
>      101 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
>          |                      ^~~~~~~~~
> 
> 
> vim +/uclamp_mutex +1361 kernel/sched/core.c
> 
> 71f8bd4600521f kernel/sched.c      Ingo Molnar     2007-07-09  1349  
> 69842cba9ace84 kernel/sched/core.c Patrick Bellasi 2019-06-21  1350  #ifdef CONFIG_UCLAMP_TASK
> 2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1351  /*
> 2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1352   * Serializes updates of utilization clamp values
> 2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1353   *
> 2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1354   * The (slow-path) user-space triggers utilization clamp value updates which
> 2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1355   * can require updates on (fast-path) scheduler's data structures used to
> 2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1356   * support enqueue/dequeue operations.
> 2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1357   * While the per-CPU rq lock protects fast-path update operations, user-space
> 2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1358   * requests are serialized using a mutex to reduce the risk of conflicting
> 2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1359   * updates or API abuses.
> 2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1360   */
> 2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22 @1361  static DEFINE_MUTEX(uclamp_mutex);
> 2480c093130f64 kernel/sched/core.c Patrick Bellasi 2019-08-22  1362  
> 
> :::::: The code at line 1361 was first introduced by commit
> :::::: 2480c093130f64ac3a410504fa8b3db1fc4b87ce sched/uclamp: Extend CPU's cgroup controller
> 
> :::::: TO: Patrick Bellasi <patrick.bellasi@arm.com>
> :::::: CC: Ingo Molnar <mingo@kernel.org>
> 

Please allow me a day to walk through the code just to double-check, but
the obvious fixes are either letting UCLAMP_TASK depend on SYSCTL or:

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453ab7e20..18d9622eac8d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1394,7 +1394,9 @@ void set_load_weight(struct task_struct *p, bool update_load)
  * requests are serialized using a mutex to reduce the risk of conflicting
  * updates or API abuses.
  */
+#if defined(CONFIG_UCLAMP_TASK_GROUP) || defined(CONFIG_SYSCTL)
 static DEFINE_MUTEX(uclamp_mutex);
+#endif
 
 /* Max allowed minimum utilization */
 static unsigned int __maybe_unused sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;



