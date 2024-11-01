Return-Path: <linux-kernel+bounces-391975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DCD9B8E14
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 10:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E66EB22666
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 09:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383DD15C15B;
	Fri,  1 Nov 2024 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="fy66hohr"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D2C153BF8;
	Fri,  1 Nov 2024 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730454262; cv=none; b=cTeuaK1VwYkNB2BuhFDvX0UuU+bTgiemTjDr1Z6VoW48Q51KhmsXM4aPb2RedeDeWmulLcszZ8qQrcj6weypbfTJagHySMa/bc+dxGSjCOxg+uZzTWta471bbOMNnemXePuNem2Avl9jiyrD+SX1KH9O7uQj3ixP34QWBpGqg64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730454262; c=relaxed/simple;
	bh=UtbEw9PpeFiRtaLNPiremI+4jAr/ByX5D3N7bqeXPuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkNrNhECguPVIujy0pBc8ES70qpdeiJgB6Erx34LKZi4ZGY7ql9qIPVqIgB1X5VLJORKVAROp4/TsYRiEUVpVT6JxrkJ2rBoW+INiJfAdv9Fiw+G/Qeq8FPWI9jX53uQp5G1Ij0Yrbc8yKeedmfQRZqQicO8z3do/Lj0VY7nfKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=fy66hohr; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=XLnYQfdr8NyxggDtyRx5yaVqi2owvaQFbxe2uSIzQDY=;
	b=fy66hohrsCdw8c1rLOwe1R3p0cESVr4sM7Wg0sz6gnvpaC9gbGWQk5cVrOeMfp
	mQi10MAUzS0dyf+eg3+BZ06Y/hb6Cd/rM0jE8JyTWh9ooGrAxtCT9ENGHpEalrjr
	5Lma9nkUb2nzst601UrIUfobJn6qGNGXXM9O6pOHulB2Y=
Received: from dragon (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgAXf8lroiRn8dxjAQ--.13888S3;
	Fri, 01 Nov 2024 17:42:05 +0800 (CST)
Date: Fri, 1 Nov 2024 17:42:03 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: fsl: Add Gateworks GW82XX-2x
 dev kit
Message-ID: <ZySia6Jaie9QvcH4@dragon>
References: <20241022153031.1231934-1-tharvey@gateworks.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022153031.1231934-1-tharvey@gateworks.com>
X-CM-TRANSID:Mc8vCgAXf8lroiRn8dxjAQ--.13888S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVdWFUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCx+KZWckj-02owAAsf

On Tue, Oct 22, 2024 at 08:30:30AM -0700, Tim Harvey wrote:
> Adds support for the Gateworks GW82XX-2X development kit
> based on a GW82XX baseboard and a GW702X System On Module.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!


