Return-Path: <linux-kernel+bounces-208817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A60E9902987
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 21:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6581F22F63
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3285F14F9C4;
	Mon, 10 Jun 2024 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHORytuV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153D14EC48;
	Mon, 10 Jun 2024 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718049314; cv=none; b=M2CiMSlotseVqV/rojB1LsZN/tqnnzwlOqzrnP3X1RxAHeKz6tLPyCkRuxUlp1SjYN4iQwotjZzLaMg73t8T4nbHUU0GHi8UtQ+sP77SlazvpcrAzYM16nYD0AU1jDGvCILbZSMoyfZ9Bi9TIYQZt5wYPhX1LVZr2tA5/QlB+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718049314; c=relaxed/simple;
	bh=xNHUb4ovz8AJyryZLDu5iujyhhcwpfdIbyJBEUYUBMw=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=RtecUIWbvAr9EYknKSnQrAEP5Nj/On0ctqbCw+Ece98H00FSfhNuqUU6lKZxepEBOkW0bf9TUmqi5pObC6GRMi1epEyApIgdEFqnWVq6ueS7wkeeo1aXUn17H56mGXEoA11+Evumk2vJdDaDCFgYCyucl2/oj4ElpCaXDZNUQX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHORytuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FDAC2BBFC;
	Mon, 10 Jun 2024 19:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718049314;
	bh=xNHUb4ovz8AJyryZLDu5iujyhhcwpfdIbyJBEUYUBMw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=oHORytuVkl5rJaED39nn09Zd4t3v7c3yUb7SPtZr16hPjsgYob63bWh0xAQBRl57x
	 DQF860bkGHdRMikuVCLu/5APyPUWruBqHse762MEL4I8ytvFRVRu2y5t58qPDEYfAa
	 wSTrkatNpX0E5pD/IFUiHr9M81iDweGo/rWozSCWHM4Mg4yxzlWQaW1tLHeuLUgsam
	 59WnrWolp4vkJdi/zywyFzdO/YRQOdhAidCIoE5ZelcwO/mo7dDjOeslA/jpDF8feK
	 C3kW+stE4zJR254C2CSU2aK0jURNxTPDeNvZjSDLpa5NIjC8hS+10NIJyHX7hkTG3k
	 7FJaY8pIFfddg==
Date: Mon, 10 Jun 2024 13:55:12 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Li Yang <leoyang.li@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240610081913.46790-1-alexander.stein@ew.tq-group.com>
References: <20240610081913.46790-1-alexander.stein@ew.tq-group.com>
Message-Id: <171804879912.2984722.5962641990497405720.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: add MBa8MP-RAS314 SBC


On Mon, 10 Jun 2024 10:19:12 +0200, Alexander Stein wrote:
> MBa8MP-RAS314 is an SBC based on the embedded module TQMa8MPxL.
> All relevant interfaces integrated in the CPU have been implemented on
> the MBa8MP-RAS314 for (an) industrial usage. Due to the numerous interfaces
> and the small size of this SBC the use in different applications
> is possible without the need of a [special,custom] design.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-tqma8mpql-mba8mp-ras314.dtb' for 20240610081913.46790-1-alexander.stein@ew.tq-group.com:

arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314.dtb: interrupt-controller@32fc2000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#






