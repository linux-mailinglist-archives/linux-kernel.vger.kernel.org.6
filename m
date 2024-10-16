Return-Path: <linux-kernel+bounces-367630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313879A04AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E694E28372C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29BB1D8DF8;
	Wed, 16 Oct 2024 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="J3N3M59F"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334AF202F63;
	Wed, 16 Oct 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729068639; cv=none; b=GMdce7JdnH8YXB/1/c6w4UHL+3PSAVoyweUr0ADqlRrjvva93axTAuegqN5DZQtau0ZLYHFJ5F6C0xRc9wdpaTTlpn9mGwbrrG7LYskwuaoogppiDm2dy/c4q721PSKrvIRtRTNCIAriA/Zb4sVYDOWfHSkjY0fa6C0CcKeaaXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729068639; c=relaxed/simple;
	bh=LtVByiWSZtHR8mgWIuhwk6J8AyO9HCJMjno04GmKUF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7fpV+zTIrr2l5nGVHQ8eHo/iMlu4myx9zmX8kRP5jWes//VRcP71fRmrewT6hwIh8icxbuJNPevgwpOp3bJQRhPEhAua74zgOqpYDiqBzHJmOWcXYfk7u3yFOjy77XaQRP6Uneq9JmBEG63NBDKuSOUhd5Y+ERCZ+HAbPv5MwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=J3N3M59F; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Po78hYeDV+J0PQFG2Fu9nvFQPh5C5GSX/UuSGg42/T0=;
	b=J3N3M59Fe0DM4EM7PCLZ9tvp8SzuUw7q87nZZKGo14mn6DN1n9EM6P1di3uOSO
	tflcMGxERAAWu2bfb1qEuNbPLfgj2q2KPlBNuFuBNhmdMHoC9CzCFaPAJoOjZP+E
	053Pqy8tTIf5dEwZRDTxzfeMwvNLLlgRz1syQuZRm1OTw=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgCXWNwqfg9nJTkaAA--.410S3;
	Wed, 16 Oct 2024 16:49:47 +0800 (CST)
Date: Wed, 16 Oct 2024 16:49:45 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: dts: nxp: imx6ul*: add uart dma support
Message-ID: <Zw9+KYSP69O9Hgb3@dragon>
References: <20240918-imx6ul-sdma-v1-0-d25abd56e65c@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918-imx6ul-sdma-v1-0-d25abd56e65c@geanix.com>
X-CM-TRANSID:Mc8vCgCXWNwqfg9nJTkaAA--.410S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVvedUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxB6ZWcPLTjrhwABsU

On Wed, Sep 18, 2024 at 02:07:41PM +0200, Sean Nyekjaer wrote:
> Sean Nyekjaer (2):
>       ARM: dts: nxp: imx6ul: add dma support for all uarts
>       ARM: dts: nxp: imx6ull: add dma support for uart8

Applied both, thanks!


