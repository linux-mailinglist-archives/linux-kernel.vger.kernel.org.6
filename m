Return-Path: <linux-kernel+bounces-399641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A06E99C0216
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 11:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63F6A283B08
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5891E909C;
	Thu,  7 Nov 2024 10:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxSjIUBd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640B81CC8A3;
	Thu,  7 Nov 2024 10:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974640; cv=none; b=jHTnvS/WJfGr6Oi6N/vBUYxZuJyJ6uu+cogUzkmCBOiKM/DvbMJsFLGQe7Gu9OjkfqI6aE5MgJMfqUirGIyipRz5zre04wadiFem3IG/QVTaDOcH+eX0s/Ds+ooZ/d5xp8x+zmtVdcf5EmZ2liVLEK/5IhQGZSJv5ABLD4+O2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974640; c=relaxed/simple;
	bh=ftccsi9pXS5GYpa1yQsXJVtN5jjl2k8iuGKq2B9q32U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ay1LtKAzmPMUOKPuVl+qIaCgHpJrPk8oieq0b1xU4ow6BwTr/2BeNlD6zKkRpnrjEoPRs4E9Lm4QXz0Q/vdgPom+MXfpsfHqe90MNu1UFgjIHFcSmH39Y91UtmjnzHyLxHOaMJlaLRQPKmjWWqPksn9xN3icwzKM4UO1vWzQU4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxSjIUBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A13DC4CED2;
	Thu,  7 Nov 2024 10:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730974639;
	bh=ftccsi9pXS5GYpa1yQsXJVtN5jjl2k8iuGKq2B9q32U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QxSjIUBdjmWTtcRcpmXznk3+uzGx6OZ5MaP2TX2QpIktW0c55qCsSgWRsaDfYQweM
	 341FnzzKv+aeXrcsVWZ98VZhEQBUum4/BB0KyDkHouTN179BqBuo33OrOULgnNRAjh
	 ChLGyerJKxLGrvYmxRToZhkqEd/FtFbwqLtaRz+we03h3FOPh7YlyPwzBOVMz8+70M
	 hMojf8oF8caz1SC7Za8td11CknAeoMMoTnMbx4UmH9PxUJuO2XqKoMFuxaf2EEjp9c
	 bX57oyk8qKYLDjvd1EnG3FJqg7PZB4G5OK6pOYwPJvfKNYS3WfL61CnI9iHZEL4qLu
	 3iv1tBJGKBsyw==
Date: Thu, 7 Nov 2024 11:17:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/2] dt-bindings: mtd: davinci: convert to yaml
Message-ID: <5r6j26qwcxyppxicdqih6tskb2qxkb5phzjtwqv47iqb4qupkp@zxujctq7ot6k>
References: <20241107-ondie-v6-0-f70905dc12bf@gmail.com>
 <20241107-ondie-v6-2-f70905dc12bf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241107-ondie-v6-2-f70905dc12bf@gmail.com>

On Thu, Nov 07, 2024 at 10:19:54AM +0100, Marcus Folkesson wrote:
> Convert the bindings to yaml format.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  .../devicetree/bindings/mtd/davinci-nand.txt       |  94 ---------------
>  .../devicetree/bindings/mtd/ti,davinci-nand.yaml   | 134 +++++++++++++++++++++
>  2 files changed, 134 insertions(+), 94 deletions(-)

...

> +allOf:
> +  - $ref: nand-controller.yaml
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,davinci-nand
> +      - ti,keystone-nand
> +
> +  reg:
> +    items:
> +      - description:
> +          Access window.

Merge two lines. See other files how they do it.

> +      - description:
> +          AEMIF control registers

Merge two lines

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0

These two properties are not needed, drop. I don't understand why did
they appear here. Changelog also does no explain it.

> +
> +  partitions:
> +    $ref: /schemas/mtd/partitions/partitions.yaml
> +
> +  ti,davinci-chipselect:
> +    description:
> +      Number of chipselect. Indicate on the davinci_nand driver which
> +      chipselect is used for accessing the nand.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +
> +  ti,davinci-mask-ale:
> +    description:
> +      Mask for ALE. Needed for executing address phase. These offset will be
> +      added to the base address for the chip select space the NAND Flash
> +      device is connected to.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x08
> +
> +  ti,davinci-mask-cle:
> +    description:
> +      Mask for CLE. Needed for executing command phase. These offset will be
> +      added to the base address for the chip select space the NAND Flash device
> +      is connected to.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0x10
> +
> +  ti,davinci-mask-chipsel:
> +    description:
> +      Mask for chipselect address. Needed to mask addresses for given
> +      chipselect.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +
> +  ti,davinci-ecc-bits:
> +    description: Used ECC bits.
> +    enum: [1, 4]
> +
> +  ti,davinci-ecc-mode:
> +    description: Operation mode of the NAND ECC mode.
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [none, soft, hw, on-die]
> +    deprecated: true
> +
> +  ti,davinci-nand-buswidth:
> +    description: Bus width to the NAND chip
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [8, 16]
> +    default: 8
> +    deprecated: true
> +
> +  ti,davinci-nand-use-bbt:
> +    type: boolean
> +    description:
> +      Use flash based bad block table support. OOB identifier is saved in OOB
> +      area.
> +    deprecated: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"

Drop these two.

> +  - ti,davinci-chipselect
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +      #address-cells = <2>;
> +      #size-cells = <1>;
> +
> +      nand-controller@2000000,0 {
> +        compatible = "ti,davinci-nand";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        reg = <0 0x02000000 0x02000000
> +        1 0x00000000 0x00008000>;

Two items must be encoded as two items, so two <> <>
Also messed alignment. See DTS coding style.

> +
> +        ti,davinci-chipselect = <1>;
> +        ti,davinci-mask-ale = <0>;
> +        ti,davinci-mask-cle = <0>;
> +        ti,davinci-mask-chipsel = <0>;
> +
> +        ti,davinci-nand-buswidth = <16>;
> +        ti,davinci-ecc-mode = "hw";
> +        ti,davinci-ecc-bits = <4>;
> +        ti,davinci-nand-use-bbt;
> +
> +        partitions {

Where are the partitions documented? In which binding? Don't you miss
mtd.yaml? I think this binding misses some references, but I am not sure
which ones.

Best regards,
Krzysztof


