Return-Path: <linux-kernel+bounces-400397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D789C0CF2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C7D284FD8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06C3215F58;
	Thu,  7 Nov 2024 17:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="zcc/GNvw"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B94925771
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000774; cv=none; b=qAMlUp9sOHNHr8mD2xevUK7lDf5MgXtmSD8HlaBVWSpvEJavpjRdj7PhibLWRNuwIJnAZmyhc3tfVxgPdeaGnnSDKTUSSZUvE5qaTtqEvTnFBiLgscwW4vLax1KeyKPYBw685ecYJsrUkSSa+c9dniY1AelZB4bMu0Ll9a74fHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000774; c=relaxed/simple;
	bh=dDS3Av2u4bLCuCO6fr0uDRNY9hzb3IazY71L1OrrI/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SnZzzk+OTbm6kci8Z7oRSnTIpw2yNUrgznnvDxOgoDb+aWxV19YZTHPMU4/d2/WvQq7Pf+YwrKYo28gdfY61ckoJX2onw384Fn5ddCeF9cY+z/bczJdZvZKdy2WXJqByhEQlQdlNqlXgUobZ81WpeOh/Xe0/agb4e5rQsemPX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=zcc/GNvw; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id BDEC141A48;
	Thu,  7 Nov 2024 17:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1731000768;
	bh=dDS3Av2u4bLCuCO6fr0uDRNY9hzb3IazY71L1OrrI/w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=zcc/GNvwd0sM9yseZCLm0MqKSUwqsKljhMn9rxNEcueHP1vXqufyh5NB78/4xU14b
	 zPfOxgjGPtMA7KJDER3szdZJ3cX99KMn5eDgjh4hwXx9dIuE7jiwNXp+hUAPaOY7/R
	 TgspuMQwjTw2/O0f0hyFZkOWqzIgVtGk8yNzSKzjNO8iLSZRWs9jxX1ZF71sBW7LSc
	 GeMlFLm42deYIEyG96HQXkbrq/YOo8NvyaFQm5DofGQitMot6eAJnYd07vqdebx4C9
	 M/R0FdqpnaGmEzqkCj6bWZ/iwb1vpzGIFoiH6McvtliAB45o/oRap04IsKUhYTXeLG
	 Yghq3R0Tq3xbw==
Message-ID: <64d386e8-6684-4213-8aba-7d1daf94f2cf@asahilina.net>
Date: Fri, 8 Nov 2024 02:32:47 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: Fix __wp_page_copy_user fallback path for remote mm
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Sergio Lopez Pascual <slp@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20241101-mm-remote-pfn-v1-1-080b609270b7@asahilina.net>
 <c00226ea-6e29-4432-a1c4-a25e9e05df9c@redhat.com>
 <2d8380b9-3d03-4263-b5bf-7e0227c83ba9@asahilina.net>
 <0977a33b-8318-43a5-a5a1-4eb8c93ca270@redhat.com>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <0977a33b-8318-43a5-a5a1-4eb8c93ca270@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/8/24 2:14 AM, David Hildenbrand wrote:
