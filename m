Return-Path: <linux-kernel+bounces-179172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340058C5CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 23:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37D21F22764
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 21:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84757180A87;
	Tue, 14 May 2024 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="LwaIbRru"
Received: from msa.smtpout.orange.fr (msa-217.smtpout.orange.fr [193.252.23.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C47114532B
	for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715721034; cv=none; b=JANLvABjl/83SvejabqK5fecDnXRR2JMCywCTzKb07vSp9U3/cdwai83ZJDQnWbZHCsmnOozoeVXY7XpzMkJ/Bz38nitp6o7OB6FmYH9vAXeEqXGx5A3QO2kc+erSoN0XxOWu/RBQCM1YE5O6fCPF/UiIuCcJoRG2eqNjcb2XIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715721034; c=relaxed/simple;
	bh=e2KLbrdsks+J6+1FvGS7oH2+UqSVRAnRmGXVo1hlsCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AU8BJaJnkmtB6UKCPTK95BJ0eY4oYAUHVgwshxF/36qFX98r5/ZLqiUkW3ql7PC9LeNRBGjkcqwyBQU+t/Oaq59TWHoVjhJwFO2C3QlRbyiWBn/19TRgcJtm3VxxGt9moU8UHxCpdUYu7X6Osy2XVLxrJscdGJf1PLSb4qrU0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=LwaIbRru; arc=none smtp.client-ip=193.252.23.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 6ysXsio6Zfcja6ysXstlKb; Tue, 14 May 2024 22:36:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715718967;
	bh=nnkV8QffiL7l22gdgN3bgaCjV2cYw/rxwjbuLjaurWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=LwaIbRruVSX6cMoGHOexSQ95eEEW6+Ns/6TfRrTg9YY0DJgHDxcudQ6EhJH+zkiNR
	 sAGNhJTxF7kxsGbmpTsCFbjDvzwBH2g4sd6WTUIdJjFOb53fQZ4TMBlwzDNTFhauFP
	 W3yIeaq8DO2lRcZe3/2tJQGleSJnPOYcTMsaS3Jwpg8hM2VYd0fIfszwBJGIEHqNsO
	 yFsAxV+pYpvOeG17rsas03P5Ey4Ec4zux5pgRkN1i3R2WsM2nviSB5pyfOG+0hdFsI
	 zHnsH3Nbj6Sw8Wf1H8tIhM8Ot4TJp4Xnf10ULkPBQvHEK2Ou5Mu22xnY0kox1MXsJR
	 IEfY7MAuwSjSQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 14 May 2024 22:36:06 +0200
X-ME-IP: 86.243.17.157
Message-ID: <d5f51c2e-daef-467d-9430-8c2d48819a56@wanadoo.fr>
Date: Tue, 14 May 2024 22:35:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] binder: use bitmap for faster descriptor lookup
To: Carlos Llamas <cmllamas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Christian Brauner <brauner@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 Tim Murray <timmurray@google.com>, Alice Ryhl <aliceryhl@google.com>,
 John Stultz <jstultz@google.com>, Steven Moreland <smoreland@google.com>,
 Nick Chen <chenjia3@oppo.com>
References: <20240514160926.1309778-1-cmllamas@google.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240514160926.1309778-1-cmllamas@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/05/2024 à 18:09, Carlos Llamas a écrit :
> When creating new binder references, the driver assigns a descriptor id
> that is shared with userspace. Regrettably, the driver needs to keep the
> descriptors small enough to accommodate userspace potentially using them
> as Vector indexes. Currently, the driver performs a linear search on the
> rb-tree of references to find the smallest available descriptor id. This
> approach, however, scales poorly as the number of references grows.
> 
> This patch introduces the usage of bitmaps to boost the performance of
> descriptor assignments. This optimization results in notable performance
> gains, particularly in processes with a large number of references. The
> following benchmark with 100,000 references showcases the difference in
> latency between the dbitmap implementation and the legacy approach:
> 
>    [  587.145098] get_ref_desc_olocked: 15us (dbitmap on)
>    [  602.788623] get_ref_desc_olocked: 47343us (dbitmap off)
> 
> Note the bitmap size is dynamically adjusted in line with the number of
> references, ensuring efficient memory usage. In cases where growing the
> bitmap is not possible, the driver falls back to the slow legacy method.
> 
> A previous attempt to solve this issue was proposed in [1]. However,
> such method involved adding new ioctls which isn't great, plus older
> userspace code would not have benefited from the optimizations either.
> 
> Link: https://lore.kernel.org/all/20240417191418.1341988-1-cmllamas@google.com/ [1]

..

> +static int get_ref_desc_olocked(struct binder_proc *proc,
> +				struct binder_node *node,
> +				u32 *desc)
> +{
> +	struct dbitmap *dmap = &proc->dmap;
> +	unsigned long *new, bit;
> +	unsigned int nbits;
> +
> +	/* 0 is reserved for the context manager */
> +	if (node == proc->context->binder_context_mgr_node) {
> +		*desc = 0;
> +		return 0;
> +	}
> +
> +	if (unlikely(!dbitmap_enabled(dmap))) {
> +		*desc = slow_desc_lookup_olocked(proc);
> +		return 0;
> +	}
> +
> +	if (dbitmap_get_first_zero_bit(dmap, &bit) == 0) {
> +		*desc = bit;
> +		return 0;
> +	}
> +
> +	/*
> +	 * The descriptors bitmap is full and needs to be expanded.
> +	 * The proc->outer_lock is briefly released to allocate the
> +	 * new bitmap safely.
> +	 */
> +	nbits = dbitmap_expand_nbits(dmap);
> +	binder_proc_unlock(proc);
> +	new = bitmap_zalloc(nbits, GFP_KERNEL | __GFP_ZERO);

Hi,

Nitpick: No need to __GFP_ZERO when using zalloc().

CJ

> +	binder_proc_lock(proc);
> +	dbitmap_expand(dmap, new, nbits);
> +
> +	return -EAGAIN;
> +}

..

> +#define NBITS_MIN	BITS_PER_TYPE(unsigned long)
> +
> +struct dbitmap {
> +	unsigned int nbits;

Should it be long (or unsigned long) to better match the bitmap API?

(not sure if it can overflow in this use case, but at least for consistancy)

> +	unsigned long *map;
> +};

..

> +static inline unsigned int dbitmap_shrink_nbits(struct dbitmap *dmap)
> +{
> +	unsigned int bit;
> +
> +	if (dmap->nbits <= NBITS_MIN)
> +		return 0;
> +
> +	bit = find_last_bit(dmap->map, dmap->nbits);

find_last_bit() returns an unsigned long.

(bitmap_get_first_zero_bit() below uses unsigned long)

CJ

> +	if (unlikely(bit == dmap->nbits))
> +		return NBITS_MIN;
> +
> +	if (unlikely(bit <= (dmap->nbits >> 2)))
> +		return dmap->nbits >> 1;
> +
> +	return 0;
> +}

..

> +static inline int
> +dbitmap_get_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
> +{
> +	unsigned long n;
> +
> +	n = find_first_zero_bit(dmap->map, dmap->nbits);
> +	if (unlikely(n == dmap->nbits))
> +		return -ENOSPC;
> +
> +	*bit = n;
> +	set_bit(n, dmap->map);
> +
> +	return 0;
> +}

..


