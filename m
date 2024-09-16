Return-Path: <linux-kernel+bounces-330130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F495979A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 05:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E523B1F22A86
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 03:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63371AAA5;
	Mon, 16 Sep 2024 03:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="bt0AjElf"
Received: from out0-198.mail.aliyun.com (out0-198.mail.aliyun.com [140.205.0.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8733DF5B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 03:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726457203; cv=none; b=BIgINDb6i2A8PXW71kyhWQpn883xuHseI1zPTh0MATfSioKikUyYb8kyeXQwz2Cz2Pkk+RPrxgx0RN7LcYF/02rK/smZzTgmpTBjRTe3S4zNy1cqPna6w9t7xcxC1sJShrYDtUmz9RngCo9UFgQNOad13Aukix2O6k5+0WQzgIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726457203; c=relaxed/simple;
	bh=WbO0s6t1Z/kq9rH7BmcylBVgm0ly7sSCS7UJkI3e6Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kz2fdCzV9KV0ahzeST2zClNoJupcTWdLhsWKrDQOZDeo2Br15XGH0xehBIMNSi1kXXjJPPlfZr1/JYwTvUrZf5o6rBmEead38domGnkbh0Srys0moPxdfKkhHrUL6MElC3XS8pCjB6umKkGLcw0cpwzRRf8Yv67/9eHo+fBEqlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=bt0AjElf; arc=none smtp.client-ip=140.205.0.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1726457190; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OOmy7JDINxAVfJcoN737SsiEUfg9IvPs19KIn+yDxlc=;
	b=bt0AjElfllrDLe0OgXI08Q33u7qRjgZhjvQV2L0IpFdDDkI8BJeQ0Kn7F/Uaprp51+BGtavG64GnNLahT/NiufXkW20MxUFGL10UoMpFa+1ZnxgEafDBxytOygVMdBPAsf5LC0LWKfSRUX2RSlb+ydXnrJ1dtAA/Gz0Z+nKo8F0=
Received: from 30.0.144.48(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.ZKLwz1R_1726456247)
          by smtp.aliyun-inc.com;
          Mon, 16 Sep 2024 11:10:54 +0800
Message-ID: <76385637-099e-45f5-b892-bd62c028926d@antgroup.com>
Date: Mon, 16 Sep 2024 11:10:45 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] um: Remove highmem leftovers
To: Benjamin Berg <benjamin@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240913142137.248245-1-tiwei.btw@antgroup.com>
 <20240913142137.248245-3-tiwei.btw@antgroup.com>
 <56a679e9ea6a6e6c7d9316608f25fd691001e8dc.camel@sipsolutions.net>
Content-Language: en-US
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <56a679e9ea6a6e6c7d9316608f25fd691001e8dc.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024/9/16 00:55, Benjamin Berg wrote:
> Hi,
> 
> does that mean we can also drop the 3-level page table support on i386?
> It seems like the two level page table is entirely sufficient on a
> system without high memory (i.e. only 32bit physical addresses).

Good point. I think so too.

Regards,
Tiwei

> 
> When I took a look at it for the 4-level page table support on 64 bit I
> got a bit confused. But I had not realized that highmem support had
> been removed.
> 
> Benjamin
> 
> On Fri, 2024-09-13 at 22:21 +0800, Tiwei Bie wrote:
>> Highmem was only supported on UML/i386. And the support has been
>> removed by commit a98a6d864d3b ("um: Remove broken highmem support").
>> Remove the leftovers and stop UML from trying to setup highmem when
>> the sum of physmem_size and iomem_size exceeds max_physmem.
>>
>> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
>> ---
>>  arch/um/drivers/virtio_uml.c       |  9 +--------
>>  arch/um/include/shared/as-layout.h |  1 -
>>  arch/um/include/shared/mem_user.h  |  5 ++---
>>  arch/um/kernel/mem.c               |  3 ---
>>  arch/um/kernel/physmem.c           | 30 +++++++++++-----------------
>> --
>>  arch/um/kernel/um_arch.c           | 17 +++++++----------
>>  6 files changed, 21 insertions(+), 44 deletions(-)
>>
>> diff --git a/arch/um/drivers/virtio_uml.c
>> b/arch/um/drivers/virtio_uml.c
>> index 2b6e701776b6..e7f5556e3c96 100644
>> --- a/arch/um/drivers/virtio_uml.c
>> +++ b/arch/um/drivers/virtio_uml.c
>> @@ -72,7 +72,7 @@ struct virtio_uml_vq_info {
>>  	bool suspended;
>>  };
>>  
>> -extern unsigned long long physmem_size, highmem;
>> +extern unsigned long long physmem_size;
>>  
>>  #define vu_err(vu_dev, ...)	dev_err(&(vu_dev)->pdev->dev,
>> ##__VA_ARGS__)
>>  
>> @@ -673,13 +673,6 @@ static int vhost_user_set_mem_table(struct
>> virtio_uml_device *vu_dev)
>>  
>>  	if (rc < 0)
>>  		return rc;
>> -	if (highmem) {
>> -		msg.payload.mem_regions.num++;
>> -		rc = vhost_user_init_mem_region(__pa(end_iomem),
>> highmem,
>> -				&fds[1],
>> &msg.payload.mem_regions.regions[1]);
>> -		if (rc < 0)
>> -			return rc;
>> -	}
>>  
>>  	return vhost_user_send(vu_dev, false, &msg, fds,
>>  			       msg.payload.mem_regions.num);
>> diff --git a/arch/um/include/shared/as-layout.h
>> b/arch/um/include/shared/as-layout.h
>> index 06292fca5a4d..61965a06c18a 100644
>> --- a/arch/um/include/shared/as-layout.h
>> +++ b/arch/um/include/shared/as-layout.h
>> @@ -41,7 +41,6 @@ extern unsigned long uml_physmem;
>>  extern unsigned long uml_reserved;
>>  extern unsigned long end_vm;
>>  extern unsigned long start_vm;
>> -extern unsigned long long highmem;
>>  
>>  extern unsigned long brk_start;
>>  
>> diff --git a/arch/um/include/shared/mem_user.h
>> b/arch/um/include/shared/mem_user.h
>> index 11a723a58545..adfa08062f88 100644
>> --- a/arch/um/include/shared/mem_user.h
>> +++ b/arch/um/include/shared/mem_user.h
>> @@ -47,10 +47,9 @@ extern int iomem_size;
>>  #define ROUND_4M(n) ((((unsigned long) (n)) + (1 << 22)) & ~((1 <<
>> 22) - 1))
>>  
>>  extern unsigned long find_iomem(char *driver, unsigned long
>> *len_out);
>> -extern void mem_total_pages(unsigned long physmem, unsigned long
>> iomem,
>> -		     unsigned long highmem);
>> +extern void mem_total_pages(unsigned long physmem, unsigned long
>> iomem);
>>  extern void setup_physmem(unsigned long start, unsigned long usable,
>> -			  unsigned long len, unsigned long long
>> highmem);
>> +			  unsigned long len);
>>  extern void map_memory(unsigned long virt, unsigned long phys,
>>  		       unsigned long len, int r, int w, int x);
>>  
>> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
>> index a5b4fe2ad931..5026668dc054 100644
>> --- a/arch/um/kernel/mem.c
>> +++ b/arch/um/kernel/mem.c
>> @@ -6,7 +6,6 @@
>>  #include <linux/stddef.h>
>>  #include <linux/module.h>
>>  #include <linux/memblock.h>
>> -#include <linux/highmem.h>
>>  #include <linux/mm.h>
>>  #include <linux/swap.h>
>>  #include <linux/slab.h>
>> @@ -51,8 +50,6 @@ EXPORT_SYMBOL(empty_zero_page);
>>  pgd_t swapper_pg_dir[PTRS_PER_PGD];
>>  
>>  /* Initialized at boot time, and readonly after that */
>> -unsigned long long highmem;
>> -EXPORT_SYMBOL(highmem);
>>  int kmalloc_ok = 0;
>>  
>>  /* Used during early boot */
>> diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
>> index fb2adfb49945..cc5238c1bf1e 100644
>> --- a/arch/um/kernel/physmem.c
>> +++ b/arch/um/kernel/physmem.c
>> @@ -24,17 +24,14 @@ EXPORT_SYMBOL(high_physmem);
>>  
>>  extern unsigned long long physmem_size;
>>  
>> -void __init mem_total_pages(unsigned long physmem, unsigned long
>> iomem,
>> -		     unsigned long highmem)
>> +void __init mem_total_pages(unsigned long physmem, unsigned long
>> iomem)
>>  {
>> -	unsigned long phys_pages, highmem_pages;
>> -	unsigned long iomem_pages, total_pages;
>> +	unsigned long phys_pages, iomem_pages, total_pages;
>>  
>> -	phys_pages    = physmem >> PAGE_SHIFT;
>> -	iomem_pages   = iomem   >> PAGE_SHIFT;
>> -	highmem_pages = highmem >> PAGE_SHIFT;
>> +	phys_pages  = physmem >> PAGE_SHIFT;
>> +	iomem_pages = iomem   >> PAGE_SHIFT;
>>  
>> -	total_pages   = phys_pages + iomem_pages + highmem_pages;
>> +	total_pages = phys_pages + iomem_pages;
>>  
>>  	max_mapnr = total_pages;
>>  }
>> @@ -64,13 +61,12 @@ void map_memory(unsigned long virt, unsigned long
>> phys, unsigned long len,
>>   * @reserve_end:	end address of the physical kernel memory.
>>   * @len:	Length of total physical memory that should be
>> mapped/made
>>   *		available, in bytes.
>> - * @highmem:	Number of highmem bytes that should be mapped/made
>> available.
>>   *
>> - * Creates an unlinked temporary file of size (len + highmem) and
>> memory maps
>> + * Creates an unlinked temporary file of size (len) and memory maps
>>   * it on the last executable image address (uml_reserved).
>>   *
>>   * The offset is needed as the length of the total physical memory
>> - * (len + highmem) includes the size of the memory used be the
>> executable image,
>> + * (len) includes the size of the memory used be the executable
>> image,
>>   * but the mapped-to address is the last address of the executable
>> image
>>   * (uml_reserved == end address of executable image).
>>   *
>> @@ -78,19 +74,19 @@ void map_memory(unsigned long virt, unsigned long
>> phys, unsigned long len,
>>   * of all user space processes/kernel tasks.
>>   */
>>  void __init setup_physmem(unsigned long start, unsigned long
>> reserve_end,
>> -			  unsigned long len, unsigned long long
>> highmem)
>> +			  unsigned long len)
>>  {
>>  	unsigned long reserve = reserve_end - start;
>>  	long map_size = len - reserve;
>>  	int err;
>>  
>> -	if(map_size <= 0) {
>> +	if (map_size <= 0) {
>>  		os_warn("Too few physical memory! Needed=%lu,
>> given=%lu\n",
>>  			reserve, len);
>>  		exit(1);
>>  	}
>>  
>> -	physmem_fd = create_mem_file(len + highmem);
>> +	physmem_fd = create_mem_file(len);
>>  
>>  	err = os_map_memory((void *) reserve_end, physmem_fd,
>> reserve,
>>  			    map_size, 1, 1, 1);
>> @@ -109,7 +105,7 @@ void __init setup_physmem(unsigned long start,
>> unsigned long reserve_end,
>>  	os_write_file(physmem_fd, __syscall_stub_start, PAGE_SIZE);
>>  	os_fsync_file(physmem_fd);
>>  
>> -	memblock_add(__pa(start), len + highmem);
>> +	memblock_add(__pa(start), len);
>>  	memblock_reserve(__pa(start), reserve);
>>  
>>  	min_low_pfn = PFN_UP(__pa(reserve_end));
>> @@ -137,10 +133,6 @@ int phys_mapping(unsigned long phys, unsigned
>> long long *offset_out)
>>  			region = region->next;
>>  		}
>>  	}
>> -	else if (phys < __pa(end_iomem) + highmem) {
>> -		fd = physmem_fd;
>> -		*offset_out = phys - iomem_size;
>> -	}
>>  
>>  	return fd;
>>  }
>> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
>> index 8e594cda6d77..8f86aa468b50 100644
>> --- a/arch/um/kernel/um_arch.c
>> +++ b/arch/um/kernel/um_arch.c
>> @@ -366,18 +366,15 @@ int __init linux_main(int argc, char **argv)
>>  
>>  	setup_machinename(init_utsname()->machine);
>>  
>> -	highmem = 0;
>> +	physmem_size = (physmem_size + PAGE_SIZE - 1) & PAGE_MASK;
>>  	iomem_size = (iomem_size + PAGE_SIZE - 1) & PAGE_MASK;
>> +
>>  	max_physmem = TASK_SIZE - uml_physmem - iomem_size -
>> MIN_VMALLOC;
>>  
>> -	/*
>> -	 * Zones have to begin on a 1 << MAX_PAGE_ORDER page
>> boundary,
>> -	 * so this makes sure that's true for highmem
>> -	 */
>> -	max_physmem &= ~((1 << (PAGE_SHIFT + MAX_PAGE_ORDER)) - 1);
>>  	if (physmem_size + iomem_size > max_physmem) {
>> -		highmem = physmem_size + iomem_size - max_physmem;
>> -		physmem_size -= highmem;
>> +		physmem_size = max_physmem - iomem_size;
>> +		os_info("Physical memory size shrunk to %llu
>> bytes\n",
>> +			physmem_size);
>>  	}
>>  
>>  	high_physmem = uml_physmem + physmem_size;
>> @@ -413,8 +410,8 @@ void __init setup_arch(char **cmdline_p)
>>  	u8 rng_seed[32];
>>  
>>  	stack_protections((unsigned long) &init_thread_info);
>> -	setup_physmem(uml_physmem, uml_reserved, physmem_size,
>> highmem);
>> -	mem_total_pages(physmem_size, iomem_size, highmem);
>> +	setup_physmem(uml_physmem, uml_reserved, physmem_size);
>> +	mem_total_pages(physmem_size, iomem_size);
>>  	uml_dtb_init();
>>  	read_initrd();
>>  


