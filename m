Return-Path: <linux-kernel+bounces-225420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6975D913058
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 00:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A39B250DB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 22:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFAE16EC12;
	Fri, 21 Jun 2024 22:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV9Dv8BN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF1208C4;
	Fri, 21 Jun 2024 22:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009174; cv=none; b=g1AeMl1cXePmmf1dMUtQUtae8oM2CzECPmnhZle2YpV8xpiWjv50NrqrsLbqxKaCTX/qxHXdez/i/wzSVDeFYqcwYgLZ3mn36Ef5xXm+0lfEe82naYiUof2i+ruWX5SNX0yRJtl5vNNtO723kyveJemz5g2272deaaSjI2fPBJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009174; c=relaxed/simple;
	bh=KXVxfZHfpI1nU0S3z0qKOarDKcIzLrtglGhKI5R1SUs=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=j8Axr0pCYpAcbrBVcW2Nyf0Ev5Ci2dfBLbQFRAj78i/6FfLI1ahFq5MDLxXXDb4N7RGOk1ZQWNYECvQpoCuiorKI2qdTjqwGLE47v3Kbg6dWRr/zgoEXRRXVvhsyZ8cnjB/TI/XffcxwaGcoon2iij0DgXI/NkIkR4g1+Zg7vWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV9Dv8BN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E4EAC2BBFC;
	Fri, 21 Jun 2024 22:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719009174;
	bh=KXVxfZHfpI1nU0S3z0qKOarDKcIzLrtglGhKI5R1SUs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=GV9Dv8BN2goGDdRHEmgBYU4ObMqDVwbRwlqj2UTre0tBUaQnHUCfNh1QScxEMGFIs
	 fvzzT8NY9R+19v8Q9qrDsFGgRR7F6hMvpbzw7kTBeKrL3/g40utOAGP+j2kI5/iub6
	 nWY7ZDgoFOMi7QDQz0Tdci2WXZHWKFnBw+gOcR6kIxZWzaDsaHNf7aHd1KrDRdI/eo
	 JAxbl9oyIYIKYX5UnUw/4pSmmAlUK7xtxAYziNKJJaDNcuYJuZXiSCKXP2un/8xPM9
	 gvkG1IBI27nBXtH+WEvVsJkT+D32V3SzfRQA487LQHdIevPnXoSnixLtQy3vyRhRzD
	 s7hSdHFQ1J3oQ==
Date: Fri, 21 Jun 2024 16:32:53 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 imx@lists.linux.dev
In-Reply-To: <20240621213031.2759046-1-Frank.Li@nxp.com>
References: <20240621213031.2759046-1-Frank.Li@nxp.com>
Message-Id: <171900917306.3197721.16899253855832126411.robh@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: soc: fsl: Convert q(b)man-* to yaml
 format


On Fri, 21 Jun 2024 17:30:14 -0400, Frank Li wrote:
> Convert qman, bman, qman-portals, bman-portals to yaml format.
> 
> Additional Chang for fsl,q(b)man-portal:
> - Only keep one example.
> - Add fsl,qman-channel-id property.
> - Use interrupt type macro.
> - Remove top level qman-portals@ff4200000 at example.
> 
> Additional change for fsl,q(b)man:
> - Fixed example error.
> - Remove redundent part, only keep fsl,qman node.
> - Change memory-regions to memory-region.
> - fsl,q(b)man-portals is not required property
> 
> Additional change for fsl,qman-fqd.yaml:
> - Fixed example error.
> - Only keep one example.
> - Ref to reserve-memory.yaml
> - Merge fsl,bman reserver memory part
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/soc/fsl/bman-portals.txt         |  56 ------
>  .../devicetree/bindings/soc/fsl/bman.txt      | 137 -------------
>  .../bindings/soc/fsl/fsl,bman-portal.yaml     |  51 +++++
>  .../devicetree/bindings/soc/fsl/fsl,bman.yaml |  83 ++++++++
>  .../bindings/soc/fsl/fsl,qman-fqd.yaml        |  68 +++++++
>  .../bindings/soc/fsl/fsl,qman-portal.yaml     | 110 +++++++++++
>  .../devicetree/bindings/soc/fsl/fsl,qman.yaml |  97 +++++++++
>  .../bindings/soc/fsl/qman-portals.txt         | 134 -------------
>  .../devicetree/bindings/soc/fsl/qman.txt      | 187 ------------------
>  9 files changed, 409 insertions(+), 514 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/bman-portals.txt
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/bman.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,bman-portal.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,bman.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,qman-fqd.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,qman-portal.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/fsl/fsl,qman.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/qman-portals.txt
>  delete mode 100644 Documentation/devicetree/bindings/soc/fsl/qman.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/fsl/fsl,bman-portal.example.dtb: /example-0/bman-portal@0: failed to match any schema with compatible: ['fsl,bman-portal-1.0.0', 'fsl,bman-portal']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240621213031.2759046-1-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


