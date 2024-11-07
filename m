Return-Path: <linux-kernel+bounces-399161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 334569BFBB9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDF881F21129
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4813101E6;
	Thu,  7 Nov 2024 01:38:47 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA1E15E88;
	Thu,  7 Nov 2024 01:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943527; cv=none; b=bQILWFrYDpqBwlVQNw8Sr2L7018NC4AerxCaNh727YkXJmDt75AZirO4tr7i0EJ3q9nkpewpUGsdxgHmad2FbA/Wb1jQIG+ZNbMEFVTmoPMdcjFotcWUTzVOn4a2AONR3TyB71pqMjVesib4h8nHomUr1TDboFoKheMLwVZ6wek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943527; c=relaxed/simple;
	bh=cdDVSN2dDQ7aY2Y83N1SVPJflL98KpAv57ou8HHraiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CMXpewcgyGg2T63UmV7qAlgnln7npHhkISWFKamVcnIdlZMWYOAeaxi0Yymi4tfYIu0JfY/W2/YmfMurg1LpotoUpdwxNQDLltMhsgNDmLFp3O29XRnE8UCBAqgeqXgl6W+LOuJuQNQm6W6zjEmrFcR9RLqy9vzKT5kX/9iO6UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XkPnS20bWz1SG99;
	Thu,  7 Nov 2024 09:37:00 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id B0E0E18002B;
	Thu,  7 Nov 2024 09:38:42 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 09:38:41 +0800
Message-ID: <214a5a61-0ae6-09c8-9fce-c43b09a07f03@huawei.com>
Date: Thu, 7 Nov 2024 09:38:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] docs/zh_CN: fix one sentence in llvm.rst
Content-Language: en-US
To: Dongliang Mu <dzm91@hust.edu.cn>, <si.yanteng@linux.dev>, Alex Shi
	<alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Bill
 Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
CC: <hust-os-kernel-patches@googlegroups.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
References: <20241107013615.374757-1-dzm91@hust.edu.cn>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241107013615.374757-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/11/7 9:35, Dongliang Mu wrote:
> According to Jinjie Ruan, the description about the prebuilt llvm is
> incorrect. Fix this sentence with new understanding.
> 
> Link: https://groups.google.com/g/hust-os-kernel-patches/c/GbN5RkVrBho/m/2sC9rAw7BQAJ
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  Documentation/translations/zh_CN/kbuild/llvm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/translations/zh_CN/kbuild/llvm.rst b/Documentation/translations/zh_CN/kbuild/llvm.rst
> index f71092144a26..f87e0181d8e7 100644
> --- a/Documentation/translations/zh_CN/kbuild/llvm.rst
> +++ b/Documentation/translations/zh_CN/kbuild/llvm.rst
> @@ -188,7 +188,7 @@ LLVM 并不支持 Linux 内核所有可支持的架构，同样，即使 LLVM 
>  
>  我们在 `kernel.org <https://kernel.org/pub/tools/llvm/>`_ 提供预编译的稳定版 LLVM。
>  这些版本已经针对 Linux 内核构建，使用配置文件数据进行优化。相较于其他发行版中的 LLVM，它们应该
> -能提高内核构建时间。
> +能提高内核构建效率。

Reviewed-by: Jinjie Ruan <ruanjinjie@huawei.com>

>  
>  以下是一些有助于从源代码构建 LLVM 或通过发行版的包管理器获取 LLVM 的链接。
>  

