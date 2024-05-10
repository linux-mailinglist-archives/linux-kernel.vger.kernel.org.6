Return-Path: <linux-kernel+bounces-175529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 562508C20E6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF7B0B20A18
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3048161330;
	Fri, 10 May 2024 09:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JZLPdWRa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04F371581E3;
	Fri, 10 May 2024 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333300; cv=none; b=dfGQ1WDicQewvK6ZUfGRZ1peeU5hSWYpI6K7a5Fa1LlCe17aC21oY4J5iGgkHUC9DFXedXVyKujtEKq5fS/wX1szf8x+/Yd5B1BjK0m3J2X5tVuc85W2rBn1uwwqrnUdA7Gp5LWZf1B7sP2frbWojQHCPYLu49FQDMtAIWtO9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333300; c=relaxed/simple;
	bh=dxTRjOQB8hV7hmmGL+CDfSzZsS7tWt/RvqCgX+Aa4Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uq99qK0ll5sgi0+HTg4dUu7ZbnWKKwTakO6QFr19OdJHL+SJ6Q6mjTdtbUANUSIm93pD2oWuV/IMx4yOcSEapBXoJ7GxoiVoHsagzYp1ylsU5HHHGciM5Odm/qBPPL8wpE0XAZ7KuSTMya1ZX1yBI+sBPj5AA4HHNrtDsxlNJX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JZLPdWRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CFBC113CC;
	Fri, 10 May 2024 09:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715333299;
	bh=dxTRjOQB8hV7hmmGL+CDfSzZsS7tWt/RvqCgX+Aa4Nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZLPdWRaFF9cWZ1jbLzizYe53nqJZV9fwPKG5mQ8v0hCrqLuVNJx058fmrHjSq5AW
	 2iX4dOByuR03/AEs6abnHDnvGp7dWIoDjqUBkk29ICt7ZCMGQIMjDrZi3wwgJj7f8q
	 oL8oA5CRE1GZI/XZTu5SFF6O9pOFCXTveAbcFkqs=
Date: Fri, 10 May 2024 10:28:14 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
	"quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] usb: dwc3: core: Fix unused variable warning in core
 driver
Message-ID: <2024051050-pantomime-sudden-a382@gregkh>
References: <20240506074939.1833835-1-quic_kriskura@quicinc.com>
 <20240508230839.utioi5i2c5kozm4d@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508230839.utioi5i2c5kozm4d@synopsys.com>

On Wed, May 08, 2024 at 11:08:43PM +0000, Thinh Nguyen wrote:
> On Mon, May 06, 2024, Krishna Kurapati wrote:
> > While fixing a merge conflict in linux-next, hw_mode variable
> > was left unused. Remove the unused variable in hs_phy_setup call.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://urldefense.com/v3/__https://lore.kernel.org/all/202405030439.AH8NR0Mg-lkp@intel.com/__;!!A4F2R9G_pg!aXN14tvkvwnNZ9N8-EDi-Seef9jgZBKlkZRYasINRgTOU2ijWbTvFIxkZIXOThGQQHmXc0FjiJPFI1cgdCOyAafAxB-70Q$ 
> > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > ---
> > Changes in v2:
> > Added reported by and closes tags.
> > 
> >  drivers/usb/dwc3/core.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 8b6f7769fcd5..7f176ba25354 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -676,11 +676,8 @@ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
> >  
> >  static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
> >  {
> > -	unsigned int hw_mode;
> >  	u32 reg;
> >  
> > -	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> > -
> >  	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
> >  
> >  	/* Select the HS PHY interface */
> > -- 
> > 2.34.1
> > 
> 
> Looks like my response reporting the merge issue to Stephen fell through
> the cracks.
> 
> Thanks for the patch.
> 
> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

I think I already fixed this up when I did the merge a few hours ago, if
not, please let me know.

thanks,

greg k-h

