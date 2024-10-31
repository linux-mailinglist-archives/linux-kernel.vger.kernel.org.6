Return-Path: <linux-kernel+bounces-389934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C1E9B733D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 04:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F05B285EF5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36C212C489;
	Thu, 31 Oct 2024 03:56:36 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D101BD9DC
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730346996; cv=none; b=tcxqWfdN4ltMZv/MolMbN3cFpdlhqTGuP40gnyay/Z/NbmUtMH32SfhEBXb4TYTCwJ7t7SAtA9HPPwgS1BWnX+GqrojkHEoiBS4R2q09IS/Clytw6cLhliFtxUtOTh+/VcgPlLlCGKK5IFwusQ8o4sjI1ftpQlBdatomVoqoRPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730346996; c=relaxed/simple;
	bh=Qv6tb5Jb1T6QgohqMKTjIJDVuCufHrVpT7UOQFkGMvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iiJn1K5sElcEwpFtXtDxj9MMZJopxNvs6MAbFnFSh4q4M4vxY3lnGhzROt4YEu3MHWwnTWmUmsc8PSVmeyF01x51dfSMKRIKu+7ciZdbRqgJ0kytnLM1JCOvPSInfh+veatrxn/aYxsWKvvem9KgQBuSAG+GbHi05xmDWJ0PKgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Xf99P0nw3zpXgL;
	Thu, 31 Oct 2024 11:54:33 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F04D180103;
	Thu, 31 Oct 2024 11:56:28 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 31 Oct 2024 11:56:26 +0800
Message-ID: <49e78df6-91bf-7c63-b2d0-f36a301535da@huawei.com>
Date: Thu, 31 Oct 2024 11:56:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next v4 04/19] arm64: entry: Remove
 __enter_from_kernel_mode()
Content-Language: en-US
To: Mark Rutland <mark.rutland@arm.com>
CC: <oleg@redhat.com>, <linux@armlinux.org.uk>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <sstabellini@kernel.org>, <maz@kernel.org>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <luto@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <akpm@linux-foundation.org>,
	<samitolvanen@google.com>, <arnd@arndb.de>, <ojeda@kernel.org>,
	<rppt@kernel.org>, <hca@linux.ibm.com>, <aliceryhl@google.com>,
	<samuel.holland@sifive.com>, <paulmck@kernel.org>, <aquini@redhat.com>,
	<petr.pavlu@suse.com>, <viro@zeniv.linux.org.uk>,
	<rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>,
	<wangkefeng.wang@huawei.com>, <surenb@google.com>,
	<linus.walleij@linaro.org>, <yangyj.ee@gmail.com>, <broonie@kernel.org>,
	<mbenes@suse.cz>, <puranjay@kernel.org>, <pcc@google.com>,
	<guohanjun@huawei.com>, <sudeep.holla@arm.com>,
	<Jonathan.Cameron@huawei.com>, <prarit@redhat.com>, <liuwei09@cestc.cn>,
	<dwmw@amazon.co.uk>, <oliver.upton@linux.dev>, <kristina.martsenko@arm.com>,
	<ptosi@google.com>, <frederic@kernel.org>, <vschneid@redhat.com>,
	<thiago.bauermann@linaro.org>, <joey.gouly@arm.com>,
	<liuyuntao12@huawei.com>, <leobras@redhat.com>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<xen-devel@lists.xenproject.org>
References: <20241025100700.3714552-1-ruanjinjie@huawei.com>
 <20241025100700.3714552-5-ruanjinjie@huawei.com>
 <ZyDzNmSgmYkXWcdD@J2N7QTR9R3.cambridge.arm.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <ZyDzNmSgmYkXWcdD@J2N7QTR9R3.cambridge.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/29 22:37, Mark Rutland wrote:
> On Fri, Oct 25, 2024 at 06:06:45PM +0800, Jinjie Ruan wrote:
>> The __enter_from_kernel_mode() is only called by enter_from_kernel_mode(),
>> remove it.
> 
> The point of this split is to cleanly separate the raw entry logic (in
> __enter_from_kernel_mode() from pieces that run later and can safely be
> instrumented (later in enter_from_kernel_mode()).

Hi, Mark,

I reviewed your commit bc29b71f53b1 ("arm64: entry: clarify entry/exit
helpers"), and keep these functions is to make instrumentation
boundaries more clear, and will not change them.

> 
> I had expected that a later patch would replace
> __enter_from_kernel_mode() with the generic equivalent, leaving
> enter_from_kernel_mode() unchanged. It looks like patch 16 could do that
> without this patch being necessary -- am I missing something?

Yes, you are right! these useless cleanup patches will be removed.

And when switched to generic syscall, I found that proper refactoring
would also facilitate clear code switching.

Thank you.

> 
> Mark.
> 
>>
>> No functional changes.
>>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  arch/arm64/kernel/entry-common.c | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
>> index ccf59b44464d..a7fd4d6c7650 100644
>> --- a/arch/arm64/kernel/entry-common.c
>> +++ b/arch/arm64/kernel/entry-common.c
>> @@ -36,7 +36,7 @@
>>   * This is intended to match the logic in irqentry_enter(), handling the kernel
>>   * mode transitions only.
>>   */
>> -static __always_inline irqentry_state_t __enter_from_kernel_mode(struct pt_regs *regs)
>> +static noinstr irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
>>  {
>>  	irqentry_state_t ret = {
>>  		.exit_rcu = false,
>> @@ -55,13 +55,6 @@ static __always_inline irqentry_state_t __enter_from_kernel_mode(struct pt_regs
>>  	rcu_irq_enter_check_tick();
>>  	trace_hardirqs_off_finish();
>>  
>> -	return ret;
>> -}
>> -
>> -static noinstr irqentry_state_t enter_from_kernel_mode(struct pt_regs *regs)
>> -{
>> -	irqentry_state_t ret = __enter_from_kernel_mode(regs);
>> -
>>  	mte_check_tfsr_entry();
>>  	mte_disable_tco_entry(current);
>>  
>> -- 
>> 2.34.1
>>
> 

