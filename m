Return-Path: <linux-kernel+bounces-216154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41407909C08
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 09:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63D01F22A9A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 07:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E2B16EC07;
	Sun, 16 Jun 2024 07:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="fSQoL1S7"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58F45025E
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 07:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718521766; cv=none; b=Axvmw7yGya+G9mkZK9vratoIdhw77qloehYWkILNWwuXx+GLXEZWwECCf2qyrYse4HM7oaE3qyUGE5uC3E+sgeD0/Aqzwq3eJVRdsqshL/eT/BmCPwRYJ+e91ncqsiY0WxtJYN3EbzZ+yFKEBfoATQR3aW5f7U1XFmJQhBli/RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718521766; c=relaxed/simple;
	bh=vZ0BN+iwJKmD0J8p1QINCDjKP75eZtW2SC1O6NI3ukE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dekoUt4qLdVoTtSPSqYrGcRqzs6nfOql3OGzmrelzE7R7iwrnsCBIDg+v52kuP2oPdKyHrpE+c8982lnir+HyubFw5OunOI9DDBb8hwaaUYajQ37THUKPIwll2Ps/6hNBqhMNTyymfiNDjXI/wYbTy8KHaUNYH6ZbiiYp119B4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=fSQoL1S7; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=hoopR7IVlqAk31RamLP5caSJX2yo8Er/Hi00JioDoi0=;
	b=fSQoL1S7o2B0aEjMy7ProFCXlOtQDDoRKFNDrGrnp6aNmbr1v2fCCSKqBLtB/f
	bhhEFXVxHD3qBb7ychvk/gfDkNo24Raxv7d3OZ3mHrLYy+mHSdT2OkcS4JYK+h7P
	PfxQ+L/ArlQW9k5QF6NQXVIBjFpMmkk/1zh6WhpsFHSn0=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrAB33vqHj25mmz__Bw--.39420S3;
	Sun, 16 Jun 2024 15:08:56 +0800 (CST)
Date: Sun, 16 Jun 2024 15:08:55 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Chris Healy <cphealy@gmail.com>
Subject: Re: [PATCH v2] ARM: imx_v6_v7_defconfig: enable DRM_SII902X and
 DRM_DISPLAY_CONNECTOR
Message-ID: <Zm6Ph1FGsPYJCcbe@dragon>
References: <20240603-imx-sii902x-defconfig-v2-1-a39e442011ae@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603-imx-sii902x-defconfig-v2-1-a39e442011ae@linaro.org>
X-CM-TRANSID:ClUQrAB33vqHj25mmz__Bw--.39420S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4GQ6DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBsAZV6Nn4yK5AABsJ

On Mon, Jun 03, 2024 at 12:09:39AM +0300, Dmitry Baryshkov wrote:
> Enable the LVDS-to-HDMI bridge and the HDMI display connector drivers
> used on the iMX53 QSB and QSRB boards with the HDMI mezzanine.
> 
> Cc: Chris Healy <cphealy@gmail.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Applied, thanks!


