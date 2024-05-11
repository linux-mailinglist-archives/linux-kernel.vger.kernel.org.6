Return-Path: <linux-kernel+bounces-176452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DD58C301D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 09:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A9D1B21FC2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186D610953;
	Sat, 11 May 2024 07:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JV/HMLLw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491F828E7;
	Sat, 11 May 2024 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715413205; cv=none; b=lIicoyCeR7wuR+HAFlZBkIQCo+EmtKjdY6lI+gI1Y3FuXU0urD55X2DJ1UxktZwwh3dqvxXkFLvJdrNxan0i/2JjB9umkGP/2v+XGz6JwQT74NV86PquOVCseV78f7HVqc6JlLI0OdbJ0CYcmbnltqhC3o7YA7pZm1oiJjQjOvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715413205; c=relaxed/simple;
	bh=XF+Dy5icbI5aSYWMAVXu2mAAjgCiLJWJwJYriOUWYKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo6adeuy20IuppPhyyVAr2JVEvb5U32/dpxctW1jwrty+e05eCRIlJd2xg2/sgXSrCqgNjGMtmqT3M4X0wQjVFHcTbnu2ZB8Bce0+cxHERCn1U0V551jkUJJv7W5mGEqKncu2xZT4ToR04IHr7/KNbICS51WbXZYVHwJPqXC0as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JV/HMLLw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9A7C2BD10;
	Sat, 11 May 2024 07:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715413204;
	bh=XF+Dy5icbI5aSYWMAVXu2mAAjgCiLJWJwJYriOUWYKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JV/HMLLwoQ06PnDnOPfN2lib6LkUv68VCHOl+HY5emtEqeCCDcKD816kruh4JiJ/V
	 CCb+B8s0eoe89GR+ungdEBc3LugbBUjzGEunEm4Ga1tAN9pTdlxi139TT9iJjQ9N2i
	 FmQRsBMOoKzip05DJgwgGeQ5Fu9hRsoCLJXWrcQI=
Date: Sat, 11 May 2024 08:40:02 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
	"quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] usb: dwc3: core: Fix unused variable warning in core
 driver
Message-ID: <2024051154-define-scandal-993a@gregkh>
References: <20240506074939.1833835-1-quic_kriskura@quicinc.com>
 <20240508230839.utioi5i2c5kozm4d@synopsys.com>
 <2024051050-pantomime-sudden-a382@gregkh>
 <0f056ece-6d38-428e-bf18-edb053c90ca7@quicinc.com>
 <20240511010732.4o5dkela2geoyfma@synopsys.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511010732.4o5dkela2geoyfma@synopsys.com>

On Sat, May 11, 2024 at 01:07:41AM +0000, Thinh Nguyen wrote:
> On Sat, May 11, 2024, Krishna Kurapati PSSNV wrote:
> > 
> > 
> > On 5/10/2024 2:58 PM, Greg Kroah-Hartman wrote:
> > > On Wed, May 08, 2024 at 11:08:43PM +0000, Thinh Nguyen wrote:
> > > > On Mon, May 06, 2024, Krishna Kurapati wrote:
> > > > > While fixing a merge conflict in linux-next, hw_mode variable
> > > > > was left unused. Remove the unused variable in hs_phy_setup call.
> > > > > 
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > Closes: https://urldefense.com/v3/__https://lore.kernel.org/all/202405030439.AH8NR0Mg-lkp@intel.com/__;!!A4F2R9G_pg!aXN14tvkvwnNZ9N8-EDi-Seef9jgZBKlkZRYasINRgTOU2ijWbTvFIxkZIXOThGQQHmXc0FjiJPFI1cgdCOyAafAxB-70Q$
> > > > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > > > ---
> > > > > Changes in v2:
> > > > > Added reported by and closes tags.
> > > > > 
> > > > >   drivers/usb/dwc3/core.c | 3 ---
> > > > >   1 file changed, 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > > index 8b6f7769fcd5..7f176ba25354 100644
> > > > > --- a/drivers/usb/dwc3/core.c
> > > > > +++ b/drivers/usb/dwc3/core.c
> > > > > @@ -676,11 +676,8 @@ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
> > > > >   static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
> > > > >   {
> > > > > -	unsigned int hw_mode;
> > > > >   	u32 reg;
> > > > > -	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> > > > > -
> > > > >   	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
> > > > >   	/* Select the HS PHY interface */
> > > > > -- 
> > > > > 2.34.1
> > > > > 
> > > > 
> > > > Looks like my response reporting the merge issue to Stephen fell through
> > > > the cracks.
> > > > 
> > > > Thanks for the patch.
> > > > 
> > > > Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > > 
> > > I think I already fixed this up when I did the merge a few hours ago, if
> > > not, please let me know.
> > > 
> > 
> > Hi Greg,
> > 
> >  I just checked usb-next and linux-next. The unused variable is still there.
> > Can you pick this change up.
> > 
> 
> Just want to note that this new merge conflict is different than the
> previous that the new fix doesn't iterate through GUSB3PIPECTL[n] and
> GUSB2PHYCFG[n] base on the number of ports in dwc3_enable_susphy().
> 
> I don't think this will affect multi-port configurations. But for
> consistency, we can iterate and apply the change for all ports.
> I can submit a patch later.

Please do, thanks!

greg k-h

