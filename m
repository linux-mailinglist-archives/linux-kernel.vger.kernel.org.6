Return-Path: <linux-kernel+bounces-555378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A740A5B6A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB413AAE2A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 02:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5381E3DFA;
	Tue, 11 Mar 2025 02:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ip1G6nMb"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4133B1EF01;
	Tue, 11 Mar 2025 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741659796; cv=none; b=T7Cl/AkMc8ks4X5sgSGY3umuUVW5ewTth4hxqOL+NaYC1ynLhOdqkOirNMt62rW7NL6A3NPrYqMC0GXg4v7aeoVgSluQc7EIGTe4U3xr1DDeFsd68zlLUt4+w1A8sKWq+SnDiuuO2u3seaVdV7knUSPBqeyrrRjY2AZdZ4Ydrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741659796; c=relaxed/simple;
	bh=FwDXJPajxYapMkrEHeU4zgpIrMKAAFr1prC0HvmXJa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9OB5ljy0OkEXMAs3w8QI7BLHGby0YYZaBlSDhjyFhzh2KXn+sz50sIPmE/0Ww9Sl2LyocFz0b/PMTdwwzrH6o/2s00jW6RFyZhXGnFLgZt9RBG2N8Abig9sQXymm8678wxK6Br4ZcdFp+gfU4ogU30fSAVHo6t87Ieb4ECLUBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ip1G6nMb; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=SH7i3hEBunXl56kGHk5HmVNJ3ShdY5ZTb+FytLjyRoY=;
	b=ip1G6nMbetQfy4n7AFrG5+zjHYqZOIHmTr3npDbaScpW1iyI9Rne44mmrPIlld
	DHRemHeIcXi/ub2gwMyzlN1zfjIc2AAQ6EObqg08WoVAWD6C6890Mm2R5YFMng2C
	xTrmstW6UnVyxH4LaGLe/xYwkKclUflqVQDUlzrAqdYNA=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDHMiJwns9n3Eq0AA--.48756S3;
	Tue, 11 Mar 2025 10:22:41 +0800 (CST)
Date: Tue, 11 Mar 2025 10:22:39 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 0/4] arm64: dts: add imx95_15x15_evk boards support
Message-ID: <Z8+eb5HNX/FQPg5P@dragon>
References: <20250221-imx95_15x15-v4-0-385ee8e03dfd@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221-imx95_15x15-v4-0-385ee8e03dfd@nxp.com>
X-CM-TRANSID:Ms8vCgDHMiJwns9n3Eq0AA--.48756S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVpVbDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEQQNZWfPU+rdgwAAsy

On Fri, Feb 21, 2025 at 04:15:56PM -0500, Frank Li wrote:
> Frank Li (4):
>       dt-bindings: arm: fsl: add i.MX95 15x15 EVK board
>       arm64: dts: imx95: Add #io-channel-cells = <1> for adc node
>       arm64: dts: imx95: Add i3c1 and i3c2
>       arm64: dts: imx95: Add imx95-15x15-evk support

Applied all, thanks!


