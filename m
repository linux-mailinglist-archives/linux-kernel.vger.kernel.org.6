Return-Path: <linux-kernel+bounces-207278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C6A9014EE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 10:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ED2FB21880
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 08:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4964B1CA80;
	Sun,  9 Jun 2024 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fZRkQEsF"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114FDBE4F;
	Sun,  9 Jun 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717921268; cv=none; b=jhT8JkmSPBP2lNtGYniRNOgrOcH1pgutL0qT2hIgqX0xK9dBzsMgJBg4e6nF/wwnPpO6+wSkwNhTYu/flFBZsOXEpd1r8spfLuh0f/BsBuRAOZNe5B7igTz8lEpgemVVbYUHwp3F/RDv34px8iKLa1tM+1BL+y1nQDDZbmq67uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717921268; c=relaxed/simple;
	bh=5DevxDXr7dBgUa1XngX1B4wwpcU5vAKWJLDm4Bc6Xe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YnaUrV3XqmXhmDPl2lqUH/rbpmuTLfTS3JEuD71FUZ8lZRG/omvhTmMWcN3Yi7w2JX1QR/a7lrFRsMdqzz0ewVz3S7zHzcyi9jqZhlG7P8W13BewERN+phpkp0GPVxOdojWjAACB6qw9QNKCZa2dGU+z/eOXZQY9UNDpED7slcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fZRkQEsF; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: dzm91@hust.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717921260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p4o03/pzCQ6eaeQy5QsanEkCk2N90XxxK4ZFhqU5w5g=;
	b=fZRkQEsFiu91Pkd2Pxhlci0bCPR1U1by4AqZxFdHkBwjJ7CqLVi0NH3Op5wN7wakh2zbu1
	vRy8pXkX8BC8ivI70n6i6ZZ/UPe7etrVzJQKVMj5utldss5Qwa/2HFztKrbPOZW5ajdKuA
	nQfDzWjrEZI7DaQzI7fjhALlIbNXao8=
X-Envelope-To: alexs@kernel.org
X-Envelope-To: siyanteng@loongson.cn
X-Envelope-To: corbet@lwn.net
X-Envelope-To: konstantin@linuxfoundation.org
X-Envelope-To: linux-doc@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: zenghui.yu@linux.dev
Message-ID: <fdbbe5d0-65ea-49ef-9a4c-26fe7a691c64@linux.dev>
Date: Sun, 9 Jun 2024 16:20:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] docs/zh_CN: update the translation of security-bugs
To: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 Jonathan Corbet <corbet@lwn.net>,
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240607025842.24321-1-dzm91@hust.edu.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zenghui Yu <zenghui.yu@linux.dev>
In-Reply-To: <20240607025842.24321-1-dzm91@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/6/7 10:58, Dongliang Mu wrote:
> Update to commit 5928d411557e ("Documentation: Document the Linux Kernel
> CVE process")
> 
> commit 0217f3944aeb ("Documentation: security-bugs.rst: linux-distros
> relaxed their rules")
> commit 3c1897ae4b6b ("Documentation: security-bugs.rst: clarify CVE
> handling")
> commit 4fee0915e649 ("Documentation: security-bugs.rst: update
> preferences when dealing with the linux-distros group")
> commit 44ac5abac86b ("Documentation/security-bugs: move from admin-guide/
> to process/")
> 
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  .../translations/zh_CN/admin-guide/index.rst  |  1 -
>  .../translations/zh_CN/process/index.rst      |  3 +-
>  .../zh_CN/process/security-bugs.rst           | 84 +++++++++++++++++++
>  3 files changed, 86 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/translations/zh_CN/process/security-bugs.rst
> 
> diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
> index ac2960da33e6..773c53956000 100644
> --- a/Documentation/translations/zh_CN/admin-guide/index.rst
> +++ b/Documentation/translations/zh_CN/admin-guide/index.rst
> @@ -37,7 +37,6 @@ Todolist:
>  
>     reporting-issues
>     reporting-regressions
> -   security-bugs

It's be good to remove the old zh_CN/admin-guide/security-bugs.rst file
as well and update all references to it:

% git grep "admin-guide/security-bugs.rst" Documentation/translations/zh_CN/
Documentation/translations/zh_CN/admin-guide/reporting-issues.rst:Documentation/translations/zh_CN/admin-guide/security-bugs.rst 
，
Documentation/translations/zh_CN/admin-guide/reporting-issues.rst:更多信息请参见 
Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。
Documentation/translations/zh_CN/process/submitting-patches.rst:参见 
Documentation/translations/zh_CN/admin-guide/security-bugs.rst 。

Thanks,
Zenghui

