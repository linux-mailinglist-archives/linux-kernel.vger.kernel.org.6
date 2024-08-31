Return-Path: <linux-kernel+bounces-309919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FA49671DD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3FCDB221C7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C0C12E78;
	Sat, 31 Aug 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="nQfnJUmp"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DC0320F;
	Sat, 31 Aug 2024 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725111364; cv=none; b=sC0cCELJPuDoqZRAbXjKNIzdaP9kRG/v5fuet8fI4LHMfVv39K0w6mq9qMstpdAvAdJhzekmfAaYXQniH38t2hLr/EO2Qk+CJI02+IIN1NBWH8LCjUZ2qXPr3i2wF/z5u6CjFHVIzAIW/gG4rnmPRyaKrTmy+eYIhQrNDJAyHl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725111364; c=relaxed/simple;
	bh=nb1KlipafvKkZuX0UdkBwV2xAvHWB2eZEw8AwihytT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+riD3sRAkyQ1RsVq5BPXF+TkivaSo9UJfDPwTq2C6sUqJo6uQo9esqhOd1g37DCdYnAUOHwV+lmVQweo5ujQD3BI9l7Ozqw8wUQ4wuNeiMpuMmLoFpQcUfz5S1T7C4t388fb9ubO1VphN5FKpeNl7FSBMUqhyh72lBZmZVcLW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=nQfnJUmp; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=bXl+AVvOmYzlBrZ/FtMR0B/VSQACYgUi4M2jIPQ445s=;
	b=nQfnJUmp0UCfO2KACX/GkC8wD4IQnCU0UA7ofRIAiStkAPYVnPIWHB1QpQ4QuX
	6s2cxyTpDaXz05SPp1Cp20C9msuUxSiTlSOfJ1W2Kjk583iDA+ODX3I8f5FfnGFf
	EXrovfRTq0+LrG69UZnoDmOjuVQPOvMvbD9syZQm018IU=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3XzwQHNNm0dA7AA--.11142S3;
	Sat, 31 Aug 2024 21:35:14 +0800 (CST)
Date: Sat, 31 Aug 2024 21:35:12 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: Enable HDMI to Data Modul i.MX8M
 Plus eDM SBC
Message-ID: <ZtMcEIZn2rNLBzPm@dragon>
References: <20240818202741.95967-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240818202741.95967-1-marex@denx.de>
X-CM-TRANSID:Ms8vCgD3XzwQHNNm0dA7AA--.11142S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIq2MUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQtMZWbS-GE9EQAAs2

On Sun, Aug 18, 2024 at 10:27:10PM +0200, Marek Vasut wrote:
> Enable HDMI support on Data Modul i.MX8M Plus eDM SBC.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks!


