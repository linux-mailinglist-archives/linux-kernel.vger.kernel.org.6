Return-Path: <linux-kernel+bounces-531430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D253A4406F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5CB19E2836
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6722E268FDB;
	Tue, 25 Feb 2025 13:12:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C5268FE0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740489176; cv=none; b=ebuwz8H61TrsOrcwW1bWOB0U112g6gqpUQ4tQLpB2efGEAz2AbOiiWWd5VWxXE0RbI3ikdvAnXtMbtdFPnjhvqzqbKGGG8xTtur8+qXj6JOC92AdA7d+77CpSaW578M3Ic+dHhRg8+QJV8Nn3euLmRYBniSvZdtkZrIrLKp0zBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740489176; c=relaxed/simple;
	bh=wtj3DHyoEoxmLt14+sy56w/NaikvXl9fzVazfG0TZOk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n2neoc5UwhQgAHbCm2OKyYW1m5odFIBq7P2RQMUBj4Bn1Iwf67QftOKNtgMspKh96/WO6r+g8JSfwoS5xAQmOuTbGoF3++LAn6bGSXN8VT+FT22HmlBOABerNbYGAA0K0Zg4YnM5mxuKdAcG1rnwUD7xWuzvLd4MJ7t4CErlJao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tmujx-0005hF-Vy; Tue, 25 Feb 2025 14:12:50 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tmujx-002mMH-2B;
	Tue, 25 Feb 2025 14:12:49 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tmujx-000913-1t;
	Tue, 25 Feb 2025 14:12:49 +0100
Message-ID: <f4466c280bfef24be5d998299df450aa02ff2973.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/8] dt-bindings: reset: audiomix: Add reset ids for
 EARC and DSP
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Daniel Baluta <daniel.baluta@nxp.com>, robh@kernel.org,
 krzk+dt@kernel.org,  shawnguo@kernel.org, mathieu.poirier@linaro.org
Cc: conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
 festevam@gmail.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org,  imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,  linux-remoteproc@vger.kernel.org,
 andersson@kernel.org, Frank.Li@nxp.com,  peng.fan@nxp.com,
 laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com
Date: Tue, 25 Feb 2025 14:12:49 +0100
In-Reply-To: <20250225102005.408773-2-daniel.baluta@nxp.com>
References: <20250225102005.408773-1-daniel.baluta@nxp.com>
	 <20250225102005.408773-2-daniel.baluta@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2025-02-25 at 12:19 +0200, Daniel Baluta wrote:
> Add reset ids used for EARC and DSP on i.MX8MP platform.
>=20
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  include/dt-bindings/reset/imx8mp-reset-audiomix.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 include/dt-bindings/reset/imx8mp-reset-audiomix.h
>=20
> diff --git a/include/dt-bindings/reset/imx8mp-reset-audiomix.h b/include/=
dt-bindings/reset/imx8mp-reset-audiomix.h
> new file mode 100644
> index 000000000000..3349bf311764
> --- /dev/null
> +++ b/include/dt-bindings/reset/imx8mp-reset-audiomix.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
> +/*
> + * Copyright 2025 NXP
> + */
> +
> +#ifndef DT_BINDING_RESET_IMX8MP_AUDIOMIX_H
> +#define DT_BINDING_RESET_IMX8MP_AUDIOMIX_H
> +
> +#define IMX8MP_AUDIOMIX_EARC		0
> +#define IMX8MP_AUDIOMIX_EARC_PHY	1
> +#define IMX8MP_AUDIOMIX_DSP		2

How about calling these IMX8MP_AUDIOMIX_EARC_RESET,
IMX8MP_AUDIOMIX_EARC_PHY_RESET, and IMX8MP_AUDIOMIX_DSP_STALL instead?

regards
Philipp

