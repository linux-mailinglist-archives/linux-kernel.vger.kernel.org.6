Return-Path: <linux-kernel+bounces-183784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE26F8C9E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 15:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E948B213F2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B967A135A7D;
	Mon, 20 May 2024 13:21:55 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C5554FA1
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716211315; cv=none; b=CcSqiv7tmbEgLLE/SmCA9uQrUZOgfIi0XdrMzW6gAArlm3vein7NN3RlcLDfZHi55hAeUteqXww8ZY4sazuhwiorlcbW+Y6CY7M216w1d2f7ppJ0TdwygIyWO37/2ssTX41Hiw4315R+d2qslFeL3Pger6bqS6rouiOLETgwKmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716211315; c=relaxed/simple;
	bh=lFhFicoTUR0HTjRnwiKX7Nhd2JVpOUuOPHos2f7lCwo=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lte8wTObOfx23ATsoWPN9x4l9/QYLtMTN9505D1fIr9nxe5XjsHQFpioUAQy5EpouZzkBVk8x+VYZqX+Q4x8EY5sYIYwz6AeS2k8fbMjSUh4VS92pBuiR7lgKKp7K+Wso6aay2kT04VQ8YrOm3LeLAMjfG0a4IJFD+p2CPCH2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VjdTp3zn5z1HCJF;
	Mon, 20 May 2024 21:20:14 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 8334B180062;
	Mon, 20 May 2024 21:21:44 +0800 (CST)
Received: from [10.67.111.82] (10.67.111.82) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 20 May
 2024 21:21:44 +0800
Subject: Re: [PATCH] arm64: asm-bug: Add .align 2 to the end of __BUG_ENTRY
To: Li Zetao <lizetao1@huawei.com>, Mark Rutland <mark.rutland@arm.com>
References: <1715955208-17109-1-git-send-email-xiaojiangfeng@huawei.com>
 <ZksnARrLkKHcX4C_@J2N7QTR9R3>
 <20d70835-9411-9a08-c567-56d7040e01dd@huawei.com>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <Dave.Martin@arm.com>,
	<xieyuanbin1@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <nixiaoming@huawei.com>,
	<wangbing6@huawei.com>, <douzhaolei@huawei.com>, <liaohua4@huawei.com>,
	<lijiahuan5@huawei.com>, <wangfangpeng1@huawei.com>, "zhangjianhua (E)"
	<chris.zjh@huawei.com>
From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <876b3571-b7f5-03f1-5da2-07a2ec47ad08@huawei.com>
Date: Mon, 20 May 2024 21:21:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20d70835-9411-9a08-c567-56d7040e01dd@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/5/20 20:05, Li Zetao wrote:


>>> diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
>>> index c762038..6e73809 100644
>>> --- a/arch/arm64/include/asm/asm-bug.h
>>> +++ b/arch/arm64/include/asm/asm-bug.h
>>> @@ -28,6 +28,7 @@
>>>       14470:    .long 14471f - .;            \
>>>   _BUGVERBOSE_LOCATION(__FILE__, __LINE__)        \
>>>           .short flags;                 \
>>> +        .align 2;                \
> The use of .align 2 here is based on the assumption that struct bug_entry is 4-byte aligned. Currently, there is no problem with this assumption, but for compatibility reasons, refer to the riscv architecture and refactor the implementation of __BUG_FLAGS:
> 
> #define __BUG_FLAGS(flags)                    \
> do {                                \
>     __asm__ __volatile__ (                    \
>         "1:\n\t"                    \
>             "ebreak\n"                \
>             ".pushsection __bug_table,\"aw\"\n\t"    \
>         "2:\n\t"                    \
>             __BUG_ENTRY "\n\t"            \
>             ".org 2b + %3\n\t"                      \
>             ".popsection"                \
>         :                        \
>         : "i" (__FILE__), "i" (__LINE__),        \
>           "i" (flags),                    \
>           "i" (sizeof(struct bug_entry)));              \
> } while (0)
> 
> Align the real size of struct bug_entry through .org. What do you think?

The implementation of risc-v BUG_ENTRY does handle
the `implicit padding` at the end of the struct correctly,
however, it does not handle the `implicit padding` in the middle of
the struct correctly, for example, assume that
the struct bug_entry changes as follows in the future:
struct bug_entry {
	signed int bug_addr_disp; // 4 bytes
	unsigned short flags; // 2 bytes
	< implicit padding > // 6 bytes
	unsigned long long flags2; // 8 bytes
}

Even the implementation of risc-v BUG_ENTRY
can't handle this situation. Referencing risc-v solution
complicates things, but doesn't completely solve the problem.

In the current scenario, we know the contents of struct bug_entry
and generate variables using assembly language.
I don't think it's necessary to complicate things.

