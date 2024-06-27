Return-Path: <linux-kernel+bounces-231960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFA791A0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67AE1B22986
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80827641E;
	Thu, 27 Jun 2024 07:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="e9L6GaKk"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B66D1A8;
	Thu, 27 Jun 2024 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474738; cv=none; b=GCEhPwIEt9JcteoG6pekRDelu4tNYe0hgT+/BWd3yNI9kF86BDBjIh9JjB6+lnW0Xj2d8VzomYvSzIsGDaMdcc1R9ZWmN/aTAuwOWXIh7+rKah6ZFGIp89pKVMNVPac5c2VBo/ubKyLtitDIH3yzAunzMYNU8i4sk4uavf2jhOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474738; c=relaxed/simple;
	bh=PNvkEYWCL5PovGD0P2qF3krIDcXGXZcIfYxxUFEFQTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrhdroNsHCEBWYxstyU7DmMyo0kGSniDYEdIzY+lwMGqHKYUHxf3JxsO1kntFgUBI02ibXLeq23IL+gOiOSHQXYdvQYAQmQm743TKkDCxTwnFHu0kvxZksU1LjAN494fP0/sCrysOPgSPrdGF/cxSVcTGHCSK7KE+qMLMM8eBck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=e9L6GaKk; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=dwSrd4rEFtEbvg8UIqDAYpLCFNz8AxorAioAjY9AB2U=;
	b=e9L6GaKk0FJRkRWTlFa2/kLOeWBiVXXeniM8D6BAmaQdgOHFPbJFrHFniw4ML9
	g8BTNs24OyHmuWfMUFM1YarqzxfOSCjtVjx/ABtJQBDF/MLeT68VrJWSyfVfVzjW
	IYqUaycrcskp6PzpuiZ4buTt4GOUduudk+I9eKjuWTSmM=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3v5nXGX1mma0aAA--.27519S3;
	Thu, 27 Jun 2024 15:50:49 +0800 (CST)
Date: Thu, 27 Jun 2024 15:50:47 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp-venice-gw702x: add support for PHY
 LED's
Message-ID: <Zn0Z1/LULtTmF4/t@dragon>
References: <20240618200551.1740178-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618200551.1740178-1-tharvey@gateworks.com>
X-CM-TRANSID:Ms8vCgD3v5nXGX1mma0aAA--.27519S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUV9mRUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRkLZWZv-cxxIAAAsX

On Tue, Jun 18, 2024 at 01:05:52PM -0700, Tim Harvey wrote:
> The GW702x SoM has an onboard DP83867 RGMII GbE PHY that drives two
> LED's (LED1 and LED2, skipping LED0). Add the appropriate dt bindings to
> allow these PHY LED's to be controlled via a netdev trigger.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!


