Return-Path: <linux-kernel+bounces-309911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E419671C4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 15:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60FFC283BFD
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC12510A2A;
	Sat, 31 Aug 2024 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="gH/fZMfA"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51254DDC7;
	Sat, 31 Aug 2024 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725110643; cv=none; b=oj83EYwjvnPKN/SH3zuoZ7Jka0tkaD43Ubp6Dd4mGL9wSaiEb1CB5dilzrHcQYBljzQ+K1m07OBdARYEihz2Oqx4fJh8nrrNNCjw7Ww+rKL6Ao5CYNNm2HKCDg4b10YUFoZZ618FksdExKsdyLSHi19HfXP3m7Nn5S1bOTEkAp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725110643; c=relaxed/simple;
	bh=YrlKkmeXnl9yn9by35cmlHWOsibdj1GiUV2S7E+D34A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcNXYl+OYb4dKxAAVjUpS7twcitc4iowRqrNqtdjypI4yt4HepCZrDavzMl3lfRfg+1GFMidpY4ibKAvmNDeqkn5sJHSgx5TtEtSLEhluKNV0ZBcQEmxeYlCFPSm+AeZOKsJmphLVAkx1QIICQKbo8YziH7wb/STBYKCK0cY1SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=gH/fZMfA; arc=none smtp.client-ip=1.95.21.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=AKh6GeJUGJqgVmvjczY15ttYojz0WLz6kYGq1JRrolI=;
	b=gH/fZMfA2IIkiSos0uwF6FUiWxZqQsHZH2yO4+82PXwuOF6EavAdJs/VAh6a/r
	V1VRwrr3JD3ojvM6p7Kh7u5il2nZTJcXCTR7cJn/vJpnsPLWdS0Sk/6C/4F0eAEQ
	uiFnHCm06WxkC86kJvV1kgcORtUm1ibb7UlaWWzL2IrwI=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBXPjNLGdNmEq06AA--.15266S3;
	Sat, 31 Aug 2024 21:23:25 +0800 (CST)
Date: Sat, 31 Aug 2024 21:23:23 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Yannic Moog <y.moog@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH 0/3] arm64: dts: add aux-voltage-chargeable to Phytec
 imx8m boards
Message-ID: <ZtMZSxj5jqCiNeIZ@dragon>
References: <20240814-b4-phytec_imx8m_rtc_updates-v1-0-10f1afc1b3ad@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814-b4-phytec_imx8m_rtc_updates-v1-0-10f1afc1b3ad@phytec.de>
X-CM-TRANSID:Mc8vCgBXPjNLGdNmEq06AA--.15266S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4AR6UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgVMZWbS-GY3CgABss

On Wed, Aug 14, 2024 at 11:26:35AM +0200, Yannic Moog wrote:
> All Phytec imx8m boards have a chargeable capacitor that the populated
> rtc is able to charge. Add rtc property to all (phytec imx8m) boards
> setting the aux-voltage-chargeable property appropriately. The patches
> cause no functional change.
> 
> ---
> Yannic Moog (3):
>       arm64: dts: imx8mp-phyboard-pollux: add rtc aux-voltage-chargeable
>       arm64: dts: imx8mm-phyboard-polis: add rtc aux-voltage-chargeable
>       arm64: dts: imx8mm-phygate-tauri-l: add rtc aux-voltage-chargeable

Applied, thanks!


