Return-Path: <linux-kernel+bounces-337893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1512B9850C1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67951F24937
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321D3148856;
	Wed, 25 Sep 2024 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iX+8Aqw+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA531487C0;
	Wed, 25 Sep 2024 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727229414; cv=none; b=GkYeQr2Yfuh6hrFxjJXFAo4nI7K7dWprp9cnKfXBoyd6InwSJYfaSLjBZsEYBCXAQth8QdWlY7oVQCQCIvLGF3HsGf1NICG+isV26SAz/rZRK2R+lr8whTnvPEhQIUWuKZgfcu/B7i3qOmKAwg5dHm4maMU+NVIdFaYkgz1YJIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727229414; c=relaxed/simple;
	bh=2FR2lsQ9RHony3xyGMav8cplOjjTHD0taQFKJB8JjPI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=PqvpVXwFDeb4d45Q4MLCXBDAmza39OMnu+ACEWhEac5OoIy3xh10Eg5/20QhO4Xqf7BYN89yjIGYVeHVko8PuZqlY+jJgLmM9hcUrI/cPKLmZwba5/AmrbM0QtR+Q7Q4C/odQfgZ2ya3TfMIuADxZ+xkMmz7RTpuUbmOAuyxzr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iX+8Aqw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE85C4CED0;
	Wed, 25 Sep 2024 01:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727229414;
	bh=2FR2lsQ9RHony3xyGMav8cplOjjTHD0taQFKJB8JjPI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=iX+8Aqw+c5kOdnx6zsUqUeaKrlbLirtyOX0E7mhbJYz9eW001SadVFWecwA8+zhZO
	 7SNjjr71xqKKaOUSMXncr+SQvcctg93u2SVGuqw3+V8s4wGg8nZoAk0tAB0kxjVNdb
	 nSVnihVFWbP5OLmOuRJMOYiYHL/QDIC+sthOpV6rJQezhCr5HW2k8PWdgGmEJ9SG92
	 26XCbKcaQwvzUPcXtPU4dp9reVZJonuIVAEqJ+u+kRg+zaapNIXwbyW5qsfKFxe3h6
	 l76tbHdM1Ivjo+hcJ782HQTQRBlLUyEHFBqSR0E+hD5Jb+QsW4qMkJaUS4fAK1GHLs
	 Wf9iQiYLVkxpg==
Date: Tue, 24 Sep 2024 20:56:53 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240924120044.130913-1-francesco@dolcini.it>
References: <20240924120044.130913-1-francesco@dolcini.it>
Message-Id: <172722910864.836153.9736556461477683432.robh@kernel.org>
Subject: Re: [PATCH v1 0/3] arm64: dts: ti: k3-am62-verdin: Add Ivy carrier
 board


On Tue, 24 Sep 2024 14:00:41 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add support for the Toradex Verdin AM62 Ivy carrier board. Ivy is a carrier
> board designed for industrial environments, supporting industrial
> I/O interfaces such as CAN, RS485, RS232, Gigabit Ethernet, 0-25mA analog
> inputs, relays, PCIe and more. The board also includes a TPM for security
> applications.
> 
> https://www.toradex.com/products/carrier-board/ivy-carrier-board
> 
> João Paulo Gonçalves (3):
>   dt-bindings: arm: ti: Add verdin am62 ivy board
>   arm64: dts: ti: k3-am62-verdin: add label to som adc node
>   arm64: dts: ti: k3-am62-verdin: Add Ivy carrier board
> 
>  .../devicetree/bindings/arm/ti/k3.yaml        |   2 +
>  arch/arm64/boot/dts/ti/Makefile               |   2 +
>  .../arm64/boot/dts/ti/k3-am62-verdin-ivy.dtsi | 655 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi    |   3 +-
>  .../dts/ti/k3-am625-verdin-nonwifi-ivy.dts    |  22 +
>  .../boot/dts/ti/k3-am625-verdin-wifi-ivy.dts  |  22 +
>  6 files changed, 705 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-ivy.dtsi
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-ivy.dts
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-ivy.dts
> 
> --
> 2.39.5
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y ti/k3-am625-verdin-nonwifi-ivy.dtb ti/k3-am625-verdin-wifi-ivy.dtb' for 20240924120044.130913-1-francesco@dolcini.it:

arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-ivy.dtb: syscon@43000000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#
arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-ivy.dtb: syscon@43000000: compatible: ['syscon', 'simple-mfd'] is too short
	from schema $id: http://devicetree.org/schemas/mfd/syscon-common.yaml#






