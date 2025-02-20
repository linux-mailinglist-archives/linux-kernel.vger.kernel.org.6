Return-Path: <linux-kernel+bounces-524100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52069A3DF25
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1669D3A3720
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C3E20C028;
	Thu, 20 Feb 2025 15:45:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B2C1FE46F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066353; cv=none; b=p0RalSx8GzrNx6HHlf0c9kWZL0SGXWvhWOyJxuMJJDeRIldGqta6UAgEDYmzWNpebPtGkq6AkHFcaobckZG3imnCE4bXPPo9yNS6v8spHaltiIm5/IaztnSdEKMuBgXHu3COz7ezff09vyz7Y3JC/u3LQYg/TB3IQt4jhOEDfxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066353; c=relaxed/simple;
	bh=J6tNrRWmwDeSw4FPqfaA9voFmMDbjtLKvyBcPxfz8iQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IJdT+KZ27OxZS+5S+kXHRbb8ljuiWtjtJzB7uU5qFuJGl/4wziQrlQ9B1oTLMQ1pXgSgIDJc1W+knQeA04Qgqm57GGdEh9WUIQMwWnCqKHxO4AH4vmWZqrx/sbFwWajN7vIf0LfMd/oKaFcd11lf1kK8gATpftsz7p24pCHMjE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tl8kB-0003Py-2B; Thu, 20 Feb 2025 16:45:43 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tl8kA-001xUj-2g;
	Thu, 20 Feb 2025 16:45:42 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1tl8kA-000Cm6-2O;
	Thu, 20 Feb 2025 16:45:42 +0100
Message-ID: <f69d6076f5b41bcf56ddbf24a72a600fa51466dc.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/8] dt-bindings: dsp: fsl,dsp: Add resets property
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Daniel Baluta <daniel.baluta@nxp.com>, robh@kernel.org,
 shawnguo@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org, 
	shengjiu.wang@nxp.com, Frank.Li@nxp.com, peng.fan@nxp.com, 
	laurentiu.mihalcea@nxp.com, iuliana.prodan@nxp.com
Date: Thu, 20 Feb 2025 16:45:42 +0100
In-Reply-To: <20250219192102.423850-3-daniel.baluta@nxp.com>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
	 <20250219192102.423850-3-daniel.baluta@nxp.com>
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

On Mi, 2025-02-19 at 21:20 +0200, Daniel Baluta wrote:
> On i.MX8MP we introduced support for using a reset controller
> to control DSP operation.
>=20
> This patch adds reset property which is required for i.MX8MP.
>=20
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  .../devicetree/bindings/dsp/fsl,dsp.yaml      | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml b/Documen=
tation/devicetree/bindings/dsp/fsl,dsp.yaml
> index ab93ffd3d2e5..923e7f079f1b 100644
> --- a/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/fsl,dsp.yaml
> @@ -82,6 +82,13 @@ properties:
>      description:
>        Phandle to syscon block which provide access for processor enablem=
ent
> =20
> +  resets:
> +    description:
> +      A pair consisting of phandle to audio-blk-control and an index ref=
erencing
> +      the DSP Run/Stall bit in audiomix registers.
> +      See include/dt-bindings/reset/imx8mp-reset-audiomix.h for each ind=
ex meaning.
> +    maxItems: 1

This is going to be confusing when there is an actual (undocumented?)
DSP core reset that is not described in the device tree bindings, see
patch 8.

To me this looks like a bit of a gray zone, as I don't know how the
hardware actually works, but if you wouldn't call the Run/Stall bit a
reset, it probably shouldn't be described as such in the device tree
bindings.

I'm not sure. Should both core and runstall reset be described in the
device tree? Or only the core reset, or neither? Either way we should
try not to lie about the hardware here.

regards
Philipp

