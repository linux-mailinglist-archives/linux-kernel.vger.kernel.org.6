Return-Path: <linux-kernel+bounces-187207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0418CCE98
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 10:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343622821EC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 08:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8FE13C918;
	Thu, 23 May 2024 08:50:51 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D6646AF;
	Thu, 23 May 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716454251; cv=none; b=CeVlGXdoQ0YqYsR/HqHu7cvLhUvVbU8bdsDlvGktJP/czlCyBvnjsmFhxctyLzFRHnXZ7lrb9J6tsyTuVsNzagR6xkSoEe6X/PKXvNuceA0OTghyBmLon0twCxOy1CVgPeCM53lI7V/Hkvlp0gL77zxbuptnCIzTIjNQDmwPfbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716454251; c=relaxed/simple;
	bh=o6mR2MAS1+lUicCl6cB9aVJ9GHBKQb9Xgj8ZjykgBNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Do80Yy+1JKbgGuUHcO1OyibezI1P8B/SMlW4vayaqmDkUVZCqcohN+V9BdIuGIbpJCUnc04OtRUvpDT17ywQswKJaG5go0cg6L/K2YNSnjNHD/meTJbiJ7Eu4PbJR6Aw1EQp/+DHF0xCPQKBPzSYeLVTShyDkixxYBMDjFMBEzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VlMH764r1z1S7Yv;
	Thu, 23 May 2024 16:46:59 +0800 (CST)
Received: from canpemm500006.china.huawei.com (unknown [7.192.105.130])
	by mail.maildlp.com (Postfix) with ESMTPS id 2362B14038F;
	Thu, 23 May 2024 16:50:39 +0800 (CST)
Received: from [10.67.109.61] (10.67.109.61) by canpemm500006.china.huawei.com
 (7.192.105.130) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 May
 2024 16:50:38 +0800
Message-ID: <da7e8c85-52fd-b2f4-83da-751f812de6ae@huawei.com>
Date: Thu, 23 May 2024 16:50:18 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: CVE-2024-26650: platform/x86: p2sb: Allow p2sb_bar() calls during
 PCI device probe
To: Michal Hocko <mhocko@suse.com>
CC: <linux-cve-announce@vger.kernel.org>, Lee Jones <lee@kernel.org>,
	<Jun.Ma2@amd.com>, <cve@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240326175007.1388794-18-lee@kernel.org>
 <Zkz2qpUP-HVROO1I@tiehlicka>
From: zhengzucheng <zhengzucheng@huawei.com>
In-Reply-To: <Zkz2qpUP-HVROO1I@tiehlicka>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500006.china.huawei.com (7.192.105.130)


在 2024/5/22 3:31, Michal Hocko 写道:
> This patch has been reverted in upstream by 03c6284df179 ("Revert
> "drm/amd/amdgpu: Fix potential ioremap() memory leaks in
> amdgpu_device_init()"") and based on the changelog the CVE should be
> rejected.

hi Michal Hocko

This reverted patch was previously used to resolve CVE-2024-35928 ?

so CVE-2024-35928 should be rejected?


commit 03c6284df179de3a4a6e0684764b1c71d2a405e2
Author: Ma Jun <Jun.Ma2@amd.com>
Date:   Tue Mar 19 15:24:03 2024 +0800

     Revert "drm/amd/amdgpu: Fix potential ioremap() memory leaks in 
amdgpu_device_init()"

     This patch causes the following iounmap erorr and calltrace
     iounmap: bad address 00000000d0b3631f

     The original patch was unjustified because amdgpu_device_fini_sw() will
     always cleanup the rmmio mapping.

     This reverts commit eb4f139888f636614dab3bcce97ff61cefc4b3a7.

     Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
     Suggested-by: Christian König <christian.koenig@amd.com>
     Reviewed-by: Christian König <christian.koenig@amd.com>
     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>


> On Tue 26-03-24 17:50:16, Lee Jones wrote:
>> Description
>> ===========
>>
>> In the Linux kernel, the following vulnerability has been resolved:
>>
>> platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe
>>
>> p2sb_bar() unhides P2SB device to get resources from the device. It
>> guards the operation by locking pci_rescan_remove_lock so that parallel
>> rescans do not find the P2SB device. However, this lock causes deadlock
>> when PCI bus rescan is triggered by /sys/bus/pci/rescan. The rescan
>> locks pci_rescan_remove_lock and probes PCI devices. When PCI devices
>> call p2sb_bar() during probe, it locks pci_rescan_remove_lock again.
>> Hence the deadlock.
>>
>> To avoid the deadlock, do not lock pci_rescan_remove_lock in p2sb_bar().
>> Instead, do the lock at fs_initcall. Introduce p2sb_cache_resources()
>> for fs_initcall which gets and caches the P2SB resources. At p2sb_bar(),
>> refer the cache and return to the caller.
>>
>> Before operating the device at P2SB DEVFN for resource cache, check
>> that its device class is PCI_CLASS_MEMORY_OTHER 0x0580 that PCH
>> specifications define. This avoids unexpected operation to other devices
>> at the same DEVFN.
>>
>> Tested-by Klara Modin <klarasmodin@gmail.com>
>>
>> The Linux kernel CVE team has assigned CVE-2024-26650 to this issue.
>>
>>
>> Affected and fixed versions
>> ===========================
>>
>> 	Issue introduced in 6.0 with commit 9745fb07474f and fixed in 6.1.76 with commit 2841631a0365
>> 	Issue introduced in 6.0 with commit 9745fb07474f and fixed in 6.6.15 with commit 847e1eb30e26
>> 	Issue introduced in 6.0 with commit 9745fb07474f and fixed in 6.7.3 with commit d281ac9a987c
>> 	Issue introduced in 6.0 with commit 9745fb07474f and fixed in 6.8 with commit 5913320eb0b3
>>
>> Please see https://www.kernel.org for a full list of currently supported
>> kernel versions by the kernel community.
>>
>> Unaffected versions might change over time as fixes are backported to
>> older supported kernel versions.  The official CVE entry at
>> 	https://cve.org/CVERecord/?id=CVE-2024-26650
>> will be updated if fixes are backported, please check that for the most
>> up to date information about this issue.
>>
>>
>> Affected files
>> ==============
>>
>> The file(s) affected by this issue are:
>> 	drivers/platform/x86/p2sb.c
>>
>>
>> Mitigation
>> ==========
>>
>> The Linux kernel CVE team recommends that you update to the latest
>> stable kernel version for this, and many other bugfixes.  Individual
>> changes are never tested alone, but rather are part of a larger kernel
>> release.  Cherry-picking individual commits is not recommended or
>> supported by the Linux kernel community at all.  If however, updating to
>> the latest release is impossible, the individual changes to resolve this
>> issue can be found at these commits:
>> 	https://git.kernel.org/stable/c/2841631a03652f32b595c563695d0461072e0de4
>> 	https://git.kernel.org/stable/c/847e1eb30e269a094da046c08273abe3f3361cf2
>> 	https://git.kernel.org/stable/c/d281ac9a987c553d93211b90fd4fe97d8eca32cd
>> 	https://git.kernel.org/stable/c/5913320eb0b3ec88158cfcb0fa5e996bf4ef681b

