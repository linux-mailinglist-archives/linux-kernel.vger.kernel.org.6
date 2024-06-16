Return-Path: <linux-kernel+bounces-216546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDFC90A0E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241AE1C210E6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 23:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311F074BE1;
	Sun, 16 Jun 2024 23:58:50 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8089D225D6;
	Sun, 16 Jun 2024 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718582329; cv=none; b=M5KjuBCC2n2d0PoLxhMd3lAIX+YLJSlDD9kFnK3ghxN7Zn+jEHE8bPvd9hKwhjk+NPF8Sfsh/OdcHa9S+gs9NvDJr0ZoCp9U6Xmq1dvVeB0XyK12ekZV/I/biMqqBbrYUTDtUvFNpOZr7MSMgpNImg1as7H1jL0OV3cSfQqT77I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718582329; c=relaxed/simple;
	bh=J786VmLBsIS9hA0rgT6mbCgXRYVRzeIaqzjALSa/MFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ors9iZrYX24z3jWrj+y3GK10UFJKYIrCFWYtsqVrHXtvwsZSq4vgmpqsaR5T6Km3oNiLOx5+vklyhXbUsLgstLQ9EDE+AHTS11k3uiamLDmVPwJKtCW7aP3ix7OIJglT8Q0nSz7NwmwIiz5JaMlhFZZuUTW0e7kpO0X37uq68Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Sun, 16 Jun 2024 23:58:29 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Inochi Amaoto <inochiama@outlook.com>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Chen Wang <unicorn_wang@outlook.com>,
	Chao Wei <chao.wei@sophgo.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 1/6] riscv: dts: sophgo: Put sdhci compatible in dt of
 specific SoC
Message-ID: <20240616235829.GA4000183@ofsar>
References: <20240612-sg2002-v2-0-19a585af6846@bootlin.com>
 <20240612-sg2002-v2-1-19a585af6846@bootlin.com>
 <IA1PR20MB49534C9E29E86B478205E4B3BBC02@IA1PR20MB4953.namprd20.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <IA1PR20MB49534C9E29E86B478205E4B3BBC02@IA1PR20MB4953.namprd20.prod.outlook.com>

Hi

On 18:47 Wed 12 Jun     , Inochi Amaoto wrote:
> On Wed, Jun 12, 2024 at 10:02:31AM GMT, Thomas Bonnefille wrote:
> > Remove SDHCI compatible for CV1800b from common dtsi file to put it in
> > the specific dtsi file of the CV1800b.
> > This commits aims at following the same guidelines as in the other nodes
> > of the CV18XX family.
is there any URL of guideline? or did I miss anything
couldn't find any discussion about this in v1

> > 
> > Signed-off-by: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
> > ---
> >  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 4 ++++
> >  arch/riscv/boot/dts/sophgo/cv18xx.dtsi  | 1 -
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > index ec9530972ae2..b9cd51457b4c 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > @@ -25,3 +25,7 @@ &clint {
> >  &clk {
> >  	compatible = "sophgo,cv1800-clk";
> >  };
> > +
> > +&sdhci0 {
> > +	compatible = "sophgo,cv1800b-dwcmshc";
> > +};
> > diff --git a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > index 891932ae470f..7247c7c3013c 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv18xx.dtsi
> > @@ -288,7 +288,6 @@ uart4: serial@41c0000 {
> >  		};
> >  
> >  		sdhci0: mmc@4310000 {
> > -			compatible = "sophgo,cv1800b-dwcmshc";
> >  			reg = <0x4310000 0x1000>;
> >  			interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
> >  			clocks = <&clk CLK_AXI4_SD0>,
> > 
> > -- 
> > 2.45.2
> > 
> 
> Hi, Jisheng,
> 
> Is this change necessary? IIRC, the sdhci is the same across 
> the whole series.
I tend to agree with Inochi here, if it's same across all SoC, then no bother to
split, it will cause more trouble to maintain..

> 
> Regards,
> Inochi

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

