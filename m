Return-Path: <linux-kernel+bounces-290332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 435F6955254
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84B11F244F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D35F1C579C;
	Fri, 16 Aug 2024 21:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhwwgOzz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DE781AD7;
	Fri, 16 Aug 2024 21:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843662; cv=none; b=J3j4xxyx8OFMvlKmSQdnDmtGnm1b/9RK5VIHcaoMISPOPNeXnc/QE18l7qHTiQY8CGyCQlT3ANyIML2uYbFqTkdjtbRDFczsupbfexx6vGXZYEl+ANmrG9GhEKJmeKrKv64aApVdQPIFfYPpoSwEA/DKwFkAemidJFs+3FvBJCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843662; c=relaxed/simple;
	bh=nB7RxrnkIVm50snYE//BPyweHApZH+gsW/nw8YAi54g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQYksONiNNwGt8uo6sBqUCMisEbOoVrWt+gj5+ehKwOQzQ8zu3fe7WKSsgkvk0mygPYWWOxUn6UYgf2W37WLAt/ifC5T18L77ge+ozIOYzikJfF0XPYYoO/Y8lN72fMmY1Wxpc+yD5rOwVb8owglq+07B/WCaGy6UG+i4T7aT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhwwgOzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D80C32782;
	Fri, 16 Aug 2024 21:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723843662;
	bh=nB7RxrnkIVm50snYE//BPyweHApZH+gsW/nw8YAi54g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhwwgOzzgyCvbZNFrbpRHjV0NoeqojEnmEgM5lHW15QkKUQqX8uIFS420OYRilZ9s
	 EG5n3wryZ57mVmqVWG8nRW+i0y9Gp+G7v/peqPkLnbfI7poCs5Pj3pI+zhNFtr9BbP
	 Lw/sH6tKyR/wTvVp1J6XTJBWAcNoq1FjnBLOq4ligugdkQSxKzFVvhEQa4wm0l+Lg3
	 UUGYkuQoUJgRv7857zSDdVOTF5cgg6adRVtYayanWfSPXXrS6uTvCF9w1ueJpOUDTV
	 O1NegIWFngk53Zp/roRnaYEG+Tojk/xcmuEPAxavsIB9N+7KVshV9rBinGlmohu+Ei
	 I35BH0ukCnbng==
Date: Fri, 16 Aug 2024 15:27:41 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: board: convert fsl-board.txt to yaml
Message-ID: <20240816212741.GA2225734-robh@kernel.org>
References: <20240813163638.3889778-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813163638.3889778-1-Frank.Li@nxp.com>