> On 07.11.24 17:43, Asahi Lina wrote:
>> On 11/5/24 9:03 PM, David Hildenbrand wrote:
>>> On 01.11.24 13:08, Asahi Lina wrote:
>>>> If the source page is a PFN mapping, we copy back from userspace.
>>>> However, if this fault is a remote access, we cannot use
>>>> __copy_from_user_inatomic. Instead, use access_remote_vm() in this
>>>> case.
>>>>
>>>> Fixes WARN and incorrect zero-filling when writing to CoW mappings in
>>>> a remote process, such as when using gdb on a binary present on a DAX
>>>> filesystem.
>>>>
>>>> [  143.683782] ------------[ cut here ]------------
>>>> [  143.683784] WARNING: CPU: 1 PID: 350 at mm/memory.c:2904
>>>> __wp_page_copy_user+0x120/0x2bc
>>>> [  143.683793] CPU: 1 PID: 350 Comm: gdb Not tainted 6.6.52 #1
>>>> [  143.683794] Hardware name: linux,dummy-virt (DT)
>>>> [  143.683795] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS
>>>> BTYPE=--)
>>>> [  143.683796] pc : __wp_page_copy_user+0x120/0x2bc
>>>> [  143.683798] lr : __wp_page_copy_user+0x254/0x2bc
>>>> [  143.683799] sp : ffff80008272b8b0
>>>> [  143.683799] x29: ffff80008272b8b0 x28: 0000000000000000 x27:
>>>> ffff000083bad580
>>>> [  143.683801] x26: 0000000000000000 x25: 0000fffff7fd5000 x24:
>>>> ffff000081db04c0
>>>> [  143.683802] x23: ffff00014f24b000 x22: fffffc00053c92c0 x21:
>>>> ffff000083502150
>>>> [  143.683803] x20: 0000fffff7fd5000 x19: ffff80008272b9d0 x18:
>>>> 0000000000000000
>>>> [  143.683804] x17: ffff000081db0500 x16: ffff800080fe52a0 x15:
>>>> 0000fffff7fd5000
>>>> [  143.683804] x14: 0000000000bb1845 x13: 0000000000000080 x12:
>>>> ffff80008272b880
>>>> [  143.683805] x11: ffff000081d13600 x10: ffff000081d13608 x9 :
>>>> ffff000081d1360c
>>>> [  143.683806] x8 : ffff000083a16f00 x7 : 0000000000000010 x6 :
>>>> ffff00014f24b000
>>>> [  143.683807] x5 : ffff00014f24c000 x4 : 0000000000000000 x3 :
>>>> ffff000083582000
>>>> [  143.683807] x2 : 0000000000000f80 x1 : 0000fffff7fd5000 x0 :
>>>> 0000000000001000
>>>> [  143.683808] Call trace:
>>>> [  143.683809]  __wp_page_copy_user+0x120/0x2bc
>>>> [  143.683810]  wp_page_copy+0x98/0x5c0
>>>> [  143.683813]  do_wp_page+0x250/0x530
>>>> [  143.683814]  __handle_mm_fault+0x278/0x284
>>>> [  143.683817]  handle_mm_fault+0x64/0x1e8
>>>> [  143.683819]  faultin_page+0x5c/0x110
>>>> [  143.683820]  __get_user_pages+0xc8/0x2f4
>>>> [  143.683821]  get_user_pages_remote+0xac/0x30c
>>>> [  143.683823]  __access_remote_vm+0xb4/0x368
>>>> [  143.683824]  access_remote_vm+0x10/0x1c
>>>> [  143.683826]  mem_rw.isra.0+0xc4/0x218
>>>> [  143.683831]  mem_write+0x18/0x24
>>>> [  143.683831]  vfs_write+0xa0/0x37c
>>>> [  143.683834]  ksys_pwrite64+0x7c/0xc0
>>>> [  143.683834]  __arm64_sys_pwrite64+0x20/0x2c
>>>> [  143.683835]  invoke_syscall+0x48/0x10c
>>>> [  143.683837]  el0_svc_common.constprop.0+0x40/0xe0
>>>> [  143.683839]  do_el0_svc+0x1c/0x28
>>>> [  143.683841]  el0_svc+0x3c/0xdc
>>>> [  143.683846]  el0t_64_sync_handler+0x120/0x12c
>>>> [  143.683848]  el0t_64_sync+0x194/0x198
>>>> [  143.683849] ---[ end trace 0000000000000000 ]---
>>>>
>>>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>>>> ---
>>>>    mm/memory.c | 7 ++++++-
>>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index
>>>> 3ccee51adfbbd007b24331fe6874265f231a877b..dba25d9734063ac02cdaeb0a5cd5432473f6372e 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -3081,13 +3081,18 @@ static inline int __wp_page_copy_user(struct
>>>> page *dst, struct page *src,
>>>>                update_mmu_cache_range(vmf, vma, addr, vmf->pte, 1);
>>>>        }
>>>>    +    /* If the mm is a remote mm, copy in the page using
>>>> access_remote_vm() */
>>>> +    if (current->mm != mm) {
>>>> +        if (access_remote_vm(mm, (unsigned long)uaddr, kaddr,
>>>> PAGE_SIZE, 0) != PAGE_SIZE)
>>>
>>> access_remote_vm() will do a mmap_read_lock_killable() and then call
>>> into get_user_page_vma_remote() -- fortunately read-access, otherwise
>>> we'd be in trouble :) .
>>>
>>> So we should already be holding the mmap read lock from the previous
>>> access_remote_vm() users (who we end up here) ... doesn't this complain
>>> with lockdep about recursive locking?
>>>
>>> I keep forgetting locking rules, so I might just be wrong.
>>
>> You're right, this complains with lockdep:
>>
>> [   23.154031]
>> [   23.154093] ============================================
>> [   23.154193] WARNING: possible recursive locking detected
>> [   23.154229] 6.6.52 #2 Not tainted
>> [   23.154270] --------------------------------------------
>> [   23.154306] gdb/349 is trying to acquire lock:
>> [   23.154343] ffff0000862e3450 (&mm->mmap_lock){++++}-{3:3}, at:
>> __access_remote_vm+0x3c/0x3a8
>> [   23.154431]
>> [   23.154431] but task is already holding lock:
>> [   23.154474] ffff0000862e3450 (&mm->mmap_lock){++++}-{3:3}, at:
>> __access_remote_vm+0x3c/0x3a8
>> [   23.154553]
>> [   23.154553] other info that might help us debug this:
>> [   23.154598]  Possible unsafe locking scenario:
>> [   23.154598]
>> [   23.154641]        CPU0
>> [   23.154665]        ----
>> [   23.154685]   lock(&mm->mmap_lock);
>> [   23.154712]   lock(&mm->mmap_lock);
>> [   23.154741]
>> [   23.154741]  *** DEADLOCK ***
>> [   23.154741]
>> [   23.154790]  May be due to missing lock nesting notation
>> [   23.154790]
>> [   23.154838] 2 locks held by gdb/349:
>> [   23.154868]  #0: ffff0000835b53f8 (sb_writers#4){.+.+}-{0:0}, at:
>> vfs_write+0x84/0x2e0
>> [   23.154945]  #1: ffff0000862e3450 (&mm->mmap_lock){++++}-{3:3}, at:
>> __access_remote_vm+0x3c/0x3a8
>> [   23.155023]
>> [   23.155023] stack backtrace:
>> [   23.155060] CPU: 5 PID: 349 Comm: gdb Not tainted 6.6.52 #2
>> [   23.155112] Hardware name: linux,dummy-virt (DT)
>> [   23.155148] Call trace:
>> [   23.155167]  dump_backtrace+0x98/0x118
>> [   23.155209]  show_stack+0x18/0x24
>> [   23.155240]  dump_stack_lvl+0x60/0xac
>> [   23.155292]  dump_stack+0x18/0x24
>> [   23.155320]  print_deadlock_bug+0x260/0x34c
>> [   23.155364]  validate_chain+0x364/0x4c0
>> [   23.155393]  __lock_acquire+0x564/0xb64
>> [   23.155420]  lock_acquire.part.0+0x9c/0x1bc
>> [   23.155448]  lock_acquire+0x9c/0x140
>> [   23.155477]  down_read_killable+0x44/0x158
>> [   23.155521]  __access_remote_vm+0x3c/0x3a8
>> [   23.155562]  __wp_page_copy_user+0x13c/0x3a8
>> [   23.155611]  wp_page_copy+0x98/0x4d8
>> [   23.155640]  do_wp_page+0x290/0x594
>> [   23.155671]  __handle_mm_fault+0x258/0x25c
>> [   23.155712]  handle_mm_fault+0x64/0x1f0
>> [   23.155755]  faultin_page+0x64/0x138
>> [   23.155798]  __get_user_pages+0x11c/0x340
>> [   23.155843]  get_user_pages_remote+0xc4/0x404
>> [   23.155895]  __access_remote_vm+0xf4/0x3a8
>> [   23.155922]  access_remote_vm+0x10/0x1c
>> [   23.155952]  mem_rw.isra.0+0xc4/0x218
>> [   23.155996]  mem_write+0x18/0x24
>> [   23.156023]  vfs_write+0xa4/0x2e0
>> [   23.156066]  ksys_pwrite64+0x7c/0xc0
>> [   23.156109]  __arm64_sys_pwrite64+0x20/0x2c
>> [   23.156152]  invoke_syscall+0x48/0x10c
>> [   23.156196]  el0_svc_common.constprop.0+0x40/0xe0
>> [   23.156249]  do_el0_svc+0x1c/0x28
>> [   23.156293]  el0_svc+0x54/0x140
>> [   23.156334]  el0t_64_sync_handler+0x120/0x12c
>> [   23.156384]  el0t_64_sync+0x194/0x198
>>
>> I guess the locking implementation is recursive so that's why this
>> didn't actually deadlock...
>>
>> I'm not sure what the right way to do this is then. The underlying
>> reason why the fallback code is being called is that do_wp_page() calls
>> vm_normal_page(), which returns NULL for VM_PFNMAP pages. So vmf->page
>> is NULL and __wp_page_copy_user has to use the fallback path. However,
>> the reason GUP works is that follow_page_pte() and friends have a
>> specific fallback path for the pte_devmap() case that grabs a struct
>> page anyway. Maybe similar logic should be in do_wp_page() so it can
>> grab a struct page for PFN mappings too?
> 
> There is currently WIP to remove pte_devmap() and make vm_normal_page()
> return these pages as well.
> 
> But that would not be in VM_PFNMAP mappings, because VM_PFNMAP means
> "don't you ever look at the struct page".
> 
> Likely, you do not have a VM_PFNMAP mapping here but instead a
> VM_MIXEDMAP mapping(or likely no special mapping at all)?
> 
> vm_normal_page() returns NULL for pte_devmap(), independent of
> VM_PFNMAP, because pte_special() should succeed on them.
> 
> 
> 
> I recall that there is still a problem with false-positives on
> folio_test_anon() with ZONE_DEVICE pages, so it's maybe not that
> easy ... and the whole get_dev_pagemap() stuff is nasty.
> 
> Likely we would have to do what GUP does, and temporarily grab a pgmap
> reference. Gah.
> 
> 
> So if we sort out the pagemap stuff and the possibly wrong
> folio_test_anon() on some ZONE_DEVICE pages (but not all, because IIRC
> DEVICE_PRIVATE can be anon ...), it might be doable.
> 
> But it sounds ugly, especially because that code might change soon and
> not require messing with ZONE_DEVICE pages on that level.
> 
> And then, we'd not be able to handle VM_PFNMAP cleanly ...
> 
> 
> Maybe we could test if the PFN has a directmap and simply read using
> that? I mean, that's what kmap_local_page() ends up doing on systems
> without highmem ... and without !defined(HASHED_PAGE_VIRTUAL) && !
> defined(WANT_PAGE_VIRTUAL) the kmap_local_page() really just is a
> page_to_virt(), which is mostly mapping a PFN to the corresponding
> virtual address ...
> 
> But it doesn't universally work ...
> 
>>
>> Or if the problem is just the lock, would just eliding the locking work?
>> I guess that only works if all the calls into wp_page_copy() are
>> guaranteed to hold the mmap lock already, but I don't know if that is
>> true...
> 
> The whole "GUP recursively calling into GUP" code looks concerning.
> Could we even trigger a case where we get a recursive page fault handler
> call, because of some odd race? (concurrent MADV_DONTNEED or similar)
> 
> I think we should much rather fail this remote fault if there is no easy
> way to make it work right now.
> 
> At least I suspect this is primarily a "debugger" scenario that didn't
> work so far and we could leave it "not working because not supported" in
> a nicer way?
> 
> 
> If this really must succeed, I can spend some time thinking about how to
> do this cleaner ...

Well, this breaks debuggers in general on a virtiofs VM mounted with
DAX, which is a sensible use case I think. One reason to use DAX is
avoiding duplication of the page cache between the host and the guest
(or multiple guests).

I think the main reason not that many people are trying DAX across the
board for virtiofs is various bugs that have been slowly fixed, and this
would be one of the remaining ones...

(Full disclosure: For the use case I'm working on we're no longer
mounting the whole rootfs with DAX right now (only a subset) since we're
still evaluating the performance, but I'd like to keep the option open
and having it break debuggers is kind of a blocker...)

~~ Lina


