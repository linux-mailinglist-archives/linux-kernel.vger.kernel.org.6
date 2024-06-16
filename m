Return-Path: <linux-kernel+bounces-216092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 608CF909B42
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 04:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1285D1F215E8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 02:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C833616C69B;
	Sun, 16 Jun 2024 02:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="HGcJ6DxT"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691212B9AE;
	Sun, 16 Jun 2024 02:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718505172; cv=none; b=hba2CELkdKPm4aYqyEYRoBXLQuwizZWOhXKJ5+mmhj6QnyNtgYuyqJHknK2ybBvyh68UmRTv0z8GOIEHM+KvP90XebBV2SfZdDKu0VJCvZ4zvaTOXt70YUfQTpss5DPB95YpNbjwfc6hPiUzF0XjFMf+MIOBSl/wr6OtPwAuyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718505172; c=relaxed/simple;
	bh=u3+EI/syrhiTmuQIanrqV5I6MyI8po3RILPAsl4CAyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmHtK8xhWJsj9qnpUmM0cb+UatgkU1eTGQdB4LjRYOqg7UhbwUS1PxX3QoP97mUxnrQghze03pTeBew8CduLKRAuRn1MaerWnwxJOb7SMSx57aaP7uU9fUSkhc9a/T6lu9Scc1Fep5PbqTZq6skOx01oJwTOj9/jCYm2Pr7IIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=HGcJ6DxT; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=XUdtgsTaJbkkEzxuZMU72erEzpZ8Iwy4UurOMsxIWLE=;
	b=HGcJ6DxTRCowvd8dq0EAEGsFGqGgPGo1v4FiP0mxKDJ+tm+Hx2/YkAJlEr+e5G
	qjJZ1I8OjfgJ/2eFGejkcyC/O2kFc51sEBcUM7qyjb4aL8vYBTmZgUEEjpZrt7oI
	sAW6DB9r4Dm6NI8nt8HIBMGytI8oStVD6N46eP2xpib2U=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrADnr0+7Tm5myI++CA--.26946S3;
	Sun, 16 Jun 2024 10:32:28 +0800 (CST)
Date: Sun, 16 Jun 2024 10:32:27 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: max.oss.09@gmail.com
Cc: Max Krummenacher <max.krummenacher@toradex.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] arm64: dts: freescale: imx8m{m|p}: don't limit
 i2c2 max. clock
Message-ID: <Zm5Ou/NCnq43FAYR@dragon>
References: <20240527160359.1965512-1-max.oss.09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527160359.1965512-1-max.oss.09@gmail.com>
X-CM-TRANSID:C1UQrADnr0+7Tm5myI++CA--.26946S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcS_MDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBRwAZVsVCpobjAAAs1

On Mon, May 27, 2024 at 06:03:44PM +0200, max.oss.09@gmail.com wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> 
> This sets the I2C clock frequency to something people expect it to
> be by default.
> 
> For I2C DDC we do want to lower the I2C clock to have more reliable
> communication. However that should be done where the I2C bus is
> assigned to a HDMI DDC, not as the default.
> 
> 
> Max Krummenacher (2):
>   arm64: dts: freescale: imx8mm-verdin: don't limit i2c2 max. clock
>   arm64: dts: freescale: imx8mp-verdin: don't limit i2c2 max. clock

Applied both, thanks!


