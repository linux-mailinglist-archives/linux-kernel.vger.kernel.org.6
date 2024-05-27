Return-Path: <linux-kernel+bounces-189983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B808CF801
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 05:13:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E2C280E56
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 03:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759BEDF44;
	Mon, 27 May 2024 03:13:43 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F257DDA5;
	Mon, 27 May 2024 03:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716779623; cv=none; b=UPzdkhbg8wk67UP4AR2UlOvTi/16YR9+48w1wjBoW4qupDa/Nu7rPlalbcXMoYyFzdDlW/7lk+IszYtKiuBj2pavtU2V0kklW3gxnh+xHZ64moau0ZeeKX5Kq92NIi2EGOB898GOJ2Yhcefs0a9+nMjv8KkI90EFf/t+ErgE0g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716779623; c=relaxed/simple;
	bh=LQUBKtXo9O7lpjMOTq/te/3KdZL8KecWHRgyfxXZNM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bCmDZSbGuQCjOnF1AWfNFf8a8biBCSpAF0qirML7JHeIMR/LHwAcWqaKE+NnuEgvgFCAojlZ8d0EdcLLdICECtfRh3XoV8EOR41GoOD+rjcAwvS3wz6q1WTzeWHfd4bUSbotpnurqnU/Ep4aRRWLpWky6wFELExX20rCn2R9YGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Vngcw5MNvzPn51;
	Mon, 27 May 2024 11:10:24 +0800 (CST)
Received: from canpemm500001.china.huawei.com (unknown [7.192.104.163])
	by mail.maildlp.com (Postfix) with ESMTPS id F0371140384;
	Mon, 27 May 2024 11:13:31 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 May 2024 11:13:31 +0800
Message-ID: <3dffcc67-750e-c4c4-9154-99f1b1154fe0@huawei.com>
Date: Mon, 27 May 2024 11:13:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] sched/Documentation: Add RT_RUNTIME_SHARE
 documentation
To: <mingo@kernel.org>, <chrubis@suse.cz>, <rostedt@goodmis.org>,
	<bagasdotme@gmail.com>, <corbet@lwn.net>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240419090432.1935211-1-zhangqiao22@huawei.com>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20240419090432.1935211-1-zhangqiao22@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500001.china.huawei.com (7.192.104.163)

Ping.

在 2024/4/19 17:04, Zhang Qiao 写道:
> RT_RUNTIME_SHARE is an important strategy for rt bandwidth, and
> we should document this sched feature.
> 
> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
> Improvements-suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/scheduler/sched-rt-group.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-rt-group.rst b/Documentation/scheduler/sched-rt-group.rst
> index d685609ed3d7..eea2fc6f068f 100644
> --- a/Documentation/scheduler/sched-rt-group.rst
> +++ b/Documentation/scheduler/sched-rt-group.rst
> @@ -12,6 +12,7 @@ Real-Time group scheduling
>       2.1 System-wide settings
>       2.2 Default behaviour
>       2.3 Basis for grouping tasks
> +     2.4 RT_RUNTIME_SHARE sched feature
>     3. Future plans
>  
>  
> @@ -146,6 +147,17 @@ For now, this can be simplified to just the following (but see Future plans):
>  
>     \Sum_{i} runtime_{i} <= global_runtime
>  
> +2.4 RT_RUNTIME_SHARE sched feature
> +----------------------------------
> +
> +RT_RUNTIME_SHARE allows a cpu to borrow rt-runtime from other cpus if it runs
> +out of its own rt-runtime.
> +
> +With this feature enabled, a rt-task may hit 100% cpu usage and can stall other
> +per-cpu tasks like kworkers, as a result, which leads into system hang.
> +
> +Thus, it is advised to disable this feature by default to avoid aforementioned
> +issue unless you know what you're doing.
>  
>  3. Future plans
>  ===============
> 

