Return-Path: <linux-kernel+bounces-397237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FB79BD892
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 23:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACB51F2227E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 22:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CA021643D;
	Tue,  5 Nov 2024 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cY9hxH+C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF51E5022;
	Tue,  5 Nov 2024 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730845581; cv=none; b=aCQdHP8uOxpPdu/o4+svrqslE/fAqZew/KYYurShqLwBHKD6WUJc/C2U/cJChwDdyWlkE304tfoJHcHaTmxn9FrbYprmNAT4Lz/8sn0pIqKZGuB7lLuk+wqidAbO3LkTc6N+BeU6NLknzUmqE7bJt4dC4/wFQf/Xz1dGTDD0w5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730845581; c=relaxed/simple;
	bh=gUcGGAjg6ClSNd/HH7alKR6n2IzO8dsSIGyV+jGCjNA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=GzBYKctuoMego8vBb1dDSPc1dJ0SWfB8v4ePBPcpjeD7oWg+nMvVnQ4piRC+sl+mhAMfhOf+xiOTUy1e/O03HNkoSYtY6MwOYHc7vwfTmSQlycg5/eCvs/iBMCRmDQbEN35AboVslQtYbplYejT4cB8/p5EHRvWBSxDvze3i0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cY9hxH+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBB7C4CECF;
	Tue,  5 Nov 2024 22:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730845581;
	bh=gUcGGAjg6ClSNd/HH7alKR6n2IzO8dsSIGyV+jGCjNA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=cY9hxH+CDpYIqNX5TMw89reoBJFOBHf+zeZPOwcc7wblaoXteLaXcYApQh2k4k3wP
	 mZAGajYKVr+Li4EjHQy06meR6Z1w3036jK2TcCCLFPx4vYr3Mx5lEIxeRQzUd5wgm4
	 3G6PTUDU2VNl8x2WaBjlWei39jBoigMM91ebximln7HC98rT9vMYbbnPbxdFGHnnpD
	 k7IKXLcz/3wq7S69iXYUdwia2L7df7DWlZWa9O5wPuo1Zk0YciO6UXi1EmJybKypug
	 e+KQPgUkhNlaTC8UdgZe1lEjzirPO8t5/8ZvO9kvTsivbWb+cgGP8+rvQWk/ws5Pq+
	 5gMV01CX0XHcA==
Date: Tue, 05 Nov 2024 16:26:19 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20241105213232.443192-1-robh@kernel.org>
References: <20241105213232.443192-1-robh@kernel.org>
Message-Id: <173084557910.617337.976853252835079367.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Enable dtc "interrupt_provider" warnings


On Tue, 05 Nov 2024 15:32:32 -0600, Rob Herring (Arm) wrote:
> All the warnings from the "interrupt_provider" dtc check are fixed now,
> so enable the warning for the examples.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/Makefile            | 1 -
>  Documentation/devicetree/bindings/example-schema.yaml | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dts:27.33-39.11: Warning (interrupt_provider): /example-0/msi-controller@5d270000: Missing '#interrupt-cells' in interrupt provider
Documentation/devicetree/bindings/interrupt-controller/fsl,mu-msi.example.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.example.dts:22.55-31.15: Warning (interrupt_provider): /example-0/bus/msi-controller@33d00000: Missing '#interrupt-cells' in interrupt provider
Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.example.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
Documentation/devicetree/bindings/usb/cypress,cypd4226.example.dts:20.13-50.11: Warning (interrupt_provider): /example-0/i2c: '#interrupt-cells' found, but node is not an interrupt provider
Documentation/devicetree/bindings/usb/cypress,cypd4226.example.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.example.dts:26.14-48.11: Warning (interrupt_provider): /example-0/pmic: '#interrupt-cells' found, but node is not an interrupt provider
Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.example.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dts:24.23-47.11: Warning (interrupt_provider): /example-0/pcie@dfc00000: '#interrupt-cells' found, but node is not an interrupt provider
Documentation/devicetree/bindings/pci/snps,dw-pcie.example.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'
Documentation/devicetree/bindings/gpio/st,nomadik-gpio.example.dts:24.23-33.11: Warning (interrupt_provider): /example-0/gpio@8012e080: Missing '#interrupt-cells' in interrupt provider
Documentation/devicetree/bindings/gpio/st,nomadik-gpio.example.dtb: Warning (interrupt_map): Failed prerequisite 'interrupt_provider'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241105213232.443192-1-robh@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


