Return-Path: <linux-kernel+bounces-278150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9BC94ACC0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 17:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDBDB1C2294C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A8812C460;
	Wed,  7 Aug 2024 15:23:04 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E350B12BEBE
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044183; cv=none; b=AOIN/EF5zrz26VNMmH/6WJnTPzTLYGwR/GoipmqhS/H2mni8sMjNlH6Q/Gyqc9el6ey4s0ot3khD7s8vT0WBm51klkAsHdghngL0gyuH+TsadxbFDZspV3xWtxKOldvdcmFlf9ltn/rVS1vJYY9RD7whh+8ANm4dfisl+YcfoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044183; c=relaxed/simple;
	bh=kACrunjvDB/DSQMdxOVsjAqK3jNN66NyvYykrJSHotM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o/0dvtK+GtNECINe6yorZEsPnTFlYfGIHCPUO6aR4z5GRgC/CZpvXocFoLQTBjWqj2Klw6KbaHpHfHealyRIB5FQJQXUFTbByuoMyYc8Xc9CnvVovzihvOn280q5YSg81BqCDeYbGYmy9S9sruNpO2Vj7syqHpCCADpysXTnQNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WfDMn43JBz20l6g;
	Wed,  7 Aug 2024 23:18:29 +0800 (CST)
Received: from kwepemg500010.china.huawei.com (unknown [7.202.181.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D801140113;
	Wed,  7 Aug 2024 23:22:56 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 kwepemg500010.china.huawei.com (7.202.181.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 Aug 2024 23:22:55 +0800
Message-ID: <2812367a-49ad-4c88-8844-8f8493b15bbd@huawei.com>
Date: Wed, 7 Aug 2024 23:22:54 +0800
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
CC: <linux-arm-kernel-join@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com>
 <c11ba413-89f6-46b4-8d59-96306c9f1f14@huawei.com>
 <52518ac5-53bb-4c70-ba99-4314593129dc@gmail.com>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <52518ac5-53bb-4c70-ba99-4314593129dc@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg500010.china.huawei.com (7.202.181.71)

Thanks, I reproduce the link error with toolchain
gcc version 9.3.0
GNU ld (GNU Binutils) 2.33.1

with same gcc version, just upgrading ld version to 2.36.1, it does not 
segfault and build completes. there should be bugs in low version of ld,
and the ".reloc  .text, R_ARM_NONE, ." triggers that.


On 2024/8/7 19:51, Harith George wrote:
> 
> 
> On 07-08-2024 15:19, liuyuntao (F) wrote:
>> It seems to be ok with vexpress_defconfig in mainline tree v6.11-rc2,
>> I may need your .config/code file for further testing.
>>
> Please find attached minimal patches just for your testing. "make 
> ARCH=arm e7_defconfig; make ARCH=arm xipImage"
> 
> Thanks,
> Warm Regards,
> Harith

