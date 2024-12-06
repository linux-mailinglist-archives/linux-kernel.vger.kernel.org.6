Return-Path: <linux-kernel+bounces-435754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC399E7BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 23:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE84316D742
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 22:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D121F472F;
	Fri,  6 Dec 2024 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="LTuak8sm"
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE722C6C3
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733524996; cv=none; b=SbXEzDBjWtGN0mYPkGyTJzmIxAaPumczps8cfDlgzTPD15dLeDDdaQtlqZrDu+nULsXRH9fZXtKSRrey3swCfaaeUiUoTy/+5TutHAw/fDxyt3TebrYQo+dsTQzfsKrv4dD9wF1ecAX6KF//JLVb1M3iWdfJALQvsYM2zxNhEjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733524996; c=relaxed/simple;
	bh=phssO+WypSeTR7z4Ne4+tcv+HghbojHTDiuBwB2kKGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEXdOBinZEndWqtZVfa9tV9Vw71P3ZmOntFBnUw4Z2ywUNzdi9+645cxVatOb3bZBAnKMxgQv1T1NkI8BD5cbuWM/QmS2Pcm3i1fUjXhOpXKI5LsEpklLahhGHsDnVBfLvY58qD7vjIXAMbnkYlNIUWNQ4mPk4TaD78NOaNeL5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=LTuak8sm; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 2E28F340069;
	Fri,  6 Dec 2024 22:43:12 +0000 (UTC)
