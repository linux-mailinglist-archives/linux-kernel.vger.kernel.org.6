Return-Path: <linux-kernel+bounces-231957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A1A91A0D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 09:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9E7B2131C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB076D1B9;
	Thu, 27 Jun 2024 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="neT7Oelm"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDAA288BD;
	Thu, 27 Jun 2024 07:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719474703; cv=none; b=get+k3vCvVx4xghfIKSFPz4oil1Vz2dYhO/5R2HII2RlP1ipEz5wuOPOUuWZKAtA85qpJHG9p6AiDl2tvQONf/PsIQgP9a1c/Jup+ursaf4zu+Ak4pqoixSnuqRHX4Qeiio3Vt9vOFIv3D82XAXGr+5xGlZq/wt7GgTzmO/zU2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719474703; c=relaxed/simple;
	bh=RV9E31PmeduVVuCzHwiX/NDQPw9AVEV7Axw8llMtRAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQKX5jWP2CnJnPlhRDFm1e9lpfuJEkHlk+b9eym+oueOGwhfh2Y7HXdK5UHphq8Or7HZ5v0W8WprZcmt1M7DtU2mKnMpyE+0JChCVpb71xZ5vcKxki2SBRBOt6GDhKScWA05Un6QKadTTzOaDsPR682VjPs0CB0TelJ59M9+/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=neT7Oelm; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=0evzdLmi7y9qBXDsgNLFrAiLidaqqqkYyTE6ToeNOvc=;
	b=neT7OelmYL2z5GFCm9IBqZ7t1R2jYUuigABaNOYL+gp6MKAN9YcnWLfKApZUfV
	jLa6nc70E1G9l5lSelguhAmwQtHPiv58WwApdzShGhFBp0MnFjTu2DsiP3slLzVb
	iAfk/o5a+bUxrW4VbQEI4a+L0AQDilTyY3vv+fvDzHWy0=
Received: from dragon (unknown [114.218.218.47])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3HxDGGX1mX7IZAA--.51889S3;
	Thu, 27 Jun 2024 15:50:32 +0800 (CST)
Date: Thu, 27 Jun 2024 15:50:30 +0800
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
Subject: Re: [PATCH] arm64: dts: imx8mm-venice-gw700x: add support for PHY
 LED's
Message-ID: <Zn0Zxn9YIZ9aufbu@dragon>
References: <20240618200253.1738876-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618200253.1738876-1-tharvey@gateworks.com>
X-CM-TRANSID:M88vCgD3HxDGGX1mX7IZAA--.51889S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIku4UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAggLZWZv-czU4AAAso

On Tue, Jun 18, 2024 at 01:02:54PM -0700, Tim Harvey wrote:
> The GW700x SoM has an onboard DP83867 RGMII GbE PHY that drives two
> LED's (LED1 and LED2, skipping LED0). Add the appropriate dt bindings to
> allow these PHY LED's to be controlled via a netdev trigger.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!


