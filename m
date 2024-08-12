Return-Path: <linux-kernel+bounces-283003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC41E94EBBB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADB22827C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 11:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8971B175D26;
	Mon, 12 Aug 2024 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="CtMSXft8"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC5F175D2B;
	Mon, 12 Aug 2024 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461752; cv=none; b=qY36+adKehOqwX/o3+Ek4HF+oG1yS93xvzzXfqrXDNBXG1Tnv9doVmJUjnPbqy9Jnb5A8pT8TNmzQXNz0kHlxR3jvZsXFq9WnSW8Nt+YLfSmUesb00NiCZXoBvTwP98LBPOW53Rs3XCUzjicGPNmKTrEp2/Qq9DL8wfRF0lGN+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461752; c=relaxed/simple;
	bh=4jaakDxvIcnXFdfZmyP2wnGK9yJak9z4Mq7GMeP72ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPZ9wOZnRBr62f06gV1rBQ/CGysaBJFHWRGl3/pm0x5ocz4X5CIr+QaZnyYdH5xBdERXgBFt5kkjnBcLGsQlJaLa1mKjHET2jLleleGkcgBkpvo2KTUIgvFv0gFTcpAmOX+0UG6qBlvZ1lAq4UIpARC0dlWtz3/mpCFLj4Mncjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=CtMSXft8; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=7GykEmBrAEkBeuYpBhyNWSRhlT7wFBCLIkHl5OolLTE=;
	b=CtMSXft8EokDC1cgHrt7nCWEMiT1Y6OSbt5/EYD3pTsPF1WtBhiuxHaOM6jWeZ
	aWf8UINqVpf3rYvukrq+rZEOoxmVIoSFFq4OeApNfeQ4Jstk9lCREZC6Dvb7Vmth
	eXeGlBnGky/UbrxglL24bgsSonby+ghsr1YdEfeXjeh+Q=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp3 (Coremail) with SMTP id M88vCgBHTrhJ8LlmglcQAg--.62044S3;
	Mon, 12 Aug 2024 19:21:46 +0800 (CST)
Date: Mon, 12 Aug 2024 19:21:44 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8-ss-dma: add #address-cells and
 #size-cells to LPI2C nodes
Message-ID: <ZrnwSG3CSQYey1jS@dragon>
References: <20240717135027.4116101-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717135027.4116101-1-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:M88vCgBHTrhJ8LlmglcQAg--.62044S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVLZ2DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiER45ZWa5790BIQAAse

On Wed, Jul 17, 2024 at 03:50:25PM +0200, Alexander Stein wrote:
> These properties are required by i2c-controller.yaml bindings.
> Add them on SoC level, rather than on board level.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied both, thanks!


