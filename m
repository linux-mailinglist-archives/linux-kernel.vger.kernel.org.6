Return-Path: <linux-kernel+bounces-231922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AC391A063
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A321F21BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376324DA0C;
	Thu, 27 Jun 2024 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="BaHhItfP"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3BD4D11D;
	Thu, 27 Jun 2024 07:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719473196; cv=none; b=uzhh8DLBWd6vzTNcwaDB+KE8L6L9NymLsrunIZfhKmqHLnj2nLXU6EkmwdEjRpT3q8KId9Vs+u/ydrLsCcoSFgIC79CaFb/kc6cCFRIRTdYJfd/yqLbwBW0p+yFfOUyTlMUOJumvPRiqncxCdQ3LQ+Xly7rWopUt3XyvL9sKj+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719473196; c=relaxed/simple;
	bh=k19oMRwYZixgIkDPdeaKHx3aHREHfP+8oM5zi7YlyiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s64xn9Fk4NGQPPQPIlHcLs/9qbRyOTXZBL6Fvx6OWVbHIMdrme2cX03sT/qApaEdY7X3oAk8pI45D/L90yuQxLC7eThXgRWG6iUptbi7nfX7Hy6zNa4rgpJ1Tlx/iAdpZIeWcojaTYRT5prbR9zTSis295hPOYniASK74Ii/+To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=BaHhItfP; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=yfnR4f5J5qrRmd7Y0VQuklEvzqrooKhNJa00ntjIhf8=;
	b=BaHhItfP4Cr8SUBN99K9wfKLESjUGYrMnhQfVViWjvezo7ka93dAz/T/COdN9S
	snaFx2l78q5n1ITgFa1jokmGNwEYcJbILHiuBN8OQl+JSZjTn3LXi8+PP31qfNx8
	dgjtItaWxazH6tAn/OAnjNT4CtsylVenItld7Q8AGVxAE=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3X8gFFH1m8I0aAA--.52410S3;
	Thu, 27 Jun 2024 15:25:59 +0800 (CST)
Date: Thu, 27 Jun 2024 15:25:57 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Michael Walle <mwalle@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>, Li Yang <leoyang.li@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Priit Laes <plaes@plaes.org>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/13] ARM: dts: kontron-samx6i: various fixes
Message-ID: <Zn0UBS9vx8bJ+6Kc@dragon>
References: <20240617091341.2375325-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617091341.2375325-1-mwalle@kernel.org>
X-CM-TRANSID:Ms8vCgD3X8gFFH1m8I0aAA--.52410S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw1xAw1UuFykWFy5uF4fGrg_yoW8GFW7pr
	97WrZ2yF1v9w4ftryqqF9FyayYyw4DAr9rtw1DJasFv3y3Zr17ArZIgws8XFyxZFn5ZrsI
	q3y7urnYy34rCr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jz1v3UUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCQcLZWZv-cxcAQAAsF

On Mon, Jun 17, 2024 at 11:13:28AM +0200, Michael Walle wrote:
> While working on a new PHY support for this board I've noticed quite
> a few errors. Fix these and introduce an actual board for the
> module. For now, there was just a dtsi and no actual user of it.
> 
> v3:
>  - fix typos and property order. Thanks Shawn.
> 
> v2:
>  - new patch to fix the node names to make the schema happy
>  - new patch to fix the PCIe reset line polarity
>  - new patch to remove the unused and invalid wake-up-gpio property
>  - add required poperties for the supply voltages to the wm8904 node
>  - enable PCIe in the ADS2 device tree include
> 
> Michael Walle (13):
>   ARM: dts: imx6qdl-kontron-samx6i: fix phy-mode
>   ARM: dts: imx6qdl-kontron-samx6i: fix PHY reset
>   ARM: dts: imx6qdl-kontron-samx6i: fix board reset
>   ARM: dts: imx6qdl-kontron-samx6i: cleanup the PMIC node
>   ARM: dts: imx6qdl-kontron-samx6i: fix SPI0 chip selects
>   ARM: dts: imx6qdl-kontron-samx6i: fix product name
>   ARM: dts: imx6qdl-kontron-samx6i: always enable eMMC
>   ARM: dts: imx6qdl-kontron-samx6i: add SDIO_PWR_EN support
>   ARM: dts: imx6qdl-kontron-samx6i: fix node names
>   ARM: dts: imx6qdl-kontron-samx6i: fix PCIe reset polarity
>   ARM: dts: imx6qdl-kontron-samx6i: remove wake-up-gpio property
>   dt-bindings: arm: fsl: document Kontron SMARC-sAMX6i boards
>   ARM: dts: imx6qdl-kontron-samx6i: add actual device trees

Applied all, thanks!


