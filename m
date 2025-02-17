Return-Path: <linux-kernel+bounces-517344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2078BA37F6F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89DAE7A532C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEEB217679;
	Mon, 17 Feb 2025 10:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="hORx4vwo"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2382521764B;
	Mon, 17 Feb 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786820; cv=none; b=M4GY88sbHTwq35MuFgBmuYaVzxst/ANp0WKzLrLDsmQKx6xkNPlbIgsZsDuLPnug33YII8Zz32vn6DL8BbEiPccrG75q9PQezd/teC7tGyGYidWl57n25CwtKJkCTzWYMWMZUmfD4Kv1gAzcbSQ2931QR0mhOEx8M6b5H/gaky4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786820; c=relaxed/simple;
	bh=DORebK+rJAkcdpfoUg2yLd6mXT11QhnNS8Ys58jtV1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqbYA9v5vfb7bK7qwXaEYg34rDF2Gja95Z61qTmTh5dsFS9woup/EUpCQ1O/krR22JZm4IvN+ukziz/7Ui2o23l0c39VhNbxil0fjnA1E1z4ikaeUbFRHdk5ZjB7fhSxJgRYLZPwWzIQv+/B3OeVdL/N/Bg+l4k8mbYytqEKCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=hORx4vwo; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=jLolwAPvGVxT6aAEjL3uBdU5olsoXzQXTlC8GliVIF4=;
	b=hORx4vwoIpdqKgJlUC3/ma9uoQDd0rMVBbSndCHQr2X9D+MakWX6BD+LBIbW8G
	P4qnO8OdzRgydsARR56PTkD5kxBOVFq5mGG/cgs1UwQSkxXxYmCopfxETjCOX4ye
	2w4He0t2ffaNutgVbo7wr8qS/S5RsouKfSUv5uOX9mu/M=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAHTzUQCrNn4KomCQ--.17144S3;
	Mon, 17 Feb 2025 18:06:10 +0800 (CST)
Date: Mon, 17 Feb 2025 18:06:08 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Lukasz Majewski <lukma@denx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v11 2/3] dt-bindings: arm: Document the btt3 i.MX28 based
 board
Message-ID: <Z7MKEBkiBatFl54o@dragon>
References: <20241107085705.490940-1-lukma@denx.de>
 <20241107085705.490940-2-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107085705.490940-2-lukma@denx.de>
X-CM-TRANSID:Mc8vCgAHTzUQCrNn4KomCQ--.17144S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4Xo2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiERn2ZWey2VbYUgAAsL

On Thu, Nov 07, 2024 at 09:57:04AM +0100, Lukasz Majewski wrote:
> The imx287 based btt3 board is very similar to xea in terms of used SOM
> module.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied 2/3 and 3/3, thanks!


