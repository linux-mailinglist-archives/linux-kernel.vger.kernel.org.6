Return-Path: <linux-kernel+bounces-371118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E25C59A36B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF4FB24BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEAE189B80;
	Fri, 18 Oct 2024 07:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X5KdRaEY"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEAD188724
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235407; cv=none; b=gLt2+258WhB7Zn++y9A2lRmlpTUlkc+g2i7VGDi25cRGXmxiX26+hPrumy1OAoy031nUOJpNuHHWVk/pro/V2V3QXNYXM1apKBiWbBXf1BZZ7G6Zj1z/ShEC+fB+RzmIODIJSzVAty7sGtqma7+g1FLvtSmgSAUG0ICHdPrK4g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235407; c=relaxed/simple;
	bh=k9L8JsOvOFxALDdMXJEjUggGAtwb3h7COGtZXiPSsp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+UNOEnqPLblvI6bX2ayHDkDaeHb3e/YLM8YvBJ0dWoO8qFz0ocfZJA2+9wdbL/Pg3cyBUcg4+cklGbzlIUyr6JoJELdKv2VrAAB1FZvoOIEadtL93K61vycJxBWm5qisDC1RSApV2ebOy8B39RNy2T2OgI6CZgYci4t01LxWn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X5KdRaEY; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <521e45c9-a402-4c53-936b-6052fa23c052@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729235401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O62afb38F2VjWAM8YzEi2B4+rD9H0BT+zR5G48p4spM=;
	b=X5KdRaEYjPYLUPBkUsMW0tcnkuAq+Yut29sJCIUCdXNp9opHln+zfqX07PJYnavSuBep4+
	ADRWTQzS0r3fVmNGxfbtfRzK1Hk4KEVdYcD563M1ecc2krnyHjazotLj2S3zhsnc5+FohW
	7cplCjSwCPn9HJoH+KM++KbsNSLc1NI=
Date: Fri, 18 Oct 2024 15:09:54 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] docs/zh_CN: update the translation of
 process/coding-style.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, SeongJae Park <sj@kernel.org>,
 Federico Vaga <federico.vaga@vaga.pv.it>,
 Thorsten Blum <thorsten.blum@toblux.com>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241018014609.3781089-1-dzm91@hust.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20241018014609.3781089-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2024/10/18 09:46, Dongliang Mu 写道:
> Update to commit c5d436f05a3f ("docs/process: fix typos")
>
> scripts/checktransupdate.py reports:
>
> Documentation/translations/zh_CN/process/coding-style.rst
> commit c5d436f05a3f ("docs/process: fix typos")
> commit 82b8000c28b5 ("net: drop special comment style")
> 2 commits needs resolving in total
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng
> ---
> v1->v2: revise the script name
>   .../translations/zh_CN/process/coding-style.rst       | 11 -----------
>   1 file changed, 11 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/process/coding-style.rst b/Documentation/translations/zh_CN/process/coding-style.rst
> index 10b9cb4f6a65..0484d0c65c25 100644
> --- a/Documentation/translations/zh_CN/process/coding-style.rst
> +++ b/Documentation/translations/zh_CN/process/coding-style.rst
> @@ -560,17 +560,6 @@ Documentation/translations/zh_CN/doc-guide/index.rst 和 scripts/kernel-doc 。
>   	 * with beginning and ending almost-blank lines.
>   	 */
>   
> -对于在 net/ 和 drivers/net/ 的文件，首选的长 (多行) 注释风格有些不同。
> -
> -.. code-block:: c
> -
> -	/* The preferred comment style for files in net/ and drivers/net
> -	 * looks like this.
> -	 *
> -	 * It is nearly the same as the generally preferred comment style,
> -	 * but there is no initial almost-blank line.
> -	 */
> -
>   注释数据也是很重要的，不管是基本类型还是衍生类型。为了方便实现这一点，每一行
>   应只声明一个数据 (不要使用逗号来一次声明多个数据)。这样你就有空间来为每个数据
>   写一段小注释来解释它们的用途了。


