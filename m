Return-Path: <linux-kernel+bounces-415980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6579D3FAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D4CEB3874D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC741BD509;
	Wed, 20 Nov 2024 15:04:52 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AEC1A9B3B;
	Wed, 20 Nov 2024 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732115091; cv=none; b=ITG9E41qmBFFxxzVNnizvaLen6ajWPLEXn8x1Y2m7SYCgBLAdDcr+4IdjRataXCoCTJa9qUI0T3SGNVTFz0rfN4RpCf5x5d5pD5ULJg0+8STxTwSt8XUv6+mpsErvxjv+N0NdLAS/EjPUVyWxCoiclIkeyv1nJtGwyr7aMpVBR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732115091; c=relaxed/simple;
	bh=hDeJYjycHF77ZLbMNTQlumwoqT3rg0rRLzelRS/sr8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqjLZ8k+imW3kdZQgYvqHX05ugOYMnaL+pdAHtB//lrxp7xBuPMF2gJpYfUBc0APiYEW6qKy016KaOoU9oX95P7F+k0xSaeOdHquDKpZ1MXSWZ9PPRI+3eoTTYhv8C3hOQsH6aaMzh0ZHSC1YKCBTs4zsaLgBEXTQ8AJb+2ffb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FFCC4CECD;
	Wed, 20 Nov 2024 15:04:50 +0000 (UTC)
Date: Wed, 20 Nov 2024 10:05:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect
 type in assignment (different base types)
Message-ID: <20241120100526.26705a95@gandalf.local.home>
In-Reply-To: <202411201356.pXoYlKFB-lkp@intel.com>
References: <202411201356.pXoYlKFB-lkp@intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 13:59:39 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Steven,
> 
> First bad commit (maybe != root cause):

Does not look to be root cause.

