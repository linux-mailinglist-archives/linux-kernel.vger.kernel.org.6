Return-Path: <linux-kernel+bounces-296840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43F195AFA7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2299F1C2192C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6E615854B;
	Thu, 22 Aug 2024 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iGll5xha"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A460381B8;
	Thu, 22 Aug 2024 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313146; cv=none; b=OIJRvoHrcBjfnGwRo5p3eMG27IFun6xY9W/doGV5mvswuqdsMNkd+P/UOXoSzsJnbCva9ae66pCwaW5I/umr9XF++ad9lfNSezQf06wT3EUy3ZV0U7F1hy4BsGa3H7aHp1IVtFIGgMFmxkiiK0BTiN0g6l884WChpgw6zJPrsg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313146; c=relaxed/simple;
	bh=5p+AOW3PaNEHUKsXIMaRGD9UPBXBOJCfsgIk5Bzep30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9HaOmfjOUsy6CxsoJ9ewdcSfJcFkA3/l9pWocRLGlxt9rlrm/WQYkeZUcMFtT83a25U5i2bjtHMvr3T1VcgYHqK1qXE5ez4vg8KBAaetefywIWhKsNrZnrnvZG8zCJ2g6nyQLMxm0iSv9I6w/WnsXRcRNcVXUcHzBt1zcqC2jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iGll5xha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72CEFC4AF09;
	Thu, 22 Aug 2024 07:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724313145;
	bh=5p+AOW3PaNEHUKsXIMaRGD9UPBXBOJCfsgIk5Bzep30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGll5xha1GqSKSTqk46WEcMj3UW1EPwCzcwwdy64NY1NjSHEpmem1Dl5DvBie8IhU
	 Hu0CANtOUz6G0T+t0wInxcJ1L16KADK8euKQg0xrA7E5zOtjHrBfRnYTbnN1+HjuuN
	 d0wv18D4KSLJtuJeZI1OIyaomSdZyWD+LpgykqrU=
Date: Thu, 22 Aug 2024 15:52:23 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nilo Alexandre <n1lux.comp@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: rtl8192e: Fix alignment parenthesis
Message-ID: <2024082243-docile-buffing-b770@gregkh>
References: <20240822002703.4183848-1-n1lux.comp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822002703.4183848-1-n1lux.comp@gmail.com>

On Wed, Aug 21, 2024 at 09:27:00PM -0300, Nilo Alexandre wrote:
> Fix alignment parenthesis in _rtl92e_read_eeprom_info
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Nilo Alexandre <n1lux.comp@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index d95807ceed7a6..caaa79935d7da 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -322,7 +322,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
>  		if (priv->epromtype == EEPROM_93C46) {
>  			if (!priv->autoload_fail_flag) {
>  				usValue = rtl92e_eeprom_read(dev,
> -					                     EEPROM_TxPwDiff_CrystalCap >> 1);
> +								EEPROM_TxPwDiff_CrystalCap >> 1);

The alignment DID match, you just need to use tabs instead of spaces.
Did you run this change through checkpatch.pl after making it to verify
it did what you are saying it did?

thanks,

greg k-h

