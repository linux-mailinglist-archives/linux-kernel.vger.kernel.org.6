Return-Path: <linux-kernel+bounces-293166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F27C957B89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 04:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AD0EB221A3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 02:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401723D3B3;
	Tue, 20 Aug 2024 02:41:23 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15EDDA6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724121682; cv=none; b=m7clRz41e+yiRy/qu+3NJ1yhxjgC0o7kvQrPLwmHfGSKcRmmipP1rnq6E8tA9M2GlqJJ9GSlCEAXyfEGWvfEeesAN6VnyYhc/TGx2uNuLRzE0mx2tkzivilr3tz/gfVLqSj83cHki2aLla1fAf4NuP4VK5cfiIAi/9ARwz71BvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724121682; c=relaxed/simple;
	bh=9j1GDWkhoComCPik0Qz4+dIRBtEl5h3Xfdl4oQFO3GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F+AZyF9ufCNLwHfNRsXgpWziNpRpUnz9lL+raC9ANaecBeYTO6PuCYrzq8OG1cgkSlZZqcxMEDkKSrwm/SUTB9M3ErFYovtUcJV3Xw6iavtU5I+wL3M++sVmfv2kyGLU0DY7VVDWVcNI5OFYPelAsObteDA2fxUmnmb+Hsa2vSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wntrh5vJ3zQq4b;
	Tue, 20 Aug 2024 10:36:36 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AE9C1402E0;
	Tue, 20 Aug 2024 10:41:17 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 20 Aug 2024 10:41:16 +0800
Message-ID: <2ee770cc-b5dc-1837-aa65-6b2519e03d70@huawei.com>
Date: Tue, 20 Aug 2024 10:41:15 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] riscv: Remove unused _TIF_WORK_MASK
Content-Language: en-US
To: <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
	<samitolvanen@google.com>, <debug@rivosinc.com>, <andy.chiu@sifive.com>,
	<guoren@kernel.org>, <songshuaishuai@tinylab.org>, <bjorn@rivosinc.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240711111508.1373322-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240711111508.1373322-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/7/11 19:15, Jinjie Ruan wrote:
> Since commit f0bddf50586d ("riscv: entry: Convert to generic entry"),
> _TIF_WORK_MASK is no longer used, so remove it.
> 
> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/riscv/include/asm/thread_info.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> index 5d473343634b..0eead6b7b790 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -111,8 +111,4 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
>  #define _TIF_UPROBE		(1 << TIF_UPROBE)
>  #define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)
>  
> -#define _TIF_WORK_MASK \
> -	(_TIF_NOTIFY_RESUME | _TIF_SIGPENDING | _TIF_NEED_RESCHED | \
> -	 _TIF_NOTIFY_SIGNAL | _TIF_UPROBE)
> -

Ping.

>  #endif /* _ASM_RISCV_THREAD_INFO_H */

