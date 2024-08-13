Return-Path: <linux-kernel+bounces-284016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A1394FBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 04:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D491F21CF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 02:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4DA1CD0C;
	Tue, 13 Aug 2024 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="hI4xmBB9"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223321CD02;
	Tue, 13 Aug 2024 02:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723517359; cv=none; b=tDm+tfGO31lmSuQrP3STNemqpFgFFTfIfCarpNLr+j9B2pRjDoKjdYX7xVJ5JA9xxpb8aQr6lyZG4xOSuXnu5qeBfH4NQr5tupahnDZ/XC4Pqm32+F0qABFpQ1CyGOjHfpAS4v3WcqcuPES2GzgZ5cTSta3mTOkHBFREMI6sOsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723517359; c=relaxed/simple;
	bh=sXp6YddTODBVzlnCvVgBh98L85fjzrGiv+X1+cmMRBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PksGDvX/m4rennqPFJdNc0tZAdN2iZ0eOdDi2Zqxm3QHedRwalp6OgRr4gdjjCb3yZc3i3BNXZbtqR/ELXnSxPpmfYJPjVSgGWc8OiZmIkF+a8nrQpc0485UAS8nNzU2ZRCkvNzsoAp92mB2p0dAdeK4YkHd0zKRD1qtsI9C2Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=hI4xmBB9; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=KFNCvveRopBL4M4RjwAKxrwlHBT+Ho9SPPnEkeplJbU=;
	b=hI4xmBB9wBLbBbTvLkysHzKLD4r+pDYjcFIrixHwLInFKTTuaUMUXe2mQLR1KC
	nJF3/jIphw4Tthj+EdrIWkOxYqKMGvVnTcOprK59MfWFMu9cVZ45rdwZC9Ki+uEx
	eapjt/CuzaKRjyBDTTCRTlgsd5Q2f/1ksQPf+shaY92L4=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDXHy2MybpmpkVSAg--.46498S3;
	Tue, 13 Aug 2024 10:48:46 +0800 (CST)
Date: Tue, 13 Aug 2024 10:48:44 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH v2 0/4] arm64: dts: imx93-11x11-evk: Add several sound
 cards
Message-ID: <ZrrJjPmix3Dp+wEK@dragon>
References: <1722217199-10640-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722217199-10640-1-git-send-email-shengjiu.wang@nxp.com>
X-CM-TRANSID:Mc8vCgDXHy2MybpmpkVSAg--.46498S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU-rb1UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiER46ZWa6xSATFAAAsu

On Mon, Jul 29, 2024 at 09:39:55AM +0800, Shengjiu Wang wrote:
> Add bt-sco, PDM microphone, XCVR sound card support.
> 
> changes in v2:
> - move #sound-dai-cells to i.mx93.dtsi
> - fix some coding style issue
> - fix CHECK_DTBS issue
> 
> Shengjiu Wang (4):
>   arm64: dts: imx93: Add #sound-dai-cells property
>   arm64: dts: imx93-11x11-evk: add bt-sco sound card support
>   arm64: dts: imx93-11x11-evk: Add PDM microphone sound card support
>   arm64: dts: imx93-11x11-evk: Add audio XCVR sound card

Applied all, thanks!


