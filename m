Return-Path: <linux-kernel+bounces-310147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C0E967582
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 10:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F25C1F21C83
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B2D143894;
	Sun,  1 Sep 2024 08:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="WGd6Yzmm"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA58D47F5B;
	Sun,  1 Sep 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725177812; cv=none; b=Rx4lULjsWUZviX79cAzGMxyW3aMbrj4b/E6P7jSkXoMuIyzD3MZA+c3SjrXIQ4H3lzM2PyivzsXcW6WaX2Ij3f682aYwdQ1XZNGCuLnCW0OrpBTQ1vbJo8Wb9qxnz+TvdUfVvGtMzBo1gDzrxGYRRNma09qYkR18J9qm1ydsv5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725177812; c=relaxed/simple;
	bh=iAG1LEm9LOjE3hU2RrlrIZyOmu4Vs7xcnABbmpFnSzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ3TgLoRZvstWIKnlE5cpwdoypwNxufc4/dQUf8LwRyiijChKHuAZejIht4ohWiCcPVMwNz51yPXBC7rrTA/r5SFb7dOSAYEdgBJL1a+uvhGZxSVOE7G3y1VemDHtyeulyYOfwjHZrn+/L62VM7LZqiWAfl739CzyYfKSG8L1+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=WGd6Yzmm; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=tOUbzpzMDrbtrd4COkzTeyagHJLY/G2ctlXKKoR2Zn8=;
	b=WGd6YzmmoqEvPnb/nzEoWxp1IFzLq6YlsmRCrEJRrRMet49o2KtHTFGeYxzIcX
	yp5AInJzJABJTY7KDanDSXhXvcPNlDyu5Jp/YlB7yYaTPWzCmW4CFmXo8eW9z1WW
	kxJwO1E0y4BT9O+JS3pg9Hc7Rx4wB9Eu0A1Yxe556e9wk=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXv02zH9Rmh3dEAA--.21709S3;
	Sun, 01 Sep 2024 16:03:01 +0800 (CST)
Date: Sun, 1 Sep 2024 16:02:59 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] imx: MAINTAINERS: correct TQ Systems DTS patterns
Message-ID: <ZtQfs8V7VUgt0F28@dragon>
References: <20240825084946.20457-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240825084946.20457-1-krzysztof.kozlowski@linaro.org>
X-CM-TRANSID:Ms8vCgDXv02zH9Rmh3dEAA--.21709S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7oGQDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEg5NZWbUD38kCQAAsb

On Sun, Aug 25, 2024 at 10:49:46AM +0200, Krzysztof Kozlowski wrote:
> Fix file patterns for TQ systems DTS after re-organizing the ARM DTS
> structure to fix get_maintainers.pl self-tests like:
> 
>   ./MAINTAINERS:23329: warning: no file matches	F:	arch/arm/boot/dts/imx*mba*.dts*
> 
> Fixes: 724ba6751532 ("ARM: dts: Move .dts files to vendor sub-directories")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied with a bit update on subject prefix: 

  MAINTAINERS: correct TQ Systems DTS patterns

Shawn


