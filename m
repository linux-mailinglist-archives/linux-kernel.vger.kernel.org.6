Return-Path: <linux-kernel+bounces-200244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C718FAD66
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 10:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C4A5281984
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 08:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E01422D1;
	Tue,  4 Jun 2024 08:23:37 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04F82A1C5
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717489417; cv=none; b=AagyO82CwNfMG1vRiyLJdGz2l6Wa4YfZSebaCdauHJqHGAHE7WXrKWy6aMJ1wmndU7NVej+X/yLZPrH/YzYSD6mFfzA6Jt9FvFkwJeLTZyYn1Pe8duZmMWXSKirGKAcK+A2dzhYHRsLDlVXaDSsg+8hYta0XbnbCn0r33qiN+aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717489417; c=relaxed/simple;
	bh=RQvAbHhfGZydeK8yVv9kEPBowqkACBAOfaUsBflwvEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gSsYrmi9Yod8SGGGYJX/xL8zzFoLP6w3veO/gQsqib2quIPHqk1d3AnhFvLhN3S+UM2ns8KHUCdEI2T/1wvToNKQJItZ63T4WZ2Y257KgVoth0iQz7ZGxV8plqHi0rScK+AunGjBkLIVs9UrIcQQ5K/7n072TwJ3Xe85kfN6g9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Vtk8s62gnz1xsGB;
	Tue,  4 Jun 2024 16:22:05 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 826C4140155;
	Tue,  4 Jun 2024 16:23:25 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 16:23:24 +0800
Message-ID: <a6e091e0-4825-fcad-41eb-0bdd96a32bde@huawei.com>
Date: Tue, 4 Jun 2024 16:23:23 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] ARM: Add HAVE_FUNCTION_ARG_ACCESS_API support
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <oleg@redhat.com>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
	<eric.devolder@oracle.com>, <robh@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240603073751.2282024-1-ruanjinjie@huawei.com>
 <Zl2BNCXzKRG+eTDv@shell.armlinux.org.uk>
 <3089651e-d8eb-f193-5eac-db925000dce9@huawei.com>
 <Zl7M4rjQbN2c9Bje@shell.armlinux.org.uk>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zl7M4rjQbN2c9Bje@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)



On 2024/6/4 16:14, Russell King (Oracle) wrote:
> On Tue, Jun 04, 2024 at 09:36:04AM +0800, Jinjie Ruan wrote:
>> On 2024/6/3 16:39, Russell King (Oracle) wrote:
>>> On Mon, Jun 03, 2024 at 03:37:51PM +0800, Jinjie Ruan wrote:
>>>> Currently, kprobe on ARM32 can not use the '$argx' syntax available on
>>>> other architecture. So implement regs_get_kernel_argument() and add
>>>> HAVE_FUNCTION_ARG_ACCESS_API support.
>>>
>>> This may work in the simple case, but it just doesn't work in the
>>> general case, where a function accepts 64-bit arguments. For example,
>>> for EABI and a function taking a 64-bit argument followed by a 32-bit
>>> argument:
>>>
>>> 	R0/R1 = 64-bit argument
>>> 	R2 = 32-bit argument
>>>
>>> Now consider 32-bit argument followed by 64-bit argument:
>>>
>>> 	R0 = 32-bit argument
>>> 	R1 = unused
>>> 	R2/R3 = 64-bit argument
>>
>> I agree with you, the current implementation considers a very simple
>> case, where all parameters are 32-bit.
>>
>> From "Procedure Call Standard for the Arm® Architecture", the
>> "6.1.1.1 Handling values larger than 32 bits" describes it this way:
>>
>> A double-word sized type is passed in two consecutive registers (e.g.,
>> r0 and r1, or r2 and r3).
>>
>>>
>>> Note that the mapping isn't argN = RN.
>>>
>>> Also, given that "unsigned long" is 32-bit on 32-bit Arm, one can't
>>> return a 64-bit argument through this interface. Even if one typed
>>> the function as u64, it still wouldn't work because the caller
>>> assigns the return value to an unsigned long. This seems to be an
>>> issue throughout the kernel tracing - it isn't written to support
>>
>> How about updating this interface to solve this problem? Let
>> regs_get_kernel_argument() return u64.
> 
> That doesn't solve the first problem. The issue is that once we enable
> this, it becomes userspace ABI, and any changes to it then become
> regressions.

Thank you! I understand what you mean. For the existing "$arg" API
interface, ARM32 cannot determine whether an input parameter of the
instrumentation function is a 32-bit or 64-bit parameter, and there is
no way to control the user not to instrument the function with complex
parameters, so this config cannot be enabled.

> 
> So no, I'm not going to have it enabled in mainline in a half-broken
> state.
> 

