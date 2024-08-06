Return-Path: <linux-kernel+bounces-275782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD579489B5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE43B241F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 07:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84F016630E;
	Tue,  6 Aug 2024 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oZ4JKev7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15B0165F1A;
	Tue,  6 Aug 2024 07:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722927790; cv=none; b=CvlRzZsBO+0b4UqqEX6sY30Owd2K5gVV0lfUyUmcL7OsdY3u+eguv+U8luXEnPDAvX420Tatomz3m4WqOxAqFdi5gwDN0GV8QakhSzMzeYRvnRLHSd8nh0Ox2Dmh9M030zpdNyu5q4WFg6YucpQuls15h0hs8sUnRwRdyU+Jwm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722927790; c=relaxed/simple;
	bh=Uch8dFf6MlEHa9ZVycbyHeaQ1QrxHu+yrpId+jbyF00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/AhkK/0r3NqdgTEDYH2e9WWxagVG3FwP6uOxrgOH+JzZKh9MN/Rr92RDag3UO7CPOhZHnANWAfJGVCb5yFrSarGMqE7VKqvHr15TFZwmrLPMgMEJ3eE8TFRsLzELV28xWAy0pzlp3ifT6KJDVtob61b6hQGGLyaEfbez9B9F9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oZ4JKev7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9AD7C32786;
	Tue,  6 Aug 2024 07:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722927789;
	bh=Uch8dFf6MlEHa9ZVycbyHeaQ1QrxHu+yrpId+jbyF00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZ4JKev7dUOJ6zBEXP13UMzLvPu4wgPJecdSp9fosTTLCWHhkYWbp5wLmGyovI89J
	 izJQ9FZr6x2n1kiE9eX6PR77hR2k6/QGCMS/ZhSLc7tH9lSraB+NFATz1/vRyZywPX
	 AjoGE68NmWmnl8+NKezpe/sUGpdQ5DcrdtV93DNM=
Date: Tue, 6 Aug 2024 09:03:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, oswald.buddenhagen@gmx.de,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: emu10k1: Fix coding style issues and warnings
Message-ID: <2024080611-rants-thee-d23a@gregkh>
References: <20240805155206.463035-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805155206.463035-1-abhishektamboli9@gmail.com>

On Mon, Aug 05, 2024 at 09:22:06PM +0530, Abhishek Tamboli wrote:
> Fix coding style errors and warnings in sound/pci/emu10k1/memory.c
> reported by checkpatch.pl. Changes includes:
> 
> - Add spaces after commas in macro definitions.
> - Insert blank lines after variable declarations.
> - Consistent spacing around operators.
> - Remove trailing whitespace.
> - Move EXPORT_SYMBOL declarations to immediately follow their
>   respective functions.
> - Correct spacing in conditional statements and type casts.
> 
> Fix the following errors and warnings:
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define __set_ptb_entry(emu,page,addr) \
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define __set_ptb_entry(emu,page,addr) \
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_ptb_entry(emu,page,addr)	__set_ptb_entry(emu,page,addr)
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_silent_ptb(emu,page)
> 	__set_ptb_entry(emu,page,emu->silent_page.addr)
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_silent_ptb(emu,page)
> 	__set_ptb_entry(emu,page,emu->silent_page.addr)
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define set_silent_ptb(emu,page)
> 	__set_ptb_entry(emu,page,emu->silent_page.addr)
> 
> WARNING: Missing a blank line after declarations
> +	int i;
> +	page *= UNIT_PAGES;
> 
> WARNING: Missing a blank line after declarations
> +	int i;
> +	page *= UNIT_PAGES;
> 
> ERROR: space required after that ',' (ctx:VxV)
> +#define get_emu10k1_memblk(l,member)
> 	list_entry(l, struct snd_emu10k1_memblk, member)
> 
> WARNING: space prohibited between function name and open parenthesis '('
> +	list_for_each (pos, &emu->mapped_link_head) {
> 
> WARNING: Missing a blank line after declarations
> +	struct snd_emu10k1_memblk *blk =
> 		get_emu10k1_memblk(pos, mapped_link);
> +	if (blk->mapped_page < 0)
> 
> ERROR: else should follow close brace '}'
> +		}
> +		else if (size > max_size) {
> 
> ERROR: need consistent spacing around '-' (ctx:WxV)
> +	psize = get_aligned_page(size + PAGE_SIZE -1);
>  	                                          ^
> 
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> +EXPORT_SYMBOL(snd_emu10k1_memblk_map);
> 
> WARNING: Missing a blank line after declarations
> +		dma_addr_t addr;
> +		if (ofs >= runtime->dma_bytes)
> 
> ERROR: space prohibited after that '!' (ctx:BxW)
> +		if (! is_valid_page(emu, addr)) {
>  		    ^
> 
> ERROR: trailing whitespace
> +^Istruct snd_util_memhdr *hdr = hw->memhdr; $
> 
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> +EXPORT_SYMBOL(snd_emu10k1_synth_alloc);
> 
> ERROR: trailing whitespace
> +^Istruct snd_util_memhdr *hdr = emu->memhdr; $
> 
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> +EXPORT_SYMBOL(snd_emu10k1_synth_free);
> 
> WARNING: Missing a blank line after declarations
> +	int first_page, last_page;
> +	first_page = blk->first_page;
> 
> WARNING: Missing a blank line after declarations
> +	char *ptr;
> +	if (snd_BUG_ON(page < 0 || page >= emu->max_cache_pages))
> 
> ERROR: space prohibited after that '!' (ctx:BxW)
> +	if (! ptr) {
>  	    ^
> 
> ERROR: "(foo*)" should be "(foo *)"
> +	return (void*)ptr;
> 
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> +EXPORT_SYMBOL(snd_emu10k1_synth_memset);
> 
> WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> +EXPORT_SYMBOL(snd_emu10k1_synth_copy_from_user);
> 
> Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> ---
>  sound/pci/emu10k1/memory.c | 36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

