Return-Path: <linux-kernel+bounces-365325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E12099E08D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C799928252B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E551C302E;
	Tue, 15 Oct 2024 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Wyb4/JxW"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B91018BC21;
	Tue, 15 Oct 2024 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979985; cv=none; b=iLZA/DQ7m93yIujx3Fs5AOdnncdf0OdVw/ywt5SMahWdBGlgoly/EszSXjm0nORhbaRMJ8qvFRWW8n+beQR2Se5kQF3/dGh0u8PA84ASkM4+2/VbxjWypNPyE67igE0txiGuzLXNDA/y4syT9k4IamT4JJH4xpVwkwbLBVuyy4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979985; c=relaxed/simple;
	bh=e2+iFrOJzwzNfSbMrK1Gg5aTCjWbwMktcisESyQ/0Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+zEcOftbmCMhUugOryu/7wn7tfIsJKEN64t1Iqe7gedqoc/a1/iP0iso7LOR0yePEyAd70zqYe3rGr3GZgu5fNu6J9ogGQKJ56LS726Cchih3Kwp6OwPWSL/6sgnuZLwK/LCAmzJJ4puG2WTjfWG35ygAoM678GKHK8giIAgd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Wyb4/JxW; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=VnWpEMqsaiHx1UpbckYzGM7hHu3/g8tn6M+IPcoVc1s=;
	b=Wyb4/JxWriALg09AHwSs3VPSyIISJ1nCkehabr0kVFDRIEEmT3hRLqEcvVdSJ3
	2Qi+DXdQ9zE/ItF2nN1J2iTRTv1cuWmNFSiPNQwmc4WQtPHN7qLvphFkZf0CmVvd
	F13zNkjxCAjaPCQHxFGenxCfN0+gngjM4U+x9t8mcPhCA=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3ny3dIw5nQJgDAA--.7183S3;
	Tue, 15 Oct 2024 16:12:15 +0800 (CST)
Date: Tue, 15 Oct 2024 16:12:13 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tarang Raval <tarang.raval@siliconsignals.io>
Cc: shawnguo@kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] arm64: dts: imx8mm-emtop-baseboard: Add Peripherals
 Support
Message-ID: <Zw4j3XOxhdO/dztA@dragon>
References: <20240903091720.443091-1-tarang.raval@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903091720.443091-1-tarang.raval@siliconsignals.io>
X-CM-TRANSID:M88vCgD3ny3dIw5nQJgDAA--.7183S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxCJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBBx5ZWcN2zvY+AAAsu

On Tue, Sep 03, 2024 at 02:47:20PM +0530, Tarang Raval wrote:
> Add following peripherals support for the Emtop i.MX8M Mini Baseboard
> 
>         * Wi-Fi
>         * Audio
>         * SD card
>         * RTC
>         * CAN bus
>         * USB OTG
> 
> Signed-off-by: Tarang Raval <tarang.raval@siliconsignals.io>

Applied, thanks!