Received: from [192.168.100.159] (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 92D0513C2B0;
	Fri,  6 Dec 2024 14:43:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 92D0513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1733524991;
	bh=phssO+WypSeTR7z4Ne4+tcv+HghbojHTDiuBwB2kKGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LTuak8smAqeWSsvN2tXxos6zfgKgxU70HuNsq9t/ucqwUpi7rGYwUGCarqx0o2z/L
	 1r6PPyvpOo51RfWTzHRmo/GtOnepJu9Lzm1rQkCsbTrLkE/ew5uC/1gALsonN24Ta6
	 PWclAJWo+GZmKwCZSG6iFIV5Gh+UuF3wq/WLZv/8=
Message-ID: <dcec571e-4f84-b12b-b931-4dbfb3f8bd98@candelatech.com>
Date: Fri, 6 Dec 2024 14:43:11 -0800
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
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <CAJuCfpGk6kyAAEUakMTNvJWmo98Gfbrk22+yZNEwO0eMbRc1Og@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1733524993-fJhQwq_NxnvD
X-MDID-O:
 us5;at1;1733524993;fJhQwq_NxnvD;<greearb@candelatech.com>;b4c026870a3b52e78af0ca2564020f08
X-PPE-TRUSTED: V=1;DIR=OUT;

On 12/6/24 14:03, Suren Baghdasaryan wrote:
> On Fri, Dec 6, 2024 at 1:50 PM Ben Greear <greearb@candelatech.com> wrote:
>>
>> Hello Suren,
>>
>> My system crashes on bootup, and I bisected to this commit.
>>
>> 0f9b685626daa2f8e19a9788625c9b624c223e45 is the first bad commit
>> commit 0f9b685626daa2f8e19a9788625c9b624c223e45
>> Author: Suren Baghdasaryan <surenb@google.com>
>> Date:   Wed Oct 23 10:07:57 2024 -0700
>>
>>       alloc_tag: populate memory for module tags as needed
>>
>>       The memory reserved for module tags does not need to be backed by physical
>>       pages until there are tags to store there.  Change the way we reserve this
>>       memory to allocate only virtual area for the tags and populate it with
>>       physical pages as needed when we load a module.
>>
>> The crash looks like this:
>>
>> BUG: unable to handle page fault for address: fffffbfff4041000
>> #PF: supervisor read access in kernel mode
>> #PF: error_code(0x0000) - not-present page
>> PGD 44d0e7067 P4D 44d0e7067 PUD 44d0e3067 PMD 10bb38067 PTE 0
>> Oops: Oops: 0000 [#1] PREEMPT SMP KASAN
>> CPU: 0 UID: 0 PID: 319 Comm: systemd-udevd Not tainted 6.12.0-rc6+ #21
>> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
>> RIP: 0010:kasan_check_range+0xa5/0x190
>> Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 ce 00 00 00 45 89 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 d0 0f 84 b29
>> RSP: 0018:ffff88812c26f980 EFLAGS: 00010206
>> RAX: fffffbfff4041000 RBX: fffffbfff404101e RCX: ffffffff814ec29b
>> [  OK  DX: fffffbfff4041018 RSI: 00000000000000f0 RDI: ffffffffa0208000
>> 0m] Finished BP: fffffbfff4041000 R08: 0000000000000001 R09: fffffbfff404101d
>> ;1;39msystemd-udR10: ffffffffa02080ef R11: 0000000000000003 R12: ffffffffa0208000
>> ev-trig…e R13: ffffc90000dac7c8 R14: ffffc90000dac7e8 R15: dffffc0000000000
>> - Coldplug All uFS:  00007fe869216b40(0000) GS:ffff88841da00000(0000) knlGS:0000000000000000
>> dev Devices.
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: fffffbfff4041000 CR3: 0000000121e86002 CR4: 00000000003706f0
>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>> Call Trace:
>>    <TASK>
>> [  OK  ? __die+0x1f/0x60
>> 0m] Reached targ ? page_fault_oops+0x258/0x910
>> et sysi ? dump_pagetable+0x690/0x690
>> nit.target - ? search_bpf_extables+0x22/0x250
>>    System Initiali ? trace_page_fault_kernel+0x120/0x120
>> zation.
>>    ? search_bpf_extables+0x164/0x250
>>    ? kasan_check_range+0xa5/0x190
>>    ? fixup_exception+0x4d/0xc70
>>    ? exc_page_fault+0xe1/0xf0
>> [  OK  ? asm_exc_page_fault+0x22/0x30
>> 0m] Reached targ ? load_module+0x3d7b/0x7560
>> et netw ? kasan_check_range+0xa5/0x190
>> ork.target - __asan_memcpy+0x38/0x60
>>    Network.
>>    load_module+0x3d7b/0x7560
>>    ? module_frob_arch_sections+0x30/0x30
>>    ? lockdep_lock+0xbe/0x1b0
>>    ? rw_verify_area+0x18d/0x5e0
>>    ? kernel_read_file+0x246/0x870
>>    ? __x64_sys_fspick+0x290/0x290
>>    ? init_module_from_file+0xd1/0x130
>>    init_module_from_file+0xd1/0x130
>>    ? __ia32_sys_init_module+0xa0/0xa0
>>    ? lock_acquire+0x2d/0xb0
>>    ? idempotent_init_module+0x116/0x790
>>    ? do_raw_spin_unlock+0x54/0x220
>>    idempotent_init_module+0x226/0x790
>>    ? init_module_from_file+0x130/0x130
>>    ? vm_mmap_pgoff+0x203/0x2e0
>>    __x64_sys_finit_module+0xba/0x130
>>    do_syscall_64+0x69/0x160
>>    entry_SYSCALL_64_after_hwframe+0x4b/0x53
>> RIP: 0033:0x7fe869de327d
>> Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 248
>> RSP: 002b:00007ffe34a828d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
>> RAX: ffffffffffffffda RBX: 0000557fa8f3f3f0 RCX: 00007fe869de327d
>> RDX: 0000000000000000 RSI: 00007fe869f4943c RDI: 0000000000000006
>> RBP: 00007fe869f4943c R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
>> R13: 0000557fa8f3f030 R14: 0000000000000000 R15: 0000557fa8f3d110
>>    </TASK>
>> Modules linked in:
>> CR2: fffffbfff4041000
>> ---[ end trace 0000000000000000 ]---
>>
>> I suspect you only hit this with an unlucky amount of debugging enabled.  The kernel config I used
>> is found here:
>>
>> http://www.candelatech.com/downloads/cfg-kasan-crash-regression.config
>>
>> I will be happy to test fixes.
> 
> Hi Ben,
> Thanks for reporting the issue. Do you have these recent fixes in your tree:
> 
> https://lore.kernel.org/all/20241130001423.1114965-1-surenb@google.com/
> https://lore.kernel.org/all/20241205170528.81000-1-hao.ge@linux.dev/
> 
> If not, couple you please apply them and see if the issue is still happening?
> Thanks,
> Suren.

Hello Suren,

Thanks for the quick response.  The first patch is already in latest Linus tree,
and I applied the second one manually.  The kernel still crashes:

(gdb) l *(load_module+0x3c46)
0xffffffff814f30d6 is in load_module (/home/greearb/git/linux-2.6/kernel/module/main.c:2624).
2619				if (i == info->index.mod &&
2620				   (WARN_ON_ONCE(shdr->sh_size != sizeof(struct module)))) {
2621					ret = -ENOEXEC;
2622					goto out_err;
2623				}
2624				memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size);
2625			}
2626			/*
2627			 * Update the userspace copy's ELF section address to point to
2628			 * our newly allocated memory as a pure convenience so that
(gdb)

(gdb) l *(__asan_memcpy+0x38)
0xffffffff81b39268 is in __asan_memcpy (/home/greearb/git/linux-2.6/mm/kasan/shadow.c:105).
100	EXPORT_SYMBOL(__asan_memmove);
101	#endif
102	
103	void *__asan_memcpy(void *dest, const void *src, ssize_t len)
104	{
105		if (!kasan_check_range(src, len, false, _RET_IP_) ||
106		    !kasan_check_range(dest, len, true, _RET_IP_))
107			return NULL;
108	
109		return __memcpy(dest, src, len);
(gdb)

(gdb) l *(kasan_check_range+0xa5)
0xffffffff81b386f5 is in kasan_check_range (/home/greearb/git/linux-2.6/mm/kasan/generic.c:116).
111			start += prefix;
112		}
113	
114		words = (end - start) / 8;
115		while (words) {
116			if (unlikely(*(u64 *)start))
117				return bytes_is_nonzero(start, 8);
118			start += 8;
119			words--;
120		}
(gdb)


BUG: unable to handle page fault for address: fffffbfff4041000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 44d0e7067 P4D 44d0e7067 PUD 44d0e3067 PMD 10bb3d067 PTE 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 7 UID: 0 PID: 319 Comm: systemd-udevd Not tainted 6.13.0-rc1+ #24
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 02/15/2023
RIP: 0010:kasan_check_range+0xa5/0x190
Code: 8d 5a 07 4c 0f 49 da 49 c1 fb 03 45 85 db 0f 84 ce 00 00 00 45 89 db 4a 8d 14 d8 eb 0d 48 83 c0 08 48 39 d0 0f 84 b29
RSP: 0018:ffff88812d3ef980 EFLAGS: 00010206
RAX: fffffbfff4041000 RBX: fffffbfff404101e RCX: ffffffff814f30d6
RDX: fffffbfff4041018 RSI: 00000000000000f0 RDI: ffffffffa0208000
[  OK  BP: fffffbfff4041000 R08: 0000000000000001 R09: fffffbfff404101d
0m] Finished 10: ffffffffa02080ef R11: 0000000000000003 R12: ffffffffa0208000
;1;39msystemd-udR13: ffffc90000dac930 R14: ffffc90000dac950 R15: dffffc0000000000
ev-trig…e FS:  00007fc25423bb40(0000) GS:ffff88841dd80000(0000) knlGS:0000000000000000
- Coldplug All uCS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff4041000 CR3: 0000000128ef4003 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <TASK>
  ? __die+0x1f/0x60
  ? page_fault_oops+0x258/0x910
  ? dump_pagetable+0x690/0x690
  ? search_bpf_extables+0x22/0x250
  ? show_ldttss+0x230/0x230
  ? search_bpf_extables+0x164/0x250
  ? kasan_check_range+0xa5/0x190
  ? fixup_exception+0x4d/0xc70
  ? exc_page_fault+0xe1/0xf0
  ? asm_exc_page_fault+0x22/0x30
  ? load_module+0x3c46/0x8680
  ? kasan_check_range+0xa5/0x190
  __asan_memcpy+0x38/0x60
  load_module+0x3c46/0x8680
  ? __kernel_read+0x270/0x9f0
  ? module_frob_arch_sections+0x30/0x30
  ? lockdep_lock+0xbe/0x1b0
  ? rw_verify_area+0x18d/0x5e0
  ? kernel_read_file+0x246/0x870
  ? __x64_sys_fspick+0x290/0x290
  ? init_module_from_file+0xd1/0x130
  init_module_from_file+0xd1/0x130
  ? __ia32_sys_init_module+0xa0/0xa0
  ? lock_acquire+0x2d/0xb0
  ? idempotent_init_module+0x10d/0x780
  ? do_raw_spin_unlock+0x54/0x220
  idempotent_init_module+0x21d/0x780
  ? init_module_from_file+0x130/0x130
  ? __fget_files+0x1a5/0x2d0
  __x64_sys_finit_module+0xbe/0x130
  do_syscall_64+0x69/0x160
  entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7fc254e0827d
Code: 5d c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 248
RSP: 002b:00007ffe1750a718 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000055da274c5500 RCX: 00007fc254e0827d
RDX: 0000000000000000 RSI: 00007fc254f6e43c RDI: 0000000000000006
RBP: 00007fc254f6e43c R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000246 R12: 0000000000020000
R13: 000055da2749cbb0 R14: 0000000000000000 R15: 000055da274c44a0
  </TASK>
Modules linked in:
CR2: fffffbfff4041000
---[ end trace 0000000000000000 ]---

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com



