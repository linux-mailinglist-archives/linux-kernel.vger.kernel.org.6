Return-Path: <linux-kernel+bounces-371121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0009A36B8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847381F248B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 07:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D73318BBAE;
	Fri, 18 Oct 2024 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c6TZClOX"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9E188917
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 07:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729235471; cv=none; b=cLmQECjOQ5cRrK0Jx3iL/5pB6yzYmiOosCAGMKaD4whJ4nUapFJT/j2fXs7qpvs6hsAX0PKAu/UU9r1dQ4vlqZ1Ao9NSSO/BMYFmrYHzzxfd8arOuRgSlp1Qc2g86iLjNS0jSMjtq5YNwL2rP9lnifgSEE7+3tzEh+ILeOZgJG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729235471; c=relaxed/simple;
	bh=KhpKfpfAxofzn5Lk8AAilVgA3xnrYs4kWfSIOcDbJH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8JTmurl+vmtW0+SiRDerGdtkn1SNuAcLrdd3hPkpCHq2yh82onksk2rF9hxbDX19yXEoZJ+AmGCqamnOYCoilSzNv3aRkYWY0IZd5PXEITD5zmx5nc8QCGTetQLBjV0IxMGaplQ8u0bKDxP5N5NafA9yjAxhthZQhAu90ywgB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c6TZClOX; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0d807175-a7ba-4fd9-adf8-e388ab126ded@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729235467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pjgyr7iHWkx1YZrrYsXIEVt9rAkmdbqLb5oxsHnAaLE=;
	b=c6TZClOXKQJtrljEFD6lswmH9TiP0FnLP0aMvJ2GOwNHhBWxRCcfxuzIS3jk3AU/HnWdZC
	1nkNyzFFIXX6Byg0ZcB6bQOY6VK2UXMab0zhWJlvgY8+asq9kTkfofozNmHxxjOzoddD7L
	4KnweV6SB0dBTCIcW9cjIska2eay1yA=
Date: Fri, 18 Oct 2024 15:11:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] docs/zh_CN: update the translation of
 process/email-clients.rst
To: Dongliang Mu <dzm91@hust.edu.cn>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>
Cc: hust-os-kernel-patches@googlegroups.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241018014908.3783976-1-dzm91@hust.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20241018014908.3783976-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




在 2024/10/18 09:49, Dongliang Mu 写道:
> Update to commit 91031ca349ee ("docs: improve comment consistency in
> .muttrc example configuration")
>
> scripts/checktransupdate.py reports:
>
> Documentation/translations/zh_CN/process/email-clients.rst
> commit 91031ca349ee ("docs: improve comment consistency in .muttrc
> example configuration")
> commit 7fe7de7be828 ("Docs/process/email-clients: Document HacKerMaiL")
> commit 9c03bc90c065 ("Documentation: process: Revert "Document suitability
> of Proton Mail for kernel development"")
> commit 1d2ed9234c85 ("Documentation: process: Document suitability of
> Proton Mail for kernel development")
> 4 commits needs resolving in total
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
Reviewed-by: Yanteng Si <si.yanteng@linux.dev>

Thanks,
Yanteng
> ---
> v1->v2: revise the script name
>   .../translations/zh_CN/process/email-clients.rst         | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/process/email-clients.rst b/Documentation/translations/zh_CN/process/email-clients.rst
> index 34d51cdadc7b..a70393089df3 100644
> --- a/Documentation/translations/zh_CN/process/email-clients.rst
> +++ b/Documentation/translations/zh_CN/process/email-clients.rst
> @@ -197,7 +197,7 @@ Mutt不自带编辑器，所以不管你使用什么编辑器，不自动断行
>   Mutt 是高度可配置的。 这里是个使用mutt通过 Gmail 发送的补丁的最小配置::
>   
>     # .muttrc
> -  # ================  IMAP ====================
> +  # ================  IMAP  ====================
>     set imap_user = 'yourusername@gmail.com'
>     set imap_pass = 'yourpassword'
>     set spoolfile = imaps://imap.gmail.com/INBOX
> @@ -325,3 +325,10 @@ Gmail网页客户端自动地把制表符转换为空格。
>   另一个问题是Gmail还会把任何含有非ASCII的字符的消息改用base64编码，如欧洲人的
>   名字。
>   
> +HacKerMaiL (TUI)
> +****************
> +
> +HacKerMaiL (hkml) 是一个基于公共收件箱的简单邮件管理工具，它不需要订阅邮件列表。
> +该工具由 DAMON 维护者开发和维护，旨在支持 DAMON 和通用内核子系统的基本开发工作
> +流程。详细信息可参考 HacKerMaiL 的 README 文件
> +(https://github.com/sjp38/hackermail/blob/master/README.md)。


