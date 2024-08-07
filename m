Return-Path: <linux-kernel+bounces-277683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A439694A4B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FE4A281D88
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D121D175C;
	Wed,  7 Aug 2024 09:49:59 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E81801
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024198; cv=none; b=FRwZOviCU8t6vjiIISg10yCBl58zdkkwwHk39cLYUEasiF2SB3a36p9f+GhnYIX12ZXoiuy4+nh4p5OlC1caz4HJIDvQBoyoq3tD1PnvrPuLAmfQdjdJQdsLbvdIOQ8qVLiy9pCGIq0eAbXXNW/0CqTPjCjeb+X4bv/g+rs1Ftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024198; c=relaxed/simple;
	bh=+1d5dJpSZQVDjU2G/4MWLmye/ccW4fBcrrHX88dVaeU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ki+RP7tRhHKD7akMLXdud1/6wAFphd6C3otArg7Np4EOwSKqE8fpfvMulQant+EYP8FOGppKmUcIr5+3WKBuct1giHdzNtccYPF7O6J25lIv6Oncd2hyCYqG0RJJpxcSpAAp5HliFS0BGXj4RErywHCXv2N/lSW1TVWQmUz8DWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Wf54V0Mxqzcd2k;
	Wed,  7 Aug 2024 17:49:46 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4027F18006C;
	Wed,  7 Aug 2024 17:49:53 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 kwepemg500010.china.huawei.com (7.202.181.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Aug 2024 17:49:52 +0800
Message-ID: <c11ba413-89f6-46b4-8d59-96306c9f1f14@huawei.com>
Date: Wed, 7 Aug 2024 17:49:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [build fail] v6.11-rc2 from "ARM: 9404/1: arm32: enable
 HAVE_LD_DEAD_CODE_DATA_ELIMINATION"
Content-Language: en-US
To: Harith George <mail2hgg@gmail.com>, <arnd@arndb.de>,
	<linus.walleij@linaro.org>, <rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>,
	<harith.g@alifsemi.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg500010.china.huawei.com (7.202.181.71)

It seems to be ok with vexpress_defconfig in mainline tree v6.11-rc2,
I may need your .config/code file for further testing.

On 2024/8/7 13:12, Harith George wrote:
> Hi,
> 
> I am seeing a regression in "make xipImage" builds in mainline tree 
> v6.11-rc2  with LD segmentation fault.
> 
> $ make V=1 xipImage
> ...
> + arm-poky-linux-musleabi-ld -EL -z noexecstack --no-undefined -X 
> --pic-veneer -z norelro --build-id=sha1 --orphan-handling=warn 
> --script=./arch/arm/kernel/vmlinux.lds -o vmlinux --whole-archive 
> vmlinux.a init/version-timestamp.o --no-whole-archive --start-group 
> arch/arm/lib/lib.a lib/lib.a --end-group
> scripts/link-vmlinux.sh: line 49: 3371164 Segmentation fault      (core 
> dumped) ${ld} ${ldflags} -o ${output} ${wl}--whole-archive ${objs} 
> ${wl}--no-whole-archive ${wl}--start-group ${libs} ${wl}--end-group 
> ${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}
> make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 139
> make[2]: *** Deleting file 'vmlinux'
> make[1]: *** [/home/amol/hgg/mainline/linux/Makefile:1156: vmlinux] Error 2
> make: *** [Makefile:224: __sub-make] Error 2
> 
> git bisect pointed to ed0f941022515ff40473("ARM: 9404/1: arm32: enable 
> HAVE_LD_DEAD_CODE_DATA_ELIMINATION")
> 
> "CONFIG_HAVE_LD_DEAD_CODE_DATA_ELIMINATION=y" is getting set with the 
> commit in my .config.
> But, my .config is _not_ enabling the "LD_DEAD_CODE_DATA_ELIMINATION" flag.
> 
> Reverting commit ed0f94102251, resolves the linking fail.
> Infact, reverting just the ".reloc  .text, R_ARM_NONE, ." additions in 
> arch/arm/kernel/entry-armv.S resolves the linking fail.
> 
> My toolchain is
> arm-poky-linux-musleabi-gcc (GCC) 9.2.0
> GNU ld (GNU Binutils) 2.32.0.20190204
> 
> I am working on a new platform. Hence my .config/code has other platform 
> related additions which would not make sense on current mainline, which 
> is why I have not added it here. Do let me know if you would still like 
> to have the .config file.
> 
> 
> Thanks,
> Warm Regards,
> Harith
> 
> 
> 

