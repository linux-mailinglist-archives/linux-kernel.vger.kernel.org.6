Return-Path: <linux-kernel+bounces-183804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B4F8C9E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6492831E2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44739136994;
	Mon, 20 May 2024 13:48:51 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1108136986
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 13:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716212930; cv=none; b=ZvejLYmuL41kekbtS77u8rvFiY1+s0MQpo5xD+usSgTTx0QiTdz4RLFd/vewYEZ3335dEpUNgZOGFtm5G8q3on3JePRIYRHtVFjjqDBForlWn5p7JN+DQJtYa8nJ5K5FyovZsg9a0Gk0nwCqhnjJm/x3mTxzJJLKqRJuwOpwGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716212930; c=relaxed/simple;
	bh=p71lg6zGyJAtcZ8Xn2jER3pWn4wYpyvMIBfJ1w+2jFI=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Fv3Ud14calVuPfXdvaprDMAb+rLZBeZ4Kw9dJuOP1broAzvextGw9v0/OSoUZw1YcqNz9Mc4GaGN1PjEnp+BBmoVEjsIjY55xM03fGlA2X8njAJiPZuyTzONthxQtl0j9U2pWELY+FKfg/Viz7Ei0MUY4bLtlIZfLDKhAk6OQBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Vjdd40Q08zvXcX;
	Mon, 20 May 2024 21:26:32 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id C537A180069;
	Mon, 20 May 2024 21:30:07 +0800 (CST)
Received: from [10.67.111.82] (10.67.111.82) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 20 May
 2024 21:30:07 +0800
Subject: Re: [PATCH] arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY
To: Mark Rutland <mark.rutland@arm.com>
References: <1715955208-17109-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZksnARrLkKHcX4C_@J2N7QTR9R3>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <Dave.Martin@arm.com>,
	<xieyuanbin1@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <nixiaoming@huawei.com>,
	<wangbing6@huawei.com>, <douzhaolei@huawei.com>, <liaohua4@huawei.com>,
	<lijiahuan5@huawei.com>, <wangfangpeng1@huawei.com>
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <8452c8cb-4822-9110-0a3c-51dd94ee3e8d@huawei.com>
Date: Mon, 20 May 2024 21:30:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZksnARrLkKHcX4C_@J2N7QTR9R3>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/5/20 18:33, Mark Rutland wrote:

