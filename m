Return-Path: <linux-kernel+bounces-543744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA07A4D943
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB7D4162E61
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E41A1FCFE4;
	Tue,  4 Mar 2025 09:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="EMr/+P6X";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="koFWoSw0"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BED133998;
	Tue,  4 Mar 2025 09:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081939; cv=none; b=N/zRKzOvoGwbupePW6BxKWOsCzYcA8eYqZp85McV0xmZ9nexCESyCAxGTD2Z+aaUEbPWXPMzijtKREIHgCyHP1Y0jLiMhmVBvXdXtL8RrO6Ut8cnusoY+/bBX5xvl6PLlL/uwNywTSB3u4wrWujU4ms99rIUnu5CY1NKWpaqZR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081939; c=relaxed/simple;
	bh=hXGug7FgtSHuxCFFEipVALOby2Wjhd3nLF352x7nsFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXW2+f//07fvUNfjFxPbkToWon5fGPJJ2ZAN2SjIGFg2fMK1gT+IZGoCm7VnlIx8TIEX6j7V7Vm3Tkk78E8QK9iJrwqo/fl+cA90c6kwpelffDE+tRHzKRjSOIs+Q1RLglsizznAyjUGJn9liYYP/A9vqnaRunPctBUf2Cz/fRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=EMr/+P6X; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=koFWoSw0 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1741081938; x=1772617938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iUsHT7BkvvVZ2doNOAGllF0BwQPdhpWqLZzk/yD8Vrc=;
  b=EMr/+P6XuzExp8oHwsL6J3+z1jWwE7i1B8aRlEw52/91RCB4McfXQuEO
   ghk8JBbIXLJ4d+gxOE32dRNQUWyA6LK9o4kLwZ+X3TWhEJ7RrIOF7rdLM
   ekkR1Us3KAhFvMPeprN0HR9bkd+afLqYwXcWMbkH1nE7r3+LVR/FOg3Ck
   fbD/NggBSzF9JNbMuVk94g3qeJjRENuNxDpPyNrk7eVSEWdTJPjOWnEdY
   6imDZ+Jx45wpW+ZPQGzTN4vyMoYwoBlUPDhVW3shgf/ZRbdSIm3X1Szus
   fQobYj9RKjeJQ4O/uxDme3qOu2SfFDUuuECZat91+wrmj7bfUq7ZeQSdd
   Q==;
X-CSE-ConnectionGUID: /bl8OXK5RaaGQPX/3aiVLQ==
X-CSE-MsgGUID: REU/aoFmSIOpOSZV6HugPg==
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="42262157"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 04 Mar 2025 10:52:14 +0100
X-CheckPoint: {67C6CD4E-28-97089932-E672704E}
X-MAIL-CPID: 628BE1DE09BC53C991B85770F1670AD8_3
X-Control-Analysis: str=0001.0A002111.67C6CD4E.00B4,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54FF116CC2F;
	Tue,  4 Mar 2025 10:52:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1741081930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUsHT7BkvvVZ2doNOAGllF0BwQPdhpWqLZzk/yD8Vrc=;
	b=koFWoSw09WVbwOj8YlQRnL11S9C72pwazdD9v2+cQHPuYzuVo+7ciykwETxJbylbU/Ycqg
	f82kmBhNIDF917h/CPFJcpQKdQJbCU6qE0fcNKX7/b9V0rLpz3jd3Vf72OBDBD0H3rqY7d
	muwWJfuGQpHWrhWNHbaqNtC2GGp2rBte7V8a3c6Gr9eGxM16HXtHGA3BRJRaBgdcr11rfK
	RDYryUbgqEOsN473Gj3/2gvVt49FEB6cgoJxboRSj4/vIC6EaLIEb2D2os2BL7VQ+tmvYu
	tX9akweDqLrAk/X0RVLQBIw6RJrY3bv5OaF7g5j/YA0NO7yBQaknRVhoxdRs2Q==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Liu Ying <victor.liu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, victor.liu@nxp.com, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, peng.fan@nxp.com,
 Conor Dooley <conor.dooley@microchip.com>
