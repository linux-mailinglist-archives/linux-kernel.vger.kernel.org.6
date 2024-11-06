Return-Path: <linux-kernel+bounces-398937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D272B9BF83F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB7A1C22968
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8020C308;
	Wed,  6 Nov 2024 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vcq1KOGi"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA4520968D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 20:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730926646; cv=none; b=MD0MePfaoYpSCgafLb19ntGidib3LAvNOmNICfU+gvZJpikx8iJ4ayV5VhK70dXrYLcqCQSLu24SfRVrPsDORrRpBOlniePojrNisqzS5sfwj0zcaltLxdqtcUXm2eLhW4W37Dn5UNqaN3mN2JFxc1hAHZU4fYoGHVi6no91qwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730926646; c=relaxed/simple;
	bh=dZuvF83IXYJXupxHZE099aiodPb+Z5AqCA56iv4qUB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntueZlLmhBriDSHvge4oXJDrKtctKy4voI9uHInIEm3n4RB3O0hIkXLvPsBBX5rRbUcuOpFOv6YI5p3Xfoj840/vFVHWKPL7jZG4Q/xBllIKJ0ef8MjDEF4AaL099K7fnDJSvOkqB40wWVNDMhj0Z4LCLaifUHuflh7fWpQYOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vcq1KOGi; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Nov 2024 15:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730926642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LE7GTXlvS9azbZbdUMiTosoynBaaDsHv9uOptO4TBrg=;
	b=vcq1KOGiykDrS+Uo+0erUxlROqlrje+d/lucdoA4/XIJ1Q3NjRLLvxy1Gjs+9yavewjEG/
	0/Sqf2Q5rYWMROwbN8X+sjQ07DYu1SQA6TVugAp40RN+KTO2J6nRlvpQ52jCpduH0noAo8
	K37oJrmZPDRymV/9wMPJG2T5es/mU5I=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Piotr Zalewski <pZ010001011111@proton.me>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, syzbot+bee87a0c3291c06aa8c6@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Change OPT_STR max to be 1 less than the size of
 choices array
Message-ID: <sxtugjw3gbifdvountioelfdpeqa7hnx4jxd3a76nh5uklf3du@vd7wof7b7nge>
References: <20241106193443.307896-2-pZ010001011111@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106193443.307896-2-pZ010001011111@proton.me>
X-Migadu-Flow: FLOW_OUT

On Wed, Nov 06, 2024 at 07:46:30PM +0000, Piotr Zalewski wrote:
> Change OPT_STR max value to be 1 less than the "ARRAY_SIZE" of "_choices"
> array. As a result, remove -1 from (opt->max-1) in bch2_opt_to_text.
> 
> The "_choices" array is a null-terminated array, so computing the maximum
> using "ARRAY_SIZE" without subtracting 1 yields an incorrect result. Since
> bch2_opt_validate don't subtract 1, as bch2_opt_to_text does, values
> bigger than the actual maximum would pass through option validation.
> 
> Reported-by: syzbot+bee87a0c3291c06aa8c6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=bee87a0c3291c06aa8c6
> Fixes: 63c4b2545382 ("bcachefs: Better superblock opt validation")
> Suggested-by: Kent Overstreet <kent.overstreet@linux.dev>
> Signed-off-by: Piotr Zalewski <pZ010001011111@proton.me>

Thanks! Applied

> ---
> 
> Notes:
>     Changes in v2:
>         - Instead of subtracting 1 in bch2_opt_validate as in
>           bch2_opt_to_text add -1 in OPT_STR macro definition
>           and remove subtraction in bch2_opt_to_text.
> 
>     link to v1: https://lore.kernel.org/linux-bcachefs/20241031231823.688918-2-pZ010001011111@proton.me/
> 
>  fs/bcachefs/opts.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/bcachefs/opts.c b/fs/bcachefs/opts.c
> index 83f55cf99d46..49c59aec6954 100644
> --- a/fs/bcachefs/opts.c
> +++ b/fs/bcachefs/opts.c
> @@ -227,7 +227,7 @@ const struct bch_option bch2_opt_table[] = {
>  #define OPT_UINT(_min, _max)	.type = BCH_OPT_UINT,			\
>  				.min = _min, .max = _max
>  #define OPT_STR(_choices)	.type = BCH_OPT_STR,			\
> -				.min = 0, .max = ARRAY_SIZE(_choices),	\
> +				.min = 0, .max = ARRAY_SIZE(_choices) - 1, \
>  				.choices = _choices
>  #define OPT_STR_NOLIMIT(_choices)	.type = BCH_OPT_STR,		\
>  				.min = 0, .max = U64_MAX,		\
> @@ -429,7 +429,7 @@ void bch2_opt_to_text(struct printbuf *out,
>  			prt_printf(out, "%lli", v);
>  		break;
>  	case BCH_OPT_STR:
> -		if (v < opt->min || v >= opt->max - 1)
> +		if (v < opt->min || v >= opt->max)
>  			prt_printf(out, "(invalid option %lli)", v);
>  		else if (flags & OPT_SHOW_FULL_LIST)
>  			prt_string_option(out, opt->choices, v);
> -- 
> 2.47.0
> 
> 

