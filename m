Return-Path: <linux-kernel+bounces-215760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B57C09096BB
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FEC01F23417
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A54182A0;
	Sat, 15 Jun 2024 08:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="EoTs6NzW"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8532117C6B;
	Sat, 15 Jun 2024 08:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718438809; cv=none; b=H7l14aQ8yqeTyqs1T9OT22GkbuXQKKgAQNYYP30lnwBXXjuVAphnR1z8428SP6qR01cBpmu3w2X10w+QkMryCZ+IkZwTrXQegMoIXAntvtMlwqq42f4ec0YqDeePWx47aj08fsfRMRpLdMG+tSv8pX3V7GMQTnigTokmcizmecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718438809; c=relaxed/simple;
	bh=GxAOZy0x9WrDZ/LeK+PwkuiwAQ2MR0JWNopsCLd6u4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1OVuHY3afBpGjrUqaanY1/gofmfF3rBlt8PHxWpYn/CtdBKUVOvgeQSR+dcUVedPlzpnDkDXm4kV18FPXSIutRvMkUDdzf0SczDilVToVfJ0HF4dPqqIxSdU0awP7gI5thMbQb/e04rAUcdF9Mec6S9sRrZkgQe+Z6U/extgXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=EoTs6NzW; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=nBIxbGV2M/V9F3VVH2qGA1ziJ7K7maeJDL9DDy8Cg9E=;
	b=EoTs6NzW5+SbMEggtvXAVYbG9U9bsMTyrqb4pLuj6K0WRrjBrVOqaiTRqfKKdx
	y1iWKsIMSw0jdP2uf9z3eNuhA0ijGibqKT4DwWHSMKc5fm4goRzC00PAk9jbgPbO
	QtE/WEk0MSPapD/L7TiehVBCeEHZSdRfXQnyaFsb4KFtY=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrABXH+J0S21m4t60CA--.4800S3;
	Sat, 15 Jun 2024 16:06:14 +0800 (CST)
Date: Sat, 15 Jun 2024 16:06:12 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Marek Vasut <marex@denx.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, kernel@dh-electronics.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mp: Enable HDMI on i.MX8MP DHCOM PDK2
 and PDK3
Message-ID: <Zm1LdFyxYJ1+UIgY@dragon>
References: <20240514010706.245874-1-marex@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514010706.245874-1-marex@denx.de>
X-CM-TRANSID:C1UQrABXH+J0S21m4t60CA--.4800S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIco7DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDw-+ZVnxc0gsowACsF

On Tue, May 14, 2024 at 03:06:42AM +0200, Marek Vasut wrote:
> Enable HDMI output on i.MX8MP DHCOM PDK2 and PDK3. The I2C5 on PDK2 and
> I2C mux port 1 on PDK3 respectively are used in regular I2C mode instead
> of HDMI DDC mode to permit connection of other I2C devices on those buses.
> The pinctrl_hdmi node is part of the SoM DTSI already.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks!


