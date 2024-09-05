Return-Path: <linux-kernel+bounces-316682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A5F96D2B3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 281301F23E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFEB194ACB;
	Thu,  5 Sep 2024 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arVgj21q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB428F66
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725526991; cv=none; b=VKUKTrhLUr39n+jRHv3J+0SmJT8k/spsSG8r/BHAll6h0wbxu72UIZWtY3/f81kdzY+AKtgAJ9NoFMciFsn5ehUImbBNXjPzLRLTaAsvWYVdvyZGe80xl/tA7hTltfDiyHgt9uanxAwZQnhvPV6RDVrqhRQ4/f7wRu7C1kV6nEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725526991; c=relaxed/simple;
	bh=C7QqHkaQizpgmyQockOjinfASfHPk1I3HmbJdZeXzKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBzJULCvvD/LxhzCM3focxVlKftxYpv/lCNaQNVJvx1fG4BGC8Kgw2jdmE+xePOnYbM0eBNk0YaaBfuMfZGp6mFA/EqEA4TUOD3Z8njPO9NIbHLa8pLB+7T/oQajjUUu6m3otci7lSRujpJa74TN7bCayHO7Xz3K9oHfZIEHGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arVgj21q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8019C4CEC3;
	Thu,  5 Sep 2024 09:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725526990;
	bh=C7QqHkaQizpgmyQockOjinfASfHPk1I3HmbJdZeXzKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=arVgj21qrZsiyH0cldhkDd/KtA7OfMr/dfTaY+OIMMDNAjsujCSP1GDSCVam9o2VT
	 VOT6i/k9t/2IU8shBVQ/wJ0ANas8LxfvXhHvNJygr9e0XrgKBAlf03+xbygwlkCu/Y
	 GUNMjq2lH0T+OCglFp7wc0qafhE5X+pbjL573zTanBKEG/cSZfLr/e7RYrfABsqsae
	 jnC0mybgZZazptJOQqg6M7jicugDcTvC0/wfY0MDXNLYtDv/VgH69Y/RhFRD5JNThd
	 e+XoKdWW6mybffnCLHDt6n38zd354VzX/JogkNNlpTD+BrvwhgtYQjEMfIKGbuK6nD
	 4FFQsSrgu0szA==
Message-ID: <867c7fb8-480f-402e-b88e-54499d4db3b7@kernel.org>
Date: Thu, 5 Sep 2024 17:03:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] erofs: mark experimental fscache backend
 deprecated
To: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
 <20240830032840.3783206-4-hsiangkao@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240830032840.3783206-4-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/8/30 11:28, Gao Xiang wrote:
> Although fscache is still described as "General Filesystem Caching" for
> network filesystems and other things such as ISO9660 filesystems, it has
> actually become a part of netfslib recently, which was unexpected at the
> time when "EROFS over fscache" proposed (2021) since EROFS is entirely a
> disk filesystem and the dependency is redundant.
> 
> Mark it deprecated and it will be removed after "fanotify pre-content
> hooks" lands, which will provide the same functionality for EROFS.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

