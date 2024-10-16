Return-Path: <linux-kernel+bounces-367464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F849A02B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C4681C24670
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3468318FC61;
	Wed, 16 Oct 2024 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="oXWgEajK"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A56192D9D;
	Wed, 16 Oct 2024 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064158; cv=none; b=gd3hCPXJPjKXtGkZs58ahiHVQyMeyQvIHAHWcpog4f4J8dYrrBEsYZPBymyBN7cArSqhVZm4ssp/pgRIDpmrcbldtLFcOoL6eCHCoVOvc48MWAbj1RSTxFfyzEHINZS0cD3/DM4ASMFoJEM/6ZY0Lxj8iANZBkuPNYGJAHvXvzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064158; c=relaxed/simple;
	bh=peEzn+UemnGQGrFRnW8uHaHTsL4IiCLH2YduloaHKcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qu1BqtR6f1NKhJla9u5xxpeAPWB5J55oviiNMjZCuZwUkFm99Z3FLsNOiJxjLB0ycCuwfW2Vbm/g6W2aJHabATK0396500WQC1dGG6kbB3nIwvDJIw99Rwe/nLFn3QfR4HK8ZcgPwPnClAdEoB5f1WTO8kFxCfJm3hCXDEQIUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=oXWgEajK; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=v4mRDPQLv4l7PaLq/uY4JvOZTz86CjEX0ox+UguQ2SI=;
	b=oXWgEajKvDX/8Gd1fmjXEzTyl9qQfOxs6MReLU5Wmr19FHwGcwubByr3a6KE2N
	4YW9UJG0ohk7frnxYd8nvFQegEbzP9339yxjMnxduwlEVM+JojYHeb29cmM68JVq
	cxnXW019AKm1qnHwRyP5oeXT0BZ7YK4idlFkAd8gPYUkw=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgA3HHiebA9nwdgYAA--.421S3;
	Wed, 16 Oct 2024 15:34:56 +0800 (CST)
Date: Wed, 16 Oct 2024 15:34:54 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] arm64: dts: colibri-imx8x: Add ad7879_ts label to
 touchscreen controller
Message-ID: <Zw9snjcbqROfsoZM@dragon>
References: <20240910152213.2072743-1-ghidoliemanuele@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910152213.2072743-1-ghidoliemanuele@gmail.com>
X-CM-TRANSID:M88vCgA3HHiebA9nwdgYAA--.421S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUa0eHDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQd6ZWcPYxQfCQAAsA

On Tue, Sep 10, 2024 at 05:22:12PM +0200, Emanuele Ghidoli wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> The device tree defines the touchscreen controller, but it cannot be
> enabled because it lacks a reference label.
> This commit adds a label to allow it to be referenced and enabled.
> 
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Applied, thanks!


