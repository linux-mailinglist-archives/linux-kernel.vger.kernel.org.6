Return-Path: <linux-kernel+bounces-415581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B079D3884
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7DC282589
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F344D19D894;
	Wed, 20 Nov 2024 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="X1CZSjvK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFFB158D6A;
	Wed, 20 Nov 2024 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099221; cv=none; b=BNu37DZfF2vY34lhJiYXGjj24SWrBNYkLIFAdQxNgYRbD9Hb8P4If0V08vxDUsYjYEcVSyG/swF5RL8omqL2Oa7zmSCkZFI999PRl7CxXvpGrCG7hyfahJmzGTcrpyL2kd0wk3zf+mMWHaoJ5+7XdkNXoDqEuTwTrSE0bp5XO7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099221; c=relaxed/simple;
	bh=fTRY04llbBVBWiEO+xunTY1d92zdPHAjRvFRVXTHeok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CcXGv/pAJMODb8Yi8e/8pUoj3Rx1n+zxmHVG9G+PkutZqXnt33kI/pc6g3il4dgNZk6rZ55Nrv9WOJXHzrTLfmP0WWjE4x2B7t5ZUx2/lY818uZg59ac2IZX44tyPv7FeqPcFoeC8q9k0afcgwcam1vQC39+kgDxFmqox6cOhVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=X1CZSjvK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732099219; x=1763635219;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fTRY04llbBVBWiEO+xunTY1d92zdPHAjRvFRVXTHeok=;
  b=X1CZSjvKLYwb5dOTgJ33ltv0+30lLHnaut1Rt3Kyk4Z4RT7dw0YhvscJ
   bM9xZCOJOb5/vZFuVXRmtGZaA8NzMRLbD+woG2YkiCdElGliEmY9Nw40v
   isgW961aHVQw8Mv110q6iQDjbnGVaLUzpzpxDyfQbmOYHF8bTtAAoQhOc
   vyMlWRqFWAIlaETB00mH3xAKDMHiKd+Ulv5IZ9cM50ddHn+3DQVJpd8ot
   JmcbYlyqfsPGhumC6A45+VRwJM/awbaqSYpZFm2hflFm8DIJhknAS/zwq
   g1Uki994ojeM7kqmbslTUPE9b3L+wYFCrWP2kmP/nB+dI4nHMFgpK0hf1
   w==;
X-CSE-ConnectionGUID: J7Gote/ISpu5A3XFNDgkXw==
X-CSE-MsgGUID: ab5CMNlNT0mpNAYCosVE3w==
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="38122779"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2024 03:40:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Nov 2024 03:40:11 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 20 Nov 2024 03:40:07 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <cristian.birsan@microchip.com>
CC: <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, <krzk+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<mihai.sain@microchip.com>, <nicolas.ferre@microchip.com>, <robh@kernel.org>,
	Andrei Simion <andrei.simion@microchip.com>
Subject: Re: [PATCH 2/2] ARM: dts: microchip: sama5d27_wlsom1_ek: Add no-1-8-v property to sdmmc0 node
Date: Wed, 20 Nov 2024 12:39:47 +0200
Message-ID: <20241120103946.49779-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119160107.598411-3-cristian.birsan@microchip.com>
References: <20241119160107.598411-3-cristian.birsan@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

> From: Cristian Birsan <cristian.birsan@microchip.com>
>
> Add no-1-8-v property to sdmmc0 node to keep VDDSDMMC power rail at 3.3V.
> This property will stop the LDO regulator from switching to 1.8V when the
> MMC core detects an UHS SD Card. VDDSDMMC power rail is used by all the
> SDMMC interface pins in GPIO mode (PA0 - PA13).
>
> On this board, PA10 is used as GPIO to enable the power switch controlling
> USB Vbus for the USB Host. The change is needed to fix the PA10 voltage
> level to 3.3V instead of 1.8V.
>
> Fixes: 5d4c3cfb63fe ("ARM: dts: at91: sama5d27_wlsom1: add SAMA5D27 wlsom1 and wlsom1-ek")
> Suggested-by: Mihai Sain <mihai.sain@microchip.com>
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>

Hi,

Tested-by: Andrei Simion <andrei.simion@microchip.com>

> ---
>  arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
> index 15239834d886..35a933eec573 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1_ek.dts
> @@ -197,6 +197,7 @@ qspi1_flash: flash@0 {
>
>  &sdmmc0 {
>  	bus-width = <4>;
> +	no-1-8-v;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sdmmc0_default>;
>  	status = "okay";

Best Regards,
--
Andrei Simion

