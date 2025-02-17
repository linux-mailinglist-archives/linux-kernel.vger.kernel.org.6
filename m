Return-Path: <linux-kernel+bounces-517357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AECE6A37FA3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84ACF167E95
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2862163BC;
	Mon, 17 Feb 2025 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Sdj8FRRq"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959A381E;
	Mon, 17 Feb 2025 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787240; cv=none; b=q5sZvo8fhvOFe3J1ERS0uOQTmvSvufpxFUHRaTcVMRO2oT3dVusQSFjtr8yf8ZHTuLyUcTvZhG49tqR1U3rBG5p4Q9SNBvtQtArWorIlXIhdnDl3RPVJMWdAEMaz7M+aVsp4hua8fRc79Hy/ll3VVctdXgoeNjXyPWFye1QcTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787240; c=relaxed/simple;
	bh=DN5u6/wcRfEznxF73S7WX/T0Mt+WpV3G1I90L9pE16U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fp4Vo1vah2FPUmYptoVVCkO5t835VTYcFuE94OxfM0U+OIYZlN2pmJwFRr1FZ7w5bftL0SgfA4hMUTovJGlzJcAewm2Bo6YSZjBi3oYLVOaBIOAT4X9eVkdARGhx7TMElA+j+DVxm2R4Iq73yFuv98wlP3PdQBVFcbi8K9QQ5ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Sdj8FRRq; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=sBPLUR2UA484yxU8bopYqTzQvJ/EUqnBaEavQLKd1E8=;
	b=Sdj8FRRqJNFkYSPOMDp6sQ2Gd2AmCQ3io8JjpIXl/fTIPWf5PUJ0Z+fmbVjDE7
	z9g8yS2fSiwL35mKwequuUtW0+6YMDHpI5Got9GuayJ6SyppJiwhDZ0/Rzo+RXWC
	1tNcnJjN85GaFyqTy0t1qWSahThl3Q5f0xAAtoZHQg9Ys=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBXf7pKCbNnB58mCQ--.17719S3;
	Mon, 17 Feb 2025 18:02:52 +0800 (CST)
Date: Mon, 17 Feb 2025 18:02:50 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] arm64: dts: imx8qm-mek: add audio-codec cs42888
 and related nodes
Message-ID: <Z7MJSj2JoxT6fTIu@dragon>
References: <20241029152614.2065950-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029152614.2065950-1-Frank.Li@nxp.com>
X-CM-TRANSID:Mc8vCgBXf7pKCbNnB58mCQ--.17719S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIco7DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxr2ZWey6E2UhQAAsj

On Tue, Oct 29, 2024 at 11:26:13AM -0400, Frank Li wrote:
> Add audio-codec cs42888, enable esai0 and asrc0.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


