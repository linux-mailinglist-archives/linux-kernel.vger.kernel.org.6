Return-Path: <linux-kernel+bounces-310164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9BB9675B1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 11:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99F91F21ACF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525F914A4FF;
	Sun,  1 Sep 2024 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="UAiP9Yli"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D761341C73;
	Sun,  1 Sep 2024 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725181945; cv=none; b=ofe2oltStiVQCeYFOk6I3a956qDjLTs1WwAXe7mI/ZnJ37vQ1TxGgTp7zDgfpOBbvzdEBfnZF72arVe3K8hQV1qOvtDzY1j1ZtGxV6SIUW59uvgD5ep/4YTWLWvUdUBVDzeYxdhd2BKnI2etHYGNULhcy+ZucezFxnE+yCVsap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725181945; c=relaxed/simple;
	bh=cmYNT5S0qfMVfLTDfqNsumB8zTDkIjF4Bt9pmtpz9zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WKvpCRNwlH7Z6Qfc9o5mSuFUpKWXYvlmhJF7aeY+CTZCOwFxKgkG5KVJJthO29uirtqa9ougtW22ielnIFzgOMXMigSSYW2kNsg6ZB5RxEcibQwM16WMKlmP2Ti2M063n/HeZBxiBm0aWkrrWIOnpKrTKIGyHeVMDZXVDR4CwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=UAiP9Yli; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=cgFI24ocR6b/eVGC3R3NeznnmdVG4p1OYniHdh2gE1s=;
	b=UAiP9Yli0cg83XIe9C1XH0t5DB+cNvSMQ8rRboSqZ6BM3ibaGMMpiop0273VII
	Mb3EdP+Ewn/rw9/JbrRD3EnlxOC8O01OYbirYY72YFJIyC+/yrpHlZtnlAcDms87
	jCIMiZ6giY5agikxi3pp3qw/Vj7i2S4oZLYtQWQexz83I=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3X0nEL9Rm3QhFAA--.21923S3;
	Sun, 01 Sep 2024 17:11:34 +0800 (CST)
Date: Sun, 1 Sep 2024 17:11:32 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Liu Ying <victor.liu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, catalin.marinas@arm.com, will@kernel.org,
	quic_bjorande@quicinc.com, geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
	arnd@arndb.de, nfraprado@collabora.com
Subject: Re: [PATCH 0/2] arm64: dts: imx93-11x11-evk: Add PWM backlight for
 "LVDS" connector
Message-ID: <ZtQvxJi7lRBGRjvL@dragon>
References: <20240827064717.2383292-1-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827064717.2383292-1-victor.liu@nxp.com>
X-CM-TRANSID:Ms8vCgD3X0nEL9Rm3QhFAA--.21923S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUarb1UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgtNZWbUDStNBAAAs8

On Tue, Aug 27, 2024 at 02:47:15PM +0800, Liu Ying wrote:
> Hi,
> 
> This patch set adds PWM backlight support for "LVDS" connector on i.MX93
> 11x11 EVK.
> 
> This patch set is based on next-20240826 and targets for v6.12.
> 
> Patch 1 adds device tree support for the PWM backlight.
> Patch 2 updates defconfig for ARM64 to build ADP5585 MFD/GPIO/PWM drivers
> as modules.
> 
> Liu Ying (2):
>   arm64: dts: imx93-11x11-evk: Add PWM backlight for "LVDS" connector
>   arm64: defconfig: Enable ADP5585 GPIO and PWM drivers

Applied both, thanks!


