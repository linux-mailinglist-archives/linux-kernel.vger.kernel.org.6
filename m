Return-Path: <linux-kernel+bounces-300284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFC395E1EC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD2028272D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 05:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C02A757E0;
	Sun, 25 Aug 2024 05:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="tI7fZsIR"
Received: from msa.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F7B2BB0D
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 05:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724563007; cv=none; b=YZ7S1hEMb6laMBdz6GHUFkNtRcr0u6WgUmVcqK8Akwgudnt4whEXpDH9JBc1XhQtIgQ4CW+e2nsnWy0m1Z22jPDC1l8dJwxzPIywl3XUVE3AABHPFnr8eCydoSNgzdBpJVOTa1Z0V4ZSKYJFIPVzOkrMhU22E13bDV+Xr8wFpEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724563007; c=relaxed/simple;
	bh=MgYNPYwiYmnwAbOQyYJUKJs3MNfpo5stsgVI1hozc0A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=ILFzv+8JLFDSMy2gV2cH0xqeJEa9PCw2MIRu2De5iTlh6QwgOolSWHduLSsIF/xecypIrS8RIUtOSozJZXknvXKqnmZiBeuPyHoDHIilIHbqWGr2HmONSM+ih0d63dUHbhffYQe07Fp5ESf5axH7NW+qRxyAa2q2zjVAlIFVClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=tI7fZsIR; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id i5c3sfnbnQaX2i5c3sLa2L; Sun, 25 Aug 2024 07:16:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724562996;
	bh=etav4+/0d2M+KsLJwpfXRerYAOxWEVkaPUajKyxnERA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=tI7fZsIR0lGDL5Pu+kP2C5UybE/oSXFDDtlpXC4+Ou/dEZJehmNg3cSPp0fbMf+kJ
	 /nl2i/cUQLxosXcliwSxw3wuWv1gSX3eMn5fwpSpJEvvgwh25wLN7dCi9tYfPRfsmc
	 BnTbo2u/NXT/bYI62v1S8aCAA6tXBDJGWee+849U9n/xNfCZyds4E7ajW15ItIv5tZ
	 u/Jr34DFxZb30t2kiYsdiIfD28l9kULLWpDdtBkNwMMGKigaobpkuSaKzNBaxGRi/c
	 o9HO204ux7k3oFB9h4pPS7qTj+KxSnKqvBWFbmxZzuOowXc2IQn7gJU01z3jUuGA3j
	 3dX0K6x9UEmLw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 25 Aug 2024 07:16:36 +0200
X-ME-IP: 90.11.132.44
Message-ID: <6d4ec950-878f-499c-a808-dd5b31c2ddb6@wanadoo.fr>
Date: Sun, 25 Aug 2024 07:16:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 2/5] drm/mediatek: Fix missing of_node_put() for
 mtk_drm_get_all_drm_priv()
From: Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Jinjie Ruan <ruanjinjie@huawei.com>, hjc@rock-chips.com, heiko@sntech.de,
 andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 krzk@kernel.org, jic23@kernel.org
References: <20240823092053.3170445-1-ruanjinjie@huawei.com>
 <20240823092053.3170445-3-ruanjinjie@huawei.com>
 <a4d23c3a-9791-4d2b-9853-9c9b27460db5@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <a4d23c3a-9791-4d2b-9853-9c9b27460db5@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 23/08/2024 à 12:46, Christophe JAILLET a écrit :
>> @@ -933,10 +931,8 @@ static int mtk_drm_probe(struct platform_device 
>> *pdev)
>>           }
>>           ret = mtk_ddp_comp_init(node, &private->ddp_comp[comp_id], 
>> comp_id);
>> -        if (ret) {
>> -            of_node_put(node);
>> +        if (ret)
>>               goto err_node;
> 
> Hi,
> 
> I've seen on another thread that is was not sure that scoped versions 
> and gotos played well together.
> 
> It was asked to check more in details and confirm that it was safe 
> before applying the patch.
> 
> I've not followed the discussion, so I just point it out, in case it helps.
> 
> I'll try to give it a look in the coming days.
> 
> 
> CJ
> 

Hi,
looking at the generated asm file (gcc 14.2.1), everything looks fine.

# drivers/gpu/drm/mediatek/mtk_drm_drv.c:933: 		ret = 
mtk_ddp_comp_init(node, &private->ddp_comp[comp_id], comp_id);
	salq	$5, %rax	#, _36
	movl	%r14d, %edx	# comp_id,
	movq	%rbx, %rdi	# node,
	leaq	552(%rbp,%rax), %rsi	#, _28
	call	mtk_ddp_comp_init	#
	movl	%eax, %r12d	# tmp205, <retval>
# drivers/gpu/drm/mediatek/mtk_drm_drv.c:934: 		if (ret)
	testl	%eax, %eax	# <retval>
	jne	.L212	#,

...

.L212:
# ./include/linux/of.h:138: DEFINE_FREE(device_node, struct device_node 
*, if (_T) of_node_put(_T))
	movq	%rbx, %rdi	# node,
	call	of_node_put	#
	jmp	.L171	#

CJ

