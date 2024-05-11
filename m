Return-Path: <linux-kernel+bounces-176453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D794D8C301F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 09:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BA61C21BBD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 07:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F3710962;
	Sat, 11 May 2024 07:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tPXCmPxJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892D51C01;
	Sat, 11 May 2024 07:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715413257; cv=none; b=GKS5v+B5j6zF8nCukay3K/KPyQADhQp/aoRc7pnppvShC3sgWKIPLVgo+TwMZgDbYua/+Jqe8yL4ZK2q3ASjrwCrect9YfQ7rTHR6JRhm/h+sLaQLIhhMhomKqBQHPf5+507uV+PzJv+CwUoQSjBEYImh3xOqAJvuDvwR+ULh2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715413257; c=relaxed/simple;
	bh=A+uXYa44j5Kel+CugnlTp7NcH73Ib6xcoCFP9e6TNw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kiw3wS1iFW9vp64/e75Bt1PybivY+tq9689NO5nqsc/XTkCWdU/H5D0lDbVqfz7Mx69XPNHVe9jF1t82BBXq89RaoR/FSNt+1L3mVdlk7HSXCq8r+GYuvnfLV5kQZ59mzd3w2s4Tjdld3fEet/Y5f7T9+e7N6yocgAx7OfSpDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tPXCmPxJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD36C2BD10;
	Sat, 11 May 2024 07:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715413257;
	bh=A+uXYa44j5Kel+CugnlTp7NcH73Ib6xcoCFP9e6TNw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tPXCmPxJTT6lCv8BORjc73vyPZqmMd2stBOk7DOM2bx6y65Nh7awCjRnfkKfA2ccc
	 lQbCOOAFe+fUsNSXDCW6TJ2lZuZ9oph4kJMajnWQdfsKob+pj6H7SVpUbEHDjpVj1F
	 9f68aS1ip+IPGP8lqYC+APUsDhyZbqBTDpTWgln8=
Date: Sat, 11 May 2024 08:40:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
	"quic_jackp@quicinc.com" <quic_jackp@quicinc.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] usb: dwc3: core: Fix unused variable warning in core
 driver
Message-ID: <2024051147-prance-importer-8eed@gregkh>
References: <20240506074939.1833835-1-quic_kriskura@quicinc.com>
 <20240508230839.utioi5i2c5kozm4d@synopsys.com>
 <2024051050-pantomime-sudden-a382@gregkh>
 <0f056ece-6d38-428e-bf18-edb053c90ca7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f056ece-6d38-428e-bf18-edb053c90ca7@quicinc.com>

On Sat, May 11, 2024 at 12:56:29AM +0530, Krishna Kurapati PSSNV wrote:
> 
> 
> On 5/10/2024 2:58 PM, Greg Kroah-Hartman wrote:
> > On Wed, May 08, 2024 at 11:08:43PM +0000, Thinh Nguyen wrote:
> > > On Mon, May 06, 2024, Krishna Kurapati wrote:
> > > > While fixing a merge conflict in linux-next, hw_mode variable
> > > > was left unused. Remove the unused variable in hs_phy_setup call.
> > > > 
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://urldefense.com/v3/__https://lore.kernel.org/all/202405030439.AH8NR0Mg-lkp@intel.com/__;!!A4F2R9G_pg!aXN14tvkvwnNZ9N8-EDi-Seef9jgZBKlkZRYasINRgTOU2ijWbTvFIxkZIXOThGQQHmXc0FjiJPFI1cgdCOyAafAxB-70Q$
> > > > Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> > > > ---
> > > > Changes in v2:
> > > > Added reported by and closes tags.
> > > > 
> > > >   drivers/usb/dwc3/core.c | 3 ---
> > > >   1 file changed, 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > > index 8b6f7769fcd5..7f176ba25354 100644
> > > > --- a/drivers/usb/dwc3/core.c
> > > > +++ b/drivers/usb/dwc3/core.c
> > > > @@ -676,11 +676,8 @@ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
> > > >   static int dwc3_hs_phy_setup(struct dwc3 *dwc, int index)
> > > >   {
> > > > -	unsigned int hw_mode;
> > > >   	u32 reg;
> > > > -	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> > > > -
> > > >   	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(index));
> > > >   	/* Select the HS PHY interface */
> > > > -- 
> > > > 2.34.1
> > > > 
> > > 
> > > Looks like my response reporting the merge issue to Stephen fell through
> > > the cracks.
> > > 
> > > Thanks for the patch.
> > > 
> > > Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> > 
> > I think I already fixed this up when I did the merge a few hours ago, if
> > not, please let me know.
> > 
> 
> Hi Greg,
> 
>  I just checked usb-next and linux-next. The unused variable is still there.
> Can you pick this change up.

Now applied, thanks.

greg k-h

