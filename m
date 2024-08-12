Return-Path: <linux-kernel+bounces-282888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA6194EA1A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3162D2812E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E4516DED4;
	Mon, 12 Aug 2024 09:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="AiucvR8o"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672616DEC6;
	Mon, 12 Aug 2024 09:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723455634; cv=none; b=LXY5M/OdwcKs3SG9A/e5aOwAYAoK1M/IRm0FW15OLlN2U5fTp3pIpQ/mZ0Kx05iGsTmaVckEGDSUGKGr6Zjw2a2s2CvaUUsrK1jkdaJ6yiR2Vml9zRF2quxh2rTaUv9q3mragHLK9CFQPYrvbvkbx0Vfajax6m5p/XeW1dAuDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723455634; c=relaxed/simple;
	bh=mw6cplmOp2lcSdbR8MqeYBfW6dC4DuyHrpxZr9V789o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sa6utbLFUCBbIk91i8H/hdJe9xjw372EdisEU4xvZfgGINA3nVD4Nh635jMTuWONL609eFnGAzZ5zHLEM/JnSMmP0YlySylFBoAB/F/R+Tu4IalQSwt2SbWcFtlCBWBLFPP/Nyzf/bhGlX76fiOtH7cideeLnweWjilvYnDvmJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=AiucvR8o; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=xCSPQrFRYSdwq4poKWRNvIyPJNPWv6qGyxka+0jKnPo=;
	b=AiucvR8oj/DrADaQRaQEH2WPDsOmxBRejqJXjDzqrJ3aIoIWGZqokACkjgbX/T
	4e7I/tUlYRKAb+JJGyJL25vx6rAYaIgAzA338rsXpFb8utQUj/LZXWnlTvicQLjE
	tJ0oMACAjBGgWWY8unPokuRPUV9edhQ+hYo3m/6Op/vjg=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgAX3Y5i2LlmmjZWAg--.34770S3;
	Mon, 12 Aug 2024 17:39:48 +0800 (CST)
Date: Mon, 12 Aug 2024 17:39:46 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux@ew.tq-group.com,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] arm64: dts: mba8mx: Add Ethernet PHY IRQ support
Message-ID: <ZrnYYqCpTKFOGiG+@dragon>
References: <20240717064916.1670702-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717064916.1670702-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Ms8vCgAX3Y5i2LlmmjZWAg--.34770S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxtxhDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgg5ZWa5z1UgEwAAsw

On Wed, Jul 17, 2024 at 08:49:15AM +0200, Alexander Stein wrote:
> The interrupt pin of the PHY is connected to the GPIO expander, configure
> it accordingly.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

It doesn't apply to imx/dt64 branch.

Shawn


