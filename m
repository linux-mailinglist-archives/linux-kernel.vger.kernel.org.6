Return-Path: <linux-kernel+bounces-309738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF90966FE6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 09:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DED11F22CE2
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 07:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE9B1531FD;
	Sat, 31 Aug 2024 07:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="BlclahhY"
Received: from msa.smtpout.orange.fr (msa-216.smtpout.orange.fr [193.252.23.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC443D8E
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 07:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725087849; cv=none; b=hXB/8DQAt7XCzOFM4L38EckbizbSIiJB8Hz2LUL88iYB93QoUOoy4kYvvR0QMVkFnFbwdcAOTxCCLl7gmEutvebdhLbNP1afxd+dTegPB7RvFhBUMsjGya9N16ILwF8OROWUkMHTFu+2sRQIe2svsAE6sn2MxlUOReXreGEgpdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725087849; c=relaxed/simple;
	bh=Dt3R7cGdw3sK9nuym7jFRDn7pYfJJLDzXteXqXRoxjE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D1oIn9TTNiKs5MsfiwW1+mFjL/SH7Cfr3ISnWKrerGUNXNGUs9ee7XuvkOUZJAWeH7u6ZIR6pmo/rj7dK7brtPNtQxSlDxg9CVwGGcnCng60ipsQXtfWeEMA0ZGAUokU7lVRYb2+Gi6y1HDSTfZxwKaGlgqL1/UVkVs64AcKGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=BlclahhY; arc=none smtp.client-ip=193.252.23.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id kI9MsSUW4QaX2kI9Ms6D8D; Sat, 31 Aug 2024 09:03:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725087838;
	bh=nQY1gyPhkj6L2TL696AnPtGpi4GUmhTji5v5MQ+bEjs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To;
	b=BlclahhYQvjhND3nEJOXIGDADht72+UtsKa30curK3njZs9gc/pnC0ghFIC2zvbJk
	 Mi8STBa59wgKz0zAZQXqsBS4vBEeY3nMwjwdgVPJEUd0c3Z9RKbxUR/8wKGg1zdflm
	 PDJFMMYVlmXv2xuC0KLO74Fohh/S6fXBx7GM680XhvatQ1IA7aZ7n1DUMMA5Q0raSV
	 Yoyf4yBQs/K2MLPD+OYVO+D1BnVBBWtqqLf74HuM9Ph18EMmGzR+ZqgfvjUHL7YEGm
	 ewcZASs79m1w0k9Vc1pCqRKgTlt2R/PUzzRdpxhzOmsGKEEE0x+47/Yr7EZLf/JyCA
	 J3M2MiH/tEVGg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 31 Aug 2024 09:03:58 +0200
X-ME-IP: 90.11.132.44
Message-ID: <ea017b05-7a42-4d3a-a1f2-9bceb56966e3@wanadoo.fr>
Date: Sat, 31 Aug 2024 09:03:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 1/1] mm: vmalloc: Optimize vmap_lazy_nr arithmetic when
 purging each vmap_area
To: Uladzislau Rezki <urezki@gmail.com>,
 Adrian Huang <adrianhuang0701@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Adrian Huang <ahuang12@lenovo.com>
References: <20240829130633.2184-1-ahuang12@lenovo.com>
 <ZtDFQHGHMq6TfbKA@pc636> <ZtHyxvscMuxHQkaO@pc636>
Content-Language: en-US, fr-FR
In-Reply-To: <ZtHyxvscMuxHQkaO@pc636>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 30/08/2024 à 18:26, Uladzislau Rezki a écrit :

> At least in my case, HW, i do not see that atomic_long_add_return() is a
> top when it comes to CPU cycles. Below one is the hottest instead:
> 
> static bool
> is_vn_id_valid(unsigned int node_id)
> {
> 	if (node_id < nr_vmap_nodes)
> 		return true;
> 
> 	return false;
> }
> 
> access to "nr_vmap_nodes" which is read-only and globally defined:
> 
> static __read_mostly unsigned int nr_vmap_nodes = 1;
> 
> Any thoughts?
> 
> --
> Uladzislau Rezki
> 

Hi,

unrelated to your use case, but something that coud easily save a few 
cycles on some system, IMHO.

Maybe:

#if NR_CPUS > 1
static __read_mostly unsigned int nr_vmap_nodes = 1;
static __read_mostly unsigned int vmap_zone_size = 1;
#else
#define nr_vmap_nodes	1
#define vmap_zone_size	1
#endif

So that the compiler can do a better job because some loops can be 
optimized away and there is no need to access some memory to get theses 
values.

Not sure if such a use case can exist or is of any interest.

This is valide because of [1] and the #ifdef around the 
num_possible_cpus() declaration [2, 3].


Just my 2c.

CJ

[1]: https://elixir.bootlin.com/linux/v6.11-rc5/source/mm/vmalloc.c#L5026

[2]: 
https://elixir.bootlin.com/linux/v6.11-rc5/source/include/linux/cpumask.h#L1083
[3]: 
https://elixir.bootlin.com/linux/v6.11-rc5/source/include/linux/cpumask.h#L1136