Subject:
 Re: [PATCH v5 1/2] dt-bindings: soc: imx93-media-blk-ctrl: Add PDFC subnode
 to schema and example
Date: Tue, 04 Mar 2025 10:52:05 +0100
Message-ID: <3348463.44csPzL39Z@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250304082434.834031-2-victor.liu@nxp.com>
References:
 <20250304082434.834031-1-victor.liu@nxp.com>
 <20250304082434.834031-2-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

thanks for the update.

Am Dienstag, 4. M=E4rz 2025, 09:24:33 CET schrieb Liu Ying:
> i.MX93 SoC mediamix blk-ctrl contains one DISPLAY_MUX register which
> configures parallel display format by using the "PARALLEL_DISP_FORMAT"
> field. Document the Parallel Display Format Configuration(PDFC) subnode
> and add the subnode to example.
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> v3->v5:
> * No change.
>=20
> v2->v3:
> * Newly introduced to replace the standalone dt-binding in v1 and v2. (Ro=
b)
> * Resend with Conor's R-b tag and with the patch rebased upon v6.11-rc1.
>=20
>  .../soc/imx/fsl,imx93-media-blk-ctrl.yaml     | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-bl=
k-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk=
=2Dctrl.yaml
> index b3554e7f9e76..3f550c30d93d 100644
> --- a/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.=
yaml
> +++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx93-media-blk-ctrl.=
yaml
> @@ -24,6 +24,12 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 1
> +
>    '#power-domain-cells':
>      const: 1
> =20
> @@ -46,9 +52,43 @@ properties:
>        - const: csi
>        - const: dsi
> =20
> +  bridge@60:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        const: nxp,imx93-pdfc
> +
> +      reg:
> +        maxItems: 1
> +
> +      ports:
> +        $ref: /schemas/graph.yaml#/properties/ports
> +
> +        properties:
> +          port@0:
> +            $ref: /schemas/graph.yaml#/properties/port
> +            description: Input port node to receive pixel data.
> +
> +          port@1:
> +            $ref: /schemas/graph.yaml#/properties/port
> +            description: Output port node to downstream pixel data recei=
vers.
> +
> +        required:
> +          - port@0
> +          - port@1
> +
> +    required:
> +      - compatible
> +      - reg
> +      - ports
> +
>  required:
>    - compatible
>    - reg
> +  - '#address-cells'
> +  - '#size-cells'
>    - power-domains
>    - clocks
>    - clock-names
> @@ -76,5 +116,33 @@ examples:
>                 <&clk IMX93_CLK_MIPI_DSI_GATE>;
>                 clock-names =3D "apb", "axi", "nic", "disp", "cam",
>                               "pxp", "lcdif", "isi", "csi", "dsi";
> +      #address-cells =3D <1>;
> +      #size-cells =3D <1>;
>        #power-domain-cells =3D <1>;
> +
> +      bridge@60 {

Given that you add a subnode, I would assume Rob's comment from [1]
also applies to you here.

Despite that, looks good to me. With that fixed:
Reviewed-by: Alexander Stein <alexander.stein@ew.tq-group.com>

[1] https://lore.kernel.org/all/20250225145833.GB2361434-robh@kernel.org/

> +        compatible =3D "nxp,imx93-pdfc";
> +        reg =3D <0x60 0x4>;
> +
> +        ports {
> +          #address-cells =3D <1>;
> +          #size-cells =3D <0>;
> +
> +          port@0 {
> +            reg =3D <0>;
> +
> +            pdfc_from_lcdif: endpoint {
> +              remote-endpoint =3D <&lcdif_to_pdfc>;
> +            };
> +          };
> +
> +          port@1 {
> +            reg =3D <1>;
> +
> +            pdfc_to_panel: endpoint {
> +              remote-endpoint =3D <&panel_from_pdfc>;
> +            };
> +          };
> +        };
> +      };
>      };
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



