Return-Path: <linux-kernel+bounces-375417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362B89A95A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC8B91F22175
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E706412C81F;
	Tue, 22 Oct 2024 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="eol339eT"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DCB38384;
	Tue, 22 Oct 2024 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729561683; cv=none; b=P4Rgpc+Fnes7D2mGJLQGPqGn81JYQnJN+16Jrki6ZoIECZfs7v5XLmPQ45UminQ6ltd6HFJxjcFQI3UZqQyYhoViAR611kvBinOwfGkJKRl8VL/9S9mrUsh0VdUF0hKS0wJ0li63tkt0ysz6b7xARRZpJt0SRyc36mGEhnwUTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729561683; c=relaxed/simple;
	bh=hqYD/CBNsaLsrn8FBvCiBFGdvxlp3H8BJorx44bx5xU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYvi8DrMhFnXqdvIeezZfkIdrr467xGX253jEfJi/ItZswJZkCCfqpj3G8V5g0PX227wndJvlSdpJZCKrGM7VLavR1NxAiXZW2W6yDhYsxSNaJlGHeB5p2DkkH3OuQGlVbpnPf9+KYW/Moun1gFmrZOvUhRTZAg1+9JmYgdNlhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=eol339eT; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=eWBEveVJM0G1RyM83TGGBhWjSPPu5+wqEZFI9XnVW1Q=;
	b=eol339eTJt+loXgGdojJkVLcrpCrYmvbxfw8lfFRrttEejnU1HKsht0B+Gfr4T
	rfbj9cr/5vRhoAL15QRVv3E53VTHvzk6nQ8xA0E3E53eBk51u94sY4eLIJNCnl8B
	ijVJ5BgUHhmKlbKSRFz82z6qJBqeYumEztB9zxiocIYDs=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgCX3XwlBBdnaAaSAA--.5191S3;
	Tue, 22 Oct 2024 09:47:18 +0800 (CST)
Date: Tue, 22 Oct 2024 09:47:16 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6qdl-dhcom-pdk2: Fill in missing panel
 power-supply
Message-ID: <ZxcEJIZVdMSxbx27@dragon>
References: <20241015232509.101206-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015232509.101206-1-marex@denx.de>
X-CM-TRANSID:M88vCgCX3XwlBBdnaAaSAA--.5191S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3mhFUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgaAZWcW3kZhjwAAsm

On Wed, Oct 16, 2024 at 01:24:51AM +0200, Marek Vasut wrote:
> Add missing panel power-supply property to DT to fix the following warning.
> The power supply on this device is very simple chain of regulators from the
> main 24V input, describe those.
> 
> "
> arch/arm/boot/dts/nxp/imx/imx6q-dhcom-pdk2.dtb: panel: 'power-supply' is a required property
> "
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks!


