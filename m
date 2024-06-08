Return-Path: <linux-kernel+bounces-207083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0411C901231
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BF461F21C60
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C83176FA7;
	Sat,  8 Jun 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wbF5FcR1"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3E15A86A;
	Sat,  8 Jun 2024 15:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717858974; cv=none; b=WrlnmU8C6kl42cEhTmYSLjI16PjJNtZOb+cbvEBmOPhOH6VV7N6yrRze0ojy9Jj6cqU2KOri6ztZFBu3UK3tqCYVZHRpD5i2lWveNvivjc3zy3NwMNV6aDUqQIaaph20FXzUdo8c3kOqvrqnZEFj7q4H7SnVGtb7d021YejxmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717858974; c=relaxed/simple;
	bh=UQajqenKlrvH5lGzWKTwgn2VoSNwkyZus1uA9XzmJ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idr257xxlJbwHwtiMRESX5t7etOhItDWtBSPJ6kV/J/W3xNSIIGgaMNhwhKsVcOBtmBWN4rRFdzK1fmXrC3N291aL9ydXH8/huLjCAGVAr98yCJb+gB3zr063aILcaK9zGPetXjyCpFRbGqqhLeeH/AaQM9XEkx8HKSija2GvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wbF5FcR1; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4D90829F;
	Sat,  8 Jun 2024 17:02:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1717858955;
	bh=UQajqenKlrvH5lGzWKTwgn2VoSNwkyZus1uA9XzmJ3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wbF5FcR1OHHS/6eqX8MBcF5zS9DuwurwCsdj2MFv4nPOUZeuI8VJtUgXWyn8AwoyS
	 YiHhMSjcXCSqhQ+vBCK5JYimCt/dZYmb6aCYJK8bfJn6uAHJJPW4vXyaqbZtJlQiH4
	 25xNQyyg3C84xZfskXqZ6JqtMOrIjMPzBjM/+oG0=
Date: Sat, 8 Jun 2024 18:02:27 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	linux-kernel@vger.kernel.org,
	Daniel Scally <dan.scally@ideasonboard.com>, kernel@collabora.com,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/1] arm64: dts: imx8mp-debix-model-a: Add HDMI output
 support
Message-ID: <20240608150227.GA13024@pendragon.ideasonboard.com>
References: <20240415114135.25473-1-chris.obbard@collabora.com>
 <20240415114135.25473-2-chris.obbard@collabora.com>
 <171319369093.2333277.9109576229211275635@ping.linuxembedded.co.uk>
 <20240415163520.GA22954@pendragon.ideasonboard.com>
 <525f3c7f7f6613c78ac364c9ce0234cca5e1c710.camel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <525f3c7f7f6613c78ac364c9ce0234cca5e1c710.camel@collabora.com>

