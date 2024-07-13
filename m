Return-Path: <linux-kernel+bounces-251332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5769303A3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 06:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0992E2834E2
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 04:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E781805A;
	Sat, 13 Jul 2024 04:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HHYZ4I+3"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B261759F;
	Sat, 13 Jul 2024 04:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720844537; cv=none; b=q17n4cwoZkvj/hwRf0jSnDsgtDlyyGlVhDxKD1EcnKZQirfCuaXuyn38Ade0Jv/o+xh4iEwYx8KZDn6QFlyD2aTq8QLjO9duIXmQpd4CUIvR5bodBQo7MwwKY8ov0dSLvt1QO9i4khiobSz2XefPSp8rbZ/dZZloH79uh6A0sH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720844537; c=relaxed/simple;
	bh=wmr/ouVD2eMUIMbyLlnD82DQQxr1X9SgVFwdU/a40Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbTsT3Zz4NZwCtF/NoQbsyXlS0FZbhERJFhYQZfhzkLMztReCyI/f1rCwa3Znm87RC9rhT5HU8np+mdYQmpi+lQRcdc5OIDp6DJfggInOq+QTak1gsHUNi6SM66IGH4m+hoc6QI/xqITSjx/1h8B+D4xFqYYN9pyQTM6aYXmy2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HHYZ4I+3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=JSPtA+5qlIyfotm1HU/6yE5V/V+Kh/C7Nj2+UevhCtc=; b=HHYZ4I+3UUQFRRUi3Gu8d3bwfJ
	aY4sXVVeIyu5KDTcexwZc6PLi0YqrnrHXviUVoinsg6mcsX5kxjS98Ps1IiyviHhMW8dNDzydypu0
	8BJpXleIYVgEeejxxoF0XKgySrDCTArZPmeceCPjppq1WpZJbgWFX4UAskF93SxCt7F5cYlNOsBPS
	ZfA5dnKN1lzpw3UVT/zVJOjR8nQWn8hAHBkZ1Ngj7+d0zBp3jnHjBBg0Yxy6PgRVc8yVgrB1JWjS7
	2fb+L2XFa2Ud6DSY7YTjRazuogepsEfYVGvOKWjbPQH3qlm4uCbajey2tf9+KeYeYpm5gvoQUIBtX
	hzRccf1Q==;
Received: from [50.53.4.147] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSUGz-00000001rFy-3vmi;
	Sat, 13 Jul 2024 04:22:14 +0000
Message-ID: <201d597e-e0c7-411b-a29c-dfc3111aa863@infradead.org>
Date: Fri, 12 Jul 2024 21:22:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] docs: scheduler: Start documenting the EEVDF
 scheduler
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, corbet@lwn.net,
 sergio.collado@gmail.com, peterz@infradead.org
Cc: bilbao@vt.edu, jembid@ucm.es, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240713003213.4008440-1-carlos.bilbao.osdev@gmail.com>
 <20240713003213.4008440-2-carlos.bilbao.osdev@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240713003213.4008440-2-carlos.bilbao.osdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/12/24 5:32 PM, Carlos Bilbao wrote:
> Add some documentation regarding the newly introduced scheduler EEVDF.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> ---
>  Documentation/scheduler/index.rst            |  1 +
>  Documentation/scheduler/sched-design-CFS.rst | 10 +++--
>  Documentation/scheduler/sched-eevdf.rst      | 44 ++++++++++++++++++++
>  3 files changed, 51 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/scheduler/sched-eevdf.rst
> 
> diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
> index 43bd8a145b7a..444a6fef1464 100644
> --- a/Documentation/scheduler/index.rst
> +++ b/Documentation/scheduler/index.rst
> @@ -11,6 +11,7 @@ Scheduler
>      sched-arch
>      sched-bwc
>      sched-deadline
> +    sched-eevdf

I would have probably put EEVDF just after CFS instead of before it...
whatever.

