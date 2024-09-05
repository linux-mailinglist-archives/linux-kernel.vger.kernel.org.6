Return-Path: <linux-kernel+bounces-316523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E5696D0B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054041C22E97
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 07:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4BE1946A8;
	Thu,  5 Sep 2024 07:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWBVVBWL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D14193070;
	Thu,  5 Sep 2024 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522400; cv=none; b=IQ1LQ8qSdfieGepV4AJJvxbkpNotGTu464iaP+oX9Z8svfIySPbs/UW/J86FnwVBHT6rxlojldwb6BJ6fwIRzqhkxw2Z816BmPje9wGN6UBPjPESWY5LGs4MAnE7BzS7w16qEX2s6oe62IahZZGJrr7iGL9kdIhfRNe8OXGrEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522400; c=relaxed/simple;
	bh=ZA2xtBa0ZD9doRYaDtQI6rey1VJXbSnib3Nj3waz1sU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3Q1VZx/wBl/NkxQ+si1GDylzXPSH+Krg9rzXfBGcRBKbtKw0VYjnwmQa9CNWXy7+rufrdtk8W/teuAK37KZ1NrKHwogv6dig97B5tQSuMv9IBweHa9Wv5YLdU0sR0wUF7JKbRs3YbXWGjBLw0eEUNGvVPEUw9odQE6XGumcANg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWBVVBWL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB37C4CEC4;
	Thu,  5 Sep 2024 07:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725522399;
	bh=ZA2xtBa0ZD9doRYaDtQI6rey1VJXbSnib3Nj3waz1sU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QWBVVBWLPLUPKsa1B4jwatcUCnd9AB9Aq+Nu6f6W2MGoibG4OmY83InU+xPQKj5Fd
	 0Dh/SwWqWGD0nd1AX+AsGyEfclzNga+JpgCD6SrNz9Zd6GC1pEA6JUVcMubSWZexHN
	 H7wYxBMU+LUX71GYgMTLaIkE0563KP/MEf3o6djXM/08xpa1MdOig1AxfLVWyZmJUE
	 rpSVPSFm9Jfo8AbKkcmXEqSKJcUDIolxxacLwMxdOxwxJyXo2/vwAVHyPrdg3LkFzX
	 NvqTFMOqACEIrlnPKyWxBBeN9eSA673Ljv/CFPLacz0DhxJEtkz4g9GO/6LhfIgRoy
	 sp23g+wR/d8vw==
Date: Thu, 5 Sep 2024 15:46:30 +0800
From: Peter Chen <peter.chen@kernel.org>
To: Andreas =?iso-8859-1?Q?K=FChn?= <andreas.kuehn@diekuehnen.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
	venture@google.com, yuenn@google.com, benjaminfair@google.com,
	gregkh@linuxfoundation.org, openbmc@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: chipidea: npcm: Fix coding style with clarification
 of data type
Message-ID: <20240905074630.GA325295@nchen-desktop>
References: <20240903132535.15554-1-andreas.kuehn@diekuehnen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903132535.15554-1-andreas.kuehn@diekuehnen.com>

On 24-09-03 15:25:15, Andreas Kühn wrote:
> Fixed coding style issue: unsigned to unsigned int.
> 
> Signed-off-by: Andreas Kühn <andreas.kuehn@diekuehnen.com>

Acked-by: Peter Chen <peter.chen@kernel.org>


> ---
>  drivers/usb/chipidea/ci_hdrc_npcm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/ci_hdrc_npcm.c b/drivers/usb/chipidea/ci_hdrc_npcm.c
> index c89c68f41ccc..3e5e05dbda89 100644
> --- a/drivers/usb/chipidea/ci_hdrc_npcm.c
> +++ b/drivers/usb/chipidea/ci_hdrc_npcm.c
> @@ -18,7 +18,7 @@ struct npcm_udc_data {
>  	struct ci_hdrc_platform_data pdata;
>  };
>  
> -static int npcm_udc_notify_event(struct ci_hdrc *ci, unsigned event)
> +static int npcm_udc_notify_event(struct ci_hdrc *ci, unsigned int event)
>  {
>  	struct device *dev = ci->dev->parent;
>  
> -- 
> 2.43.0
> 

