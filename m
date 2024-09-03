Return-Path: <linux-kernel+bounces-312288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66603969486
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C1D2844AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435A21D6DA4;
	Tue,  3 Sep 2024 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bsPXzS05"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DD41D6C70;
	Tue,  3 Sep 2024 07:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346919; cv=none; b=nuyC+Wr/yrwjs9sEoDDqcR85QrOZR3xDaRppFjeSg2xhr7FnqC7vLaYB9N1wcrPCIUeOoAplR/LoNTECAn2G5lUq2cqKMcSHcCzPiVoKYCu7b/UcxUqBm3KzaMWgTEXeJKHNLIM4Ps5vgi/X4weBo/dETrvVXBk9ZXHW0/YECmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346919; c=relaxed/simple;
	bh=dd6z6/fX03r7I+OK4sAZBXXYh2KrMVhFOm2k/Xs2Xck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTnvQay+9ivq0G6NoLZwuGPtjN8q3BW3m6tsYIrZsuk3Qe8hgPeuurRX2AUdzSkNLlRFLZsCA8OQK0FsBTefk5turGxt4tAFjkthTsvgpsRDOpB61pQSqPlCiAp+aYMsCoXga2B0MF+TY4lVr1r7QTq7JclfDPwa9O8IcxLVaH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bsPXzS05; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=EMLbiGBpUuXGNz3rk2Y/NL4U1KPEBS6Vzb4O8xiWm20=;
	b=bsPXzS05MZXmnKZRLHt1am/Tf1Lt6S6u6Fi3HVbacCc1CtVVZG0b7jGvmLxQEx
	gLHCmDb2YLLh3qsne2bnYaPRmmXOxsjjlCSOe7Odm5CfcrdNpJpWzaJegTWCXUg7
	Cgy4DGS77ndqsSx4IE0c+TCrfLHij0yiW46qrWXQAMxEc=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3X_8ctNZmsEBaAA--.108S3;
	Tue, 03 Sep 2024 15:00:46 +0800 (CST)
Date: Tue, 3 Sep 2024 15:00:44 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] ARM: dts: nxp: imx: mnor pinctrl node improvements
Message-ID: <Zta0HBK1N/Yco9FY@dragon>
References: <20240902-dts-nxp-imx6-pinctrl-v2-0-ab8196baa07a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902-dts-nxp-imx6-pinctrl-v2-0-ab8196baa07a@linaro.org>
X-CM-TRANSID:M88vCgD3X_8ctNZmsEBaAA--.108S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-M5dDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRpPZWbWeZS49wABsq

On Mon, Sep 02, 2024 at 01:40:36PM +0200, Krzysztof Kozlowski wrote:
> Changes in v2:
> - Fix "grpgrp" -> "grp"
> - Link to v1: https://lore.kernel.org/r/20240831-dts-nxp-imx6-pinctrl-v1-0-f5811032bd40@linaro.org
> 
> Align the pinctrl node names with the bindings.
> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (4):
>       ARM: dts: imx6ul-tx6ul: drop empty pinctrl placeholder
>       ARM: dts: imx6ul: align pin config nodes with bindings
>       ARM: dts: imx6sl: align pin config nodes with bindings
>       ARM: dts: imx6qdl: align pin config nodes with bindings

Applied all, thanks!


