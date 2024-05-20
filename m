Return-Path: <linux-kernel+bounces-183327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AD18C97B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 03:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D021F21ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 01:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50A479DC;
	Mon, 20 May 2024 01:47:51 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1094C12C
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716169671; cv=none; b=E/ho1t5bULl0X9D7PK5VsPtN6nnrUVB9LcRLS6mAUQ4KgKSAjd7ifyh8fwOj7njAHF5g63PJ53jJu2GxdkRWoVj1olL7/GO+lBN8OXx68yGB9iiRUwSITSMfckiHCy9YlO/JBe7jcKoDtHAY5uwtmJbWEAfUyEDg8jsvsDP9Hr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716169671; c=relaxed/simple;
	bh=qpXZyW+NEeL2MCm77eZBO0fz7eYvCpAkOHbsTO+X6EA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=IrONfTzEiLHaX9PkCTEu0mygXyIT8kz5+rs4lOAODUb8vomB9gRXIPC/Sz7Gv8HLWLoPS4WZNhtLVZ0gNikzIf0pNmqhvNcplaa+7sONgbqa3Z5yaAiKd+CZQ6zj/+EfqgJ7q93zbNqv6GnOhsRWdyEsaMQib3neVFle1O8d9tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VjL5H4GTcz1xmdr;
	Mon, 20 May 2024 09:46:27 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 8A01C1A0188;
	Mon, 20 May 2024 09:47:40 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 09:47:40 +0800
Subject: Re: [PATCH -rc7] mm/huge_memory: mark huge_zero_page reserved
To: kernel test robot <oliver.sang@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
	<akpm@linux-foundation.org>, <shy828301@gmail.com>,
	<nao.horiguchi@gmail.com>, <xuyu@linux.alibaba.com>,
	<linux-kernel@vger.kernel.org>
References: <202405171417.1bb0856a-lkp@intel.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1872dc30-01ff-008c-aedb-9a83c57a6bc7@huawei.com>
Date: Mon, 20 May 2024 09:47:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202405171417.1bb0856a-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/17 15:03, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "kernel_BUG_at_include/linux/page-flags.h" on:
> 
> commit: 8e6ff9c4aad2c677c53f70d9e193c35cbbafcb88 ("[PATCH -rc7] mm/huge_memory: mark huge_zero_page reserved")
> url: https://github.com/intel-lab-lkp/linux/commits/Miaohe-Lin/mm-huge_memory-mark-huge_zero_page-reserved/20240511-115840
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git cf87f46fd34d6c19283d9625a7822f20d90b64a4
> patch link: https://lore.kernel.org/all/20240511035435.1477004-1-linmiaohe@huawei.com/
> patch subject: [PATCH -rc7] mm/huge_memory: mark huge_zero_page reserved
> 
> in testcase: trinity
> version: trinity-i386-abe9de86-1_20230429
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-03
> 	nr_groups: 5
> 
> 
> 
> compiler: gcc-13
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +------------------------------------------+------------+------------+
> |                                          | cf87f46fd3 | 8e6ff9c4aa |
> +------------------------------------------+------------+------------+
> | kernel_BUG_at_include/linux/page-flags.h | 0          | 11         |
> | invalid_opcode:#[##]                     | 0          | 11         |
> | RIP:get_huge_zero_page                   | 0          | 11         |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 11         |
> +------------------------------------------+------------+------------+
> 

Thanks for your report.

> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202405171417.1bb0856a-lkp@intel.com
> 
> 
> [  272.633454][ T3838] ------------[ cut here ]------------
> [  272.634362][ T3838] kernel BUG at include/linux/page-flags.h:540!
> [  272.635422][ T3838] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> [  272.636518][ T3838] CPU: 0 PID: 3838 Comm: trinity-c2 Not tainted 6.9.0-rc7-00184-g8e6ff9c4aad2 #1
> [  272.638008][ T3838] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [ 272.639707][ T3838] RIP: 0010:get_huge_zero_page (include/linux/page-flags.h:540 (discriminator 1) mm/huge_memory.c:211 (discriminator 1)) 

I think the root cause is that PG_reserved is inhibited on compound pages. So my original version of patch breaks the assumption.
But since PG_reserved is to be removed, I have dropped this patch.
Thanks.
.


