Return-Path: <linux-kernel+bounces-332195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB31D97B6A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40E42B241AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 01:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1E2219EB;
	Wed, 18 Sep 2024 01:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FhDrV9dR"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B11BC5C
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726624678; cv=none; b=qFxUz0+jS1uc3SANw4ycw8YY/5bfw3UIenQ8F2nPx/5Kxfzayx1wuTjJPNlnV5j2QkQQFgZ+Uf4PkAZyLUwLHA+VTZ0wSG0SItYpEm6jEhOAy77yzY4xRndgh1NijBVNOmwCEG6ZBahA3iZZrofKkD1CRb0Xxb+YYQTb6t7IZrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726624678; c=relaxed/simple;
	bh=ngMcbxZMUXpWu5YlhxeBD71LAx00cXhF6oX0y0lq8+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmeeCZl5qWzEF4QW2IL4IN9QQj308LrDVmkjrbwo/r4KL4i6oAYB5YhO71q1n9NEVWyIbp1x2VWlTvhrU74+Piyr+yr/zoPjeS8phuXLleI7uefxNMmKKwHzDWBMGdG1L+OQaHp4iOZKi4fmNMI+YBsVLUa6oEoxyYVysnA0Mqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FhDrV9dR; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726624668; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=A4jqe7pWtQ64X7iNYqSy/jnDxqkRdn0IU1n4pvDIMqY=;
	b=FhDrV9dRGtCuY7wOg7IQ0AoLxMdn/HXm6qT0PL6g/AHEsaRVJj+/OhaQtYb1WYCssk3KKFeJ4+uJbqotFcIvYKNEBeEeqX933dM/9FIyq2IqpVLigHmi9azkhXL1eeMR5wEFup8M10FFkaENJ57cT0qOjrZFZaYhaWWLjzgeYgE=
Received: from 30.221.131.28(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0WFC9GlY_1726624666)
          by smtp.aliyun-inc.com;
          Wed, 18 Sep 2024 09:57:47 +0800
Message-ID: <19ba4042-b7b8-4b8a-933d-f62eab8c684f@linux.alibaba.com>
Date: Wed, 18 Sep 2024 09:57:46 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: Fix typo in comment
To: Mohammed Anees <pvmohammedanees2003@gmail.com>,
 akpm <akpm@linux-foundation.org>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240917185156.10580-1-pvmohammedanees2003@gmail.com>
Content-Language: en-US
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20240917185156.10580-1-pvmohammedanees2003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/18/24 2:51 AM, Mohammed Anees wrote:
> Fix "Allcate" -> "Allocate"
> 
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index ea9127ba3..395e23920 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -4767,7 +4767,7 @@ int ocfs2_insert_extent(handle_t *handle,
>  }
>  
>  /*
> - * Allcate and add clusters into the extent b-tree.
> + * Allocate and add clusters into the extent b-tree.
>   * The new clusters(clusters_to_add) will be inserted at logical_offset.
>   * The extent b-tree's root is specified by et, and
>   * it is not limited to the file storage. Any extent tree can use this


