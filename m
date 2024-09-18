Return-Path: <linux-kernel+bounces-332355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 886EF97B8C7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280C4281A81
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E9916F0CA;
	Wed, 18 Sep 2024 07:51:46 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DD9461
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726645905; cv=none; b=JqgZi3AfVvxHCJi4iNnvn8LOwOcrMaWpZiGPsJAuejdlQv1ACt1IjMqMzAfP3iHmTZInO+XC4L+nZjyDjZvy8e4/xgeKl7HEldA5AGpyLvHDo0rplgZU9uYFh+U1/gESzLjPLtYEUp2dchIxJ9dg1B4melfpt7c708VIW5DV6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726645905; c=relaxed/simple;
	bh=Kf43Yet5xV7HH7wH9vxJTGBIETihrhz60E9zHZDbqOc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L1jcbbSoXcfE68FVm2p9zMUWfBK2D7Ptj3HE/Nc9fWzbbXeobZL5VMMpUqn+CzF7bkp21S7lDi7xyKZt/GQynxOf65v41cE+a4zAzprwXuv/kgDoiM5/xXrUXHf2+bV9n9eRvHWyZ4QzWPUpIoXshf7T7FbRQFsWP2z98owWiXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sqpTF-00010R-3v; Wed, 18 Sep 2024 09:51:29 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sqpTE-008lMO-57; Wed, 18 Sep 2024 09:51:28 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sqpTE-0003Dy-0H;
	Wed, 18 Sep 2024 09:51:28 +0200
Message-ID: <a5d9b775dd860d8f2bbf174300a2e3161b654035.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/3] dt-bindings: reset: Add compatible for Amlogic
 A4/A5 Reset Controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: zelong dong <zelong.dong@amlogic.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Rob
 Herring <robh@kernel.org>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Jerome Brunet
 <jbrunet@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	kelvin.zhang@amlogic.com, Conor Dooley <conor.dooley@microchip.com>
Date: Wed, 18 Sep 2024 09:51:28 +0200
In-Reply-To: <20240918074211.8067-2-zelong.dong@amlogic.com>
References: <20240918074211.8067-1-zelong.dong@amlogic.com>
	 <20240918074211.8067-2-zelong.dong@amlogic.com>
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

On Mi, 2024-09-18 at 15:42 +0800, zelong dong wrote:
> From: Zelong Dong <zelong.dong@amlogic.com>
>=20
> Add new compatible for Amlogic A4/A5 Reset Controller
>=20
> Signed-off-by: Zelong Dong <zelong.dong@amlogic.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/reset/amlogic,meson-reset.yaml   | 23 ++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.=
yaml b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> index 695ef38a7bb3..0ad81fe7b629 100644
> --- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> +++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.yaml
> @@ -12,14 +12,21 @@ maintainers:
> =20
>  properties:
>    compatible:
> -    enum:
> -      - amlogic,meson8b-reset # Reset Controller on Meson8b and compatib=
le SoCs
> -      - amlogic,meson-gxbb-reset # Reset Controller on GXBB and compatib=
le SoCs
> -      - amlogic,meson-axg-reset # Reset Controller on AXG and compatible=
 SoCs
> -      - amlogic,meson-a1-reset # Reset Controller on A1 and compatible S=
oCs
> -      - amlogic,meson-s4-reset # Reset Controller on S4 and compatible S=
oCs
> -      - amlogic,c3-reset # Reset Controller on C3 and compatible SoCs
> -      - amlogic,t7-reset
> +    oneOf:
> +      - items:

I'm not well versed in preferred dt-bindings style, but this items
looks superfluous to me. It only contains a single enum.

> +          - enum:
> +              - amlogic,meson8b-reset # Reset Controller on Meson8b and =
compatible SoCs
> +              - amlogic,meson-gxbb-reset # Reset Controller on GXBB and =
compatible SoCs
> +              - amlogic,meson-axg-reset # Reset Controller on AXG and co=
mpatible SoCs
> +              - amlogic,meson-a1-reset # Reset Controller on A1 and comp=
atible SoCs
> +              - amlogic,meson-s4-reset # Reset Controller on S4 and comp=
atible SoCs
> +              - amlogic,c3-reset # Reset Controller on C3 and compatible=
 SoCs
> +              - amlogic,t7-reset
> +      - items:
> +          - enum:
> +              - amlogic,a4-reset
> +              - amlogic,a5-reset
> +          - const: amlogic,meson-s4-reset
> =20
>    reg:
>      maxItems: 1

I think this can be merged together with the dts patches.

Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