> I reckon we should spell out the reason for this a bit more; would you
> be happy with the commit message below?
> 
> | When CONFIG_DEBUG_BUGVERBOSE=n, we fail to add necessary padding bytes
> | to bug_table entries, and as a result the last entry in a bug table will
> | be ignored, potentially leading to an unexpected panic(). All prior
> | entries in the table will be handled correctly.
> | 
> | The arm64 ABI requires that struct fields of up to 8 bytes are
> | naturally-aligned, with padding added within a struct such that struct
> | are suitably aligned within arrays.
> | 
> | When CONFIG_DEBUG_BUGVERPOSE=y, the layout of a bug_entry is:
> | 
> | 	struct bug_entry {
> | 		signed int      bug_addr_disp;	// 4 bytes
> | 		signed int      file_disp;	// 4 bytes
> | 		unsigned short  line;		// 2 bytes
> | 		unsigned short  flags;		// 2 bytes
> | 	}
> | 
> | ... with 12 bytes total, requiring 4-byte alignment.
> | 
> | When CONFIG_DEBUG_BUGVERBOSE=n, the layout of a bug_entry is:
> | 
> | 	struct bug_entry {
> | 		signed int      bug_addr_disp;	// 4 bytes
> | 		unsigned short  flags;		// 2 bytes
> | 		< implicit padding >		// 2 bytes
> | 	}
> | 
> | ... with 8 bytes total, with 6 bytes of data and 2 bytes of trailing
> | padding, requiring 4-byte alginment.
> | 
> | When we create a bug_entry in assembly, we align the start of the entry
> | to 4 bytes, which implicitly handles padding for any prior entries.
> | However, we do not align the end of the entry, and so when
> | CONFIG_DEBUG_BUGVERBOSE=n, the final entry lacks the trailing padding
> | bytes.
> | 
> | For the main kernel image this is not a problem as find_bug() doesn't
> | depend on the trailing padding bytes when searching for entries:
> | 
> | 	for (bug = __start___bug_table; bug < __stop___bug_table; ++bug)
> | 		if (bugaddr == bug_addr(bug))
> | 			return bug;
> | 
> | However for modules, module_bug_finalize() depends on the trailing
> | bytes when calculating the number of entries:
> | 
> | 	mod->num_bugs = sechdrs[i].sh_size / sizeof(struct bug_entry);
> | 
> | ... and as the last bug_entry lacks the necessary padding bytes, this entry
> | will not be counted, e.g. in the case of a single entry:
> | 	
> | 	sechdrs[i].sh_size == 6
> | 	sizeof(struct bug_entry) == 8;
> | 
> | 	sechdrs[i].sh_size / sizeof(struct bug_entry) == 0;
> | 
> | Consequently module_find_bug() will miss the last bug_entry when it does:
> | 
> | 	for (i = 0; i < mod->num_bugs; ++i, ++bug)
> | 		if (bugaddr == bug_addr(bug))
> | 			goto out;	
> | 
> | ... which can lead to a kenrel panic due to an unhandled bug.
> | 
> | This can be demonstrated with the following module:
> | 
> | 	static int __init buginit(void)
> | 	{
> | 		WARN(1, "hello\n");
> | 		return 0;
> | 	}
> | 
> | 	static void __exit bugexit(void)
> | 	{
> | 	}
> | 
> | 	module_init(buginit);
> | 	module_exit(bugexit);
> | 	MODULE_LICENSE("GPL");
> | 
> | ... which will trigger a kernel panic when loaded:
> | 
> | 	------------[ cut here ]------------
> | 	hello
> | 	Unexpected kernel BRK exception at EL1
> | 	Internal error: BRK handler: 00000000f2000800 [#1] PREEMPT SMP
> | 	Modules linked in: hello(O+)
> | 	CPU: 0 PID: 50 Comm: insmod Tainted: G           O       6.9.1 #8
> | 	Hardware name: linux,dummy-virt (DT)
> | 	pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> | 	pc : buginit+0x18/0x1000 [hello]
> | 	lr : buginit+0x18/0x1000 [hello]
> | 	sp : ffff800080533ae0
> | 	x29: ffff800080533ae0 x28: 0000000000000000 x27: 0000000000000000
> | 	x26: ffffaba8c4e70510 x25: ffff800080533c30 x24: ffffaba8c4a28a58
> | 	x23: 0000000000000000 x22: 0000000000000000 x21: ffff3947c0eab3c0
> | 	x20: ffffaba8c4e3f000 x19: ffffaba846464000 x18: 0000000000000006
> | 	x17: 0000000000000000 x16: ffffaba8c2492834 x15: 0720072007200720
> | 	x14: 0720072007200720 x13: ffffaba8c49b27c8 x12: 0000000000000312
> | 	x11: 0000000000000106 x10: ffffaba8c4a0a7c8 x9 : ffffaba8c49b27c8
> | 	x8 : 00000000ffffefff x7 : ffffaba8c4a0a7c8 x6 : 80000000fffff000
> | 	x5 : 0000000000000107 x4 : 0000000000000000 x3 : 0000000000000000
> | 	x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff3947c0eab3c0
> | 	Call trace:
> | 	 buginit+0x18/0x1000 [hello]
> | 	 do_one_initcall+0x80/0x1c8
> | 	 do_init_module+0x60/0x218
> | 	 load_module+0x1ba4/0x1d70
> | 	 __do_sys_init_module+0x198/0x1d0
> | 	 __arm64_sys_init_module+0x1c/0x28
> | 	 invoke_syscall+0x48/0x114
> | 	 el0_svc_common.constprop.0+0x40/0xe0
> | 	 do_el0_svc+0x1c/0x28
> | 	 el0_svc+0x34/0xd8
> | 	 el0t_64_sync_handler+0x120/0x12c
> | 	 el0t_64_sync+0x190/0x194
> | 	Code: d0ffffe0 910003fd 91000000 9400000b (d4210000)
> | 	---[ end trace 0000000000000000 ]---
> | 	Kernel panic - not syncing: BRK handler: Fatal exception
> | 
> | Fix this by always aligning the end of a bug_entry to 4 bytes, which is
> | correct regardless of CONFIG_DEBUG_BUGVERBOSE.
> | 
> | Fixes: 9fb7410f955f ("arm64/BUG: Use BRK instruction for generic BUG traps")
> | Signed-off-by: Yuanbin Xie <xieyuanbin1@huawei.com>
> | Signed-off-by: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
> 
> With that:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
> 

Thank you very much for your patience and professional review.

Indeed, we have not clearly expressed the specific layout
of `struct bug_entry` under the arm64 ABI
and how it causes the problem. We have only briefly described
that the assembly code does not consistent with
the binary layout of the C struct.

Your commit messge is much more accurate
in describing the problem, and we couldn't agree more.

I will follow your advice to submit our V2 patch.

