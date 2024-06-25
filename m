Return-Path: <linux-kernel+bounces-228598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5308491620D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F0ECB275A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8C01494DC;
	Tue, 25 Jun 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dQwTZPOd"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057F424B34
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719306605; cv=none; b=cijkN3n/60MbzW2RHZ4O93B1jBT/UM7uk+6YREwgTf/j/LRxkXUbmOGq3b5j4TI2MK2nL99l0owqzYt1Rdc/pisRoEsZbDYwESuPbLfkpgKRcOvf2WQpCU04Q0zCP6hRWa20uK3cCRxwH2iHxw+G+2P5k8RZK1wR2GlWzamJioI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719306605; c=relaxed/simple;
	bh=PgmweWsgyjunXwL2K/VjA1gLM34Omcb+xcKaqJqZuIA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mF62EC5euLX7MM8VomUC4hyfqbWs71MRdKZYM6PpUEo7POAxhfo33/fu8DQthwWFMg93jc9MC1AokjVxl2m0OkSMkzxgAt69Ria9WdDuZaL49JPAaWgU6ceX++UBT+sc1MwfHUFy6PUAdI9iOLoGiYwg/9ZTF8IGLYXQbGM3UaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=dQwTZPOd; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [192.168.7.205] ([71.202.166.45])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45P99UfG1551074
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Jun 2024 02:09:31 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45P99UfG1551074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719306572;
	bh=iCQ21Qo+mXw3zg+knnXoD23BPWOHBWTkZu2Jd89OruQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=dQwTZPOdqm3H9e4BT0bHkN1GekWXtznPothFfWe7/0qWIwxNpEs9Ybi2LaXLXE/EE
	 2LWlbxIuwxggxad0+QHQa+E9RITysnCImoE/ueJIogbQTWAF97N+HZrqncKx+eP4T2
	 Wic2tNRighW9s5eF4Sj9O0WqaEPBbvFi2RjmvBh8rQI/tlxikaPaiv+VK5tFfSc38r
	 SYskrjHYAhLeFIjoE3E3znuuQ7o1UyfksL+UIBAK+aLOHSyEspj7J3PJKZP9IKbIDa
	 z4lze9LueMC2cFh2XCvGwrCcDw4aA3HVCc7j/WJpSwAPwv1ewGcWH9v8g3BwjtFA/o
	 snMCzctWhvSBg==
Message-ID: <f8ab27ff-d6cf-41c7-a033-9e578b1e51fb@zytor.com>
Date: Tue, 25 Jun 2024 02:09:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Xin Li <xin@zytor.com>
Subject: Re: [PATCH 0/2] x86/fred: Fix two problems during the FRED
 initialization
To: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Xin Li
 <xin3.li@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <cover.1718972598.git.houwenlong.hwl@antgroup.com>
 <58ec98bf-b66c-4249-8a10-ff254cd405c2@zytor.com>
 <20240624062143.GA59245@k08j02272.eu95sqa>
Content-Language: en-US
Autocrypt: addr=xin@zytor.com; keydata=
 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
 l75w1xInsg==
In-Reply-To: <20240624062143.GA59245@k08j02272.eu95sqa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/23/2024 11:21 PM, Hou Wenlong wrote:
> On Sat, Jun 22, 2024 at 08:31:26AM +0800, Xin Li wrote:
>> On 6/21/2024 6:12 AM, Hou Wenlong wrote:
>>> One issue is that FRED can be disabled in trap_init(), but
>>> sysvec_install() can be called before trap_init(), thus the system
>>> interrupt handler is not installed into the IDT if FRED is disabled
>>> later. Initially, I attempted to parse the cmdline and decide whether to
>>> enable or disable FRED after parse_early_param(). However, I ultimately
>>> chose to always install the system handler into the IDT in
>>> sysvec_install(), which is simple and should be sufficient.
>>
>> Which module with a system vector gets initialized before trap_init() is
>> called?
>>
> Sorry, I didn't mention the case here. I see sysvec_install() is used
> only in the guest part (KVM, HYPERV) currently. For example, the KVM
> guest will register the HYPERVISOR_CALLBACK_VECTOR APF handler in
> kvm_guest_init(), which is called before trap_init(). So if only the FRED
> handler is registered and FRED is disabled in trap_init() later, then the
> IDT handler of the APF handler is missing.

This is a bug!  Your fix looks good to me.

>>> Another problem is that the page fault handler (exc_page_fault()) is
>>> installed into the IDT before FRED is enabled. Consequently, if a #PF is
>>> triggered in this gap, the handler would receive the wrong CR2 from the
>>> stack if FRED feature is present. To address this, I added a page fault
>>> entry stub for FRED similar to the debug entry. However, I'm uncertain
>>> whether this is enough reason to add a new entry. Perhaps a static key
>>> may suffice to indicate whether FRED setup is completed and the handler
>>> can use it.
>>
>> How could a #PF get triggered during that gap?
>>
>> Initialization time funnies are really unpleasant.
>>
> I'm not sure if there will be a #PF during that gap; I just received the
> wrong fault address when I made a mistake in that gap and a #PF
> occurred. Before idt_setup_early_pf(), the registered page fault handler
> is do_early_exception(), which uses native_read_cr2(). However, after
> that, the page fault handler had been changed to exc_page_fault(), so if
> something bad happened and an unexpected #PF occurred, the fault address
> in the error output will be wrong, although the CR2 in __show_regs() is
> correct. I'm not sure if this matters or not since the kernel will panic
> at that time.

So this doesn't sound a real problem, right?

We could simply do:

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index e6c469b323cc..e500777ed2b4 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1495,7 +1495,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
            irqentry_state_t state;
            unsigned long address;

-       address = cpu_feature_enabled(X86_FEATURE_FRED) ? 
fred_event_data(regs) : read_cr2();
+       address = native_read_cr4() & X86_CR4_FRED ? 
fred_event_data(regs) : read_cr2();

            prefetchw(&current->mm->mmap_lock);


But the page fault handler is an extreme hot path, it's not worth it.

Thanks!
        Xin





