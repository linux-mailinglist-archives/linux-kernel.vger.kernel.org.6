Return-Path: <linux-kernel+bounces-268408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F71C94244F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CFF1F2436A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AACCD2F5;
	Wed, 31 Jul 2024 01:52:16 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55FC2FD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 01:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722390735; cv=none; b=A3fWTvql2dRRA1I3ZsNWXY8WWKRKCYydfjFg00ebaM8guFi1iPKaDVVmEeB18QH7iYRP9sXh8xTm1eMU4fImzM0kKlWT9XshljzpcyFdw0WUt/PDH2/KKfVjeTCdJAD1XPK/so2ouI5vS+SsV01eBc/FX8bZp+UpgpIGiBsB+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722390735; c=relaxed/simple;
	bh=QRdipQ8xsFlH6n2BfxmanT/bEEn4THmz2AF+Y9g3Eug=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gTkpiYtCzZHnEGuA5gZcDEAUAKlMobWb7JibZCSUMvPNg9t1JFLf7x61F9dqaxRaw7HvIRJIhjRtR27W/NPHh1njsvTOmb/C0bagpKc5RcUj1M4eV1DtXHvFU0LZecZ2jhh+eOTCFPY50TLn6Lu6FgQc+S+sPvkuYb9P/6w1XuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WYZhv019YzyPDw;
	Wed, 31 Jul 2024 09:47:10 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E087A18009B;
	Wed, 31 Jul 2024 09:52:08 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemi100008.china.huawei.com (7.221.188.57) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 31 Jul 2024 09:52:08 +0800
Message-ID: <1309c436-4e7f-89a3-3b33-abddaaac410c@huawei.com>
Date: Wed, 31 Jul 2024 09:52:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH RESEND 0/2] ARM: Switch over to GENERIC_CPU_DEVICES
Content-Language: en-US
To: <linux@armlinux.org.uk>, <arnd@arndb.de>, <afd@ti.com>,
	<akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
	<eric.devolder@oracle.com>, <ardb@kernel.org>, <gregkh@linuxfoundation.org>,
	<deller@gmx.de>, <javierm@redhat.com>, <bhe@redhat.com>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240702075742.945768-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240702075742.945768-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi100008.china.huawei.com (7.221.188.57)

Gentle ping.

On 2024/7/2 15:57, Jinjie Ruan wrote:
> Currently, almost all architectures have switched to GENERIC_CPU_DEVICES,
> except for arm32. Also switch over to GENERIC_CPU_DEVICES, which can also
> make the code more concise.
> 
> Jinjie Ruan (2):
>   ARM: Switch over to GENERIC_CPU_DEVICES using arch_register_cpu()
>   ARM: Convert to arch_cpu_is_hotpluggable()
> 
>  arch/arm/Kconfig           |  1 +
>  arch/arm/include/asm/cpu.h |  1 -
>  arch/arm/kernel/setup.c    | 14 ++------------
>  3 files changed, 3 insertions(+), 13 deletions(-)
> 

