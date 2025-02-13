Return-Path: <linux-kernel+bounces-512685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3107CA33CA0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B497D3A942D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE6C212F9A;
	Thu, 13 Feb 2025 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RRJKNTPq"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9950A20DD79
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441956; cv=none; b=U5RSRSdGZ3GS0hhwQGWNq80CrC/tFqZ4DSzAKv/rHL5q/5K6T/5Z1gO8WWPqnWOlGM27TkiIjECUs7oWN6qhtHQMIc/Vz1k1YqHPTGCqx+A0zY2KdIfXLQgzDmFeAofpU37C0I+fwIoE0I4ypw6NVhSQ9wEPWbDk+zcVKhCCVWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441956; c=relaxed/simple;
	bh=gobRm5klG9qLpLtL0cXlyf1R+Cz3ToKa1X3k9IhyBOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEF5VPNS7/e2333Dgh3blVxzSNXBjxYqF65qu+QuTdIRuijeDTN8xrBcys5FKKxzl6pAMINBpVfwu8b/gi0UsEJ4u7rr8LgzRmFBD2D06X5okp33WZYB7OoRDJkUl3ABmjaL449CrA+KcAnNTpIx0Lvz78HhKpRuPaeSQ8s+HUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RRJKNTPq; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5d35c3f6-a52f-4e63-a972-50ee2898947e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739441941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PDjLygtCi1vCtbRpum5K/rvtczS1k9PvMWQ8Pv/Of7U=;
	b=RRJKNTPqn12IyLN+yh0a5aQBIxXfLKOa83lncsYP5oCcdVbnklF6jZasoZBCVaizrRnB5a
	Gs2aOLTPmvEnq0PfNPaW5/NqX0fbSEcsjX8Nl0wqXhZ6Ew2Bms/wLeHBtHb2NuQcvr0aRL
	7t2tKDzH3EhwC8dOW7kmxrZuJ5Cdi6w=
Date: Thu, 13 Feb 2025 18:18:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] docs/zh_CN: add few request for Chinese translation
To: alexs@kernel.org
Cc: Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250213054222.21776-1-alexs@kernel.org>
 <20250213054222.21776-2-alexs@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250213054222.21776-2-alexs@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2/13/25 1:42 PM, alexs@kernel.org 写道:
> From: Alex Shi <alexs@kernel.org>
>
> A good checked summit could save much time for linux-doc maintainer.
>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Yanteng Si <si.yanteng@linux.dev>



> ---
>   Documentation/translations/zh_CN/index.rst | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
> index 7574e1673180..cc512ca54172 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -26,7 +26,13 @@
>   顺便说下，中文文档也需要遵守内核编码风格，风格中中文和英文的主要不同就是中文
>   的字符标点占用两个英文字符宽度，所以，当英文要求不要超过每行100个字符时，
>   中文就不要超过50个字符。另外，也要注意'-'，'='等符号与相关标题的对齐。在将
> -补丁提交到社区之前，一定要进行必要的 ``checkpatch.pl`` 检查和编译测试。
> +补丁提交到社区之前，一定要进行必要的 ``checkpatch.pl`` 检查和编译测试，确保
> +在 ``make htmldocs/pdfdocs`` 中不增加新的告警，最后，安装检查你生成的
> +html/pdf 文件，确认它们看起来是正常的。
> +
> +提交之前请确认你的补丁可以正常提交到中文文档维护库:
> +https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git/

> +如果你的补丁依赖于其他人的补丁, 可以与其他人商量后由某一个人合并提交。

I think this requires a detailed tutorial. Otherwise, it

will increase the difficulty for beginners to get started.

How about removing it for now? I have a plan to write

a translation guidebook. What's your opinion?


Thanks,

Yanteng

>   
>   与Linux 内核社区一起工作
>   ------------------------

