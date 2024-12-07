Return-Path: <linux-kernel+bounces-435822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722409E7DA1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8D0286B87
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10968F49;
	Sat,  7 Dec 2024 00:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="OL8coNuA"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000B310F4
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733532615; cv=none; b=Dgbr9mkh29AOnxMl51GGkmCBRqhcMrPJP+ipdyRRCFIW+ZpHq2YUhpMAjLEVKvLIYgODrZOGivZsds5tsRpKyapp1Dygw2Ur2NeTrYXu+H8YkjEMnayZuqSf7gR3Kb7erTh265W2PCXeNdNKMyV/FMIi0nM7M5vNFCLSuQ41an4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733532615; c=relaxed/simple;
	bh=YZpBsaC1xhfe2qREt85maDoM9mOg7g/MhAhwuGl0NCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KTyAefg0l3hBpOjttNmoGh7phCFORzKaBlN75ZWAr1+MHyQMV4pbRdTdiGsV3GTVO+SuTTWNW5A0wFcUSytXMQ/7Vr+iZMt6oMmjJmRbn+/5E2tcxnvcKTVR3cJA33nMp+OEtgeX6/n60YmXy12NVo03pWuEE52sotAQh3iAzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=OL8coNuA; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 89DA63C0070;
	Sat,  7 Dec 2024 00:50:10 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 036F413C2B0;
	Fri,  6 Dec 2024 16:50:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 036F413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1733532610;
	bh=YZpBsaC1xhfe2qREt85maDoM9mOg7g/MhAhwuGl0NCY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OL8coNuAUScZKoTv7TE1p59d3+axkBAJr+qxYVJMdw9GiPPywvAxnoAsNu5/FWmy8
	 5NZN3C6wVrZZWf1Jg1MGYUVxyjjktJDDbHM34h9CfyA1+jPUcqXMiX3/rHk+i/frfT
	 xiS2gEB6ZDORIPJLBHgYuKrPtGXi6fFel/nXtuAc=
Message-ID: <eca69b03-9b89-af2a-d1b0-38f76675b165@candelatech.com>
Date: Fri, 6 Dec 2024 16:50:09 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: BISECTED: 'alloc_tag: populate memory for module tags as needed'
 crashes on boot.
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <1ba0cc57-e2ed-caa2-1241-aa5615bee01f@candelatech.com>
 <CAJuCfpGk6kyAAEUakMTNvJWmo98Gfbrk22+yZNEwO0eMbRc1Og@mail.gmail.com>
 <dcec571e-4f84-b12b-b931-4dbfb3f8bd98@candelatech.com>
 <CAJuCfpEwmTXkMHRdY0USwPFoWcC3d3j6r=6SRV39uP3KG6b5iA@mail.gmail.com>
 <CAJuCfpGUey5wAmL1Cgi2d-RQ=b0cqWXbo3HxvD-bomodg+GJrw@mail.gmail.com>
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <CAJuCfpGUey5wAmL1Cgi2d-RQ=b0cqWXbo3HxvD-bomodg+GJrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1733532611-C5Dj7ewo51hW
X-MDID-O:
 us5;at1;1733532611;C5Dj7ewo51hW;<greearb@candelatech.com>;b4c026870a3b52e78af0ca2564020f08
X-PPE-TRUSTED: V=1;DIR=OUT;

