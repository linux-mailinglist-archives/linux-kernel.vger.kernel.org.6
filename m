Return-Path: <linux-kernel+bounces-223076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7CA910D37
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C51CCB266A9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 16:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771041B3738;
	Thu, 20 Jun 2024 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfTvYjMI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74061AE0AC;
	Thu, 20 Jun 2024 16:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718901391; cv=none; b=SSLV3t8NJPtmr7BjGahorrX2B0oxT3tIuvXjMENjkS6CrGjQMQXE261kCxy4m2vuj0XuuIWW7tok+4KabGvljY3pd41Ai5DKDidnb7fTS4Vsz5zF87rlFx9miwOEZGSl1/eS/n2S5S8Sbz15AIiMGS+FiNIW+Uf550MCMUMvL10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718901391; c=relaxed/simple;
	bh=n/wJMdVVW764EMyC9g1orsXzaXY8/n571R9I+PD3W3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMUnMptSpiLRsoLb/70Qpn+MfxtG8UJUeyJ4qiyHIEiVSluHegRh3Eji+2QEeVU44wy05icLFoqDkF1jKgPMF12zH7L6+/l8L7JXNn43W4VO0Vd1fDn3zcW9WqxHiTBrZvAjdHSw+viKz69yeTF0iTKqAFjQT2OI1HzNZqxjD9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfTvYjMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCBDC2BD10;
	Thu, 20 Jun 2024 16:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718901391;
	bh=n/wJMdVVW764EMyC9g1orsXzaXY8/n571R9I+PD3W3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lfTvYjMIL5ljrgcqoGOQtmrldMne0zWfSmrp3OAAQdE2DjqUwSnn6XNdMaL/SHW4u
	 rlZWCjsf5PUlDzvO+7td+8+GageNcyvMKkhV4xMuov+Oj18ytAWXotafT+RKDiiusH
	 H+FYLsbLH1bPbpNOAMoox2GaT53eujW8PUO9wLF4g04/HuiR71MsqurE53Pf2Zt0qF
	 HewvG7DLabtX9ul8DhHAy7/sNjmlRXFp3pFSzGxR5dUoekzAY6z6aPfquacjBwmqUZ
	 hYUpGsSnfmb/apiM3lV3Es15yOH//gAy4oVr8sWaT/oRlr7yKwweRbbDzmNzoRBplf
	 zRg+dxs7TR0lw==
Date: Thu, 20 Jun 2024 22:06:26 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, conor@kernel.org, kishon@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	frank.li@nxp.com, conor+dt@kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v7 2/2] phy: freescale: imx8qm-hsio: Add i.MX8QM HSIO PHY
 driver support
Message-ID: <ZnRailvwM1hMtyFD@matsya>
References: <1716962565-2084-1-git-send-email-hongxing.zhu@nxp.com>
 <1716962565-2084-3-git-send-email-hongxing.zhu@nxp.com>
 <2f15baba-68b5-4e99-bdb5-6d2e05b7688b@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f15baba-68b5-4e99-bdb5-6d2e05b7688b@roeck-us.net>

On 20-06-24, 09:30, Guenter Roeck wrote:
> On Wed, May 29, 2024 at 02:02:45PM +0800, Richard Zhu wrote:
> > Add i.MX8QM HSIO PHY driver support.
> > 
> > i.MX8QM HSIO has three lane PHY instances, and can be bound to the
> > following controllers in the different use cases listed in below table.
> > - two lanes capable PCIEA controller.
> > - one lane PCIEB controller.
> > - AHCI SATA controller.
> > 
> > i.MX8QM HSIO PHYs support the following use cases.
> > +----------------------------------------------------+
> > |                               | Lane0| Lane1| Lane2|
> > |-------------------------------|------|------|------|
> > | use case 1: PCIEAX2SATA       | PCIEA| PCIEA| SATA |
> > |-------------------------------|------|------|------|
> > | use case 2: PCIEAX2PCIEB      | PCIEA| PCIEA| PCIEB|
> > |-------------------------------|------|------|------|
> > | use case 3: PCIEAPCIEBSATA    | PCIEA| PCIEB| SATA |
> > +----------------------------------------------------+
> > 
> > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
> Building alpha:allmodconfig ... failed
> --------------
> Error log:
> drivers/phy/freescale/phy-fsl-imx8qm-hsio.c: In function 'imx_hsio_set_mode':
> drivers/phy/freescale/phy-fsl-imx8qm-hsio.c:459:15: error: implicit declaration of function 'FIELD_PREP'

It should be fixed in -next tomorrow. I have applied a patch for that

-- 
~Vinod

