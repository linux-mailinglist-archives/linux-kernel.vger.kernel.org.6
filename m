Return-Path: <linux-kernel+bounces-215515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDB190940D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 00:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8899CB22498
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 22:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679301862A2;
	Fri, 14 Jun 2024 22:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evd8s+CA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97951146A8E;
	Fri, 14 Jun 2024 22:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718403319; cv=none; b=ixUP5L/by4ax/J98AUE6/wD6gHivHr6PU3YOLHzK260g4Ux6hhx0ZQ74HwjyGK0en4UKkISBqC9gB1nspXETfKqqoL+ZMufFgL75s8GEOBH93Yq3MmSnurY1adLWwR6z4pcJq7e7m/ofZ9bdejf6931K8wERnQjWyfcz8Wa3hIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718403319; c=relaxed/simple;
	bh=1cjEIBWjtesSOy+Z3gVYh6H7ZTdBXSafNwRgGrntRso=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=lZu+C0Rb1ca4+Q4iuWYykNaCJRp+0YdQbPr8xht8NAnvPq+l1EcOIj5vIHDZzzhDj171+o9NH0C6mmjbXYf2Zgm2dGc21AaaLkZWMStPFKMfkrV3vBWWgGjBODrgiG4zilccJM41aQW6NYj9Pa/4gW3S1r6dFtU4N0XWu1C600s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=evd8s+CA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18A5C2BD10;
	Fri, 14 Jun 2024 22:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718403319;
	bh=1cjEIBWjtesSOy+Z3gVYh6H7ZTdBXSafNwRgGrntRso=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=evd8s+CAnFVf2kS1uuD2kMPKo1GZREY2x3ChpfAf7EScQiNCzRbjew9KHw0VYPmOi
	 N/LL2sCs1HvdySJ3SGyxrRb4DAB5R1y3PKxFPtBQ6bzonydYfp5RRBbIlIO+e6yBGG
	 m0MmPCAC9SmrVfKjf4VTF9wAk59Oto5YMXBTGXPWtBkCjHHR3cVwsEEI5PFs5yLSra
	 VqWuJDOutbFEsEk8HpW8u38oXDHxq9FJiJ4UAYmvGpb9u8cVyT0C40uvpqByeq76zL
	 m/23duFipAqg7oTvCLvMfiw9U9X2oxSsEPvd8WqKYwFAGdh1XTw4iHY05kTDnOlKLa
	 zvdyYmyQITYEQ==
Date: Fri, 14 Jun 2024 16:15:17 -0600
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>, 
 Stuart Yoder <stuyoder@gmail.com>, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240614213109.2518797-1-Frank.Li@nxp.com>
References: <20240614213109.2518797-1-Frank.Li@nxp.com>
Message-Id: <171840331790.1657462.8424849531522839529.robh@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: misc: fsl,qoriq-mc: convert to yaml
 format


On Fri, 14 Jun 2024 17:31:03 -0400, Frank Li wrote:
> Convert fsl,qoriq-mc from txt to yaml format.
> 
> Addition changes:
> - Child node name allow 'ethernet'.
> - Use 32bit address in example.
> - Fixed missed ';' in example.
> - Allow dma-coherent.
> - Remove smmu, its part in example.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 196 ------------------
>  .../bindings/misc/fsl,qoriq-mc.yaml           | 187 +++++++++++++++++
>  2 files changed, 187 insertions(+), 196 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.example.dtb: dpmac@1: $nodename:0: 'dpmac@1' does not match '^ethernet(@.*)?$'
	from schema $id: http://devicetree.org/schemas/net/fsl,qoriq-mc-dpmac.yaml#

doc reference errors (make refcheckdocs):
Warning: Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt*
Warning: MAINTAINERS references a file that doesn't exist: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt*
MAINTAINERS: Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240614213109.2518797-1-Frank.Li@nxp.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


