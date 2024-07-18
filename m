Return-Path: <linux-kernel+bounces-256480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B41934F23
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 16:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B1F01F247C5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8231420D8;
	Thu, 18 Jul 2024 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="QdnCiTX2"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC9B13CFBD
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721313291; cv=none; b=IBzBBf8S8wCnj84W+Us1ls9WqiFV7R0Cc6VqutqMBhstsaBUDxXPU5xvrjCWeJB76JWng2qY5VuXNhUy2BHpBbeEsNpMlnPlBYiFJ8OAmyv6/a1CDWOTpPW7M0HJe5//5+78U3bQT5orhh8pb5kKhYogsdHs8bL8qKX+02M/Xv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721313291; c=relaxed/simple;
	bh=AR63/hcETtASJohZ9xguxEZJyctNf0g51w01h6yoaDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RNg3Vn1KmFt/czHrz//NBFZaKI9gbEaRNk7vO4M6xTvbW4wQ7TKrfruWbV6b6+CC/7/g13wnZ89tggb12YgrMGkiiMRqdUL4OoSWJkRLP8xeM0V7lhcAmfFmzCZoT+4NQHB6dD4bsk09KdTlrH6QtgfFGVUwhf2oAadBb0Gz7O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=QdnCiTX2; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id CDF6143414;
	Thu, 18 Jul 2024 14:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1721313284;
	bh=AR63/hcETtASJohZ9xguxEZJyctNf0g51w01h6yoaDE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QdnCiTX2RhXfk1pr/Z+vTB71lb3swuPMY18EOuvVd7fe39et55SgiRWFiKSYAjAIU
	 4PrbPKMHK0PqQZkgk0FIKjpV2/NC1CjBal6aL6Zh1uG5fc8nY+nNfqt7zh7va+v2df
	 I663bZcyzJrx9TK+k8fU6JNHc3wb05i8nBmjCyhEqHq/iRNjG4AJv/fvpCtgwwv9xr
	 hzB6nAngG1hEz+JN3NrlnPpqHA7KRPEAtPHsh3pe0dnyS5bTv1AyvdC/kQi9WkvLi3
	 WmMOXPvODIRTAN69xSYBvwbE+irL4XdGjDtAFbeLpe0C0IYAzmEaUWJi5q37Wi5B7+
	 yH3ECt8zv8XUA==
Message-ID: <66508848-7bf3-44ac-92b5-0836960e852e@asahilina.net>
Date: Thu, 18 Jul 2024 23:34:38 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LPA2 on non-LPA2 hardware broken with 16K pages
To: Will Deacon <will@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>, ryan.roberts@arm.com,
 mark.rutland@arm.com, ardb@kernel.org
References: <50360968-13fb-4e6f-8f52-1725b3177215@asahilina.net>
 <20240718131428.GA21243@willie-the-truck>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <20240718131428.GA21243@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 7/18/24 10:14 PM, Will Deacon wrote:
> Hi Lina, [+Ard, Mark and Ryan],
> 
> On Thu, Jul 18, 2024 at 06:39:10PM +0900, Asahi Lina wrote:
>> I ran into this with the Asahi Linux downstream kernel, based on v6.9.9,
>> but I believe the problem is also still upstream. The issue seems to be
>> an interaction between folding one page table level at compile time and
>> another one at runtime.
> 
> Thanks for reporting this!
> 
>> With this config, we have:
>>
>> CONFIG_PGTABLE_LEVELS=4
>> PAGE_SHIFT=14
>> PMD_SHIFT=25
>> PUD_SHIFT=36
>> PGDIR_SHIFT=47
>> pgtable_l5_enabled() == false (compile time)
>> pgtable_l4_enabled() == false (runtime, due to no LPA2)
> 
> I think this is 'defconfig' w/ 16k pages, although I wasn't able to
> trigger the issue quickly under QEMU with that. Your analysis looks
> correct, however.

Yes, it should be. I first ran into the issue with a .config that was
derived from defconfig that someone sent me while trying to debug a
different problem.

[snip]

> Cheers for the explanation; I agree that 6.10 looks like it's affected
> in the same way, even though I couldn't reproduce the crash. I think the
> root of the problem is that p4d_offset_lockless() returns a stack
> address when the p4d level is folded. I wondered about changing the
> dummy pXd_offset_lockless() definitions in linux/pgtable.h to pass the
> real pointer through instead of the address of the local, but then I
> suppose _most_ pXd_offset() implementations are going to dereference
> that and it would break the whole point of having _lockless routines
> to start with.
> 
> What if we provided our own implementation of p4d_offset_lockless()
> for the folding case, which could just propagate the page-table pointer?
> Diff below.

That seems to work, it neither reproduces the oopses outright nor
triggers any of the random sanity checks I sprinkled around gup.c while
debugging this to try to make it fail early ^^

> 
>> This causes random oopses in internal_get_user_pages_fast and related
>> codepaths.
> 
> Do you have a reliable way to trigger those? I tried doing some GUPpy
> things like strace (access_process_vm()) but it all seemed fine.

It's a bit weird because I had kernel builds where it didn't obviously
happen most of the time. During my latest round tracking this down
though, it almost 100% reliably triggered with a simple boot of a Fedora
system, usually in an `lvm` process during boot (lvm2-monitor.service).

