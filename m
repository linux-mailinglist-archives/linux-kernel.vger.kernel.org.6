Return-Path: <linux-kernel+bounces-310050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86683967424
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 03:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7231C20ED1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 01:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3264821350;
	Sun,  1 Sep 2024 01:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="nVqYlVrc"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBB61859;
	Sun,  1 Sep 2024 01:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725153491; cv=none; b=hvJxC0lb7Og+ByuUeKLzCYfTcbhdkkEoKespDaffgFSdu00xbqeMP5kE/L7BT2RxoNGFTPN4FeX/LwGFTr05ZpPRvbNQSQ1KJYAATU6dj47+DctTcVTsgFGTXGZBfBhtp56YKbFuuKHzwJWSz6ze3yhycrdGbU6ikWSkhhT6RAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725153491; c=relaxed/simple;
	bh=7/pXSxW79joSiseYS8HmEM3FxeRV8+V7Nez80v4KWYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmGA9uvJycSn9j7bW0YTvua1qnNxcCZPnjM2PB5gbCmbdc3kWrDWP7uIkni4ZmB4aqULjH2PM99SkfnzeBvCzw2C6lNO68EuKMLp4yNs1GbaMHfLvPD7qdVed05+GGB/n1EZjA7yxt+Ekx3Ip5l4n90bjEaA++u4YdoTneE2lCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=nVqYlVrc; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Lzfe1+irGYJwXkhyIj4LhNfAhozYETplmmOeOoVgFxE=;
	b=nVqYlVrcgfW1Vyjm0RUub9Am6eCshi/K4kyNaTeUIBMttlL4ag85ujqZIXykR4
	ZjZ7MCU7NEcHKypFckWEtPyNJRHYZMqp/R4RCG0vejh/nABJ7BJKJXZ17wfH9KI9
	P4V08ZvQ3Wde2xUvGamoeJe8V4589iNqu6vDbZXGHaTh8=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXPzxzwNNmSFFBAA--.17452S3;
	Sun, 01 Sep 2024 09:16:37 +0800 (CST)
Date: Sun, 1 Sep 2024 09:16:35 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Elinor Montmasson <elinor.montmasson@savoirfairelinux.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v7 0/2] ASoC: fsl-asoc-card: add S/PDIF controller support
Message-ID: <ZtPAc1iyGOKJtnNw@dragon>
References: <20240820112827.126380-1-elinor.montmasson@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820112827.126380-1-elinor.montmasson@savoirfairelinux.com>
X-CM-TRANSID:Ms8vCgDXPzxzwNNmSFFBAA--.17452S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVTKZDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAg9NZWbTjjJY3QAAsp

On Tue, Aug 20, 2024 at 01:28:25PM +0200, Elinor Montmasson wrote:
> Elinor Montmasson (2):
>   arm64: dts: imx8m: update spdif sound card node properties
>   ARM: dts: imx6: update spdif sound card node properties

Applied both, thanks!


