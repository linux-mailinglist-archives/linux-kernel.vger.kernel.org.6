Return-Path: <linux-kernel+bounces-205518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A698FFCFF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9C23287161
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EFF15A857;
	Fri,  7 Jun 2024 07:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J+Y4LT4e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HYB/qIxC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J+Y4LT4e";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HYB/qIxC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF715A854;
	Fri,  7 Jun 2024 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744755; cv=none; b=KUyCq3OVmPsz0D6dWW0/rVef+mPROuOoL6i3LdZ2N8aBGC9kllja84E0+T3HSbvJbhhm4Rm5LlhDBisBhSkZrTXDizMhMkI2JLh3Yel/PcUbV4nadG2plTB0myNy+GzLD/KH9zRY227WSdecwzzybZO9j/L6f8hHiwTHy1pgDzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744755; c=relaxed/simple;
	bh=IGNE7390uwz+Glnuj3PCyWbHh2MwFM6efpX1C4qkTq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=puYmx4I4c6zSOs85h4O66bq7Aq18SGojFjYSCh/Exy7mAoa84XV31hBXez4UYQ5ANZO1JM6MyubEYwpImZlLI/PyP+r0KvseIWXU4OkhcBpr171E+EtZC9GmDrfcEK6oBho0BoCybDnkXQffaASrHHJZddQqesPKRgDrN/STLYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J+Y4LT4e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HYB/qIxC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J+Y4LT4e; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HYB/qIxC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7804A21AF1;
	Fri,  7 Jun 2024 07:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717744750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Cum8zSN+Lk2ZaAZKd6SaSp6UIPpMMmmcaIXWYwzxkN4=;
	b=J+Y4LT4eQyfa+2k7YLlwFS8IgfXCdkR/GnwNLpHoRQ/NBygEinCbHWEVoA3SV8bruA1RuO
	EXC97R1deDcm0a43LaLRthawW5gT2gCO3+80hqiGF0w9hFzs2Nbp/QkBHJaBY2A2ZKOKDn
	cFT0mYwy+Q2rz9yvBYyCAl5atx+CDa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717744750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Cum8zSN+Lk2ZaAZKd6SaSp6UIPpMMmmcaIXWYwzxkN4=;
	b=HYB/qIxClOWuODR30ltS3v63p0hyzE1a6wTiFzQfj1U+czOxK7IXr59ZB5cUSPq8+B3J9o
	NDD5kzMhOULN1yCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J+Y4LT4e;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="HYB/qIxC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717744750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Cum8zSN+Lk2ZaAZKd6SaSp6UIPpMMmmcaIXWYwzxkN4=;
	b=J+Y4LT4eQyfa+2k7YLlwFS8IgfXCdkR/GnwNLpHoRQ/NBygEinCbHWEVoA3SV8bruA1RuO
	EXC97R1deDcm0a43LaLRthawW5gT2gCO3+80hqiGF0w9hFzs2Nbp/QkBHJaBY2A2ZKOKDn
	cFT0mYwy+Q2rz9yvBYyCAl5atx+CDa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717744750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Cum8zSN+Lk2ZaAZKd6SaSp6UIPpMMmmcaIXWYwzxkN4=;
	b=HYB/qIxClOWuODR30ltS3v63p0hyzE1a6wTiFzQfj1U+czOxK7IXr59ZB5cUSPq8+B3J9o
	NDD5kzMhOULN1yCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60C5E13A42;
	Fri,  7 Jun 2024 07:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9oRIF260YmbCcwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 07 Jun 2024 07:19:10 +0000
Message-ID: <210c320e-4b85-442e-870f-32647838a497@suse.cz>
Date: Fri, 7 Jun 2024 09:19:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: convert page type macros to enum
To: Stephen Brennan <stephen.s.brennan@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, linux-mm@kvack.org,
 Omar Sandoval <osandov@osandov.com>, linux-debuggers@vger.kernel.org,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <20240607001116.1061485-1-stephen.s.brennan@oracle.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <20240607001116.1061485-1-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-3.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,osandov.com,vger.kernel.org,infradead.org,redhat.com,kylinos.cn];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7804A21AF1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.00

On 6/7/24 2:11 AM, Stephen Brennan wrote:
> Changing PG_slab from a page flag to a page type in commit 46df8e73a4a3
> ("mm: free up PG_slab") in has the unintended consequence of removing
> the PG_slab constant from kernel debuginfo. The commit does add the
> value to the vmcoreinfo note, which allows debuggers to find the value
> without hardcoding it. However it's most flexible to continue
> representing the constant with an enum. To that end, convert the page
> type fields into an enum. Debuggers will now be able to detect that
> PG_slab's type has changed from enum pageflags to enum page_type.
> 
> Fixes: 46df8e73a4a3 ("mm: free up PG_slab")
> 
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
> v2 -> v3: rebase on mm-unstable
> v1 -> v2: include PAGE_TYPE_BASE and PAGE_MAPCOUNT_RESERVE
> 
>  include/linux/page-flags.h | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index f04fea86324d9..7c0a8fd2c8c17 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -945,20 +945,23 @@ PAGEFLAG_FALSE(HasHWPoisoned, has_hwpoisoned)
>   * mistaken for a page type value.
>   */
>  
> -#define PAGE_TYPE_BASE	0x80000000
> -/*
> - * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflows and
> - * allow owners that set a type to reuse the lower 16 bit for their own
> - * purposes.
> - */
> -#define PG_buddy	0x40000000
> -#define PG_offline	0x20000000
> -#define PG_table	0x10000000
> -#define PG_guard	0x08000000
> -#define PG_hugetlb	0x04000000
> -#define PG_slab		0x02000000
> -#define PG_zsmalloc	0x01000000
> -#define PAGE_MAPCOUNT_RESERVE	(~0x0000ffff)
> +enum page_type {
> +	/*
> +	 * Reserve 0xffff0000 - 0xfffffffe to catch _mapcount underflows and
> +	 * allow owners that set a type to reuse the lower 16 bit for their own
> +	 * purposes.
> +	 */
> +	PG_buddy	= 0x40000000,
> +	PG_offline	= 0x20000000,
> +	PG_table	= 0x10000000,
> +	PG_guard	= 0x08000000,
> +	PG_hugetlb	= 0x04000000,
> +	PG_slab		= 0x02000000,
> +	PG_zsmalloc	= 0x01000000,
> +
> +	PAGE_TYPE_BASE	= 0x80000000,
> +	PAGE_MAPCOUNT_RESERVE	= ~0x0000ffff,
> +};
>  
>  #define PageType(page, flag)						\
>  	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)


