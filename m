Return-Path: <linux-kernel+bounces-375517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 890869A96EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 05:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82A41C22C61
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ADC145A16;
	Tue, 22 Oct 2024 03:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ZBSF0lnm"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4913813790B;
	Tue, 22 Oct 2024 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566945; cv=none; b=mEa1J9Lu87EcFiGp+2lf+gfN3LBuU8slaJaRpfpzgDMtgjbmWFU3av5f7WdJk6sxZRAOKGaRV13lMff+ETgsAe7CByqXYB6cBHx91NUn2s1weLbSUPpVDb+ulOKiaLXIHV6ruKS139SzQu5/HIQ8jHPw72mjoi5NGSLiAl5/tyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566945; c=relaxed/simple;
	bh=Y8QMoNWGSW0vi6cEKbJlXyQDVhOE9k7ylYhYgnQAo7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/RWAm0f+QkCm9z5EuoqsVYabnw5QZwPv8QAM4y4LCW3qYe/WrnwPYRMIVqtRYfPoIHvfQUXCbjaK506ACnSkQ3ZAKtjO8jGvEgmGLyhHOsRDFkMj1EDo6zvVDvChjpDCjCVZwChHLOpCW89PqMbo1YhS96uxTuUyYVj6m3phqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ZBSF0lnm; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=o9wXe8/tO2owOYA8EggBQaYZFJ2LoLa0Ziam319oyYU=;
	b=ZBSF0lnmiw2pky5Fa3Fzaxq6eRXapFgB3RqiPrrbA4gp5s5gNpokApUC60d8KR
	t/QBwVhPnlj3bqWslOG4swuPHHDwWdxRsLQq00HIM9yXaciUxSy+NYXSryjga1zc
	mLxVrkIdkg2HdM+E5QVg7aK20QpOMR6MRdEWNRhhZSinQ=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgBXnu61GBdnVYeUAA--.5333S3;
	Tue, 22 Oct 2024 11:15:03 +0800 (CST)
Date: Tue, 22 Oct 2024 11:15:01 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com
Subject: Re: [PATCH v3 0/3] arm64: dts: imx93-9x9-qsb: Add sound card support
Message-ID: <ZxcYtcBZcYSWJBNt@dragon>
References: <1729068557-10073-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1729068557-10073-1-git-send-email-shengjiu.wang@nxp.com>
X-CM-TRANSID:Mc8vCgBXnu61GBdnVYeUAA--.5333S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUab18DUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiER+AZWcXARRYfwAAsp

On Wed, Oct 16, 2024 at 04:49:14PM +0800, Shengjiu Wang wrote:
> Shengjiu Wang (3):
>   arm64: dts: imx93-9x9-qsb: Enable sound-wm8962 sound card
>   arm64: dts: imx93-9x9-qsb: add bt-sco sound card support
>   arm64: dts: imx93-9x9-qsb: Add PDM microphone sound card support

Applied all, thanks!


