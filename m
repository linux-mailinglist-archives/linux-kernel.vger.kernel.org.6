Return-Path: <linux-kernel+bounces-260080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB1A93A2BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A06DD1F23945
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80AF814A4E7;
	Tue, 23 Jul 2024 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkV4Bxad"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4132154C05;
	Tue, 23 Jul 2024 14:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721744922; cv=none; b=Nh2ccQj8ShoJRwEPViHZ9Q8acoT8HP0ENHbDwD/MmvjZbpM/6bO9o3PUgoLvx5D6yfpJoocRh8kd+LHxSLc8Mn6e5KYivc/4iOUYAVBhW7BAfmnCQHoQjnpx8sNNkJs1HU+gFJVEggHOc5+jKx17i1rBW6uzSfoguRhAhxycDQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721744922; c=relaxed/simple;
	bh=15cKbkKLCHSvqsyLYXRKTBYJvAWhsD+yZ2TWL6IBELM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uU5KI56mJMxcsP9bEAcQjL++LIjbOM+dPPwIyzypt/lDKPe6DZciND4e1WhSzMLDO+LYLLZxL1XDShXCuAqDXEJqVZhsEt8uYnGtl5Hb5hjl81QDlOTqVAOXCOp1kOgEdo3dKIwn14LDC5wr/3u+y7NqG1obtR0E4WN+aSjNqLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkV4Bxad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1D9C4AF12;
	Tue, 23 Jul 2024 14:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721744922;
	bh=15cKbkKLCHSvqsyLYXRKTBYJvAWhsD+yZ2TWL6IBELM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dkV4BxadumsKlLALlkxrdsZ1RV+59WN42Rv9UbOZdF2wNN7bKEae2qJ97H03hdUiI
	 2TirdXYi1GtkX13NnplKeLZsmFFU2an/ZdDCFjkuaD7X2UP2nTmmkLS6asIOeUsyDX
	 PgBHUx3hZHKGdZ9IlRyDXJvlK0ABJkcvL9RS4vNsAzJU8TXrtjcJdxeeMNu9c+7H7T
	 d1VcSCCoIrQNdtcYibWpYUuP5K0w6dKSvdMCTGzghra7xXZ5osLe+VE8obqfMpAuFV
	 /bCx3QkNZU+qoJPhT5bHzPwFHhauDBu/oL4Yk5ULXUlVLg5XCaYaByCS5/tkoKB+Ex
	 6GYG8kJKPkx+Q==
Date: Tue, 23 Jul 2024 08:28:41 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	imx@lists.linux.dev, Daniel Baluta <daniel.baluta@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Fabio Estevam <festevam@gmail.com>, Mark Brown <broonie@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: dt-bindings: fsl,imx-audio-es8328: Convert to
 dtschema
Message-ID: <172174491993.340929.3967279887834783302.robh@kernel.org>
References: <20240722063657.23018-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722063657.23018-1-animeshagarwal28@gmail.com>


On Mon, 22 Jul 2024 12:06:51 +0530, Animesh Agarwal wrote:
> Convert the Freescale i.MX audio complex with ES8328 codec bindings to
> DT schema format.
> 
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> 
> ---
> Changes in v2:
>   - Changed top level ref to sound-card-common.yaml
> ---
>  .../bindings/sound/fsl,imx-audio-es8328.yaml  | 111 ++++++++++++++++++
>  .../bindings/sound/imx-audio-es8328.txt       |  60 ----------
>  2 files changed, 111 insertions(+), 60 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,imx-audio-es8328.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/imx-audio-es8328.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