On 12/6/24 16:15, Suren Baghdasaryan wrote:
> On Fri, Dec 6, 2024 at 2:55 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> On Fri, Dec 6, 2024 at 2:43 PM Ben Greear <greearb@candelatech.com> wrote:
>>>
>>> On 12/6/24 14:03, Suren Baghdasaryan wrote:
>>>> On Fri, Dec 6, 2024 at 1:50 PM Ben Greear <greearb@candelatech.com> wrote:
>>>>>
>>>>> Hello Suren,
>>>>>
>>>>> My system crashes on bootup, and I bisected to this commit.
>>>>>
>>>>> 0f9b685626daa2f8e19a9788625c9b624c223e45 is the first bad commit
>>>>> commit 0f9b685626daa2f8e19a9788625c9b624c223e45
>>>>> Author: Suren Baghdasaryan <surenb@google.com>
>>>>> Date:   Wed Oct 23 10:07:57 2024 -0700
>>>>>
>>>>>        alloc_tag: populate memory for module tags as needed
>>>>>
>>>>>        The memory reserved for module tags does not need to be backed by physical
>>>>>        pages until there are tags to store there.  Change the way we reserve this
>>>>>        memory to allocate only virtual area for the tags and populate it with
>>>>>        physical pages as needed when we load a module.
>>>>>
>>>>> The crash looks like this:
>>>>>
>>>>> BUG: unable to handle page fault for address: fffffbfff4041000
>>>>> #PF: supervisor read access in kernel mode
>>>>> #PF: error_code(0x0000) - not-present page
>>>>> PGD 44d0e7067 P4D 44d0e7067 PUD 44d0e3067 PMD 10bb38067 PTE 0
>>>>> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN
>>>>> CPU: 0 UID: 0 PID: 319 Comm: systemd-udevd Not tainted 6.12.0-rc6+ #21
>>>>> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
>>>>> RIP: 0010:kasan_check_range+0xa5/0x190
>>>>> Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 ce 00 00 00 45 89 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 d0 0f 84 b29
>>>>> RSP: 0018:ffff88812c26f980 EFLAGS: 00010206
>>>>> RAX: fffffbfff4041000 RBX: fffffbfff404101e RCX: ffffffff814ec29b
>>>>> [  OK  DX: fffffbfff4041018 RSI: 00000000000000f0 RDI: ffffffffa0208000
>>>>> 0m] Finished BP: fffffbfff4041000 R08: 0000000000000001 R09: fffffbfff404101d
>>>>> ;1;39msystemd-udR10: ffffffffa02080ef R11: 0000000000000003 R12: ffffffffa0208000
>>>>> ev-trig…e R13: ffffc90000dac7c8 R14: ffffc90000dac7e8 R15: dffffc0000000000
>>>>> - Coldplug All uFS:  00007fe869216b40(0000) GS:ffff88841da00000(0000) knlGS:0000000000000000
>>>>> dev Devices.
>>>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>> CR2: fffffbfff4041000 CR3: 0000000121e86002 CR4: 00000000003706f0
>>>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>>>> Call Trace:
>>>>>     <TASK>
>>>>> [  OK  ? __die+0x1f/0x60
>>>>> 0m] Reached targ ? page_fault_oops+0x258/0x910
>>>>> et sysi ? dump_pagetable+0x690/0x690
>>>>> nit.target - ? search_bpf_extables+0x22/0x250
>>>>>     System Initiali ? trace_page_fault_kernel+0x120/0x120
>>>>> zation.
>>>>>     ? search_bpf_extables+0x164/0x250
>>>>>     ? kasan_check_range+0xa5/0x190
>>>>>     ? fixup_exception+0x4d/0xc70
>>>>>     ? exc_page_fault+0xe1/0xf0
>>>>> [  OK  ? asm_exc_page_fault+0x22/0x30
>>>>> 0m] Reached targ ? load_module+0x3d7b/0x7560
>>>>> et netw ? kasan_check_range+0xa5/0x190
>>>>> ork.target - __asan_memcpy+0x38/0x60
>>>>>     Network.
>>>>>     load_module+0x3d7b/0x7560
>>>>>     ? module_frob_arch_sections+0x30/0x30
>>>>>     ? lockdep_lock+0xbe/0x1b0
>>>>>     ? rw_verify_area+0x18d/0x5e0
>>>>>     ? kernel_read_file+0x246/0x870
>>>>>     ? __x64_sys_fspick+0x290/0x290
>>>>>     ? init_module_from_file+0xd1/0x130
>>>>>     init_module_from_file+0xd1/0x130
>>>>>     ? __ia32_sys_init_module+0xa0/0xa0
>>>>>     ? lock_acquire+0x2d/0xb0
>>>>>     ? idempotent_init_module+0x116/0x790
>>>>>     ? do_raw_spin_unlock+0x54/0x220
>>>>>     idempotent_init_module+0x226/0x790
>>>>>     ? init_module_from_file+0x130/0x130
>>>>>     ? vm_mmap_pgoff+0x203/0x2e0
>>>>>     __x64_sys_finit_module+0xba/0x130
>>>>>     do_syscall_64+0x69/0x160
>>>>>     entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>>>> RIP: 0033:0x7fe869de327d
>>>>> Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 248
>>>>> RSP: 002b:00007ffe34a828d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>>>>> RAX: ffffffffffffffda RBX: 0000557fa8f3f3f0 RCX: 00007fe869de327d
>>>>> RDX: 0000000000000000 RSI: 00007fe869f4943c RDI: 0000000000000006
>>>>> RBP: 00007fe869f4943c R08: 0000000000000000 R09: 0000000000000000
>>>>> R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
>>>>> R13: 0000557fa8f3f030 R14: 0000000000000000 R15: 0000557fa8f3d110
>>>>>     </TASK>
>>>>> Modules linked in:
>>>>> CR2: fffffbfff4041000
>>>>> ---[ end trace 0000000000000000 ]---
>>>>>
>>>>> I suspect you only hit this with an unlucky amount of debugging enabled.  The kernel config I used
>>>>> is found here:
>>>>>
>>>>> http://www.candelatech.com/downloads/cfg-kasan-crash-regression.config
>>>>>
>>>>> I will be happy to test fixes.
>>>>
>>>> Hi Ben,
>>>> Thanks for reporting the issue. Do you have these recent fixes in your tree:
>>>>
>>>> https://lore.kernel.org/all/20241130001423.1114965-1-surenb@google.com/
>>>> https://lore.kernel.org/all/20241205170528.81000-1-hao.ge@linux.dev/
>>>>
>>>> If not, couple you please apply them and see if the issue is still happening?
>>>> Thanks,
>>>> Suren.
>>>
>>> Hello Suren,
>>>
>>> Thanks for the quick response.  The first patch is already in latest Linus tree,
> 
> Hmm. Could you please double-check which tree you are using? I don't
> see the first patch
> (https://lore.kernel.org/all/20241130001423.1114965-1-surenb@google.com/)
> in Linus' tree. Maybe you are using linux-next?

Sorry, you are correct.  I must have mangled something when trying to apply
the patch and I didn't look hard enough when patch said changes were already applied.

I can re-test this next week...and for reference, kernel boots fine when you disable
KASAN and other debugging.

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



