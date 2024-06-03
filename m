Return-Path: <linux-kernel+bounces-199146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B048D82FD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00BC21F21484
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 12:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0979312CDA8;
	Mon,  3 Jun 2024 12:55:35 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397012C816
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419334; cv=none; b=KsB0PbSBEamkNznerRODxaiOs6MUbpn34tIy+CrSIUMQjRsOWQ12tUWYDPaOAExRNp9y/duwT8jCFsyf9b/8HaqlIQEBorJeKZLVdMXZb397OswVXn4hnXXPbXBezfLf6n1DW1BuGR23k8opFMO4YGR3hUQHypm3g7377pgHJ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419334; c=relaxed/simple;
	bh=zWe5whA25T5TVE2QuwRPt+5WNEG45lktcBKkrxyPjRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jAqVoblzP0eRnlQANJsXWm87Mt/iiJbKeOR+nVT3L34VfXmzR2OSV0FqENQsaEvzB21QOKGSAPe9PEl5JRKjrx28yOWgGgZDik8/Sph49dJCwEfvFJGY8YI31eu4KhM6YhxCO4S5lRNMrz/BBJFtcW+23rqnIZA2O5rMlfpmprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VtDBH746Mz1S98Q;
	Mon,  3 Jun 2024 20:51:35 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id EE43A140382;
	Mon,  3 Jun 2024 20:55:14 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Jun 2024 20:55:09 +0800
Message-ID: <a800254e-f305-4adc-9d8b-fea8c5926539@huawei.com>
Date: Mon, 3 Jun 2024 20:55:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-next v4] arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
Content-Language: en-US
To: Russell King <linux@armlinux.org.uk>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Fangrui Song <maskray@google.com>, Linus
 Walleij <linus.walleij@linaro.org>, <geert@linux-m68k.org>,
	<linux@armlinux.org.uk>, <afd@ti.com>, <akpm@linux-foundation.org>,
	<kirill.shutemov@linux.intel.com>, <geert+renesas@glider.be>,
	<corbet@lwn.net>, <rppt@kernel.org>, <robh@kernel.org>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <liuyuntao12@huawei.com>
References: <20240316023932.700685-1-liuyuntao12@huawei.com>
 <CAMj1kXH5bpbagOO+WFwxp4=U=Kbu9RVbPrEemt80S7My1jTEdw@mail.gmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <CAMj1kXH5bpbagOO+WFwxp4=U=Kbu9RVbPrEemt80S7My1jTEdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd100004.china.huawei.com (7.185.36.20)

Gentle ping

On 2024/3/20 1:12, Ard Biesheuvel wrote:
> On Sat, 16 Mar 2024 at 03:44, Yuntao Liu <liuyuntao12@huawei.com> wrote:
>>
>> The current arm32 architecture does not yet support the
>> HAVE_LD_DEAD_CODE_DATA_ELIMINATION feature. arm32 is widely used in
>> embedded scenarios, and enabling this feature would be beneficial for
>> reducing the size of the kernel image.
>>
>> In order to make this work, we keep the necessary tables by annotating
>> them with KEEP, also it requires further changes to linker script to KEEP
>> some tables and wildcard compiler generated sections into the right place.
>> When using ld.lld for linking, KEEP is not recognized within the OVERLAY
>> command, and Ard proposed a concise method to solve this problem.
>>
>> It boots normally with defconfig, vexpress_defconfig and tinyconfig.
>>
>> The size comparison of zImage is as follows:
>> defconfig       vexpress_defconfig      tinyconfig
>> 5137712         5138024                 424192          no dce
>> 5032560         4997824                 298384          dce
>> 2.0%            2.7%                    29.7%           shrink
>>
>> When using smaller config file, there is a significant reduction in the
>> size of the zImage.
>>
>> We also tested this patch on a commercially available single-board
>> computer, and the comparison is as follows:
>> a15eb_config
>> 2161384         no dce
>> 2092240         dce
>> 3.2%            shrink
>>
>> The zImage size has been reduced by approximately 3.2%, which is 70KB on
>> 2.1M.
>>
>> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
>> Tested-by: Arnd Bergmann <arnd@arndb.de>
>> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

