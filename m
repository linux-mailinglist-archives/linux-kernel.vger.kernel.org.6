Return-Path: <linux-kernel+bounces-213391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5A4907484
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 150B21F22750
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E247314374B;
	Thu, 13 Jun 2024 14:02:48 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E80C8C7;
	Thu, 13 Jun 2024 14:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287368; cv=none; b=fpXNGgz+1ardcXrod2Ky8QdT/Nw5QpPeBHtRc1OsWrqqXXe33w+qMEknMB9Hd5/FcyN82HAxicB9uG3sqGDagp/KYPhL9b3ctXFEiLCkr7NNRqfLuIDI9uQqCkN06KJtzvwKU1zIufdCClwgHy7kVFsReoAwLKA/rib09ohIOI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287368; c=relaxed/simple;
	bh=ba31KMcH9Sse/E6nlGBlFa3LctbVyEL7XIQ4TSKCYZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mxX5eH4U1kSPfrI1rbAJuvus/4cUC9TfBhB/jc5etkFUbaxNluGooM9F4LQkGT49dh/gqWbraKI7XetnM91tdVqdbMHKG7zcB79uCUIUvE2dm+Ro1TcfolSqCXVbSlmF/JsB9LrFA8b78a195+iYh1p/zRXtJPPtQxnhXZBCVDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W0PG21FHXzdcjZ;
	Thu, 13 Jun 2024 22:01:14 +0800 (CST)
Received: from dggpeml100021.china.huawei.com (unknown [7.185.36.148])
	by mail.maildlp.com (Postfix) with ESMTPS id 1584F18007C;
	Thu, 13 Jun 2024 22:02:42 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml100021.china.huawei.com (7.185.36.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 22:02:41 +0800
Message-ID: <935974c5-89b1-4811-bdef-6652937829a1@huawei.com>
Date: Thu, 13 Jun 2024 22:02:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-36966: erofs: reliably distinguish block based and
 fscache mode
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Gao Xiang <hsiangkao@linux.alibaba.com>, <cve@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-cve-announce@vger.kernel.org>, Baokun
 Li <libaokun@huaweicloud.com>, <yangerkun@huawei.com>
References: <2024060804-CVE-2024-36966-8bbb@gregkh>
 <686626cd-7dcd-4931-bf55-108522b9bfeb@linux.alibaba.com>
 <362b1e1b-dcdb-4801-a9fc-18d019e7c775@huawei.com>
 <2024061323-ibuprofen-dreamy-ae0b@gregkh>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <2024061323-ibuprofen-dreamy-ae0b@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100021.china.huawei.com (7.185.36.148)

On 2024/6/13 21:55, Greg Kroah-Hartman wrote:
> On Thu, Jun 13, 2024 at 07:21:14PM +0800, Baokun Li wrote:
>> On 2024/6/13 17:38, Gao Xiang wrote:
>>> Hi,
>>>
>>> (+Cc Baokun Li)
>>>
>>> On 2024/6/8 20:53, Greg Kroah-Hartman wrote:
>>>> Description
>>>> ===========
>>>>
>>>> In the Linux kernel, the following vulnerability has been resolved:
>>>>
>>>> erofs: reliably distinguish block based and fscache mode
>>>>
>>>> When erofs_kill_sb() is called in block dev based mode, s_bdev may not
>>>> have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
>>>> it will be mistaken for fscache mode, and then attempt to free an
>>>> anon_dev
>>>> that has never been allocated, triggering the following warning:
>>>>
>>>> ============================================
>>>> ida_free called for id=0 which is not allocated.
>>>> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
>>>> Modules linked in:
>>>> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
>>>> RIP: 0010:ida_free+0x134/0x140
>>>> Call Trace:
>>>>    <TASK>
>>>>    erofs_kill_sb+0x81/0x90
>>>>    deactivate_locked_super+0x35/0x80
>>>>    get_tree_bdev+0x136/0x1e0
>>>>    vfs_get_tree+0x2c/0xf0
>>>>    do_new_mount+0x190/0x2f0
>>>>    [...]
>>>> ============================================
>>>>
>>>> Now when erofs_kill_sb() is called, erofs_sb_info must have been
>>>> initialised, so use sbi->fsid to distinguish between the two modes.
>>>>
>>>> The Linux kernel CVE team has assigned CVE-2024-36966 to this issue.
>>>>
>>>>
>>>> Affected and fixed versions
>>>> ===========================
>>>>
>>>>      Fixed in 6.6.32 with commit f9b877a7ee31
>>>>      Fixed in 6.8.11 with commit dcdd49701e42
>>>>      Fixed in 6.9 with commit 7af2ae1b1531
>>> For reference, this issue doesn't affect Linux kernel below 6.6.
>>>
>>> This behavior ("s_bdev may not be initialized in erofs_kill_sb()")
>>> is introduced due to commit aca740cecbe5 ("fs: open block device after
>>> superblock creation").
>>>
>>> In other words, previously .kill_sb() was called only after
>>> fill_super failed and problematic erofs_kill_sb() called due to
>>> setup_bdev_super() failure can only happen since Linux 6.6.
>>>
>>> Thanks,
>>> Gao Xiang
>> Exactly! I'm so sorry I forgot to add the Fixes tag.
> No worries.  I've updated the CVE database with this information and the
> json file and web site will show the new information soon when it gets
> propagated.
>
> thanks,
>
> greg k-h

Thank you very much for the update!

-- 
With Best Regards,
Baokun Li