On Mon, Apr 15, 2024 at 06:07:24PM +0100, Christopher Obbard wrote:
> On Mon, 2024-04-15 at 19:35 +0300, Laurent Pinchart wrote:
> > On Mon, Apr 15, 2024 at 04:08:10PM +0100, Kieran Bingham wrote:
> > > Quoting Christopher Obbard (2024-04-15 12:41:27)
> > > > Enable the HDMI output on the Debix Model A SBC, using the HDMI encoder
> > > > present in the i.MX8MP SoC.
> > > 
> > > Aha, you beat me to it. I have a commit locally (Dated 2022-09-06) but
> > > not sent because I didn't realise the HDMI support finally got upstream
> > > \o/
> > > 
> > > > Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> > > > ---
> > > > 
> > > >  .../dts/freescale/imx8mp-debix-model-a.dts    | 47 +++++++++++++++++++
> > > >  1 file changed, 47 insertions(+)
> > > > 
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> > > > b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> > > > index 2c19766ebf09..29529c2ecac9 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> > > > @@ -20,6 +20,18 @@ chosen {
> > > >                 stdout-path = &uart2;
> > > >         };
> > > >  
> > > > +       hdmi-connector {
> > > > +               compatible = "hdmi-connector";
> > > > +               label = "hdmi";
> > > > +               type = "a";
> > > > +
> > > > +               port {
> > > > +                       hdmi_connector_in: endpoint {
> > > > +                               remote-endpoint = <&hdmi_tx_out>;
> > > > +                       };
> > > > +               };
> > > > +       };
> > > > +
> > > 
> > > Interesting. My patch missed this. But it looks correct.
> > > 
> > > >         leds {
> > > >                 compatible = "gpio-leds";
> > > >                 pinctrl-names = "default";
> > > > @@ -94,6 +106,28 @@ ethphy0: ethernet-phy@0 { /* RTL8211E */
> > > >         };
> > > >  };
> > > >  
> > > > +&hdmi_pvi {
> > > > +       status = "okay";
> > > > +};
> > > > +
> > > > +&hdmi_tx {
> > > > +       pinctrl-names = "default";
> > > > +       pinctrl-0 = <&pinctrl_hdmi>;
> > > > +       status = "okay";
> > > > +
> > > > +       ports {
> > > > +               port@1 {
> > > > +                       hdmi_tx_out: endpoint {
> > > > +                               remote-endpoint = <&hdmi_connector_in>;
> > > > +                       };
> > > > +               };
> > > > +       };
> > > > +};
> > > > +
> > > > +&hdmi_tx_phy {
> > > > +       status = "okay";
> > > > +};
> > > > +
> > > >  &i2c1 {
> > > >         clock-frequency = <400000>;
> > > >         pinctrl-names = "default";
> > > > @@ -241,6 +275,10 @@ &i2c6 {
> > > >         status = "okay";
> > > >  };
> > > >  
> > > > +&lcdif3 {
> > > > +       status = "okay";
> > > > +};
> > > > +
> > > 
> > > Except for the addition of the connector, the above matches my patch to
> > > here.
> > > 
> > > >  &snvs_pwrkey {
> > > >         status = "okay";
> > > >  };
> > > 
> > > But in my patch I have the following hunk here: (I haven't checked to
> > > see if this still applies on mainline, so take with a pinch of salt if
> > > it's not there!)
> > > 
> > > 
> > >  &iomuxc {
> > >  	pinctrl-names = "default";
> > > -	pinctrl-0 = <&pinctrl_hog>;
> > > -
> > > -	pinctrl_hog: hoggrp {
> > > -		fsl,pins = <
> > > -
> > > 			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL					0x400001c3
> > > -
> > > 			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA					0x400001c3
> > > -
> > > 			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD						0x40000019
> > > -
> > > 			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC						0x40000019
> > > -		>;
> > > -	};
> > > 
> > >  	pinctrl_eqos: eqosgrp {
> > >  		fsl,pins = <
> > >  			MX8MP_IOMUXC_ENET_MDC__ENET_QOS_MDC		
> > > 					0x3
> > >  			MX8MP_IOMUXC_ENET_MDIO__ENET_QOS_MDIO		
> > > 				0x3
> > > 
> > > 
> > > > @@ -358,6 +396,15 @@
> > > > MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16                              0x19
> > > >                 >;
> > > >         };
> > > >  
> > > > +       pinctrl_hdmi: hdmigrp {
> > > > +               fsl,pins = <
> > > > +                      
> > > > MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL                    
> > > > 0x400001c3
> > > > +                      
> > > > MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA                    
> > > > 0x400001c3
> > > > +                      
> > > > MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD                        
> > > > 0x40000019
> > > > +                      
> > > > MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC                        
> > > > 0x40000019
> > > > +               >;
> > > > +       };
> > > > +
> > > 
> > > And my addition here is :
> > > 
> > > 
> > > +	pinctrl_hdmi: hdmigrp {
> > > +		fsl,pins = <
> > > +			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL	0
> > > x1c3
> > > +			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA	0
> > > x1c3
> > > +			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD	
> > > 	0x19
> > > +			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC	
> > > 	0x19
> > > +		>;
> > > +	};
> > > +
> > > 
> > > 
> > > I haven't looked into what the 0x40000000 does yet, but just
> > > highlighting the difference from the version I've been using to make use
> > > of HDMI so far.
> > > 
> > > Does anyone else know the impact here? Otherwise I'll try to find time
> > > to check this later. (For some undefined term of later...)
> > 
> > In drivers/pinctrl/freescale/pinctrl-imx.c,
> > 
> > #define IMX_NO_PAD_CTL  0x80000000      /* no pin config need */
> > #define IMX_PAD_SION 0x40000000         /* set SION */
> > 
> > The SION (Software Input ON) bit forces the input path active for the
> > pin. This can be used, for instance, to capture through GPIO the value
> > of a pin driven by a module. I'm not sure that's needed here.
> 
> Thanks for the explanation, makes perfect sense. I will send a v2 without the
> SION bit set (e.g exactly per the hunk in Kieran's patch).

I'd like to get this merged in v6.11. If you don't have time to send a
v2, I'm happy resending our version of the patch instead :-)

> > > >         pinctrl_i2c1: i2c1grp {
> > > >                 fsl,pins = <
> > > >                        
> > > > MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL                                
> > > > 0x400001c2

-- 
Regards,

Laurent Pinchart