>      sched-design-CFS
>      sched-domains
>      sched-capacity
> diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/scheduler/sched-design-CFS.rst
> index bc1e507269c6..b703c6dcb3cd 100644
> --- a/Documentation/scheduler/sched-design-CFS.rst
> +++ b/Documentation/scheduler/sched-design-CFS.rst
> @@ -8,10 +8,12 @@ CFS Scheduler
>  1.  OVERVIEW
>  ============
>  
> -CFS stands for "Completely Fair Scheduler," and is the new "desktop" process
> -scheduler implemented by Ingo Molnar and merged in Linux 2.6.23.  It is the
> -replacement for the previous vanilla scheduler's SCHED_OTHER interactivity
> -code.
> +CFS stands for "Completely Fair Scheduler," and is the "desktop" process
> +scheduler implemented by Ingo Molnar and merged in Linux 2.6.23. When
> +originally merged, it was the replacement for the previous vanilla
> +scheduler's SCHED_OTHER interactivity code. Nowadays, CFS is making room
> +for EEVDF, for which documentation can be found in
> +:ref:`sched_design_EEVDF`.
>  
>  80% of CFS's design can be summed up in a single sentence: CFS basically models
>  an "ideal, precise multi-tasking CPU" on real hardware.
> diff --git a/Documentation/scheduler/sched-eevdf.rst b/Documentation/scheduler/sched-eevdf.rst
> new file mode 100644
> index 000000000000..31ad8f995360
> --- /dev/null
> +++ b/Documentation/scheduler/sched-eevdf.rst
> @@ -0,0 +1,44 @@
> +.. _sched_design_EEVDF:
> +
> +===============
> +EEVDF Scheduler
> +===============
> +
> +The "Earliest Eligible Virtual Deadline First" (EEVDF) was first introduced
> +in a scientific publication in 1995 [1]. The Linux kernel began
> +transitioning to EEVDF in version 6.6 (as a new option in 2024), moving
> +away from the earlier Completely Fair Scheduler (CFS) in favor of a version
> +of EEVDF proposed by Peter Zijlstra in 2023 [2-4]. More information
> +regarding CFS can be found in :ref:`sched_design_CFS`.
> +
> +Similarly to CFS, EEVDF aims to distribute CPU time equally among all
> +runnable tasks with the same priority. To do so, it assigns a virtual run
> +time to each task, creating a "lag" value that can be used to determine
> +whether a task has received its fair share of CPU time. In this way, a task
> +with a positive lag is owed CPU time, while a negative lag means the task
> +has exceeded its portion. EEVDF picks tasks with lag greater or equal to
> +zero and calculates a virtual deadline (VD) for each, selecting the task
> +with the earliest VD to execute next. It's important to note that this
> +allows latency-sensitive tasks with shorter time slices to be prioritized,
> +which helps with their responsiveness.
> +
> +There are ongoing discussions on how to manage lag, especially for sleeping
> +tasks; but at the time of writing EEVDF uses a "decaying" mechanism based
> +on virtual run time (VRT). This prevents tasks from exploiting the system
> +by sleeping briefly to reset their negative lag: when a task sleeps, it
> +remains on the run queue but marked for "deferred dequeue," allowing its
> +lag to decay over VRT. Hence, long-sleeping tasks eventually have their lag
> +reset. Finally, tasks can preempt others if their VD is earlier, and tasks
> +can request specific time slices using the new sched_setattr() system call,
> +which further facilitates the job of latency-sensitive applications.
> +
> +4. REFERENCES
> +=============

Why is this section numbered 4?
No other sections here are numbered.

> +
> +[1] https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=805acf7726282721504c8f00575d91ebfd750564
> +
> +[2] https://lore.kernel.org/lkml/a79014e6-ea83-b316-1e12-2ae056bda6fa@linux.vnet.ibm.com/
> +
> +[3] https://lwn.net/Articles/969062/
> +
> +[4] https://lwn.net/Articles/925371/

Other than those 2 comments:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>


Thanks.

-- 
~Randy

