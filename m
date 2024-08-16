Return-Path: <linux-kernel+bounces-290341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE4D2955279
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D2181C217F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71C1C4631;
	Fri, 16 Aug 2024 21:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cU+b8xGw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CDB136E21;
	Fri, 16 Aug 2024 21:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723844125; cv=none; b=tAriICp03eg7osrrzFf6OB0b7K13dWjhZy829IP2XukOG8Tv9o2eKz8xsrtWOp0FID6vUjqY0JbsBFxOSyWBQDhIj4XUQs0dy1r1MxxtpkHpUtU99ki8xpOEvMDQCUadv208+QurY3KMeZL55V9MiWpgJ/oXmWx8F8ZvWpoNnOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723844125; c=relaxed/simple;
	bh=E5pRy/NZev7CQ+5MeoeycTawER7eb3a9BUaFoSbrWzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVkd42v4lo9hU68Z12XTT+vWnHtZFf1hnUiy5eGa59a0mBGZxWDbU+NsLSmNnA/LlAXd6fVDozxC7c48cgJTnaqniJH3sQjr8AI8EFkl47m1D4AK7A9Q3w2+nXFyKH4oBIXwcDHkJbKOjAjQYEbgnA//D3bQAdtiTadSZZyWKps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cU+b8xGw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457D4C32782;
	Fri, 16 Aug 2024 21:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723844123;
	bh=E5pRy/NZev7CQ+5MeoeycTawER7eb3a9BUaFoSbrWzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cU+b8xGwPB2wjrNZN58g5rTTZ0K8gy2cVElnvOdNBJS+eRW2cTS6lty9cFaxEA1GE
	 nvwA8ZyQBoB9dS/JEHAfNUt28/UrQsNEIS2kzi3Al7cI1Ioji8cazLDcD+iPAYZWnO
	 6h2rmgQwXmGs/xssJ8nxyDCA/zRx1SVbFTtP6WXIDgjH8trJzxo+3p26PbZ5jjF5db
	 r5P3sixRrT+GaLUTRd2uX+eNfMF9bMLPOh/F/kKCPJ3PKicBeQajp9fkZtNS0CsYOE
	 LcaAZFcJXdh6W8bSCeUip+QLDhD9hqjKMG4y9TBsEelvDyR/V2v0oXSoSXe66tO1Yf
	 56BQ2GZJ3jCdA==
Date: Fri, 16 Aug 2024 15:35:22 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
	alsa-devel@alsa-project.org, Kevin Lu <kevin-lu@ti.com>,
	linux-sound@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Shenghao Ding <shenghao-ding@ti.com>,
	Mark Brown <broonie@kernel.org>, Baojun Xu <baojun.xu@ti.com>
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: convert tlv320aic31xx.txt to yaml
Message-ID: <172384412184.2291163.5262701563861623648.robh@kernel.org>
References: <20240814174422.4026100-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814174422.4026100-1-Frank.Li@nxp.com>


On Wed, 14 Aug 2024 13:44:20 -0400, Frank Li wrote:
> Convert binding doc tlv320aic31xx.txt to yaml format.
> Additional change:
> - add i2c node in example.
> - replace MICBIAS_OFF with MICBIAS_2_0v in example because MICBIAS_OFF have
> been defined in header file.
> - add ref to dai-common.yaml.
> - add #sound-dai-cells.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb: /soc@0/bus@30800000/i2c@30a30000/codec@18:
> 	failed to match any schema with compatible: ['ti,tlv320dac3100']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/sound/ti,tlv320dac3100.yaml      | 127 ++++++++++++++++++
>  .../bindings/sound/tlv320aic31xx.txt          |  77 -----------
>  2 files changed, 127 insertions(+), 77 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/ti,tlv320dac3100.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/tlv320aic31xx.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