-- Steve

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   bf9aa14fc523d2763fc9a10672a709224e8fcaf4
> commit: 59cbd4eea48fdbc68fc17a29ad71188fea74b28b KVM: Remove HIGH_RES_TIMERS dependency
> date:   3 months ago
> config: x86_64-randconfig-r133-20241119 (https://download.01.org/0day-ci/archive/20241120/202411201356.pXoYlKFB-lkp@intel.com/config)
> compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241120/202411201356.pXoYlKFB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202411201356.pXoYlKFB-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [assigned] ret @@     got restricted vm_fault_t @@  
>    arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     expected int [assigned] ret
>    arch/x86/kernel/cpu/sgx/virt.c:59:13: sparse:     got restricted vm_fault_t
> >> arch/x86/kernel/cpu/sgx/virt.c:60:20: sparse: sparse: restricted vm_fault_t degrades to integer
> >> arch/x86/kernel/cpu/sgx/virt.c:354:36: sparse: sparse: cast removes address space '__user' of expression  
>    arch/x86/kernel/cpu/sgx/virt.c:385:24: sparse: sparse: cast removes address space '__user' of expression
>    arch/x86/kernel/cpu/sgx/virt.c:385:43: sparse: sparse: cast removes address space '__user' of expression
>    arch/x86/kernel/cpu/sgx/virt.c:385:58: sparse: sparse: cast removes address space '__user' of expression
>    arch/x86/kernel/cpu/sgx/virt.c: note: in included file (through include/linux/miscdevice.h):
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
>    include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
> 
> vim +59 arch/x86/kernel/cpu/sgx/virt.c
> 
> 540745ddbc70eab Sean Christopherson 2021-03-19  32  
> 540745ddbc70eab Sean Christopherson 2021-03-19  33  static int __sgx_vepc_fault(struct sgx_vepc *vepc,
> 540745ddbc70eab Sean Christopherson 2021-03-19  34  			    struct vm_area_struct *vma, unsigned long addr)
> 540745ddbc70eab Sean Christopherson 2021-03-19  35  {
> 540745ddbc70eab Sean Christopherson 2021-03-19  36  	struct sgx_epc_page *epc_page;
> 540745ddbc70eab Sean Christopherson 2021-03-19  37  	unsigned long index, pfn;
> 540745ddbc70eab Sean Christopherson 2021-03-19  38  	int ret;
> 540745ddbc70eab Sean Christopherson 2021-03-19  39  
> 540745ddbc70eab Sean Christopherson 2021-03-19  40  	WARN_ON(!mutex_is_locked(&vepc->lock));
> 540745ddbc70eab Sean Christopherson 2021-03-19  41  
> 540745ddbc70eab Sean Christopherson 2021-03-19  42  	/* Calculate index of EPC page in virtual EPC's page_array */
> 540745ddbc70eab Sean Christopherson 2021-03-19  43  	index = vma->vm_pgoff + PFN_DOWN(addr - vma->vm_start);
> 540745ddbc70eab Sean Christopherson 2021-03-19  44  
> 540745ddbc70eab Sean Christopherson 2021-03-19  45  	epc_page = xa_load(&vepc->page_array, index);
> 540745ddbc70eab Sean Christopherson 2021-03-19  46  	if (epc_page)
> 540745ddbc70eab Sean Christopherson 2021-03-19  47  		return 0;
> 540745ddbc70eab Sean Christopherson 2021-03-19  48  
> 540745ddbc70eab Sean Christopherson 2021-03-19  49  	epc_page = sgx_alloc_epc_page(vepc, false);
> 540745ddbc70eab Sean Christopherson 2021-03-19  50  	if (IS_ERR(epc_page))
> 540745ddbc70eab Sean Christopherson 2021-03-19  51  		return PTR_ERR(epc_page);
> 540745ddbc70eab Sean Christopherson 2021-03-19  52  
> 540745ddbc70eab Sean Christopherson 2021-03-19  53  	ret = xa_err(xa_store(&vepc->page_array, index, epc_page, GFP_KERNEL));
> 540745ddbc70eab Sean Christopherson 2021-03-19  54  	if (ret)
> 540745ddbc70eab Sean Christopherson 2021-03-19  55  		goto err_free;
> 540745ddbc70eab Sean Christopherson 2021-03-19  56  
> 540745ddbc70eab Sean Christopherson 2021-03-19  57  	pfn = PFN_DOWN(sgx_get_epc_phys_addr(epc_page));
> 540745ddbc70eab Sean Christopherson 2021-03-19  58  
> 540745ddbc70eab Sean Christopherson 2021-03-19 @59  	ret = vmf_insert_pfn(vma, addr, pfn);
> 540745ddbc70eab Sean Christopherson 2021-03-19 @60  	if (ret != VM_FAULT_NOPAGE) {
> 540745ddbc70eab Sean Christopherson 2021-03-19  61  		ret = -EFAULT;
> 540745ddbc70eab Sean Christopherson 2021-03-19  62  		goto err_delete;
> 540745ddbc70eab Sean Christopherson 2021-03-19  63  	}
> 540745ddbc70eab Sean Christopherson 2021-03-19  64  
> 540745ddbc70eab Sean Christopherson 2021-03-19  65  	return 0;
> 540745ddbc70eab Sean Christopherson 2021-03-19  66  
> 540745ddbc70eab Sean Christopherson 2021-03-19  67  err_delete:
> 540745ddbc70eab Sean Christopherson 2021-03-19  68  	xa_erase(&vepc->page_array, index);
> 540745ddbc70eab Sean Christopherson 2021-03-19  69  err_free:
> 540745ddbc70eab Sean Christopherson 2021-03-19  70  	sgx_free_epc_page(epc_page);
> 540745ddbc70eab Sean Christopherson 2021-03-19  71  	return ret;
> 540745ddbc70eab Sean Christopherson 2021-03-19  72  }
> 540745ddbc70eab Sean Christopherson 2021-03-19  73  
> 
> :::::: The code at line 59 was first introduced by commit
> :::::: 540745ddbc70eabdc7dbd3fcc00fe4fb17cd59ba x86/sgx: Introduce virtual EPC for use by KVM guests
> 
> :::::: TO: Sean Christopherson <sean.j.christopherson@intel.com>
> :::::: CC: Borislav Petkov <bp@suse.de>
> 