On Tue, Aug 13, 2024 at 12:36:29PM -0400, Frank Li wrote:
> Convert binding doc fsl-board.txt to yaml format. split to 3 part
> fsl,bcsr.yaml, fsl,fpga-qixis.yaml, fsl,fpga-qixis-i2c.yaml
> 
> Additional change for fsl,fpga-qixis.yaml
> - Add childnode mdio-mux-emi*
> - Add compatible string fsl,ls1043aqds-fpga, fsl,ls1043ardb-fpga,
> fsl,ls1046aqds-fpga, fsl,ls1046ardb-fpga, fsl,ls208xaqds-fpga,
> fsl,ls1043ardb-cpld, fsl,ls1046ardb-cpld, fsl,ls1088aqds-fpga,
> fsl,ls1088ardb-fpga, fsl,ls2080aqds-fpga, fsl,ls2080ardb-fpga.
> - Change address to 32bit in example.
> 
> Additional change for fsl,fpga-qixis-i2c.yaml
> - Add mux-controller
> - Add compatible string fsl,ls1028aqds-fpga, fsl,lx2160aqds-fpga
> 
> Fix below warning:
> 
> arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dtb: /soc/i2c@2000000/fpga@66: failed to match any schema with compatible: ['fsl,ls1028aqds-fpga', 'fsl,fpga-qixis-i2c', 'simple-mfd']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - drop description in fsl,bcsr.yaml
> - bsc9132qds is too old, their dts have not simple-mfd.
> - split qixis-i2c compatible to two group, one with simple-mfd and the
> other one without simple-mfd.
> - Add new full example for ls1028
> - Remove [0-9], keep @ for mdio-mux-emi. Dts need be update to avoid
> warning
> - fix typo dt-binding in subject
> ---
>  .../devicetree/bindings/board/fsl,bcsr.yaml   | 32 ++++++++
>  .../bindings/board/fsl,fpga-qixis-i2c.yaml    | 70 ++++++++++++++++
>  .../bindings/board/fsl,fpga-qixis.yaml        | 81 +++++++++++++++++++
>  .../devicetree/bindings/board/fsl-board.txt   | 81 -------------------
>  .../boot/dts/freescale/fsl-ls1043a-qds.dts    |  2 +-
>  5 files changed, 184 insertions(+), 82 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/board/fsl,bcsr.yaml
>  create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
>  create mode 100644 Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
>  delete mode 100644 Documentation/devicetree/bindings/board/fsl-board.txt
> 
> diff --git a/Documentation/devicetree/bindings/board/fsl,bcsr.yaml b/Documentation/devicetree/bindings/board/fsl,bcsr.yaml
> new file mode 100644
> index 0000000000000..df3dd8399671f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/board/fsl,bcsr.yaml
> @@ -0,0 +1,32 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/board/fsl,bcsr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Board Control and Status
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,mpc8360mds-bcsr
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    board@f8000000 {
> +        compatible = "fsl,mpc8360mds-bcsr";
> +        reg = <0xf8000000 0x8000>;
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml b/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
> new file mode 100644
> index 0000000000000..28b37772fb656
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/board/fsl,fpga-qixis-i2c.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/board/fsl,fpga-qixis-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale on-board FPGA connected on I2C bus
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,bsc9132qds-fpga
> +          - const: fsl,fpga-qixis-i2c
> +      - items:
> +          - enum:
> +              - fsl,ls1028aqds-fpga
> +              - fsl,lx2160aqds-fpga
> +          - const: fsl,fpga-qixis-i2c
> +          - const: simple-mfd
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  mux-controller:
> +    $ref: /schemas/mux/reg-mux.yaml
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        board-control@66 {
> +            compatible = "fsl,bsc9132qds-fpga", "fsl,fpga-qixis-i2c";
> +            reg = <0x66>;
> +        };
> +    };
> +
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        board-control@66 {
> +            compatible = "fsl,ls1028aqds-fpga", "fsl,fpga-qixis-i2c",
> +                         "simple-mfd";
> +            reg = <0x66>;
> +
> +            mux-controller {
> +                compatible = "reg-mux";
> +                #mux-control-cells = <1>;
> +                mux-reg-masks = <0x54 0xf0>; /* 0: reg 0x54, bits 7:4 */
> +            };
> +        };
> +    };
> +
> diff --git a/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml b/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
> new file mode 100644
> index 0000000000000..4d4eb45ce64cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/board/fsl,fpga-qixis.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/board/fsl,fpga-qixis.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale on-board FPGA/CPLD
> +
> +maintainers:
> +  - Frank Li <Frank.Li@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: fsl,p1022ds-fpga
> +          - const: fsl,fpga-ngpixis
> +      - items:
> +          - enum:
> +              - fsl,ls1088aqds-fpga
> +              - fsl,ls1088ardb-fpga
> +              - fsl,ls2080aqds-fpga
> +              - fsl,ls2080ardb-fpga
> +          - const: fsl,fpga-qixis
> +      - items:
> +          - enum:
> +              - fsl,ls1043aqds-fpga
> +              - fsl,ls1043ardb-fpga
> +              - fsl,ls1046aqds-fpga
> +              - fsl,ls1046ardb-fpga
> +              - fsl,ls208xaqds-fpga
> +          - const: fsl,fpga-qixis
> +          - const: simple-mfd
> +      - enum:
> +          - fsl,ls1043ardb-cpld
> +          - fsl,ls1046ardb-cpld
> +          - fsl,t1040rdb-cpld
> +          - fsl,t1042rdb-cpld
> +          - fsl,t1042rdb_pi-cpld
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  ranges:
> +    maxItems: 1
> +
> +patternProperties:
> +  '^mdio-mux-emi@[a-f0-9]+$':

If we're going to update the dts file, this should be 'mdio-mux@'. I'll 
fix this when applying. The rest looks good.

Note that p5040ds.dts has 2 nodes at the same reg address, but different 
bit offsets. The way we handle that is adding the register starting bit 
offset to the unit-address like this:

mdio-mux@9,1 (mux-mask 0x6)
mdio-mux@9,3 (mux-mask 0x78)

Rob

