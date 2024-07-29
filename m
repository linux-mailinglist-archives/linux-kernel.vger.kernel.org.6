Return-Path: <linux-kernel+bounces-266149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CBB93FBAF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 18:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAB6284A6F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CAE186E40;
	Mon, 29 Jul 2024 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ov+Nd+CA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20939186E27
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 16:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271437; cv=none; b=fwsVrwAX2P/Wj08zI33ZR+apPw4hQhJ4DH9M4uixxEq3Eqm2mg9Z5jKIOTyzI1JDrI0EGRnVK9HeusD6wOWbIYFBWXZxWDj3WxAngkPH5hOrZt7Ff3d5PH+JXV6TweKvF7yaC65LexfeP2mU7UI5Y4iBQqItwfw6fEfHNdhJ3Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271437; c=relaxed/simple;
	bh=3RnVbJ7Xp2mSnHzWgy1Sv+7m9uJ+ThcVDNDbMpd2XDI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UvNVHja47vVYE5cfiQ8HWpS93MmK37PEmfU3ciS4k7B+snvLPi861fbeW6PtBAq27gO0l9wriUF0pigYzWAhkEHN0/Qh6ifJ2XR7hJVSksUXkSK+aZOdLa07SsHb+6QWqFY+uax07WfyX/qfrz9T0bWT80uNWYTsvmah/oe1HEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ov+Nd+CA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722271436; x=1753807436;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3RnVbJ7Xp2mSnHzWgy1Sv+7m9uJ+ThcVDNDbMpd2XDI=;
  b=Ov+Nd+CAlPtUgwR9EZIXXNHrXdgMOjrNiiXSrK8VSw50nl5AUGc4Tbcm
   qVVZ2lA/Pnmkxs4L/T9pSp0XiG2welhns2kBKN2uWEJBUQh+F+IYehRb9
   YhQSPEv2PY7281TEZXd7LYMaRA0FcZgXXAL69GP3+eANt/m2AyAaBn5J2
   XdQgVjYJfUk2+5PWeCjVYiFFY/KnWl7/C2tKkwigDQmK87vGSKWmH57C4
   clB/6jF5UtGUDALGlI7IpbTz0o+B2AyaryYYT1gW+gjtWIylcN/6/MAGs
   KhymUYHUDnZCtiJ3TXOcYKS1HNmtXmvgZ+2JHQCO+Lk2JnH3fP0G8YkUn
   w==;
X-CSE-ConnectionGUID: oCxaEmFoTteuABUf0ssY4w==
X-CSE-MsgGUID: 1VLdUO42QJiguNhVr8FOvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="20194785"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="20194785"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 09:43:56 -0700
X-CSE-ConnectionGUID: dxCHd/mpT3CxmobZmpYZCA==
X-CSE-MsgGUID: 76bPsDBrRQu8xUlSRQPoLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54004480"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 29 Jul 2024 09:43:54 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sYTTT-000rre-1o;
	Mon, 29 Jul 2024 16:43:51 +0000
Date: Tue, 30 Jul 2024 00:43:00 +0800
From: kernel test robot <lkp@intel.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:dev.2024.07.25a 15/43] kernel/rcu/rcuscale.c:1021:2:
 error: use of undeclared identifier 'writer_done'
