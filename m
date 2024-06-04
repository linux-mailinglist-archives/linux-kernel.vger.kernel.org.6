Return-Path: <linux-kernel+bounces-199909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A75DC8FA79D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DBD1C217E6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57634139CFF;
	Tue,  4 Jun 2024 01:36:26 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E0E2119
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 01:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717464985; cv=none; b=Th+MdhyWHAQjjnNRAxhv7tS9P4iwTj/GL/n00WtOIuR7Kq7pRvmuZzYBfyAA1JyING8yKKkP89HtoSWTnKEKvWx6LMXa0ubbSNiPsiycgJoLFEq7kh7rqP6+ctQsSo1kw+aI4ktuSWzxjx2Q43Lplsnr5oX63wWmBdfk+5p3dnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717464985; c=relaxed/simple;
	bh=mW5dbYIqWWUK3VaFNAsZjpjACk13IXmQ7ap4a3h8YOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qGwLg07m5hCyRBv2JF0P/A6QJ0UX9dH19UtYhaYelREm1TpZcpK/ojlow0qkfuFhGsT5pTg35MKNrFVUXe8O+Jl+CAXhMIrJHtGwhgwuYnZHgyv0BLK73xsIZRraGshJhnsqO8S6/TYVqG+CA40UCHO0coONKl9KT85UCsoJqo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VtY4B4qmxz1S4vR;
	Tue,  4 Jun 2024 09:32:26 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 52CFF14038F;
	Tue,  4 Jun 2024 09:36:06 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 4 Jun 2024 09:36:05 +0800
Message-ID: <3089651e-d8eb-f193-5eac-db925000dce9@huawei.com>
Date: Tue, 4 Jun 2024 09:36:04 +0800
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
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <Zl2BNCXzKRG+eTDv@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)



On 2024/6/3 16:39, Russell King (Oracle) wrote:
> On Mon, Jun 03, 2024 at 03:37:51PM +0800, Jinjie Ruan wrote:
>> Currently, kprobe on ARM32 can not use the '$argx' syntax available on
>> other architecture. So implement regs_get_kernel_argument() and add
>> HAVE_FUNCTION_ARG_ACCESS_API support.
> 
> This may work in the simple case, but it just doesn't work in the
> general case, where a function accepts 64-bit arguments. For example,
> for EABI and a function taking a 64-bit argument followed by a 32-bit
> argument:
> 
> 	R0/R1 = 64-bit argument
> 	R2 = 32-bit argument
> 
> Now consider 32-bit argument followed by 64-bit argument:
> 
> 	R0 = 32-bit argument
> 	R1 = unused
> 	R2/R3 = 64-bit argument

I agree with you, the current implementation considers a very simple
case, where all parameters are 32-bit.

From "Procedure Call Standard for the Arm® Architecture", the
"6.1.1.1 Handling values larger than 32 bits" describes it this way:

A double-word sized type is passed in two consecutive registers (e.g.,
r0 and r1, or r2 and r3).

> 
> Note that the mapping isn't argN = RN.
> 
> Also, given that "unsigned long" is 32-bit on 32-bit Arm, one can't
> return a 64-bit argument through this interface. Even if one typed
> the function as u64, it still wouldn't work because the caller
> assigns the return value to an unsigned long. This seems to be an
> issue throughout the kernel tracing - it isn't written to support

How about updating this interface to solve this problem? Let
regs_get_kernel_argument() return u64.

> 64-bit arguments on 32-bit architectures. See, for example,
> fetch_store_raw(), where the unsigned long gets cast to a u64.
> It'll still only have 32-bits of significant value.
> 

