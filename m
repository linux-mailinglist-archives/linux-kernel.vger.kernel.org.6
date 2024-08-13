Return-Path: <linux-kernel+bounces-284032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0835794FC35
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 05:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAF341F22878
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1054A1BC40;
	Tue, 13 Aug 2024 03:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="hDqSFEll"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8A61CD0C;
	Tue, 13 Aug 2024 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723519599; cv=none; b=T2/LCwx6XHgYM40K95yOTifD2WZV2o9lH8Y59XccR0nKvJCyHLShLJtkpjG8VgIvPXY6+3w0b39FZ0WiZZ2ypy6bzYzAo0aPgszispBkVfx8D3asqdgj4ZWmJvMbbN9Zt5/tnTQs+0OI+/NTaI+1DqJ1SqL9DtnjTi8STcKgU/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723519599; c=relaxed/simple;
	bh=8OZnmatZD9Nj9foT1hom4sw7MtYQYVDycCJi6wUTz6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQv5l2YlGR+tZbnUdUDOXid0Lz48+bsNJhIWS69K3/REMrmuR1she0RztryvT6u+9FznG0KAsrpQoanxHfsnjnJnm3yz1uMTDpVDYEd4w1ahIZBaHBA04Q3/7ZA0bo8ZsfwQM/c5wSyUCG5C5ujAy7Uo1vl+pseZpGaZcZMJqU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=hDqSFEll; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=4wTCOXPSBkKwXbRPZblUxq9M6e+9zEMhPw7rDWYENsI=;
	b=hDqSFEllOHgtpicT6nIpgr97cQbuguVi9EwoS4B0Hao6Wd5VZMkIjbT4W7rRKl
	TCOgom26lpbyxhMgebPMar9nt1wJyuvvf2C5q0js84GvwnLQXSubYvcU0oR/u3Dk
	4Wci3PcNPs4MWfY2ye9U4LYK0U3BHlVx3hHkm/wELVOhQ=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnrY9C0rpmv01fAg--.38173S3;
	Tue, 13 Aug 2024 11:25:56 +0800 (CST)
Date: Tue, 13 Aug 2024 11:25:54 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Marcel Ziswiler <marcel.ziswiler@toradex.com>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>
Subject: Re: [PATCH] arm64: dts: imx8mp-verdin: drop limit to sdio wi-fi
 frequency to 100 mhz
Message-ID: <ZrrSQtvQr+etX8FO@dragon>
References: <20240805174814.1944742-1-jpaulo.silvagoncalves@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240805174814.1944742-1-jpaulo.silvagoncalves@gmail.com>
X-CM-TRANSID:Ms8vCgDnrY9C0rpmv01fAg--.38173S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxG-eUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCQA6ZWa6wcdGkAAAsa

On Mon, Aug 05, 2024 at 02:48:14PM -0300, João Paulo Gonçalves wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> SDIO frequency was limited to workaround some instabilities, however it
> turned out that the instability had nothing to do with the speed but was
> because of an issue with the USDHC IP that was fixed in
> commit 52e4c32baed2 ("mmc: sdhci-esdhc-imx: only enable DAT[0] and CMD line
> auto tuning for SDIO device").
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>

Applied, thanks!


