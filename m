Return-Path: <linux-kernel+bounces-335933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D1D97ECD9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EB6F1C21404
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E805019CC36;
	Mon, 23 Sep 2024 14:10:10 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F21B745F4
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727100610; cv=none; b=fqrNoQYJs638ivvlGla4Sm5TfxjbUwR/Xb+MU2r7bDDHMuWu1KLbcabfO6whbaVsw4sMEpbHcTVLj17f3eNY1vpah46frPkC2H4XItIER0kqsUcaYnU8sY2lOE/oPMoESv9dsNk/c479iFcRdVSo55kcLPyjWxAS0K9l+3g8KcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727100610; c=relaxed/simple;
	bh=4vxE9g9Xu+6JTwSgT8PG0zHujevxi2qE/ZYkoWGNd4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Khal/azjhn0a6+1s4wCtedVaFoCrYVYT9YVKioyfvdGCNsd4h2tDZyrkF2m82Ffuqrg1Yg4w1xkI7aslfr1ODwtCMXNDvQFpA5v1m2+L2Vj9msJGCOFDskZOrqoE1TamSvmJmyLLbYjlyFd5lzVWA1ZJU7KAwzDVIDdgnvy+qCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XC4Xm2pKvz1HJp8;
	Mon, 23 Sep 2024 22:06:16 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id D36B61A0188;
	Mon, 23 Sep 2024 22:10:04 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 23 Sep 2024 22:10:04 +0800
Message-ID: <a2548f24-b68d-d7ce-3826-6fa1a19bf70b@huawei.com>
Date: Mon, 23 Sep 2024 22:10:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: kernel/sched/ext.c:3701:16: error: 'struct task_group' has no
 member named 'idle'
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, Tejun Heo <tj@kernel.org>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>, David
 Vernet <dvernet@meta.com>, Xie XiuQi <xiexiuqi@huawei.com>
References: <202409220859.UiCAoFOW-lkp@intel.com>
From: Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <202409220859.UiCAoFOW-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500003.china.huawei.com (7.185.36.200)

Hi,

On 2024/9/22 9:02, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   88264981f2082248e892a706b2c5004650faac54
> commit: 8195136669661fdfe54e9a8923c33b31c92fc1da sched_ext: Add cgroup support
> date:   2 weeks ago
> config: sparc-randconfig-002-20240922 (https://download.01.org/0day-ci/archive/20240922/202409220859.UiCAoFOW-lkp@intel.com/config)
> compiler: sparc-linux-gcc (GCC) 14.1.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240922/202409220859.UiCAoFOW-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202409220859.UiCAoFOW-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/sched/build_policy.c:63:
>    kernel/sched/ext.c: In function 'scx_cgroup_warn_missing_idle':
>>> kernel/sched/ext.c:3701:16: error: 'struct task_group' has no member named 'idle'
>     3701 |         if (!tg->idle)
>          |                ^~
>    kernel/sched/ext.c: In function 'scx_ops_disable_workfn':
>    kernel/sched/ext.c:4455:17: error: implicit declaration of function 'stack_trace_print'; did you mean 'event_trace_printk'? [-Wimplicit-function-declaration]
>     4455 |                 stack_trace_print(ei->bt, ei->bt_len, 2);
>          |                 ^~~~~~~~~~~~~~~~~
>          |                 event_trace_printk
>    kernel/sched/ext.c: In function 'scx_ops_exit_kind':
>    kernel/sched/ext.c:4834:30: error: implicit declaration of function 'stack_trace_save'; did you mean 'stack_tracer_enable'? [-Wimplicit-function-declaration]
>     4834 |                 ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);
>          |                              ^~~~~~~~~~~~~~~~
>          |                              stack_tracer_enable
> --
>    kernel/sched/core.c: In function 'cpu_idle_read_s64':
>>> kernel/sched/core.c:9626:27: error: 'struct task_group' has no member named 'idle'
>     9626 |         return css_tg(css)->idle;
>          |                           ^~
>    kernel/sched/core.c: In function 'cpu_idle_write_s64':
>>> kernel/sched/core.c:9634:15: error: implicit declaration of function 'sched_group_set_idle'; did you mean 'scx_group_set_idle'? [-Wimplicit-function-declaration]
>     9634 |         ret = sched_group_set_idle(css_tg(css), idle);
>          |               ^~~~~~~~~~~~~~~~~~~~
>          |               scx_group_set_idle
>    kernel/sched/core.c: In function 'cpu_idle_read_s64':
>    kernel/sched/core.c:9627:1: warning: control reaches end of non-void function [-Wreturn-type]
>     9627 | }
>          | ^
> 

I post a RFC PATCH series:
https://lore.kernel.org/all/20240923135431.2440320-1-liaoyu15@huawei.com/T/#t

Best regards,
Yu
> 
> vim +3701 kernel/sched/ext.c
> 
>   3694	
>   3695	static void scx_cgroup_warn_missing_idle(struct task_group *tg)
>   3696	{
>   3697		if (scx_ops_enable_state() == SCX_OPS_DISABLED ||
>   3698		    cgroup_warned_missing_idle)
>   3699			return;
>   3700	
>> 3701		if (!tg->idle)
>   3702			return;
>   3703	
>   3704		pr_warn("sched_ext: \"%s\" does not implement cgroup cpu.idle\n",
>   3705			scx_ops.name);
>   3706		cgroup_warned_missing_idle = true;
>   3707	}
>   3708	
> 


