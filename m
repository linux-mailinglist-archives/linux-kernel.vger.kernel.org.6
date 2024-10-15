Return-Path: <linux-kernel+bounces-365319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4BF99E071
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 10:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8483C1F2118C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 08:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4481C3026;
	Tue, 15 Oct 2024 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="jgY0lHK5"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754D31B85DF;
	Tue, 15 Oct 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728979777; cv=none; b=tkIN4q5HwJv38eC6EJofY9YDxy7SMRLhUIZJYmkScnMDKREBlT22HvxXXnrXqAVlkZeFlBI7UQc86ZRUh5FITrGN59nR75jNqkTSbg+88XIDdNIIyuSMu8FTfIiSq+gawSg0GmwhuEwL6k1msNLYKDA6fs+AkmMbXFgkaXbkHo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728979777; c=relaxed/simple;
	bh=t3sEdcPl4t0kzq0n8YkPIMG3A22CLK1lCGNiS88mZY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kgbuf72KRXNcWY6vLJEu2l8hS1vAhrFCu00ndzfGsV+cLrizbALitRqKuKAcZfXR9FRjXYgJ/M1nD7SYl0tYg3nt1E6JLlsOxp835ujkADen690+Xhm5xjYDF1Ln3jKwlA+dDRbJsdug1WyzE6fATjUwUcmid48Mf7hJHkhfAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=jgY0lHK5; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=AcpoIiyTTEPEyHLpa+DZ5Ssn9s/ruKNgo/dm3QnpIhE=;
	b=jgY0lHK5ggXbgF9usPiF6NDaNsPwCYVy9elJeOHI8E7CTPDpZsarEH97I1nV1C
	VNu6rIzPDyERMrdERq4Rko+RvDJ6dC36Ut/Rp6eWHCfj7tV2DOO7zWuMnmoy/d4H
	jJeG184WBAO/CWWpCt9rz44zlEPhw+TZDFAh7LbxBP5ls=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDHTxj_Ig5ncaIDAA--.6203S3;
	Tue, 15 Oct 2024 16:08:33 +0800 (CST)
Date: Tue, 15 Oct 2024 16:08:31 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] arm64: dts: imx8-apalis: Various improvements and
 additions
Message-ID: <Zw4i/670z7QLBcM1@dragon>
References: <20240903091231.20035-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240903091231.20035-1-francesco@dolcini.it>
X-CM-TRANSID:Ms8vCgDHTxj_Ig5ncaIDAA--.6203S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr1DXF47Ar1xWr4fJF4rAFb_yoWfurb_ur
	yFgF18uw48KFWfJws0qFnI9rW7Ww15CryFqryIgwn3X3s7ZFy5AF4ku34fZa1xKFWFkr4D
	A3Z0g392qwn8WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0tl1DUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAhF5ZWcOEpU4vgAAsn

On Tue, Sep 03, 2024 at 11:12:26AM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This series improves Toradex Apalis iMX8Q support adding:
>  - correct thermal zones
>  - analogue audio
>  - USB Host (Apalis USBH4 interface)
> 
> In addition to these it also removes the adma_pwm from the i.MX8QM SoC dtsi, as
> this IP is not available on this specific SoC.
> 
> v2:
>  - Keep I2C nodes sorted by address
> 
> v1: https://lore.kernel.org/all/20240826221541.15669-1-francesco@dolcini.it/
> 
> Andrejs Cainikovs (2):
>   arm: dts: imx8qm: Remove adma pwm

arm64: dts: ...

Fixed it up and applied the series.

Shawn

>   arm64: dts: imx8-apalis: Set thermal thresholds
> 
> Hiago De Franco (1):
>   arm64: dts: imx8-apalis: Add nau8822 audio-codec to apalis eval v1.2
> 
> João Paulo Gonçalves (2):
>   arm64: dts: imx8-apalis: Add audio support
>   arm64: dts: imx8-apalis: Add usb4 host support


