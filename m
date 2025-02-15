Return-Path: <linux-kernel+bounces-516319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB00A36F98
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFE117A4897
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 16:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF41EA7C6;
	Sat, 15 Feb 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P+1AxeRN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26301C7011;
	Sat, 15 Feb 2025 16:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739638686; cv=none; b=VKQiHAYtqyMqWW13igwAF6tkRF+/msyvUnUk30FRWIrmz0MX0QesqeEwVHnkbQmb0fxZFACbWpAiCsz+IqSbuP1/ZEtOlZo1zBm343QfOjOY5UmImFESrKQGVa5erPD7+0lroR8mJXe7aVGcB0XACmbj3OPMd2bA+BTs8gdJ5Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739638686; c=relaxed/simple;
	bh=6B6zoiCNIqlHv0DUk8i1Yt74gncjmTv9FpzXd+uhWjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKL1e+edSkzZdkJVHTo92bOkXDYb8gIyZb5TRMi06VwQeWDoKXPsEvZYFfGMwl3qB5VRjwoSFhStGl7sG/FHy0nlG3ESWcqkjOQnvwfdEpaJaaz1KteLMYxAsYQaGCQ+d1sYXs6tAPaucVeqD488tQuFWePNDei8XiEsLVGr0So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P+1AxeRN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A12C4CEDF;
	Sat, 15 Feb 2025 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739638686;
	bh=6B6zoiCNIqlHv0DUk8i1Yt74gncjmTv9FpzXd+uhWjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+1AxeRN2xmGRtomDVev2ZJZaSIcHqW6kueTTEhyomw15yIwaTRi6VIx5EmyJOp22
	 d2V9OuSqXMBFc3+6kEXQbbx/1WnVFFxsZgEQxp/4E4lmdWQ6KsiX/Ry8LYoXCSvQ8w
	 74hhobng4aSNT8Lib4PcuARxsMJfKvhSmCjkGrRU=
Date: Sat, 15 Feb 2025 17:58:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ian To <onlyian4981@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] staging: rtl8723bs: remove extra blank lines
Message-ID: <2025021535-riding-darkening-1c0d@gregkh>
References: <cover.1739351267.git.onlyian4981@gmail.com>
 <78f3702e2810424d12785f64334127a0f3cd82ef.1739351267.git.onlyian4981@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78f3702e2810424d12785f64334127a0f3cd82ef.1739351267.git.onlyian4981@gmail.com>

On Wed, Feb 12, 2025 at 01:22:56AM -0800, Ian To wrote:
> Repeated blank lines were present and removed. Reported by checkpatch.
> 
> Signed-off-by: Ian To <onlyian4981@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_security.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_security.c b/drivers/staging/rtl8723bs/core/rtw_security.c
> index e8f583206f92..18f640d48701 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_security.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_security.c
> @@ -123,7 +123,6 @@ void rtw_wep_decrypt(struct adapter  *padapter, u8 *precvframe)
>  
>  		/* calculate icv and compare the icv */
>  		*((u32 *)crc) = ~crc32_le(~0, payload, length - 4);
> -
>  	}

This was not a "repeated blank line".

>  }
>  
> @@ -219,10 +218,8 @@ void rtw_secgetmic(struct mic_data *pmicdata, u8 *dst)
>  	secmicclear(pmicdata);
>  }
>  
> -
>  void rtw_seccalctkipmic(u8 *key, u8 *header, u8 *data, u32 data_len, u8 *mic_code, u8 pri)
>  {
> -
>  	struct mic_data	micdata;
>  	u8 priority[4] = {0x0, 0x0, 0x0, 0x0};
>  

Neither was that :(

I've stopped reviewing here.

thanks,

greg k-h

