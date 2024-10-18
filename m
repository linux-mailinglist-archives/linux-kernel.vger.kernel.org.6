Return-Path: <linux-kernel+bounces-371097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ABE9A366A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0461F2471D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C3517DE06;
	Fri, 18 Oct 2024 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p1wrrSAD"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9CE10F2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729234929; cv=none; b=tNioiIYc2pEe2x2yk+Ci/VjjRUf8Hv7F1Zu3uQvmtUJQIzD1xCv2Ov4fx3vdkZMc0Vhuyi9274hmkZzYdp/G7d4F8AHAoplj67p/uUtnnZsDxoVbLdTlTYLfWV7dZQ7XK02fLF3JnfjF/v138LXEC6p5e/iv2nrxpiK9N4k/iHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729234929; c=relaxed/simple;
	bh=1OC0axrSY7PkHXgA7IuqEdTf6UvHuS/1KrSO/7HZDCA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XzywTuBBnRBvNj/Pm2gPH0zBAcfQ2tl7mAdruXZ+BoKUlfOLK42Gx2HxCAqPbeH7BojceEv3yt9pVLvIdmflZij2p0+AgI8UOVNuaBRrup/RvC32TCroAwnS94yKjjwYjY+3jYSsj5SQC5e8FvuvbHjooV2m/VsuYJJNWrLSIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p1wrrSAD; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6745d52b-ff44-41eb-bb2f-de01a44dbf0e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729234924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oF1gq4IAx7BN7XK2CjsboktwzJFb5VHajZh+5K/TUag=;
	b=p1wrrSAD7qkI2+C7fZwernvcRSqk4sz1evK6tFbn60nkkXiROGlU+3E9r/DhyqX5nVDWdM
	UEPdjQD3lDvsFN6BYh8DnbiAv5ODMMXUqtCyF6MRtV8qDCd31k967lesOKCZm7Vy/8TM9t
	GmCGeqhO4Aih0Ayqk/YEJuzLlDwKbwo=
Date: Fri, 18 Oct 2024 15:01:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] docs/zh_CN: update the translation of
 process/submitting-patches.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241017111419.3396605-1-dzm91@hust.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20241017111419.3396605-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2024/10/17 19:14, Dongliang Mu 写道:
> Update to commit eb5ed2fae197 ("docs: submitting-patches: Advertise b4")
>
> scripts/checktranstatus.py reports:
>
> Documentation/translations/zh_CN/process/submitting-patches.rst
> commit eb5ed2fae197 ("docs: submitting-patches: Advertise b4")
> commit 413e775efaec ("Documentation: fix links to mailing list services")
> 2 commits needs resolving in total
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng
> ---
>   .../zh_CN/process/submitting-patches.rst      | 19 ++++++++++---------
>   1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
> index 7ca16bda3709..f7ae584a439e 100644
> --- a/Documentation/translations/zh_CN/process/submitting-patches.rst
> +++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
> @@ -105,7 +105,7 @@ xyzzy do frotz”或“[I]changed xyzzy to do frotz”，就好像你在命令
>   当链接到邮件列表存档时，请首选lore.kernel.org邮件存档服务。用邮件中的
>   ``Message-ID`` 头（去掉尖括号）可以创建链接URL。例如::
>   
> -    Link: https://lore.kernel.org/r/30th.anniversary.repost@klaava.Helsinki.FI/
> +    Link: https://lore.kernel.org/30th.anniversary.repost@klaava.Helsinki.FI
>   
>   请检查该链接以确保可用且指向正确的邮件。
>   
> @@ -195,11 +195,8 @@ scripts/get_maintainer.pl在这个步骤中非常有用。如果您找不到正
>   在MAINTAINERS文件中查找子系统特定的列表；您的补丁可能会在那里得到更多的关注。
>   不过，请不要发送垃圾邮件到无关的列表。
>   
> -许多与内核相关的列表托管在vger.kernel.org上；您可以在
> -http://vger.kernel.org/vger-lists.html 上找到它们的列表。不过，也有与内核相关
> -的列表托管在其他地方。
> -
> -不要一次发送超过15个补丁到vger邮件列表！！！！
> +许多与内核相关的列表托管在 kernel.org 上；您可以在 https://subspace.kernel.org
> +上找到它们的列表。不过，也有与内核相关的列表托管在其他地方。
>   
>   Linus Torvalds是决定改动能否进入 Linux 内核的最终裁决者。他的邮件地址是
>   torvalds@linux-foundation.org 。他收到的邮件很多，所以一般来说最好 **别**
> @@ -621,6 +618,13 @@ Fixes: 指示补丁修复了之前提交的一个问题。它可以便于确定
>   的工作所基于的树的提交哈希。你应该在封面邮件或系列的第一个补丁中添加它，它应
>   该放在 ``---`` 行的下面或所有其他内容之后，即只在你的电子邮件签名之前。
>   
> +工具
> +----
> +
> +这个过程的许多技术方面可以使用 b4 自动完成，其文档可在
> +https://b4.docs.kernel.org/en/latest/ 查看。该工具可帮助处理诸如追踪依赖项、运行
> +checkpatch 以及格式化和发送邮件等事务。
> +
>   参考文献
>   --------
>   
> @@ -643,9 +647,6 @@ Greg Kroah-Hartman，“如何惹恼内核子系统维护人员”
>   
>     <http://www.kroah.com/log/linux/maintainer-06.html>
>   
> -不！！！别再发巨型补丁炸弹给linux-kernel@vger.kernel.org的人们了！
> -  <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>
> -
>   内核 Documentation/translations/zh_CN/process/coding-style.rst
>   
>   Linus Torvalds关于标准补丁格式的邮件


