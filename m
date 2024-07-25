Return-Path: <linux-kernel+bounces-261616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA85993B9F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 02:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 785071F22384
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 00:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAECE2599;
	Thu, 25 Jul 2024 00:49:56 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DEA4687
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721868596; cv=none; b=Nn09D4QjzPL50zwPN+hk/uxbf+XUtxVuk38qR+yvdpjA4IcoYhrV8Uyal6n9jEdL95dMWqJ+zBG2AbKzX1PdXi24mUtHud0QjwdiQJqs/vwMqtRXKHaZ/0/o7kPUSESq7RRpTHKKiAacz9wLzMDSlRh/gwzQZnk+MlE7OL650no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721868596; c=relaxed/simple;
	bh=f2OLo1B8ALSxylc0cNldPGQt9BQJiQPJFhiD0ys0tZY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=mTbSUcxExkcrpaTBmPoJujkL9qbTYOPSUKpw5/z1ZCquuIZtN+Is+HYkefOObp4D9ZPGZfawHbuK1z5SspHQ4fDMrPzLo5XUHjU5l2rj5cXKk9hy+CNNlcfr2NiY8mxMz1kJZhhGbULJTsZi8bsXsrw3lPcz0RW5Vst2MbNfFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WTsgQ4ps9zMr72;
	Thu, 25 Jul 2024 08:48:02 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 146721402CB;
	Thu, 25 Jul 2024 08:49:50 +0800 (CST)
Received: from [10.174.178.219] (10.174.178.219) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 25 Jul 2024 08:49:49 +0800
Subject: Re: [PATCH] irqchip: Replace compared GIC version with
 ID_AA64PFR0_EL1_GIC_V4P1
To: Anshuman Khandual <anshuman.khandual@arm.com>
CC: <linux-arm-kernel@lists.infradead.org>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240724054623.667595-1-anshuman.khandual@arm.com>
From: Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <55998478-6c1a-ca9c-f487-f2d8f49f5e50@huawei.com>
Date: Thu, 25 Jul 2024 08:49:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240724054623.667595-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)

On 2024/7/24 13:46, Anshuman Khandual wrote:
> Replace open encoding for GIC version code with ID_AA64PFR0_EL1_GIC_V4P1 in
> gic_cpuif_has_vsgi().
> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Applies after the following patch that fixes the given field in tools sysreg.
> 
> https://lore.kernel.org/all/20240718215532.616447-1-rananta@google.com/

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

