Return-Path: <linux-kernel+bounces-290345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFD1955282
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD7C1C2138F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B2D1C5797;
	Fri, 16 Aug 2024 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9XhEKeK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9964315D;
	Fri, 16 Aug 2024 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844260; cv=none; b=fOb2u5IUL7Y+TlX2Lxj0dCArSir2xThTRJUcaiOmII0R7h87Yx6HLOFBpWlhtGIiCEbj01Y8v/jPfl6WYZJtmrE6Ygt2nxOkK/2FREtH6FKtOd36vEeqFLSnGyxYD4lJqiR0X1lvKzkolRn9vwaRAsM9ay7ZgBRa81vvg0aNrrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844260; c=relaxed/simple;
	bh=aCbMzVqI8Gt1qrS/CvCiLsKB2HJ1HtyWwRU+x7CdzEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgPfQjCgYy61yTQE/GhbHqj4QGEUIviQe8Bm4pGEZPFsScdJ5yzkxi9k5OZWP83Bo3CoZnIiIZkgjBiiOSqV5EO/GhDQAlvTJA9+8i4uWTtzq4QuIdVhzCWxg3s/xdneR1Tge2PGHLhzYWFbJU7HvyUtxS2G98GXkZlkUfYj43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9XhEKeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F1CC32782;
	Fri, 16 Aug 2024 21:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723844260;
	bh=aCbMzVqI8Gt1qrS/CvCiLsKB2HJ1HtyWwRU+x7CdzEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9XhEKeK46Nfrhal5YW2CTH8AYTrg2rden9ipRGn3m8tSq1qB2GxDFWvb1VqC1CPX
	 86Hb7vDdybQU7WD8qL15DJSI+Ub+lr90KWuSYZJNYTDQ/ddn9GND77KNttun5+3ieg
	 pni9CL0zUwOS0C4q5HKdVBiiu0dDR0mXgdBSdYZrtcc3PagNIKqGjrIoJYPBQlk+YX
	 bhw3jUkX9fgx9p8hk32BZz59poKcRdYZUBYAh24K+FSq+2R2Zrm9JQXFR2+sEcWnPz
	 cNBAukzoeMZtajMuEcyzMZBn3a+YRBBoQLvXjYMMO0/uMP+Qmdrcb2iHRxQhRzFyEE
	 rx+3c6+1CMyYQ==
Date: Fri, 16 Aug 2024 15:37:39 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
	Shenghao Ding <shenghao-ding@ti.com>, linux-sound@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Kevin Lu <kevin-lu@ti.com>, Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>, Baojun Xu <baojun.xu@ti.com>,
	alsa-devel@alsa-project.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: Convert tpa6130a2.txt to yaml
Message-ID: <172384423481.2293778.2612322675664493468.robh@kernel.org>
References: <20240814175129.4027097-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814175129.4027097-1-Frank.Li@nxp.com>


On Wed, 14 Aug 2024 13:51:28 -0400, Frank Li wrote:
> Convert binding doc tpa6130a2.txt to yaml format.
> Additional change:
>   - add ref to dai-common.yaml
>   - add i2c node in example
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb: /soc@0/bus@30800000/i2c@30a20000/amp@60:
> 	failed to match any schema with compatible: ['ti,tpa6130a2']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/sound/ti,tpa6130a2.yaml          | 55 +++++++++++++++++++
>  .../devicetree/bindings/sound/tpa6130a2.txt   | 27 ---------
>  2 files changed, 55 insertions(+), 27 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tpa6130a2.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/tpa6130a2.txt
> 

With MAINTAINERS fixed,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


