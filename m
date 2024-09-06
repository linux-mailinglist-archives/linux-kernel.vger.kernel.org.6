Return-Path: <linux-kernel+bounces-318854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CF496F428
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 14:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B7B1F24CA1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 12:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690B81CCB38;
	Fri,  6 Sep 2024 12:20:27 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992691CB313
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625227; cv=none; b=NnBmWf5x8N2gnjr3jTeGnRJaUdJ+Q7Az/oTkUaXPZY6/okYQmJkhmRm24McsMuavz/eqr7HXHfli7ryGvmDWk1ZQ5nCh4Wm27Y9oDGRiDkQpkbAC9gTjVRyVZYhTD8g2/0YgjissFNkUFXNazGIpF8nWN0MnrE0QxL4o5r4Rl78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625227; c=relaxed/simple;
	bh=JT9oqjtvTwztSETZljUS1sYzQttKEqoWlyTWvLnYDZQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tIWxBRDTwfTP7M9rY0gbRopPpH6UhIuwZ98lJCuEYjsyBSXcj3s+XCpjZI/RfNTH8gTkaiHeiZnrPHLHTI7VyFzBpwLUMZexUAVvN9hc0FriBYXLL5fv7jTSZ1FpawlGYJjA2AUBSHzunUDlrUNpr6wN0QHQDSQDJcyVU4uuhE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X0Zzx3DtRz1j8BB;
	Fri,  6 Sep 2024 20:19:57 +0800 (CST)
Received: from kwepemf100009.china.huawei.com (unknown [7.202.181.223])
	by mail.maildlp.com (Postfix) with ESMTPS id 4010E1402E1;
	Fri,  6 Sep 2024 20:20:20 +0800 (CST)
Received: from [10.67.121.162] (10.67.121.162) by
 kwepemf100009.china.huawei.com (7.202.181.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 6 Sep 2024 20:20:19 +0800
Subject: Re: [PATCH] arm64: Add ARM64_HAS_LSE2 CPU capability
To: Mark Rutland <mark.rutland@arm.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>,
	<jonathan.cameron@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20240906090812.249473-1-tiantao6@hisilicon.com>
 <ZtrPCVhqj5qLrQVY@J2N7QTR9R3>
 <587f7c84-cdfc-b348-4cd0-1015adad2cca@hisilicon.com>
 <Ztrqie427P_Lxaoh@J2N7QTR9R3>
From: "tiantao (H)" <tiantao6@hisilicon.com>
Message-ID: <54980e73-4a1c-1eb2-98b4-fbb49e9a9b8f@hisilicon.com>
Date: Fri, 6 Sep 2024 20:20:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Ztrqie427P_Lxaoh@J2N7QTR9R3>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100009.china.huawei.com (7.202.181.223)


在 2024/9/6 19:42, Mark Rutland 写道:
> On Fri, Sep 06, 2024 at 06:58:19PM +0800, tiantao (H) wrote:
>> 在 2024/9/6 17:44, Mark Rutland 写道:
>>> On Fri, Sep 06, 2024 at 05:08:12PM +0800, Tian Tao wrote:
>>>> When FEAT_LSE2 is implemented and Bit 6 of sctlr_elx is nAA, the
>>>> full name of the Not-aligned access. nAA bit has two values:
>>>> 0b0 Unaligned accesses by the specified instructions generate an
>>>> Alignment fault.
>>>> 0b1 Unaligned accesses by the specified instructions do not generate
>>>> an Alignment fault.
>>>>
>>>> this patch sets the nAA bit to 1,The following instructions will not
>>>> generate an Alignment fault if all bytes being accessed are not within
>>>> a single 16-byte quantity:
>>>> • LDAPR, LDAPRH, LDAPUR, LDAPURH, LDAPURSH, LDAPURSW, LDAR, LDARH,LDLAR,
>>>> LDLARH.
>>>> • STLLR, STLLRH, STLR, STLRH, STLUR, and STLURH
>>>>
>>>> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
>>> What is going to depend on this? Nothing in the kernel depends on being
>>> able to make unaligned accesses with these instructions, and (since you
>>> haven't added a HWCAP), userspace has no idea that these accesses won't
>>> generate an alignment fault.
>>>
>>> Mark.
>> I've come across a situation where the simplified code is as follows:
>>
>>   long  address = (long) mmap(NULL,1024*1024*2,PROT_READ|PROT_WRITE,
>> MAP_PRIVATE|MAP_ANONYMOUS,-1,0);
>>
>> long new_address = address + 9;
>>
>>   long *p = (long*) new_address;
>>   long v = -1;
>>
>>   __atomic_store(p, &v, __ATOMIC_RELEASE);
> Hold on; looking at the ARM ARM (ARM DDI 0487K.a), the example and the
> patch are both bogus. NAK to this patch, explanation below.
>
> Per section B2.2.1.1 "Changes to single-copy atomicity in Armv8.4", all of the
> LSE2 relaxations on alignment require:
>
> | all bytes being accessed are within a 16-byte quantity that is aligned
> | to 16 bytes
>
> In your example you perform an 8-byte access at an offset of 9 bytes,
> which means the access is *not* contained within 16 bytes, and is *not*
> guaranteed to be atomic. That code simply has to be fixed, the kernel
> cannot magically make it safe.
>
> Regardless of that, the nAA bit *only* causes an alignment fault for
> accesses which cannot be atomic. If a CPU has LSE2 and SCTLR_ELx.nAA=0,
> an unaligned access within 16 bytes (which would be atomic) does not
> cause an alignment fault. That's pretty clear from the description of
> nAA and the AArch64.UnalignedAccessFaults() pseudocode:

Sorry, this example is just for verifying nnA, it's not an example of a 
real scenario,

we have scenarios that don't require atomicity to be guaranteed, they 
just require that coredump doesn't occur when non-aligned

> | boolean AArch64.UnalignedAccessFaults(AccessDescriptor accdesc, bits(64) address, integer size)
> |     if AlignmentEnforced() then
> |         return TRUE;
> |     elsif accdesc.acctype == AccessType_GCS then
> |         return TRUE;
> |     elsif accdesc.rcw then
> |         return TRUE;
> |     elsif accdesc.ls64 then
> |         return TRUE;
> |     elsif accdesc.exclusive || accdesc.atomicop then
> |         return !IsFeatureImplemented(FEAT_LSE2) || !AllInAlignedQuantity(address, size, 16);
> |     elsif accdesc.acqsc || accdesc.acqpc || accdesc.relsc then
> |         return (!IsFeatureImplemented(FEAT_LSE2) ||
> |                 (SCTLR_ELx[].nAA == '0' && !AllInAlignedQuantity(address, size, 16)));
> |     else
> |         return FALSE;
>
> Note that when FEAT_LSE2 is implemented, unaligned atomic accesss within
> a 16-byte window never raise an alignment fault, regardless of the value
> of the nAA bit.

> Setting the nAA bit only hides where atomicity is lost, and does not
> make code function correctly. Consequently, that only serves to hide
> bugs, making those harder to detect, debug, and fix. Thus I see no
> reason to set the nAA bit.
>
> So as above, NAK to this path. Please fir your broken userspace code.
>
> Mark.
>
> .


