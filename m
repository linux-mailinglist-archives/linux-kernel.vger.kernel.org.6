Return-Path: <linux-kernel+bounces-370447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B5C9A2CA4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034B91C21B69
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052BF219CAD;
	Thu, 17 Oct 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyfUEHL4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E14E1D86E4;
	Thu, 17 Oct 2024 18:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191135; cv=none; b=ZiefHjSOf6vXULX91Oyr5dPIKBfuKHFEYRMH0snea13X3kbhoEZNl7AxHvKqW8bEMQbmEIoPYB5mLyezapaxHbwQ8q0jgFSXHNr2cMLSiIHf8RlvaSPDr5U73mf62xlWnuRY2/PUgDb3hlXwc/fOqrobsfhYzkRzsLnUwk04BEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191135; c=relaxed/simple;
	bh=AV6/QfUlG94dwUZyg42XcKapvfXDCJIGvtBw39hVlnI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=iSfz6TzQEJ5D48asws1DyvuQ/fslNfE9BCorYwAijpUFZ8N1XnsERRo+rdxRx1WG2B3Ivi7ZfUEjIlgWUNbLfDOFzP/6O4ZOSBX4xygL0zB+iKmcotL2csobAcv1X4SKvPkBeJOreAFd0NZFz3a1rr7skIpPIl0wksPDZPTCOrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyfUEHL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA842C4CEC3;
	Thu, 17 Oct 2024 18:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729191134;
	bh=AV6/QfUlG94dwUZyg42XcKapvfXDCJIGvtBw39hVlnI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=FyfUEHL4KmTgxeGMRc5yUGp2PkCQ3KM9sS7ewx/bLzNKyHaJg7l0jykISP7gzZX1U
	 JSMRAEFyfbPqUIBHke4gJhOceFI+YkUhkXU7hcLA4RIO2YpXM8RA4GLA4R/E7+/upa
	 CCVlUnLy6oPs+cDyl6FD3Sn+bvdi4l0Ho3BdyGVBYT2kt3aCnh5/Obk6lleuyOYXDM
	 3SNy0XH/zoSRvD+vikfNqaDhOhZD51FLeXDPzwvy+uJaxSGLhBWyu2MqL4m+HmCnHq
	 tYWNjpj3MOETxXlNWDa/Zz7aeJQ66qv7OJhmGLd6UprH22JH4PAGOfQPLNzJEDKWRl
	 xClVPD9QPCdPA==
Message-ID: <e2d451bce226a8d77a834085dbe24166.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241007-mbly-clk-v5-2-e9d8994269cb@bootlin.com>
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com> <20241007-mbly-clk-v5-2-e9d8994269cb@bootlin.com>
Subject: Re: [PATCH v5 2/4] dt-bindings: clock: add Mobileye EyeQ6L/EyeQ6H clock indexes
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Thu, 17 Oct 2024 11:52:12 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-10-07 06:49:17)
> Add #defines for Mobileye EyeQ6L and EyeQ6H SoC clocks.
>=20
> Constant prefixes are:
>  - EQ6LC_PLL_: EyeQ6L clock PLLs
>  - EQ6HC_SOUTH_PLL_: EyeQ6H south OLB PLLs
>  - EQ6HC_SOUTH_DIV_: EyeQ6H south OLB divider clocks
>  - EQ6HC_ACC_PLL_: EyeQ6H accelerator OLB PLLs
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---

Applied to clk-next

