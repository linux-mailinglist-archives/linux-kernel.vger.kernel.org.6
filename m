Return-Path: <linux-kernel+bounces-369492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082A59A1DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D4A1F23673
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7241D1D88C7;
	Thu, 17 Oct 2024 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="bWPSRdcm"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64075CB8;
	Thu, 17 Oct 2024 09:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729156578; cv=none; b=OAg47tSQW0HQ0UBugcjM/HlyZte63ejG7cd81VFTEbFdbEVdi2LU9LTsQkBAGEbbdTO67C6VOB/ktXVPsqDOXfIUkES8YkUexn2YLPTrsqz3Wle/09wW2qK+KfUsPufSW/6puoNG7rpN6Ws+xuZvJ8LHKdHbbiYOSJSZtIZ8SFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729156578; c=relaxed/simple;
	bh=JWabqzFfdfHDY5VXB1QNVz3uYR9IzYBLiOTvssAvKoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nqsqvo0wwtxCbtL5z17ORNS8P/Abe5yXopUj2J+GHHpnmDzRcPQMn0DiKevMeDuaU4Sd5WvGjynIEF0MgD32M/6V+pvPfE6dzXiUVz+yME2emTfBjlz4fXGpTsklAc+/heb8MrTdo4q8vnbvzOuaBjjGbLhW6v7KS2wzTOImEUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=bWPSRdcm; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=8+YKKCmfji2YTt+NeUXJzgiQgBkMcY806Vacbq8VGt8=;
	b=bWPSRdcmg/lB2bXoMntFK0KLofvk1KjTyfmMCdCKKcikJhDTZbOxnvVhhTmxU2
	YujQzaWPPEtEmVR/HcUg8/1jRkhysHiL0nPI1QuI0odBubnXzNB+0R+q8mURppWP
	pHQEEP2zLz9qzj9Rx2OAag8maqKScUzbvfzW/gcmzt88A=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgBnu+Wm1RBnkL8wAA--.1316S3;
	Thu, 17 Oct 2024 17:15:19 +0800 (CST)
Date: Thu, 17 Oct 2024 17:15:17 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/3] arm64: dts: freescale: imx8mm-verdin: Add Ivy
 carrier board
Message-ID: <ZxDVpbynwzKgNQtF@dragon>
References: <20240924113048.125761-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240924113048.125761-1-francesco@dolcini.it>
X-CM-TRANSID:Ms8vCgBnu+Wm1RBnkL8wAA--.1316S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFW5Kw4rAr13Ar48CFyrCrg_yoW3ArX_uF
	WxKr10gr4DKrnrtws8Ka17Xw4vk3yFyr1Fq34vgrn3XF9xZa98AanrKryrXFnIg3Z0qF93
	J3WfKrZ3trWYkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0tl1DUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBA97ZWcQ0T0OSAAAsI

On Tue, Sep 24, 2024 at 01:30:45PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add support for the Toradex Verdin iMX8MM Ivy carrier board. Ivy is a carrier
> board designed for industrial environments, supporting industrial
> I/O interfaces such as CAN, RS485, RS232, Gigabit Ethernet, 0-25mA analog
> inputs, relays, PCIe and more. The board also includes a TPM for security
> applications.
> 
> https://www.toradex.com/products/carrier-board/ivy-carrier-board
> 
> João Paulo Gonçalves (3):
>   dt-bindings: arm: freescale: Add verdin imx8mm ivy board
>   arm64: dts: freescale: imx8mm-verdin: add label to som adc node
>   arm64: dts: freescale: imx8mm-verdin: Add Ivy carrier board

Applied all, thanks!


