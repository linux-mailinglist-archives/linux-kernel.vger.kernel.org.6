Return-Path: <linux-kernel+bounces-216574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 107D390A1A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08F91F2169F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 01:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB15441F;
	Mon, 17 Jun 2024 01:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="PCYL7qJW"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD3923A9;
	Mon, 17 Jun 2024 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718586727; cv=none; b=UoSoF4rV8272JpTtd8Y6wS4PKQ+NgBMPIKhGUafrXbOgGmwvIna3oJvgOFsFst0WYhfKNxNPuqiOwDTOm4q7w4/KzF0dL69UzwEiLUuhgiJZf7YyHmR7srtL8Yzb7zAoCzmYdGfhwMPs0t8YfZOUg86dX8w0aWDnODldlbwsRmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718586727; c=relaxed/simple;
	bh=CyvIaEn5iuYOqrb8yjEXHPmKIrnGbCY/lTru3LsPQek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9mrWAR2E6E1yx/dBsG+mB3J+sEFv9KTldbof7aw7EnuPL71SDTF5f2Rj6TSrHdzqEFCxFV4fFBFplAS+SDGljuG8iG0AcLwasXwecWsrOxvuAUyw20htVhZ+xqGsMsyEub0cPgZkzV3Y2v2boouof39r4NcaGXm7xL1QX/BDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=PCYL7qJW; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=aAq9Gr3amCNlURamGwpyh0KqzXamXGYVnTXo85CprPQ=;
	b=PCYL7qJWLWSg3pDxWVLfOZ316TzJ290TIbRVhZwLiueEtsA18X3gZk5gGGvOzn
	GZi6dxamVb+iY1PR9UXmi28f4SMfJKDpwjavKeVuueYwXV8nOrsfO5bTa38RBXIR
	V9Pyg0qpcrDd0+30Qef6UA5pU2oITfKme58yXBJdgaPu8=
Received: from dragon (unknown [114.216.76.201])
	by smtp1 (Coremail) with SMTP id ClUQrAAnCPFMjW9m8jkLCA--.41607S3;
	Mon, 17 Jun 2024 09:11:41 +0800 (CST)
Date: Mon, 17 Jun 2024 09:11:39 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: e60k02: fix aliases for mmc
Message-ID: <Zm+NS5Y//+R6w4lI@dragon>
References: <20240605083950.134479-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605083950.134479-1-andreas@kemnade.info>
X-CM-TRANSID:ClUQrAAnCPFMjW9m8jkLCA--.41607S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUsznmDUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDw0BZVnxc0xPZwAAsZ

On Wed, Jun 05, 2024 at 10:39:50AM +0200, Andreas Kemnade wrote:
> Since commit fa2d0aa96941
> ("mmc: core: Allow setting slot index via device tree alias")
> mmc numbering are changed, confusing boot scripts. Fix that by adding
> proper aliases
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied, thanks!


