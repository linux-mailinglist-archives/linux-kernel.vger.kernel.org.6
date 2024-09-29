Return-Path: <linux-kernel+bounces-342946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5377F98950D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 13:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160B0282F43
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 11:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FD4169397;
	Sun, 29 Sep 2024 11:23:27 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE47E130A54;
	Sun, 29 Sep 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727609006; cv=none; b=k7Vgj8VF03OcwvZDJ7uTMXntFNk9c8pVZoC/XjoSAZLWcsDld5JeMDOuP75X9WTyTqueKCuRHR7OeoI7e+6Eqjbez+FjZe95da/K+klPRmjXdDt6SSgiETNFi9OPjj1wJuJO+LOGe8zyIjpU/AUzQtz+w+sxW/ApSKB6q+PZuRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727609006; c=relaxed/simple;
	bh=cb8CFz7Xajukpz5KaVfiOGq1p8u1V1JOAyfqbfpMwPM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=H8JXL0UqkETR5YL/uZKJSs0J45aG/nfx3RmPIkYUw3viM40bFNygK8SLfyjvhFQzr0xD3/+UjTS87AxIPVmGh6/yR5LIn4H0iy7Kv/76rAv/rkiXL1X7I6dCVKcH5Abqw9rLg0q/bVdvsghikO0p5OxGwmpxCiERujSeYtcWfNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XGhcc5xc7zySb1;
	Sun, 29 Sep 2024 19:22:08 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 47F7818010A;
	Sun, 29 Sep 2024 19:23:14 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm000013.china.huawei.com (7.193.23.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 29 Sep 2024 19:23:13 +0800
Subject: Re: [PATCH RFC 1/2] dt-bindings: mtd: ubi-volume: add
 'volume-is-critical' property
To: Daniel Golle <daniel@makrotopia.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, John
 Crispin <john@phrozen.org>, <linux-mtd@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <e0936674dd1d6c98322e35831b8f0538a5cfa7a3.1727527457.git.daniel@makrotopia.org>
 <7a2e8819-ac70-4070-a731-53994c72cd79@kernel.org>
 <Zvf_84xxhxwpPgee@makrotopia.org>
 <18e9d774-813b-427e-9938-53853d695e18@kernel.org>
 <ZvgU0eBEwTJ3sHuN@makrotopia.org>
 <ad5a3811-c856-4f4b-f569-bb67a0e3f751@huawei.com>
 <Zvkxi-6J8R1K95PQ@makrotopia.org>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3fbc4221-5967-fb9a-3cee-91cd5de2b805@huawei.com>
Date: Sun, 29 Sep 2024 19:23:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zvkxi-6J8R1K95PQ@makrotopia.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000013.china.huawei.com (7.193.23.81)

在 2024/9/29 18:52, Daniel Golle 写道:
> On Sun, Sep 29, 2024 at 12:03:11PM +0800, Zhihao Cheng wrote:
>> 在 2024/9/28 22:38, Daniel Golle 写道:
>>> On Sat, Sep 28, 2024 at 03:45:49PM +0200, Krzysztof Kozlowski wrote:
>>>> On 28/09/2024 15:09, Daniel Golle wrote:
>>>>> On Sat, Sep 28, 2024 at 03:02:47PM +0200, Krzysztof Kozlowski wrote:
>>>>>> On 28/09/2024 14:47, Daniel Golle wrote:
>>>>>>> Add the 'volume-is-critical' boolean property which marks a UBI volume
>>>>>>> as critical for the device to boot. If set it prevents the user from
>>>>>>> all kinds of write access to the volume as well as from renaming it or
>>>>>>> detaching the UBI device it is located on.
>>>>>>>
>>>>>>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>>>>>>> ---
>>>>>>>    .../devicetree/bindings/mtd/partitions/ubi-volume.yaml   | 9 +++++++++
>>>>>>>    1 file changed, 9 insertions(+)
>>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
>>>>>>> index 19736b26056b..2bd751bb7f9e 100644
>>>>>>> --- a/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
>>>>>>> +++ b/Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
>>>>>>> @@ -29,6 +29,15 @@ properties:
>>>>>>>        description:
>>>>>>>          This container may reference an NVMEM layout parser.
>>>>>>> +  volume-is-critical:
>>>>>>> +    description: This parameter, if present, indicates that the UBI volume
>>>>>>> +      contains early-boot firmware images or data which should not be clobbered.
>>>>>>> +      If set, it prevents the user from renaming the volume, writing to it or
>>>>>>> +      making any changes affecting it, as well as detaching the UBI device it is
>>>>>>> +      located on, so direct access to the underlying MTD device is prevented as
>>>>>>> +      well.
>>>>>>> +    type: boolean
>>>>>>
>>>>>> UBI volumes are mapping to partitions 1-to-1, right? So rather I would
>>>>>> propose to use partition.yaml - we already have read-only there with
>>>>>> very similar description.
>>>>>
>>>>> No, that's not the case.
>>>>>
>>>>> An MTD partition can be used as UBI device. A UBI device (and hence MTD
>>>>> partition) can host *several* UBI volumes.
>>>>>
>>>>> Marking the MTD partition as 'read-only' won't work, as UBI needs
>>>>> read-write access to perform bad block relocation, scrubbing, ...
>>>>
>>>> OK, so not partition but read-only volume.
>>>
>>> +1
>>>
>>>>
>>>>>
>>>>> Also, typically not all UBI volumes on a UBI device are
>>>>> read-only/critical but only a subset of them.
>>>>>
>>>>> But you are right that the description is inspired by the description
>>>>> of the 'read-only' property in partition.yaml ;)
>>>>>
>>>>> I initially thought to also name the property 'read-only', just like
>>>>> for MTD partitions. However, as the desired effect goes beyond
>>>>> preventing write access to the volume itself, I thought it'd be
>>>>> better to use a new name.
>>>>
>>>> Yeah, maybe... critical indeed covers multiple cases but is also
>>>> subjective. For some bootloader is critical, for other bootloader still
>>>> might be fully A/B updateable thus could be modifiable. For others, they
>>>> want to use fw_setenv from user-space so not critical at all.
>>>
>>> The case I want to cover here is the bootloader itself being stored
>>> inside a UBI volume. MediaTek's fork of ARM TrustedFirmware-A bl2 comes
>>> with support for UBI and loads BL3 (which is TF-A BL31 and U-Boot, and
>>> maybe OP-TEE as well) from a static UBI volume. Removing, renaming or
>>> altering that volume results in the device not being able to boot any
>>> more and requiring a complicated intervention (at attaching debugging
>>> UART and using low-level recovery tool) in order to recover.
>>
>> Who removes/renames the 'critical' volume? I suggest to fix it in the upper
>> layer(not in kernel). After looking through the patch 2, it seems a hack
>> solution.
> 
> The enemy is the user, the upper layer is between the keyboard and the
> screen. Just like for 'read-only' MTD partitions I'm looking
> for a similar solution for UBI which prevents the user from accidentally
> deleting or destroying the bootloader, lets say, when logged in via SSH.
> .
> 

I guess that other partitions(excepts mtd) have the similar situations, 
users could delete a rootfs(ext4) partition by operation the raw block 
device. The kernel has no way to stop user doing this, what if the user 
just want to rebuild partions?
Marking volume as critical(by a stopper in kernel) could prevent user 
mistakenly operating, but I think it is more important that user need to 
know what he/she is doing.

