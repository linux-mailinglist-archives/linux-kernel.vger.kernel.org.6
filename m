Return-Path: <linux-kernel+bounces-216634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECE590A26E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 04:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF461C2147D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 02:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62FD176ABF;
	Mon, 17 Jun 2024 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ADO9Yjoh"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DBE23A9;
	Mon, 17 Jun 2024 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718591332; cv=none; b=bjyTdoS2NZjjIgqvbiZwVg+fn+rg9bcr1RHCZUq9o78/fgwJ5Oln53sNrisecTWKNGam2+dfDaXuIwKiXKJQ7aqiJN8MHMty5eYjm6BkFcxeL5yGh/zgb4ss5oqg6CTjTAkKteh0oWwfVx+el/OyGLXIRCo3lsMU8A9cr9cHJ04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718591332; c=relaxed/simple;
	bh=1QXC4KNQMHpF9DSVGVvMCJu94ZNsyCi4w5KcmkvxCMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxhSM+SMMdrMOWZ3t86LG7yoLjln4Lcqwj3nVza6I+Hys4o2Q3kY3eHJIKB5vJrkxvpbC+K6GLWo9rNNzF+jPZU6aPu6IrID9RMjh9tgPRN0dh4heY03XOCN9leXZ2DvucdyFIQq9FkVuJ9KaP+6tiqy73aKE3F3Nj2ykcIbRZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ADO9Yjoh; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=2F2+YpEMxCXymd2z6O6l2Gn8jzxbNXIUvmgbMNydTVw=;
	b=ADO9YjohmX1pXp3VrO7WYLwEUH7dIytsc+lC9kqFlexqHk6HzfiO1rFwRkBMxR
	Nz8HxKPyLr++8v5fXq/vxD6RSgZk6TvMGR66LYJppd5UMPip76TDRgzijF11/UDH
	2rQbFJKKvHJWdNFtxqeWW99hnCIh5Ikqr6XXwvQ99Wo2M=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrADHLhhOn29moyjOCA--.3991S3;
	Mon, 17 Jun 2024 10:28:32 +0800 (CST)
Date: Mon, 17 Jun 2024 10:28:30 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Adam Ford <aford173@gmail.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-msc-sm2s: Add HDMI output
Message-ID: <Zm+fTrH7Hrkahz3F@dragon>
References: <20240612-imx8mp-msc-sm2s-hdmi-v1-1-6c808df5205d@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612-imx8mp-msc-sm2s-hdmi-v1-1-6c808df5205d@bootlin.com>
X-CM-TRANSID:C1UQrADHLhhOn29moyjOCA--.3991S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIku4UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDRABZVszXmPK-gAAsY

On Wed, Jun 12, 2024 at 12:17:27PM +0200, Luca Ceresoli wrote:
> Enable the HDMI output of the MSC SM2-MB-EP1 carrier board based the
> SM2S-IMX8PLUS SMARC module.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Applied, thanks!


