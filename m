Return-Path: <linux-kernel+bounces-436982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 766089E8D98
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3797528126A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A5521519F;
	Mon,  9 Dec 2024 08:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="OlebIETz"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E9A12CDAE;
	Mon,  9 Dec 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733733451; cv=none; b=Ggo/enqd87W26+BrWkyofbTRcnicUweuSjOoflLgGt8HRrNqcBaSd59fN5FECRObZUUQhvOq7oI9JeBoVRS6WQrsqU3+tPedXn151Hibxd/NARBcOBiJXoASo7/ikNJEY7nM9t1ICdGkpWauh9919mg6b3zJWHHpzk5wialajvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733733451; c=relaxed/simple;
	bh=/+n6QG8R6D9zIR2ROqIAJS9brJs7afCml+rj4Z7FRfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ViJgyIA9oEZY1WqCo2RxWTXK4TSS56yARDrh6DC0KZQu+TwBfZP40Y6jXKg/CM3jR9ONvMO4j8Entc9ZFH2iWujem/qee6B7oiTPkSOBXkRdiFt658FkynFuWpKxwgnk/vIGf3aKjIx27TsmqnjlELsxUvYtrhttyg0RCtCyHxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=OlebIETz; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=YnPHthB8LMV885tm2rzcxoiQ16KBEntsl0UFvMdQ5Uc=;
	b=OlebIETzWJZPMwMwiY14oww5JJuepQGVeAXTeZimR0bjfe/+F1B8hp9/9/rTyx
	bz5boksMDTAqM7oVRfo6Q73ckNGHckIUSxiDXeuatyOUBgrhQJCUBq7irb3tvgPd
	xbHl/ZrVlRlW97C+ZSz541pTExVPaTvo2BYTQDeGTh5f4=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3boEqrFZnOi+NBA--.47304S3;
	Mon, 09 Dec 2024 16:36:59 +0800 (CST)
Date: Mon, 9 Dec 2024 16:36:57 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Heiko Schocher <hs@denx.de>
Cc: linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 3/3] arm64: dts: imx8mp: add aristainetos3 board
 support
Message-ID: <Z1asKaRAJKTBv8ui@dragon>
References: <20241105064206.43626-1-hs@denx.de>
 <20241105064206.43626-4-hs@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105064206.43626-4-hs@denx.de>
X-CM-TRANSID:Ms8vCgD3boEqrFZnOi+NBA--.47304S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsmFCUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCRywZWdWeNriYAAAsR

On Tue, Nov 05, 2024 at 07:42:06AM +0100, Heiko Schocher wrote:
> Add support for the i.MX8MP based aristainetos3 boards from ABB.
> 
> The board uses a ABB specific SoM from ADLink, based on NXP
> i.MX8MP SoC. The SoM is used on 3 different carrier boards,
> with small differences.
> 
> Signed-off-by: Heiko Schocher <hs@denx.de>

Applied, thanks!