The lvm crashes look like this, and I also got this trace in
systemd-journald once:

 internal_get_user_pages_fast+0x420/0x1728
 pin_user_pages_fast+0x9c/0xc4
 iov_iter_extract_pages+0x234/0x1044
 bio_iov_iter_get_pages+0x248/0xa90
 blkdev_direct_IO.part.0+0x3a0/0x143c
 blkdev_read_iter+0x1cc/0x388
 aio_read.constprop.0+0x1e0/0x324
 io_submit_one.constprop.0+0x378/0x1470
 __arm64_sys_io_submit+0x198/0x2d0
 invoke_syscall.constprop.0+0xd8/0x1e0
 do_el0_svc+0xc4/0x1e0
 el0_svc+0x48/0xc0
 el0t_64_sync_handler+0x120/0x130
 el0t_64_sync+0x190/0x194

Right now with my kernel build, this happens basically every boot.
However, it wasn't always like that, and I'm not sure what other
environmental differences affect the outcome. I guess since it's reading
random stack memory, it depends on what's there...

I disabled lvm2-monitor.service and tried to boot again (to unwedge
things) and this time it oopsed in udisksd like this (I recall seeing
this one before too):

 internal_get_user_pages_fast+0x420/0x1728
 pin_user_pages_fast+0x9c/0xc4
 iov_iter_extract_pages+0x234/0x1044
 bio_map_user_iov+0x214/0x724
 blk_rq_map_user_iov+0x8b0/0x1080
 blk_rq_map_user_io+0x138/0x17c
 nvme_map_user_request.isra.0+0x2b4/0x3d8
 nvme_submit_user_cmd.isra.0+0x21c/0x300
 nvme_user_cmd.isra.0+0x200/0x3fc
 nvme_dev_ioctl+0x284/0x480
 __arm64_sys_ioctl+0x550/0x1b80
 invoke_syscall.constprop.0+0xd8/0x1e0
 do_el0_svc+0xc4/0x1e0
 el0_svc+0x48/0xc0
 el0t_64_sync_handler+0x120/0x130
 el0t_64_sync+0x190/0x194

Prior to this I was testing with glmark2 (this whole thing started with
me trying to debug a downstream GPU driver issue, which I now realize is
a completely unrelated bug but it led me down this rabbit hole because
it was first reported by someone coincidentally compiling with LPA2 on).
I use this process termination torture test incantation, and I just
confirmed that it still oopses even with just a simpledrm framebuffer
and llvmpipe (software rendering) and no GPU/"full" KMS drivers compiled
in, so it should be reproducible on other platforms hopefully. The repro
is reliable within a few seconds. Running on KDE Plasma for whatever
that's worth:

while true; do WAYLAND_DISPLAY=wayland-0 timeout -s TERM -k 0 0.5
glmark2-es2-wayland & sleep 0.02 ; done

The trace looks like:

[  301.830742]  internal_get_user_pages_fast+0x248/0xcd0
[  301.831343]  get_user_pages_fast+0x48/0x60
[  301.831897]  get_futex_key+0xa4/0x3d0
[  301.832281]  futex_wait_setup+0x6c/0x164
[  301.832777]  __futex_wait+0xbc/0x15c
[  301.833200]  futex_wait+0x88/0x110
[  301.833596]  do_futex+0xf8/0x1a0
[  301.833926]  __arm64_sys_futex+0xec/0x188
[  301.834417]  invoke_syscall.constprop.0+0x50/0xe4
[  301.835029]  do_el0_svc+0x40/0xdc
[  301.835378]  el0_svc+0x3c/0x140
[  301.835796]  el0t_64_sync_handler+0x120/0x12c
[  301.836365]  el0t_64_sync+0x190/0x194

So it looks like aio, nvme ioctls, and futexes are things that tend to
trigger it. However, it's definitely not always obvious. The person
reporting the GPU issues with a LPA2 kernel build clearly wasn't having
their system crash on every boot, and I myself ended up with kernels
where the only repro was the glmark2 invocation and things weren't just
oopsing on boot.

Going down the aio path I just tried fio, but it turns out it actually
fairly reliably reproduces the futex oops when configured to fail, just
like glmark2 (I couldn't trivially get it to actually oops on actual aio
usage...).

while true; do fio --filename=nonexist --size=1M --rw=read --bs=16k
--ioengine=libaio --numjobs=10 --name=a --readonly; done

(This will complain with "fio: refusing extend of file due to read-only"
and generally not actually run a proper test, but it still repros the
futex problem)

It's not just any futex usage though. I tried writing a trivial futex
test app, and also running the tools/testing/selftests/futex selftests,
and those don't seem to trigger it.

> Thanks,
> 
> Will
> 
> --->8
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index f8efbc128446..3afe624a39e1 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1065,6 +1065,13 @@ static inline bool pgtable_l5_enabled(void) { return false; }
>  
>  #define p4d_offset_kimg(dir,addr)      ((p4d_t *)dir)
>  
> +static inline
> +p4d_t *p4d_offset_lockless(pgd_t *pgdp, pgd_t pgd, unsigned long addr)
> +{
> +       return p4d_offset(pgdp, addr);
> +}
> +#define p4d_offset_lockless p4d_offset_lockless
> +
>  #endif  /* CONFIG_PGTABLE_LEVELS > 4 */
>  
>  #define pgd_ERROR(e)   \

~~ Lina