Message-ID: <202407300009.05X7YXZC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2024.07.25a
head:   24e3bccdf4bc0ae57b0e89e0313fd4450fde12af
commit: 54ff7b22b9062495092737217877be2bdd3dabd4 [15/43] rcuscale: Save a few lines with whitespace-only change
config: x86_64-randconfig-071-20240728 (https://download.01.org/0day-ci/archive/20240730/202407300009.05X7YXZC-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407300009.05X7YXZC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407300009.05X7YXZC-lkp@intel.com/

Note: the paulmck-rcu/dev.2024.07.25a HEAD 24e3bccdf4bc0ae57b0e89e0313fd4450fde12af builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> kernel/rcu/rcuscale.c:1021:2: error: use of undeclared identifier 'writer_done'
    1021 |         writer_done = kcalloc(nrealwriters, sizeof(writer_done[0]), GFP_KERNEL);
         |         ^
   kernel/rcu/rcuscale.c:1021:45: error: use of undeclared identifier 'writer_done'
    1021 |         writer_done = kcalloc(nrealwriters, sizeof(writer_done[0]), GFP_KERNEL);
         |                                                    ^
   kernel/rcu/rcuscale.c:1021:45: error: use of undeclared identifier 'writer_done'
   kernel/rcu/rcuscale.c:1022:68: error: use of undeclared identifier 'writer_done'
    1022 |         if (!writer_tasks || !writer_durations || !writer_n_durations || !writer_done) {
         |                                                                           ^
   4 errors generated.


vim +/writer_done +1021 kernel/rcu/rcuscale.c

   946	
   947	static int __init
   948	rcu_scale_init(void)
   949	{
   950		long i;
   951		int firsterr = 0;
   952		static struct rcu_scale_ops *scale_ops[] = {
   953			&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
   954		};
   955	
   956		if (!torture_init_begin(scale_type, verbose))
   957			return -EBUSY;
   958	
   959		/* Process args and announce that the scalability'er is on the job. */
   960		for (i = 0; i < ARRAY_SIZE(scale_ops); i++) {
   961			cur_ops = scale_ops[i];
   962			if (strcmp(scale_type, cur_ops->name) == 0)
   963				break;
   964		}
   965		if (i == ARRAY_SIZE(scale_ops)) {
   966			pr_alert("rcu-scale: invalid scale type: \"%s\"\n", scale_type);
   967			pr_alert("rcu-scale types:");
   968			for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
   969				pr_cont(" %s", scale_ops[i]->name);
   970			pr_cont("\n");
   971			firsterr = -EINVAL;
   972			cur_ops = NULL;
   973			goto unwind;
   974		}
   975		if (cur_ops->init)
   976			cur_ops->init();
   977	
   978		if (cur_ops->rso_gp_kthread) {
   979			kthread_tp = cur_ops->rso_gp_kthread();
   980			if (kthread_tp)
   981				kthread_stime = kthread_tp->stime;
   982		}
   983		if (kfree_rcu_test)
   984			return kfree_scale_init();
   985	
   986		nrealwriters = compute_real(nwriters);
   987		nrealreaders = compute_real(nreaders);
   988		atomic_set(&n_rcu_scale_reader_started, 0);
   989		atomic_set(&n_rcu_scale_writer_started, 0);
   990		atomic_set(&n_rcu_scale_writer_finished, 0);
   991		rcu_scale_print_module_parms(cur_ops, "Start of test");
   992	
   993		/* Start up the kthreads. */
   994	
   995		if (shutdown) {
   996			init_waitqueue_head(&shutdown_wq);
   997			firsterr = torture_create_kthread(rcu_scale_shutdown, NULL,
   998							  shutdown_task);
   999			if (torture_init_error(firsterr))
  1000				goto unwind;
  1001			schedule_timeout_uninterruptible(1);
  1002		}
  1003		reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
  1004				       GFP_KERNEL);
  1005		if (reader_tasks == NULL) {
  1006			SCALEOUT_ERRSTRING("out of memory");
  1007			firsterr = -ENOMEM;
  1008			goto unwind;
  1009		}
  1010		for (i = 0; i < nrealreaders; i++) {
  1011			firsterr = torture_create_kthread(rcu_scale_reader, (void *)i,
  1012							  reader_tasks[i]);
  1013			if (torture_init_error(firsterr))
  1014				goto unwind;
  1015		}
  1016		while (atomic_read(&n_rcu_scale_reader_started) < nrealreaders)
  1017			schedule_timeout_uninterruptible(1);
  1018		writer_tasks = kcalloc(nrealwriters, sizeof(writer_tasks[0]), GFP_KERNEL);
  1019		writer_durations = kcalloc(nrealwriters, sizeof(*writer_durations), GFP_KERNEL);
  1020		writer_n_durations = kcalloc(nrealwriters, sizeof(*writer_n_durations), GFP_KERNEL);
> 1021		writer_done = kcalloc(nrealwriters, sizeof(writer_done[0]), GFP_KERNEL);
  1022		if (!writer_tasks || !writer_durations || !writer_n_durations || !writer_done) {
  1023			SCALEOUT_ERRSTRING("out of memory");
  1024			firsterr = -ENOMEM;
  1025			goto unwind;
  1026		}
  1027		for (i = 0; i < nrealwriters; i++) {
  1028			writer_durations[i] =
  1029				kcalloc(MAX_MEAS, sizeof(*writer_durations[i]),
  1030					GFP_KERNEL);
  1031			if (!writer_durations[i]) {
  1032				firsterr = -ENOMEM;
  1033				goto unwind;
  1034			}
  1035			firsterr = torture_create_kthread(rcu_scale_writer, (void *)i,
  1036							  writer_tasks[i]);
  1037			if (torture_init_error(firsterr))
  1038				goto unwind;
  1039		}
  1040		torture_init_end();
  1041		return 0;
  1042	
  1043	unwind:
  1044		torture_init_end();
  1045		rcu_scale_cleanup();
  1046		if (shutdown) {
  1047			WARN_ON(!IS_MODULE(CONFIG_RCU_SCALE_TEST));
  1048			kernel_power_off();
  1049		}
  1050		return firsterr;
  1051	}
  1052	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

