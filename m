Return-Path: <linux-kernel+bounces-179226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBD98C5DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 00:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477FF283B93
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 22:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34D1182C82;
	Tue, 14 May 2024 22:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGiQtCwc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ADD1DDEE;
	Tue, 14 May 2024 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715726151; cv=none; b=qiDkAkX/Imgv8sKFnNUW3MCnbCthCHJeL+nzB+Mkrs92019aP/8usinf5inWpQlGG4mzntix825YsM0SOm7DvzBMta0kLG/riwuraLr5G8CimsppL7XnA0hRUpQKr0fmmU0uTY0irzkFNO+H16i9JwdzypN7yBGoJ62YtwHDJZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715726151; c=relaxed/simple;
	bh=x7tUxf7jfIVDoQyzXs6S/E8tZSxfh6CAU+jLxpsTgbQ=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=t5UYgJlZpG5IirlVod7gRBXVSUPYbmDafsMkeGR7B6tFSkD2Q95bfTPQw+AkMYhE1nu6g4wtxDikVxTo9iYMDjzYQ/Murf/s86shFZftrUbx/H+uiV8ROxRSZpxcfb2umWzLH+fw3vN6lnI2adfX+jcMAmAtaRrmI6KdsCX/ARo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGiQtCwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669E6C2BD10;
	Tue, 14 May 2024 22:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715726150;
	bh=x7tUxf7jfIVDoQyzXs6S/E8tZSxfh6CAU+jLxpsTgbQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WGiQtCwcvpIFYCaEfv0VX2ev/dp60ppCc3OmYH+/oLaM6BoDiziPnYU2FFBsOnslU
	 PaEh4PZPeYsJPnMiEGzN677cNKieI7oUatv6Fsh9vR2zlEdttICtInbQi5HjlGl3yk
	 B1q+SjEvx6daWjA+5IQqruHkxC5mzO0/h2xxgiTN3L0pa1NjsfJIHh/pri4+QVlXE0
	 Zq76EbqOCpWn0nS30zAVhV9fNTuGmyE6NSkMPdNY1GD6Zx2Ev5suYeVf8+yK3wVMdS
	 /lSth/CUi8xWQvypdaTBS3NuzCVW5v0D1ysboER9UfcgI1ol407bGrLfIQqu8KpjIp
	 erY6MKj97ZLbw==
Date: Tue, 14 May 2024 17:35:49 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Eddie James <eajames@linux.ibm.com>
Cc: joel@jms.id.au, krzk+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-fsi@lists.ozlabs.org, andrew@codeconstruct.com.au, 
 conor+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240514195435.155372-2-eajames@linux.ibm.com>
References: <20240514195435.155372-1-eajames@linux.ibm.com>
 <20240514195435.155372-2-eajames@linux.ibm.com>
Message-Id: <171572614925.2391901.12172648988051515568.robh@kernel.org>
Subject: Re: [PATCH v5 1/9] dt-bindings: fsi: fsi2spi: Document SPI
 controller child nodes


On Tue, 14 May 2024 14:54:27 -0500, Eddie James wrote:
> The FSI2SPI bridge has several SPI controllers behind it, which
> should be documented. Also, therefore the node needs to specify
> address and size cells.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Depends on https://lore.kernel.org/all/20240514192630.152747-1-eajames@linux.ibm.com/
> 
>  .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  | 36 ++++++++++++++++---
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/spi/ibm,spi-fsi.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.example.dtb: fsi2spi@1c00: spi@0: False schema does not allow {'compatible': ['ibm,spi-fsi'], 'reg': [[0]], '#address-cells': [[1]], '#size-cells': [[0]], 'eeprom@0': {'compatible': ['atmel,at25'], 'reg': [[0]], 'address-width': [[24]], 'pagesize': [[256]], 'size': [[524288]], 'spi-max-frequency': [[1000000]]}}
	from schema $id: http://devicetree.org/schemas/fsi/ibm,fsi2spi.yaml#
Documentation/devicetree/bindings/fsi/ibm,fsi2spi.example.dtb: /example-0/fsi2spi@1c00/spi@0: failed to match any schema with compatible: ['ibm,spi-fsi']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240514195435.155372-2-eajames@linux.ibm.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


