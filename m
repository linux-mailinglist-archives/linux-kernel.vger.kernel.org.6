Return-Path: <linux-kernel+bounces-233275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD9991B51C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 04:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB591C21876
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 02:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3111C1A716;
	Fri, 28 Jun 2024 02:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="etm7XznZ"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADB21755C;
	Fri, 28 Jun 2024 02:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719542104; cv=none; b=bVjw4QV+x57zuf38rl+i7qixcB4tg47fOz8BWRB3EvExWVwRnOU6VwKuIjS6WBMzoG2uUfP26G25PSIQJOvRodyecnUtl803v/j7lZ90h9xq+zdPl5LYaDh/8rWslC68/JIGoAZhZKygK05sj8EO5aaxWauUVVMRwIYEPxldEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719542104; c=relaxed/simple;
	bh=+pdk4QsuKrrSmF01Wedd+xXBnOH2tRrw6LCT86hr5bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/qEBlwBjgrsjCcIasoMstkujlsfFPLmO3OuCoA6/DFvygdSTGHA//5LuTwjNnTLb2Am3efEg9fas91hdenPYarSf4upt3bot9CMDLoQlt93Iy4h/16Exw/i7u9dFdpBpnsQw9Tc5/k0mgqEa5x6MHQfHdks2MrXK1W5tHNzOw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=etm7XznZ; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=SkBFh4hAPDpC3VZwEVT9p9hKch3/AQhpyjO2Rm2yD94=;
	b=etm7XznZEEPi9nKDqMtCp/MbKf04+3RlBz4yM6L18tE/jrrQ7MP2DnrhPulPsf
	DRRMio4wFmFgRGpRjcnhFLtcNK1Ztt89eYMzt0cCNa+HoOAp99vkUPyl+QMmLHre
	evTSsED5kBb6YxObSEx4x2sczm5gI3QaWfjjqzem3OQUk=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3P8czIX5meSAgAA--.57314S3;
	Fri, 28 Jun 2024 10:34:29 +0800 (CST)
Date: Fri, 28 Jun 2024 10:34:27 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 07/13] arm64: dts: layerscaple: add #dma-cells for qdma
Message-ID: <Zn4hM7rZ75F15WAh@dragon>
References: <20240626202533.2182846-1-Frank.Li@nxp.com>
 <20240626202533.2182846-8-Frank.Li@nxp.com>
 <CAL_JsqJDOgGWqggWXE-_jv6oQW9nekxU-4Fui+2JFZ6DWUqLtg@mail.gmail.com>
 <CAL_JsqJ1X8rRfVrw0gGeiiQaK+9RekNFSHgXR3zhcNRNw5y9mQ@mail.gmail.com>
 <Zn2vEe//vELVxRae@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zn2vEe//vELVxRae@lizhi-Precision-Tower-5810>
X-CM-TRANSID:Ms8vCgD3P8czIX5meSAgAA--.57314S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7XrWkZFW7Wr48Xr1kWF1kGrg_yoW8Jr13pF
	yIkFWUKr48GF4UAF1q9a1rZFyYyw43Xws5Xr9xG343Kr9I9FnayryY9rs3ury7Zr4xCw1Y
	vF1UXry3W3sYvwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnpnQUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhYMZWZv-c9WIwAAsj

On Thu, Jun 27, 2024 at 02:27:29PM -0400, Frank Li wrote:
> On Thu, Jun 27, 2024 at 11:22:57AM -0600, Rob Herring wrote:
> > On Thu, Jun 27, 2024 at 11:17 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Jun 26, 2024 at 2:26 PM Frank Li <Frank.Li@nxp.com> wrote:
> > > >
> > > > Add #dma-cells for qdma to fix below warning.
> > > >         dma-controller@8380000: '#dma-cells' is a required property
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 1 +
> > > >  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 1 +
> > > >  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 1 +
> > > >  3 files changed, 3 insertions(+)
> > >
> > > Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> > 
> > Except for the typo in the subject...
> > 
> > Frank, while I appreciate the great number of reductions in DT
> > warnings on FSL platforms you and others have been working on, your
> > work is sloppy with issues you should find yourself.
> 
> I found the typo after I sent yesterday. I planned fix it after collect
> some comments. It was already in shawn's tree. I hope shawn can help fix
> it.

s/layerscaple/layerscape

Fixed it up.  Thanks for spotting it, Rob!

Shawn


