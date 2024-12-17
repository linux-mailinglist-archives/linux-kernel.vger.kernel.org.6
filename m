Return-Path: <linux-kernel+bounces-449118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D989F4A19
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 12:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3C416D440
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5EA1EF080;
	Tue, 17 Dec 2024 11:41:45 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE951EE029
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734435705; cv=none; b=Jtn2gsN3cToSjW1vrB2aiWw/IcuAo9PnwRKWs8hb6AqIqhoSAtLKq4aPL3/xYYsiTNq3YLgFvZSvkDqCguWX3pwgL4kO0UN+LQt0kWIRKcCuPbpLol7ZXO2LWXc/YrYV56egtmKkaZdhgeOh+MwDJin56qie5/aN0k0mbUrAmhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734435705; c=relaxed/simple;
	bh=phVQujIZYl4Zo0ld1HH7fkPYGd81HBE5BOQlKLA1z4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4OYIYFLIpOPn+5uYzo21BExXwF9h6kcq82EqrxdOHrqYzym7PMGOwxjvPRzATEubb+SOD09IpM7/DwoHWl0MdF8jD8+1QanfokT1AcgI8ZoGfypZ/XWho2catRePPGxCwCqzQb/YyqEdqHTW8ua7QcJyuR6FJgVV37bOfG/QMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YCFJF4rB9z4f3lDK
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:41:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3139E1A018D
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 19:41:38 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP4 (Coremail) with SMTP id gCh0CgB3noJwY2FnmB9tEw--.54003S3;
	Tue, 17 Dec 2024 19:41:37 +0800 (CST)
Message-ID: <0737acaa-ba88-764c-d8ad-376b28b988e3@huaweicloud.com>
Date: Tue, 17 Dec 2024 19:41:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/2] test_maple_tree: Test exhausted upper limit of
 mtree_alloc_cyclic()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: maple-tree@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, chuck.lever@oracle.com, brauner@kernel.org
References: <20241216190113.1226145-1-Liam.Howlett@oracle.com>
 <20241216190113.1226145-3-Liam.Howlett@oracle.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <20241216190113.1226145-3-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3noJwY2FnmB9tEw--.54003S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KrWDXFWUJrWrWr47GFyDWrg_yoW8tF4Dpa
	9rXr43KFy7AryxWrZxXanFgFy5Wa1rCr17Xws2vr4Fv3sxAF1Iqrn8Ca43ur4xG3yUWa1Y
	vr1aqa1kCFy8ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07Upyx
	iUUUUU=
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/



在 2024/12/17 3:01, Liam R. Howlett 写道:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> When the upper bound of the search is exhausted, the maple state may be
> returned in an error state of -EBUSY.  This means maple state needs to
> be reset before the second search in mas_alloc_cylic() to ensure the
> search happens.  This test ensures the issue is not recreated.
> 
> Cc: Yang Erkun <yangerkun@huaweicloud.com>
> Cc: chuck.lever@oracle.com
> Cc: brauner@kernel.org
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>   lib/test_maple_tree.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 

Thanks for the testcase!

Reviewed-by: Yang Erkun <yangerkun@huawei.com>

> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index 72bda304b5952..13e2a10d7554d 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -3738,6 +3738,34 @@ static noinline void __init alloc_cyclic_testing(struct maple_tree *mt)
>   	}
>   
>   	mtree_destroy(mt);
> +
> +	/*
> +	 * Issue with reverse search was discovered
> +	 * https://lore.kernel.org/all/20241216060600.287B4C4CED0@smtp.kernel.org/
> +	 * Exhausting the allocation area and forcing the search to wrap needs a
> +	 * mas_reset() in mas_alloc_cyclic().
> +	 */
> +	next = 0;
> +	mt_init_flags(mt, MT_FLAGS_ALLOC_RANGE);
> +	for (int i = 0; i < 1023; i++) {
> +		mtree_alloc_cyclic(mt, &location, mt, 2, 1024, &next, GFP_KERNEL);
> +		MT_BUG_ON(mt, i != location - 2);
> +		MT_BUG_ON(mt, i != next - 3);
> +		MT_BUG_ON(mt, mtree_load(mt, location) != mt);
> +	}
> +	mtree_erase(mt, 123);
> +	MT_BUG_ON(mt, mtree_load(mt, 123) != NULL);
> +	mtree_alloc_cyclic(mt, &location, mt, 2, 1024, &next, GFP_KERNEL);
> +	MT_BUG_ON(mt, 123 != location);
> +	MT_BUG_ON(mt, 124 != next);
> +	MT_BUG_ON(mt, mtree_load(mt, location) != mt);
> +	mtree_erase(mt, 100);
> +	mtree_alloc_cyclic(mt, &location, mt, 2, 1024, &next, GFP_KERNEL);
> +	MT_BUG_ON(mt, 100 != location);
> +	MT_BUG_ON(mt, 101 != next);
> +	MT_BUG_ON(mt, mtree_load(mt, location) != mt);
> +	mtree_destroy(mt);
> +
>   	/* Overflow test */
>   	next = ULONG_MAX - 1;
>   	ret = mtree_alloc_cyclic(mt, &location, mt, 2, ULONG_MAX, &next, GFP_KERNEL);


