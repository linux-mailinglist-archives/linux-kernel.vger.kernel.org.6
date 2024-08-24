Return-Path: <linux-kernel+bounces-299985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF7695DD3E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 11:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034F7283686
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 09:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F14A15573A;
	Sat, 24 Aug 2024 09:52:40 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3514EC59;
	Sat, 24 Aug 2024 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724493159; cv=none; b=r+2P8MN5dlopd8QT0zd5iMKhSi6nHu9Nx9uwAhrhODnqsh6BJYoTzSyAJdZ9ewLacmz8fekbO35d9GONMj0/BjErnc4yYemgEPpkYoIfAEE/ZCSQn2EGcDs8BAdM17IG11wbOdsNxAkt0dMa6TPLu4Msq08roXie9SCOcwAWZyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724493159; c=relaxed/simple;
	bh=RTpooz/5aJS3MXT8lVp2Drz9Z2k7ybJho9NK0JW3SAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uPEcQM81gT7OIiaZ7dAcQ2bmwCgMv69tjcMBgk+6m848A+XY3mR1SogcZ8AO8vFT8n+I5y9RofWrSr19Gj6RDPhfJuAK8xFEGRuaf8TfWWW5f6PKEKhMn47wb+mWCQVPPp77ksJvGyoXw1QSAeFeevvk6EVMrAIWIpkuLCL9qmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WrXKk5fg9z1j78w;
	Sat, 24 Aug 2024 17:52:26 +0800 (CST)
Received: from dggpemf500017.china.huawei.com (unknown [7.185.36.126])
	by mail.maildlp.com (Postfix) with ESMTPS id B56181401F2;
	Sat, 24 Aug 2024 17:52:32 +0800 (CST)
Received: from [10.67.110.89] (10.67.110.89) by dggpemf500017.china.huawei.com
 (7.185.36.126) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 24 Aug
 2024 17:52:32 +0800
Message-ID: <c0aa1e66-8e85-6aa0-e933-d5b6e3a2e3e7@huawei.com>
Date: Sat, 24 Aug 2024 17:52:05 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: CVE-2022-48921: sched/fair: Fix fault in reweight_entity
To: <cve@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cve-announce@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "Zhangqiao (2012 lab)" <zhangqiao22@huawei.com>, "Chenhui (Judy)"
	<judy.chenhui@huawei.com>
References: <2024082218-CVE-2022-48921-5016@gregkh>
From: Xia Fukun <xiafukun@huawei.com>
In-Reply-To: <2024082218-CVE-2022-48921-5016@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf500017.china.huawei.com (7.185.36.126)


On 2024/8/22 11:31, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> sched/fair: Fix fault in reweight_entity
> 
> Syzbot found a GPF in reweight_entity. This has been bisected to
> commit 4ef0c5c6b5ba ("kernel/sched: Fix sched_fork() access an invalid
> sched_task_group")
> 
> There is a race between sched_post_fork() and setpriority(PRIO_PGRP)
> within a thread group that causes a null-ptr-deref in
> reweight_entity() in CFS. The scenario is that the main process spawns
> number of new threads, which then call setpriority(PRIO_PGRP, 0, -20),
> wait, and exit.  For each of the new threads the copy_process() gets
> invoked, which adds the new task_struct and calls sched_post_fork()
> for it.
> 
> 
> The Linux kernel CVE team has assigned CVE-2022-48921 to this issue.
> 

Commit 13765de8148f ("sched/fair: Fix fault in reweight_entity")
is reverted by commit b1e8206582f9 ("sched: Fix yet more sched_fork()
races"). Since commit 13765de8148f only fixes a single instance
of this problem, not the whole class.

I think the CVE-2022-48921 needs to adjust the corresponding commit
to commit b1e8206582f9 ("sched: Fix yet more sched_fork() races").

