Return-Path: <linux-kernel+bounces-240848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C9992739F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3E581C20F13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 10:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E441AB901;
	Thu,  4 Jul 2024 10:05:22 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE24B18637;
	Thu,  4 Jul 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720087522; cv=none; b=NvMooE7EqZ1ouFJ7QZwPckTLs41v+WV6J16O1jnkeiyD+syHT6kAZBqeaKDvxMYMOLWdOvEWa9DdM/W4xhYPGxOsYshB6Zspbor7laDZ8X/TWuUPobwP7Jy4+YlpL2apvKsDEcOzA5i9lSSyAmCW7TOxUfLlf3akLOM/2g1yz5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720087522; c=relaxed/simple;
	bh=GawYRX5eDvrJfYbO8KuxHkP3nB5MwLIH6Pooqu6UQSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRlS+NSZEZMtASJv0V3BeuZhtfk0MRdyUAg2nfbKVvVfI39Tenby4nXBVirBWyebifMV8xLWfMRiOgELT8KNHiwZ11vz9TUdWWWLDawuNsNKZxw070dKjBJo107ZAwEgdm0anIgQv3Kth8+nuqKZ72ooa8oefIiSiLX8ocva9D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875ac2.versanet.de ([83.135.90.194] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sPJKx-0007cl-E2; Thu, 04 Jul 2024 12:05:11 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
 Diederik de Haas <didi.debian@cknow.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: add rock5 itx board
Date: Thu, 04 Jul 2024 12:05:10 +0200
Message-ID: <4552794.8F6SAcFxjW@diego>
In-Reply-To: <2278169.QnsP76Vvrg@bagend>
References:
 <20240703210524.776455-1-heiko@sntech.de>
 <20240703210524.776455-3-heiko@sntech.de> <2278169.QnsP76Vvrg@bagend>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Diederik,

Am Donnerstag, 4. Juli 2024, 11:38:51 CEST schrieb Diederik de Haas:
> Thanks for submitting this. A quick scan indicates it should work with a 
> (recent) Debian kernel OOTB :-)
> 
> On Wednesday, 3 July 2024 23:05:24 CEST Heiko Stuebner wrote:
> > +&sdhci {
> > +       bus-width = <8>;
> > +       no-sdio;
> > +       no-sd;
> > +       non-removable;
> > +       max-frequency = <200000000>;
> > +       mmc-hs400-1_8v;
> > +       mmc-hs400-enhanced-strobe;
> > +       mmc-hs200-1_8v;
> > +       status = "okay";
> > +};
> > +
> > +&sdmmc {
> > +       max-frequency = <200000000>;
> > +       no-sdio;
> > +       no-mmc;
> > +       bus-width = <4>;
> > +       cap-mmc-highspeed;
> > +       cap-sd-highspeed;
> > +       disable-wp;
> > +       sd-uhs-sdr104;
> > +       vmmc-supply = <&vcc_3v3_s3>;
> > +       vqmmc-supply = <&vccio_sd_s0>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&sdmmc_bus4 &sdmmc_clk &sdmmc_cmd &sdmmc_det>;
> > +       status = "okay";
> > +};
> > +
> > +/* M.2 E-KEY */
> > +&sdio {
> > +       broken-cd;
> > +       bus-width = <4>;
> > +       cap-sdio-irq;
> > +       disable-wp;
> > +       keep-power-in-suspend;
> > +       max-frequency = <150000000>;
> > +       mmc-pwrseq = <&sdio_pwrseq>;
> > +       no-sd;
> > +       no-mmc;
> > +       non-removable;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&sdiom0_pins>;
> > +       sd-uhs-sdr104;
> > +       vmmc-supply = <&vcc3v3_ekey>;
> > +       status = "okay";
> > +};
> > +
> > +&sfc {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&fspim2_pins>;
> > +       status = "okay";
> 
> Shouldn't those properties be sorted alphabetically? Or at least consistently?
> Note that the same issue is present on other places too, but I believe the 
> above quoted part shows the issue enough.

The main sorting is
- compatible
- reg
[... alphabetically ...]
- status

But now that I look at it, you're right there are some non-alphabetical
shenanigans going on there in the sdmmc and sdhci nodes ;-)

Heiko



