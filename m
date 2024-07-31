Return-Path: <linux-kernel+bounces-268764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B781942906
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1613C1F23D8B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C50B1A7F8C;
	Wed, 31 Jul 2024 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jAaiEnpq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA21116C84A;
	Wed, 31 Jul 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413935; cv=none; b=MtdCC2en7BPVYtIhKr8UlCdG16waNwzYA6EQc2E0j9acX5TQwYairAGjiMyaoFWtS8jSljowpWTlz+0YuM+e6nadTFzfDsxoybt+ccySGBma5nf7M/rMgpIJakSPkddpybEIHLDtMXLgS8llXfdVoOcBd1t+mPS4eqdVf1BAK1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413935; c=relaxed/simple;
	bh=YglaX9HXpUyXTJpl4OXQgaOln0HKw9uABoyYqgf54MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gi6vTS1HMpIfQyTPWx+uRetqwHXtA54xBKAKcTXabURMcEFqZnyvJbmhpPyHQJrKhuPrZP26wJdbvudL3BFxx5EmWCbqCYgKO+7RmFD8cnmbx9SF9qoiL6x2fIoEaJa946q1Jwm2T7ENPyzXgovK/NSHykMaUYZ+JD1ERnKA5kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jAaiEnpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C455BC116B1;
	Wed, 31 Jul 2024 08:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722413935;
	bh=YglaX9HXpUyXTJpl4OXQgaOln0HKw9uABoyYqgf54MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jAaiEnpqmHdRGtXhRibr00ktHhKJRP5ry8hyxNblx3g8xFAt6O0PPz7lguSOZ1agp
	 DLBEH5IePqVaqmRXi+dagYu+UxCjDc8rsL4bkZwbau3BR4Rx6rWFc97OWgaz3WDleN
	 Q8aukTVcMYhrH9FfkRqKoazl0ZBE6izt3pIn5R0g=
Date: Wed, 31 Jul 2024 10:18:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Akash Kumar <quic_akakum@quicinc.com>
Cc: Jing Leng <jleng@ambarella.com>, Felipe Balbi <balbi@kernel.org>,
	Pratham =?iso-8859-1?Q?Pratap=A0?= <quic_ppratap@quicinc.com>,
	Jack Pham <quic_jackp@quicinc.com>, kernel@quicinc.com,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: Increase max configuration interface to
 32
Message-ID: <2024073141-dawn-devotedly-407f@gregkh>
References: <20240521054257.32689-1-quic_akakum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521054257.32689-1-quic_akakum@quicinc.com>

On Tue, May 21, 2024 at 11:12:57AM +0530, Akash Kumar wrote:
> Currently, max configuration interfaces are limited to 16, which fails
> for compositions containing 10 UVC configurations with interrupt ep
> disabled along with other configurations , and we see bind failures
> while allocating interface ID in uvc bind.
> 
> Increase max configuration interface to 32 to support any large
> compositions, limited to the same size as USB device endpoints, as
> interfaces cannot be more than endpoints.
> 
> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
> ---
>  include/linux/usb/composite.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
> index 2040696d75b6..d6d4fbfb6d0e 100644
> --- a/include/linux/usb/composite.h
> +++ b/include/linux/usb/composite.h
> @@ -255,7 +255,7 @@ int config_ep_by_speed_and_alt(struct usb_gadget *g, struct usb_function *f,
>  int config_ep_by_speed(struct usb_gadget *g, struct usb_function *f,
>  			struct usb_ep *_ep);
>  
> -#define	MAX_CONFIG_INTERFACES		16	/* arbitrary; max 255 */
> +#define	MAX_CONFIG_INTERFACES		32
>  
>  /**
>   * struct usb_configuration - represents one gadget configuration
> -- 
> 2.17.1
> 
> 

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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

