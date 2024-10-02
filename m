Return-Path: <linux-kernel+bounces-347069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC9F98CD5F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932461F23018
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33D518EFDE;
	Wed,  2 Oct 2024 06:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="qYlBYeG/"
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E34839EB
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727851856; cv=none; b=suxFDngQeQd800dvAkVdjuUV3i8OvdS4mPyEwcxdjQxV/GoAwslIRNV/k2gd9LrrJzNSyhJALgpGMyu2tqgFftOc7W+ESaZJyWN3EAuMS/dLQ/zqOsZyELFcOH+Kdz2CctImq3wf1m5mfMg7ewNlfPi5+0Xx8DXiZQuZpxFzNQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727851856; c=relaxed/simple;
	bh=D2ylYm/qCWVeQBP3Ott9YPWRh/hNn2rqjmwBNfYl1es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J78qWaoOFaNOg/CnImIDsSkf50obynduOGHFXVawUgtyknif3D85ZAq8C47ksJWkzpMIUq32drWn8pflM8nsjtD5H++hMxw2lv4MDdyhaLbGt6MHMMx9196HCtspy/C6X7U/wDvKLSZRszmze7TYmnrvKQcarfmFf8vAkvzKVO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b=qYlBYeG/; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 39084 invoked from network); 2 Oct 2024 08:50:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1727851850; bh=pM7MPo7q4CUQUZT/fr1FSPPzJ2GCODHzKTENf6VMC5o=;
          h=From:To:Cc:Subject;
          b=qYlBYeG/MALvT9gHo8OASk+jbfB5LNbwiavyz5IXV/2xK70Ke6an/IUZ32Iqk3Eq9
           SFcNnEW45uuGrHomzD6yPaFJDW2xkc5pdl670JE3fLoPvWTnzTexhqckwYqn94rr1P
           eW96PnkZupdVsmR0D+2Qw7cNW4zQ5bsPNT5eae1k=
Received: from 89-64-14-248.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.14.248])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <shenlichuan@vivo.com>; 2 Oct 2024 08:50:49 +0200
Date: Wed, 2 Oct 2024 08:50:49 +0200
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: castet.matthieu@free.fr, gregkh@linuxfoundation.org,
	duncan.sands@free.fr, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v1] usb: atm: Correct some typos
Message-ID: <20241002065049.GB15679@wp.pl>
References: <20240926075955.10199-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926075955.10199-1-shenlichuan@vivo.com>
X-WP-MailID: 973ec0b2f732ee7726c0b9b3e3bae0f8
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [4YN0]                               

On Thu, Sep 26, 2024 at 03:59:55PM +0800, Shen Lichuan wrote:
> Fixed some confusing typos that were currently identified with codespell,
> the details are as follows:
> 
> drivers/usb/atm/ueagle-atm.c:811: endianes ==> endianness
> drivers/usb/atm/ueagle-atm.c:1279: timming ==> timing
> drivers/usb/atm/ueagle-atm.c:1975: preambule ==> preamble
> drivers/usb/atm/usbatm.c:1161: alloced ==> allocated
> 
>Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> ---
>  drivers/usb/atm/ueagle-atm.c | 6 +++---
>  drivers/usb/atm/usbatm.c     | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/atm/ueagle-atm.c b/drivers/usb/atm/ueagle-atm.c
> index 16703815be0c..62bfdf142aa0 100644
> --- a/drivers/usb/atm/ueagle-atm.c
> +++ b/drivers/usb/atm/ueagle-atm.c
> @@ -808,7 +808,7 @@ static int check_dsp_e4(const u8 *dsp, int len)
>  			if (l > len)
>  				return 1;
>  
> -		/* zero is zero regardless endianes */
> +		/* zero is zero regardless endianness */
>  		} while (blockidx->NotLastBlock);
>  	}
>  
> @@ -1276,7 +1276,7 @@ static void uea_set_bulk_timeout(struct uea_softc *sc, u32 dsrate)
>  	    sc->stats.phy.dsrate == dsrate)
>  		return;
>  
> -	/* Original timming (1Mbit/s) from ADI (used in windows driver) */
> +	/* Original timing (1Mbit/s) from ADI (used in windows driver) */
>  	timeout = (dsrate <= 1024*1024) ? 0 : 1;
>  	ret = uea_request(sc, UEA_SET_TIMEOUT, timeout, 0, NULL);
>  	uea_info(INS_TO_USBDEV(sc), "setting new timeout %d%s\n",
> @@ -1972,7 +1972,7 @@ static void uea_dispatch_cmv_e1(struct uea_softc *sc, struct intr_pkt *intr)
>  	if (cmv->bDirection != E1_MODEMTOHOST)
>  		goto bad1;
>  
> -	/* FIXME : ADI930 reply wrong preambule (func = 2, sub = 2) to
> +	/* FIXME : ADI930 reply wrong preamble (func = 2, sub = 2) to
>  	 * the first MEMACCESS cmv. Ignore it...
>  	 */
>  	if (cmv->bFunction != dsc->function) {
> diff --git a/drivers/usb/atm/usbatm.c b/drivers/usb/atm/usbatm.c
> index 2da6615fbb6f..d1e622bb1406 100644
> --- a/drivers/usb/atm/usbatm.c
> +++ b/drivers/usb/atm/usbatm.c
> @@ -1158,7 +1158,7 @@ int usbatm_usb_probe(struct usb_interface *intf, const struct usb_device_id *id,
>  		if (i >= num_rcv_urbs)
>  			list_add_tail(&urb->urb_list, &channel->list);
>  
> -		vdbg(&intf->dev, "%s: alloced buffer 0x%p buf size %u urb 0x%p",
> +		vdbg(&intf->dev, "%s: allocated buffer 0x%p buf size %u urb 0x%p",
>  		     __func__, urb->transfer_buffer, urb->transfer_buffer_length, urb);
>  	}
>  
> -- 
> 2.17.1
> 

