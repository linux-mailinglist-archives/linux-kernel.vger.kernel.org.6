Return-Path: <linux-kernel+bounces-540024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7981CA4AC92
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 16:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3061E189476C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4F51E261F;
	Sat,  1 Mar 2025 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqgGu0t/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773C91DE8A2
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740843234; cv=none; b=RkYrQOSFBICrkkLfBLqa0T8LQHGESpdAzsIV6ZBrc6EB7tpbTSYK0DqSkNa03T7yLKF7hsX3vUhHYWAypCiwMOWVdjSh5dLfez5oTLfwfkX3mdXBQ4Kv4jU+PzsLEvG80f/TElnMKZcWIggZcCGeFVzDsoZpknK/7WII//vsfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740843234; c=relaxed/simple;
	bh=EsmjMzGpSxgt+NlHjTE5WglbpyDbwvkjJBEmg3iN2Dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+rO4fdstBA9TgW0dn4hE6/pFzk4sPFmFY2blZViVe/KDTdtBJbNyGJg/H+RUJJZzi9QjalPj7E23uxuRkLi/mLNw3nYvnGlc0nw9WYSbVXlTpZxALgZ5AjfBmBtSCf74sp7BTeM7ptv+eWKCcKLEna35Lg3aPOU8r1QEYelpho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqgGu0t/; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740843233; x=1772379233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EsmjMzGpSxgt+NlHjTE5WglbpyDbwvkjJBEmg3iN2Dc=;
  b=UqgGu0t/H0MWjLSNKy4SN8xIiQKkQ/njYAtHAxG7pS5wc8LSEuS0ZDry
   0u52zo0AJMnVc4XykuJzxkjRMPXQiubQ0JxLlUlAHwte/hcoWS6ps7TMJ
   CyWRSC6ZkHVyJBGDU8W9ZSwEhpwRvZ1ddgNYcRZR35nrdvUhqapSGOwdo
   5VmQ8nyntWoxyC+sXIC9PAs7tMrmWoYDgSzIwc1JgJtAjzTpcw5utQiEa
   mJBHBbLpw+BeKbMq9yBI2ITm0Di4wnm4253yR5fyjrDM2b2w1EX821MIm
   X35HNmkwe5AzIWhm8ABrVjcrFiEdUJQFRTmhJA3XVIDDYnJM0IKaHtKvz
   w==;
X-CSE-ConnectionGUID: bo+N23dgTFqQ85zO/8wiDA==
X-CSE-MsgGUID: QoTvO6nHQrSbnPdIFnHzrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="40999775"
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="40999775"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2025 07:33:52 -0800
X-CSE-ConnectionGUID: hPIjqxm4Qnu+r1y8roqm3Q==
X-CSE-MsgGUID: waxqjX+8QFuOCRxrSQPldQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,325,1732608000"; 
   d="scan'208";a="148405680"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 01 Mar 2025 07:33:47 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1toOqW-000GNm-2Z;
	Sat, 01 Mar 2025 15:33:44 +0000
Date: Sat, 1 Mar 2025 23:33:06 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com, pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, qyousef@layalina.io,
	hongyan.xia2@arm.com, christian.loehle@arm.com,
	luis.machado@arm.com, qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 5/7 v3] sched/fair: Add push task mechanism for EAS
Message-ID: <202503012314.oQzjTBLS-lkp@intel.com>
References: <20250228134000.1226665-6-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228134000.1226665-6-vincent.guittot@linaro.org>

