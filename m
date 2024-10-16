Return-Path: <linux-kernel+bounces-367223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1607999FFF6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 06:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480AB1C24463
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 04:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93902172BB9;
	Wed, 16 Oct 2024 04:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="X3LpqizF"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C45487A5;
	Wed, 16 Oct 2024 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729051702; cv=none; b=sZqwxrLrkhWU60tI69zdfcCK7Ohj9QM/AWRnZUyvmpSxoG2ol2oHm5TA+jNGZI3/o1qTjsqiexy1aJfFUVcCOE0zNNB/04FmV/q6nwUzKT0Tk+heu0dHQwDe3+IEOTqOq3W5ajhVGdTKDIsjby6te3aMTGjpFnakFv7nS6OQXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729051702; c=relaxed/simple;
	bh=3N+STJ//28s3Z0iB/sdCIxxPiYXRl3RUngKkc7dK2Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SViOFar0BPUnMuGXZgrT27HFan/nPzLrxALtgJOWbsCn02swM8RSU7M2Es94iYTd0mXLG1qAzSRRWpW9tnq0KqdvSjOz985U4W+s8wOVhuuQEk/WrhrsmbtoO+4VD9hX+elG/6YQeB/wqU+le8uwtYX3YzPB/ZxIKnWKqqVU3QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=X3LpqizF; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=mbr909u6y0eDYh6LGTbSBvd7E+j4AUKVKbgkrG8a6FM=;
	b=X3LpqizFAhILrpKiHW+6mx8A0/RuJHlC887uNkGZX1RhEjIXgIm/AOm95kyYp5
	nJwLPcS08IpnPSmPAzJyyRV/G05Ss9/yW1vF+Zn72bz3//oy/vuxRGw6bgTj1IyS
	sneSwedPxPOv8N1h/bvNFVrPgQV1tKXiMUEWZe7IUZrZo=
Received: from dragon (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgAXll35Ow9noaQVAA--.253S3;
	Wed, 16 Oct 2024 12:07:23 +0800 (CST)
Date: Wed, 16 Oct 2024 12:07:21 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: freescale: minor whitespace cleanup
Message-ID: <Zw87+QnHZogtv6CP@dragon>
References: <20240905154410.423991-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905154410.423991-1-krzysztof.kozlowski@linaro.org>
X-CM-TRANSID:M88vCgAXll35Ow9noaQVAA--.253S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4IJmUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiEhV6ZWcPEZ+ZGAAAs-

On Thu, Sep 05, 2024 at 05:44:10PM +0200, Krzysztof Kozlowski wrote:
> The DTS code coding style expects exactly one space before '{'
> character.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!


