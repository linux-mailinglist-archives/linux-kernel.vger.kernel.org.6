Return-Path: <linux-kernel+bounces-265020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7185B93EB4F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07A61C214DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E499278C7F;
	Mon, 29 Jul 2024 02:37:12 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D4F335B5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722220632; cv=none; b=Az8CkEUqbJY6JpzT9KWqzPjd4wjKCeh0pQ9pcik9RlcNIwEkCXPLpR8GgBj6sC6KCwQrSBa9QGweV2CfXXLwX3sEbQ1RQlJiTiTtASkFe76ROlC9J+QpxndjayqiMHSbHPMA9GdMjyZ/KNpjYvHCwGg+5A1afQuLTbjXH4vuWTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722220632; c=relaxed/simple;
	bh=axdKFVy9soapBV/WFvB7mtGLkNgcnkCvb1xCFG6OPBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Mba1cdn3fFVHU4fsoAq5pKpmR//g7GHpz5+WYlzumrBh6h5TtvPWy+XFh013k+KWXi417BFMgz48hZxCKtD+k4R3RsbCKdoo/JjQDWHg5+OM+6iMDLDfJyaM2fL6OEJIIomyo1SavELv3ofXk7jlWBkEm+8+OJRLKFPcx5Ut0Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WXMp40XSnz2ClcB;
	Mon, 29 Jul 2024 10:32:28 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 05D6918002B;
	Mon, 29 Jul 2024 10:36:59 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 29 Jul 2024 10:36:58 +0800
Message-ID: <6e10605a-e45b-b683-afe1-27c2e3a51b4c@huawei.com>
Date: Mon, 29 Jul 2024 10:36:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] irqchip/gic-v3: Remove asmlinkage for gic_handle_irq()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, <maz@kernel.org>,
	<joey.gouly@arm.com>, <mark.rutland@arm.com>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20240727073648.1042377-1-ruanjinjie@huawei.com>
 <87zfq3tce4.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87zfq3tce4.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi100008.china.huawei.com (7.221.188.57)



On 2024/7/27 17:25, Thomas Gleixner wrote:
> On Sat, Jul 27 2024 at 15:36, Jinjie Ruan wrote:
>> Since commit 064dbfb41691 ("arm64: entry: convert IRQ+FIQ handlers to C"),
>> the gic_handle_irq() is only called by C functions, so remove
>> the asmlinkage.
>>
>> Fixes: 064dbfb41691 ("arm64: entry: convert IRQ+FIQ handlers to C")
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> 
> Right. Can we please fix all of that and be done with it?
> 
> # git grep -l asmlinkage drivers/irqchip/ | xargs grep set_handle_irq
> 
> should find the remaining leftovers of asmlinkage.

You are right，handle_arch_irq() are all only called in C now, we can all
remove the asmlinkage.

> 
> Thanks,
> 
>         tglx