Hi Vincent,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on peterz-queue/sched/core linus/master v6.14-rc4 next-20250228]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Guittot/sched-fair-Filter-false-overloaded_group-case-for-EAS/20250228-214408
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20250228134000.1226665-6-vincent.guittot%40linaro.org
patch subject: [PATCH 5/7 v3] sched/fair: Add push task mechanism for EAS
config: arc-randconfig-002-20250301 (https://download.01.org/0day-ci/archive/20250301/202503012314.oQzjTBLS-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250301/202503012314.oQzjTBLS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503012314.oQzjTBLS-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> kernel/sched/fair.c:8957:13: error: conflicting types for 'fair_remove_pushable_task'; have 'void(struct cfs_rq *, struct task_struct *)'
    8957 | static void fair_remove_pushable_task(struct cfs_rq *cfs_rq, struct task_struct *p) {}
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:7054:13: note: previous declaration of 'fair_remove_pushable_task' with type 'void(struct rq *, struct task_struct *)'
    7054 | static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c: In function 'pick_next_task_fair':
>> kernel/sched/fair.c:9152:40: error: passing argument 1 of 'fair_add_pushable_task' from incompatible pointer type [-Werror=incompatible-pointer-types]
    9152 |                 fair_add_pushable_task(rq, prev);
         |                                        ^~
         |                                        |
         |                                        struct rq *
   kernel/sched/fair.c:8958:58: note: expected 'struct cfs_rq *' but argument is of type 'struct rq *'
    8958 | static inline void fair_add_pushable_task(struct cfs_rq *cfs_rq, struct task_struct *p) {}
         |                                           ~~~~~~~~~~~~~~~^~~~~~
   kernel/sched/fair.c: In function 'put_prev_task_fair':
   kernel/sched/fair.c:9231:32: error: passing argument 1 of 'fair_add_pushable_task' from incompatible pointer type [-Werror=incompatible-pointer-types]
    9231 |         fair_add_pushable_task(rq, prev);
         |                                ^~
         |                                |
         |                                struct rq *
   kernel/sched/fair.c:8958:58: note: expected 'struct cfs_rq *' but argument is of type 'struct rq *'
    8958 | static inline void fair_add_pushable_task(struct cfs_rq *cfs_rq, struct task_struct *p) {}
         |                                           ~~~~~~~~~~~~~~~^~~~~~
   kernel/sched/fair.c: In function '__set_next_task_fair':
>> kernel/sched/fair.c:13518:35: error: passing argument 1 of 'fair_remove_pushable_task' from incompatible pointer type [-Werror=incompatible-pointer-types]
   13518 |         fair_remove_pushable_task(rq, p);
         |                                   ^~
         |                                   |
         |                                   struct rq *
   kernel/sched/fair.c:8957:54: note: expected 'struct cfs_rq *' but argument is of type 'struct rq *'
    8957 | static void fair_remove_pushable_task(struct cfs_rq *cfs_rq, struct task_struct *p) {}
         |                                       ~~~~~~~~~~~~~~~^~~~~~
   kernel/sched/fair.c: At top level:
>> kernel/sched/fair.c:7054:13: warning: 'fair_remove_pushable_task' used but never defined
    7054 | static void fair_remove_pushable_task(struct rq *rq, struct task_struct *p);
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +8957 kernel/sched/fair.c

  8945	
  8946	static int
  8947	balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  8948	{
  8949		if (sched_fair_runnable(rq))
  8950			return 1;
  8951	
  8952		return sched_balance_newidle(rq, rf) != 0;
  8953	}
  8954	#else
  8955	static inline void check_pushable_task(struct task_struct *p, struct rq *rq) {}
  8956	static inline void fair_queue_pushable_tasks(struct rq *rq) {}
> 8957	static void fair_remove_pushable_task(struct cfs_rq *cfs_rq, struct task_struct *p) {}
  8958	static inline void fair_add_pushable_task(struct cfs_rq *cfs_rq, struct task_struct *p) {}
  8959	static inline void set_task_max_allowed_capacity(struct task_struct *p) {}
  8960	#endif /* CONFIG_SMP */
  8961	
  8962	static void set_next_buddy(struct sched_entity *se)
  8963	{
  8964		for_each_sched_entity(se) {
  8965			if (SCHED_WARN_ON(!se->on_rq))
  8966				return;
  8967			if (se_is_idle(se))
  8968				return;
  8969			cfs_rq_of(se)->next = se;
  8970		}
  8971	}
  8972	
  8973	/*
  8974	 * Preempt the current task with a newly woken task if needed:
  8975	 */
  8976	static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int wake_flags)
  8977	{
  8978		struct task_struct *donor = rq->donor;
  8979		struct sched_entity *se = &donor->se, *pse = &p->se;
  8980		struct cfs_rq *cfs_rq = task_cfs_rq(donor);
  8981		int cse_is_idle, pse_is_idle;
  8982	
  8983		if (unlikely(se == pse))
  8984			return;
  8985	
  8986		/*
  8987		 * This is possible from callers such as attach_tasks(), in which we
  8988		 * unconditionally wakeup_preempt() after an enqueue (which may have
  8989		 * lead to a throttle).  This both saves work and prevents false
  8990		 * next-buddy nomination below.
  8991		 */
  8992		if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
  8993			return;
  8994	
  8995		if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
  8996			set_next_buddy(pse);
  8997		}
  8998	
  8999		/*
  9000		 * We can come here with TIF_NEED_RESCHED already set from new task
  9001		 * wake up path.
  9002		 *
  9003		 * Note: this also catches the edge-case of curr being in a throttled
  9004		 * group (e.g. via set_curr_task), since update_curr() (in the
  9005		 * enqueue of curr) will have resulted in resched being set.  This
  9006		 * prevents us from potentially nominating it as a false LAST_BUDDY
  9007		 * below.
  9008		 */
  9009		if (test_tsk_need_resched(rq->curr))
  9010			return;
  9011	
  9012		if (!sched_feat(WAKEUP_PREEMPTION))
  9013			return;
  9014	
  9015		find_matching_se(&se, &pse);
  9016		WARN_ON_ONCE(!pse);
  9017	
  9018		cse_is_idle = se_is_idle(se);
  9019		pse_is_idle = se_is_idle(pse);
  9020	
  9021		/*
  9022		 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
  9023		 * in the inverse case).
  9024		 */
  9025		if (cse_is_idle && !pse_is_idle) {
  9026			/*
  9027			 * When non-idle entity preempt an idle entity,
  9028			 * don't give idle entity slice protection.
  9029			 */
  9030			cancel_protect_slice(se);
  9031			goto preempt;
  9032		}
  9033	
  9034		if (cse_is_idle != pse_is_idle)
  9035			return;
  9036	
  9037		/*
  9038		 * BATCH and IDLE tasks do not preempt others.
  9039		 */
  9040		if (unlikely(!normal_policy(p->policy)))
  9041			return;
  9042	
  9043		cfs_rq = cfs_rq_of(se);
  9044		update_curr(cfs_rq);
  9045		/*
  9046		 * If @p has a shorter slice than current and @p is eligible, override
  9047		 * current's slice protection in order to allow preemption.
  9048		 *
  9049		 * Note that even if @p does not turn out to be the most eligible
  9050		 * task at this moment, current's slice protection will be lost.
  9051		 */
  9052		if (do_preempt_short(cfs_rq, pse, se))
  9053			cancel_protect_slice(se);
  9054	
  9055		/*
  9056		 * If @p has become the most eligible task, force preemption.
  9057		 */
  9058		if (pick_eevdf(cfs_rq) == pse)
  9059			goto preempt;
  9060	
  9061		return;
  9062	
  9063	preempt:
  9064		resched_curr_lazy(rq);
  9065	}
  9066	
  9067	static struct task_struct *pick_task_fair(struct rq *rq)
  9068	{
  9069		struct sched_entity *se;
  9070		struct cfs_rq *cfs_rq;
  9071	
  9072	again:
  9073		cfs_rq = &rq->cfs;
  9074		if (!cfs_rq->nr_queued)
  9075			return NULL;
  9076	
  9077		do {
  9078			/* Might not have done put_prev_entity() */
  9079			if (cfs_rq->curr && cfs_rq->curr->on_rq)
  9080				update_curr(cfs_rq);
  9081	
  9082			if (unlikely(check_cfs_rq_runtime(cfs_rq)))
  9083				goto again;
  9084	
  9085			se = pick_next_entity(rq, cfs_rq);
  9086			if (!se)
  9087				goto again;
  9088			cfs_rq = group_cfs_rq(se);
  9089		} while (cfs_rq);
  9090	
  9091		return task_of(se);
  9092	}
  9093	
  9094	static void __set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
  9095	static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first);
  9096	
  9097	struct task_struct *
  9098	pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  9099	{
  9100		struct sched_entity *se;
  9101		struct task_struct *p;
  9102		int new_tasks;
  9103	
  9104	again:
  9105		p = pick_task_fair(rq);
  9106		if (!p)
  9107			goto idle;
  9108		se = &p->se;
  9109	
  9110	#ifdef CONFIG_FAIR_GROUP_SCHED
  9111		if (prev->sched_class != &fair_sched_class)
  9112			goto simple;
  9113	
  9114		__put_prev_set_next_dl_server(rq, prev, p);
  9115	
  9116		/*
  9117		 * Because of the set_next_buddy() in dequeue_task_fair() it is rather
  9118		 * likely that a next task is from the same cgroup as the current.
  9119		 *
  9120		 * Therefore attempt to avoid putting and setting the entire cgroup
  9121		 * hierarchy, only change the part that actually changes.
  9122		 *
  9123		 * Since we haven't yet done put_prev_entity and if the selected task
  9124		 * is a different task than we started out with, try and touch the
  9125		 * least amount of cfs_rqs.
  9126		 */
  9127		if (prev != p) {
  9128			struct sched_entity *pse = &prev->se;
  9129			struct cfs_rq *cfs_rq;
  9130	
  9131			while (!(cfs_rq = is_same_group(se, pse))) {
  9132				int se_depth = se->depth;
  9133				int pse_depth = pse->depth;
  9134	
  9135				if (se_depth <= pse_depth) {
  9136					put_prev_entity(cfs_rq_of(pse), pse);
  9137					pse = parent_entity(pse);
  9138				}
  9139				if (se_depth >= pse_depth) {
  9140					set_next_entity(cfs_rq_of(se), se);
  9141					se = parent_entity(se);
  9142				}
  9143			}
  9144	
  9145			put_prev_entity(cfs_rq, pse);
  9146			set_next_entity(cfs_rq, se);
  9147	
  9148			/*
  9149			 * The previous task might be eligible for being pushed on
  9150			 * another cpu if it is still active.
  9151			 */
> 9152			fair_add_pushable_task(rq, prev);
  9153	
  9154			__set_next_task_fair(rq, p, true);
  9155		}
  9156	
  9157		return p;
  9158	
  9159	simple:
  9160	#endif
  9161		put_prev_set_next_task(rq, prev, p);
  9162		return p;
  9163	
  9164	idle:
  9165		if (!rf)
  9166			return NULL;
  9167	
  9168		new_tasks = sched_balance_newidle(rq, rf);
  9169	
  9170		/*
  9171		 * Because sched_balance_newidle() releases (and re-acquires) rq->lock, it is
  9172		 * possible for any higher priority task to appear. In that case we
  9173		 * must re-start the pick_next_entity() loop.
  9174		 */
  9175		if (new_tasks < 0)
  9176			return RETRY_TASK;
  9177	
  9178		if (new_tasks > 0)
  9179			goto again;
  9180	
  9181		/*
  9182		 * rq is about to be idle, check if we need to update the
  9183		 * lost_idle_time of clock_pelt
  9184		 */
  9185		update_idle_rq_clock_pelt(rq);
  9186	
  9187		return NULL;
  9188	}
  9189	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

