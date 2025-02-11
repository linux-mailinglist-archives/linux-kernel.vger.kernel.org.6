Return-Path: <linux-kernel+bounces-510162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22412A3190A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 23:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0271679BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C25262D1A;
	Tue, 11 Feb 2025 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ci3ny5AV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A374272905;
	Tue, 11 Feb 2025 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739314328; cv=none; b=LQCtf0EAbJQmtN0h3dPI3qPHOut5HsR0GnfHb4xY3ERf9fD2pJMWTwy0bHvoNgQTE3XtrDZyr+Y9ZHyjCDgJOKfsgV/WrnEsW3bEQT7ZBw0T4sHXvfYF62izbyW1rnd2xoqmdHfEcVyEDeYFDwmRsW1Utfd0/HDdMkYm0m7ApsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739314328; c=relaxed/simple;
	bh=DQYkM4ufN/n8fXrucc3V3ZOmG/KXTPHm940bJ+L/nRo=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=H+AaFXpWZVvS+fMoFKIUkdbUtXaZ18gERwGzXPGAMdfplPO0n1Ak2MlPUYyMN2M2wMo/T78QPpwZZbKOgZwGevY/TJvSu+Ckg3hJsOKCHh3SYV3Xg1OL0mK89RipFlX9kTDqWyRvENUTVdp0ThfbR2wJmr4WFaLovSuEmSqN8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ci3ny5AV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCBFC4CEDD;
	Tue, 11 Feb 2025 22:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739314327;
	bh=DQYkM4ufN/n8fXrucc3V3ZOmG/KXTPHm940bJ+L/nRo=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Ci3ny5AVly53CuRUMaV1XGNdXJJTMrWd41HwtrQv7r8BWqQIzQNx5fJQYMWsWzWeb
	 iRhKPe5TPRGRWyDNLxPyLJkCGxO94ZgseKlQrmani83xOIQbeXHClPXhrwhR5qSum/
	 JH85r7/gvE3WFBrGkI22up/qLHU17iW7UVuDfIGUQo2O9XXpOW2fKAJEwRaSFG6RlD
	 pDtvhILqEGHRJvB/f5mKK1EnUFsjE9nBXxmkj9O+4hm4tdOZfBgPwTdJOOR5j5AEJK
	 ssVkNQ9NYCRpWZ3xH1G2nCEqGAJ0XfGcoa2HRgpiV8/anapxxCI1hGhR0VGMhjSQTe
	 08PQt7vr+mZ4A==
Date: Tue, 11 Feb 2025 16:52:06 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, nicolas.ferre@microchip.com, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev, krzk+dt@kernel.org, 
 conor+dt@kernel.org
To: Mihai Sain <mihai.sain@microchip.com>
In-Reply-To: <20250211143302.4102-1-mihai.sain@microchip.com>
References: <20250211143302.4102-1-mihai.sain@microchip.com>
Message-Id: <173931425548.1387873.8595837512080490773.robh@kernel.org>
Subject: Re: [PATCH 0/2] Add power monitor support on sama7d65-curiosity
 board


On Tue, 11 Feb 2025 16:33:00 +0200, Mihai Sain wrote:
> This patch series adds power monitor support on Microchip SAMA7D65 Curiosity board.
> 
> [root@SAMA7D65 ~]$ lsiio
> Device 001: pac1934
> Device 000: e1000000.adc
> 
> [root@SAMA7D65 ~]$ awk -f pac1934.awk
> VDD3V3   current: 146.173 mA, voltage: 3302.73 mV
> VDDIODDR current: 62.1356 mA, voltage: 1353.96 mV
> VDDCORE  current: 242.248 mA, voltage: 1204.36 mV
> VDDCPU   current: 213.565 mA, voltage: 1303.05 mV
> 
> Mihai Sain (2):
>   ARM: dts: microchip: sama7d65: Add flexcom 10 node
>   ARM: dts: microchip: sama7d65_curiosity: Add power monitor support
> 
>  .../dts/microchip/at91-sama7d65_curiosity.dts | 52 +++++++++++++++++++
>  arch/arm/boot/dts/microchip/sama7d65.dtsi     | 21 ++++++++
>  2 files changed, 73 insertions(+)
> 
> 
> base-commit: febbc555cf0fff895546ddb8ba2c9a523692fb55
> --
> 2.48.1
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


New warnings running 'make CHECK_DTBS=y for arch/arm/boot/dts/microchip/' for 20250211143302.4102-1-mihai.sain@microchip.com:

arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: flexcom@e2824000: compatible: 'oneOf' conditional failed, one must be fixed:
	['microchip,sama7d65-flexcom', 'atmel,sama5d2-flexcom'] is too long
	'atmel,sama5d2-flexcom' was expected
	'microchip,sam9x7-flexcom' was expected
	'microchip,sama7g5-flexcom' was expected
	from schema $id: http://devicetree.org/schemas/mfd/atmel,sama5d2-flexcom.yaml#
arch/arm/boot/dts/microchip/at91-sama7d65_curiosity.dtb: /soc/flexcom@e2824000: failed to match any schema with compatible: ['microchip,sama7d65-flexcom', 'atmel,sama5d2-flexcom']






