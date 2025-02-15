Return-Path: <linux-kernel+bounces-516315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D4FA36F95
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABD203B0116
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95341E5B7C;
	Sat, 15 Feb 2025 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pe3YZ3y8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD4C1C7011;
	Sat, 15 Feb 2025 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739638617; cv=none; b=e0ksiP7FUM9Bkq7v9wva1bW3gBvkGfEWe019oCPlOm2ftlmnWDHs0SouOpYwT3lgZZGjMnxNCXsOacokk1zKT/pVB0u2gN+qYdP+/mfY70H0P93DilXAdVk9R9ms1SVNiVvW09qH7psqG7SBwooqWEVPGOdkAF6XDQMrngtTb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739638617; c=relaxed/simple;
	bh=wyw8Ovh8n7iuN0KZVDZ5yM4pmIpJuKuYOg7F8OqhR2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+dFTyLJww12SicatweWF9kwcDzKvHir5uAkDrf4GOvwCD1RVspUtpc2jf6Z1VcdfhzI3hvD4kbkVK8ctpHHsKFvJM1deRmrWH3VktaKzmR4dAYo1KA0zg+TXCLP6Jc5gmHlzfa11+9Dg3Yo2VI1BX7R4N7DApbck/ldUsUIMy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pe3YZ3y8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BE9C4CEDF;
	Sat, 15 Feb 2025 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739638616;
	bh=wyw8Ovh8n7iuN0KZVDZ5yM4pmIpJuKuYOg7F8OqhR2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pe3YZ3y8ct0kRMusplLlWkv1fnkQGWM2FHYRkQIORDM1aXxaTnHGjMY1A+GaKPQP7
	 7YGksMnp5hsxdjwTHW+zJnkMrrUhLnBr3aZ/bDuEOf8TsHU4QxGpzyN7Oa6LH6Gmij
	 O3LqHMFnxZnyUSGtINrz4h/IwZqP6D7jAe/nIMNA=
Date: Sat, 15 Feb 2025 17:56:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ian To <onlyian4981@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] staging: rtl8723bs: format comments
Message-ID: <2025021510-surround-drainage-1425@gregkh>
References: <cover.1739351267.git.onlyian4981@gmail.com>
 <2e6dc11ef35d5af653095e416f2a48b6dbcc0de1.1739351267.git.onlyian4981@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e6dc11ef35d5af653095e416f2a48b6dbcc0de1.1739351267.git.onlyian4981@gmail.com>

On Wed, Feb 12, 2025 at 01:22:54AM -0800, Ian To wrote:
> Some comments were not formatted correctly. Reported by checkpatch.
> 
> Signed-off-by: Ian To <onlyian4981@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 92 +++++++++----------
>  1 file changed, 46 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index 1e9eff01b1aa..f4556ae54352 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -30,10 +30,10 @@ const char *security_type_str(u8 value)
>  /* WEP related ===== */
>  
>  /*
> -	Need to consider the fragment  situation
> -*/
> + *	Need to consider the fragment  situation
> + */
>  void rtw_wep_encrypt(struct adapter *padapter, u8 *pxmitframe)
> -{																	/*  exclude ICV */
> +{
>  	union {
>  		__le32 f0;
>  		unsigned char f1[4];
> @@ -342,23 +342,23 @@ static const unsigned short Sbox1[2][256] = {      /* Sbox for hash (can be in R
>  	}
>  };
>  
> - /*
> -**********************************************************************
> -* Routine: Phase 1 -- generate P1K, given TA, TK, IV32
> -*
> -* Inputs:
> -*     tk[]      = temporal key                         [128 bits]
> -*     ta[]      = transmitter's MAC address            [ 48 bits]
> -*     iv32      = upper 32 bits of IV                  [ 32 bits]
> -* Output:
> -*     p1k[]     = Phase 1 key                          [ 80 bits]
> -*
> -* Note:
> -*     This function only needs to be called every 2**16 packets,
> -*     although in theory it could be called every packet.
> -*
> -**********************************************************************
> -*/
> +/*
> + **********************************************************************

Why the long line of **** ?

That should not be needed.

> -/**
> +/*

Why are you removing kerneldoc comment style?

>   * omac1_aes_128_vector - One-Key CBC MAC (OMAC1) hash with AES-128
>   * @key: 128-bit key for the hash operation
>   * @num_elem: Number of elements in the data vector
> @@ -1530,7 +1529,7 @@ static int omac1_aes_128_vector(u8 *key, size_t num_elem,
>  	return 0;
>  }
>  
> -/**
> +/*

Same here?

thanks,

greg k-h

