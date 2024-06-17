Return-Path: <linux-kernel+bounces-216654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305D390A2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFE111F2197B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB28C179665;
	Mon, 17 Jun 2024 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="OG3+Oopv"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C8E10A24;
	Mon, 17 Jun 2024 03:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718593285; cv=none; b=f7hxSN6HphoMgfSi4WX3TYt4eAuGGxoExPYMWc47pX/s+kTGFD/R0oviaxXhxs49LEjytC63gHmbUL70kSEWuVMUbiGD/f62n7kf6vw6scIT1VeoZHItY6aOhiO562DlVULd4Zt3BcASlGcoqllYyJm4HfDdMzM/3mguSAsfBFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718593285; c=relaxed/simple;
	bh=FfB7LZT6eKL1+i0+GK4vbUTf3Gkh+hb+wMYH8QTNqdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uu9D98HzPQcRcasX/zbhimytVDyJz1ubsBBnWLPRpszdrEjzRHP6FKcjN4bJ8sBXUb+GPaXj8t9DLFFDpsD6i+0KIDd4rzorH5wmw/34ja9kYZEWEBETyB0PEDXevTfpIoKb4okZUxDDpiyM2jKHzTYLnZKDIW98etmwA05VCzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=OG3+Oopv; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=eby4XkKKxODZ1wXdg8ChTQaLUDD8vGH6k5TlGqO4Pik=;
	b=OG3+OopvKtZx65RjRpg1jb3EJcBaYa5K9SbeL2b/ohIevoQIpP8prCNLtDEPfn
	ECLmXraPFxulKJyWuFR96dIeYg9/8kAGJU9llyrwJy9LI92i/zXbW1awRlAoyA3Z
	3jb0HaRQ4LkO/fGYOEEdagHD+xN/ccyMdT4wu9STTfVSI=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrADnDyDdpm9mQLgMCA--.59953S3;
	Mon, 17 Jun 2024 11:00:47 +0800 (CST)
Date: Mon, 17 Jun 2024 11:00:45 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Peng Fan <peng.fan@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 0/3] arm64: dts: add i.MX95 and EVK board
Message-ID: <Zm+m3fO5L4pVnXG/@dragon>
References: <20240617-imx95-dts-v3-v7-0-488b52e10862@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617-imx95-dts-v3-v7-0-488b52e10862@nxp.com>
X-CM-TRANSID:ClUQrADnDyDdpm9mQLgMCA--.59953S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUV8u4UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDR8BZVszXmPkSQAAsO

On Mon, Jun 17, 2024 at 10:56:34AM +0800, Peng Fan (OSS) wrote:
> Peng Fan (3):
>       dt-bindings: arm: fsl: add i.MX95 19x19 EVK board
>       arm64: dts: freescale: add i.MX95 basic dtsi
>       arm64: dts: freescale: add i.MX95 19x19 EVK minimal board dts

Applied all, thanks!


