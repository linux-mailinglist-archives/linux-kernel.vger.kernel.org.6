Return-Path: <linux-kernel+bounces-283985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666DD94FB85
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 03:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FF5282A79
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19494111AA;
	Tue, 13 Aug 2024 01:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Kpyd8M2X"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F8412E48;
	Tue, 13 Aug 2024 01:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723514328; cv=none; b=BSOywG8wCfRzm3nkZwoYjIgy4/xE23OnMyc+Qj0KdedyviH1BUpf6BJxu8xNQGFeEUprdL+tyv2rfT7L7T0re96pJTgOHSGi5BQhsUSGq8HAHmPfxvWwumMgSsnYPTx+fkO4s3fksHjOcvrpXe+U2ADf43xIULmPgQA+hUPlEQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723514328; c=relaxed/simple;
	bh=36vVZraJBv9gkEdNzrEeazN0O9x6UDRACR9GQX75zv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPgPJLMupTLLZVRieJWJTLahqmG4VzPEolMZyswqEq0SYVvoZO2LjbhLk0n+x7iioIQunE1Q/EYiq01mBgMmFNTSjR6/ALcI3T5QwlB3d7UVOoT7bptmXUglRYpd5WNhuX9AEsLrr8u6VAZAfxXdwi9//lmoHGa3TVtKsT7S7vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Kpyd8M2X; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Ew3Ua+pMM1tFjdaKMlL3jL5qyg1tUq79MqPYQMcNt68=;
	b=Kpyd8M2X+5wkxs2Nwahmt+3E/gx3M5Kovz3WbkFVFiq3E8CUFimxtgaAQxWzMA
	6NPWUt+Da/2oelPnn53o1XQj90QeSlAFTDx7g6UnrbxDP2TZKA+1COqS+d1ZXIug
	IFDVt4yIA1zRWXvev2zsskFTXcn+FWkcWK3TQVDWV913Y=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXnpCtvbpmtmReAg--.37761S3;
	Tue, 13 Aug 2024 09:58:06 +0800 (CST)
Date: Tue, 13 Aug 2024 09:58:04 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla:
 fix typo
Message-ID: <Zrq9rHkWFjhNxyK3@dragon>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
 <20240724125901.1391698-6-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724125901.1391698-6-alexander.stein@ew.tq-group.com>
X-CM-TRANSID:Ms8vCgDXnpCtvbpmtmReAg--.37761S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4IJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEgU6ZWa6XkbfswAAsg

On Wed, Jul 24, 2024 at 02:58:52PM +0200, Alexander Stein wrote:
> From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> 
> Fix typo in assignment of SD-Card cd-gpios.
> 
> Fixes: c982ecfa7992 ("arm64: dts: freescale: add initial
> device tree for MBa93xxLA SBC board")
> 
> Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Applied, thanks!


