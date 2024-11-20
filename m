Return-Path: <linux-kernel+bounces-415562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 298EF9D3839
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 11:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50333B23FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 10:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3995317836B;
	Wed, 20 Nov 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="XDH+EFjn"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B3318A6A8;
	Wed, 20 Nov 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732097420; cv=none; b=NYx0Ds0ZbHRF6RaG1sK2fVCKWyIBFnIqqWErZv8akvAUgoANEZZ4B7bW6yt+xqOKJm5KmcrySKOcBAGQb6zUCgfu7QhqRkQLtaSL0uDtuPS48uf5UUKUf7FmRBohT8pumILRBQDrkyaYi25Si3bp7OLSdoW3owU03atLjHm4aNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732097420; c=relaxed/simple;
	bh=2qaQ1SiUb+00EcaULYRvl95OFYYN7B8TVPyMTw8h0xc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlAS74VutInWGFhLfYSX5E26DPG81+XDOBIsDjixMD9HpB/6132s9ibANg/w0tIet3oEcxJRNpRPL0iMktsJOltoISn1mrgJoITi2qm9mGaDoYSjbsf9cq4+hJXinVAHnO381Zo78aQjD0fltkbC1bhY5iIBR06+zTjhHqvBGvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=XDH+EFjn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1732097419; x=1763633419;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2qaQ1SiUb+00EcaULYRvl95OFYYN7B8TVPyMTw8h0xc=;
  b=XDH+EFjnbWnmr6yUyrqvCSA7+kkmmSFSuqaFtn9WWOGY4Ol77MVkdWF/
   npUT+vO1h3uIBSmw5+mdyRE1omLBcfWiPkMPGX7aqN3jkYO4DSXD1ml1S
   M3nd0y0ImaduczI5NCIgvfXeRWmTUKMgmmRc7vEL/slSVDnNICsAwnz3n
   oVwjs5ukvKrGCBEI9O+CHjbb3ZEEK02Jx4dRJGjUIePUACwsB4CFtT4Pn
   lVjeC+BP2LZU5nRWQ21G1UXVOdsIY1S83LJAfZ1chVbpvzCH31OHqxtUs
   C2YGab6xjTtGx7Hb4UcmqRQFAs/7wXlOhmIqKgREHOwaPayavVKopT+p8
   g==;
X-CSE-ConnectionGUID: SiPX8Z95Sh2II+yWq8OwYw==
X-CSE-MsgGUID: Y5GxdXWVSHejNCzyBoDztQ==
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="35056919"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Nov 2024 03:10:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Nov 2024 03:09:37 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 20 Nov 2024 03:09:33 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <cristian.birsan@microchip.com>
CC: <alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, <krzk+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<mihai.sain@microchip.com>, <nicolas.ferre@microchip.com>, <robh@kernel.org>,
	Andrei Simion <andrei.simion@microchip.com>
Subject: Re: [PATCH 1/2] ARM: dts: microchip: sama5d29_curiosity: Add no-1-8-v property to sdmmc0 node
Date: Wed, 20 Nov 2024 12:09:19 +0200
Message-ID: <20241120100918.46190-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119160107.598411-2-cristian.birsan@microchip.com>
References: <20241119160107.598411-2-cristian.birsan@microchip.com>
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
> On this board, PA6 is used as GPIO to enable the power switch controlling
> USB Vbus for the USB Host. The change is needed to fix the PA6 voltage
> level to 3.3V instead of 1.8V.
>
> Fixes: d85c4229e925 ("ARM: dts: at91: sama5d29_curiosity: Add device tree for sama5d29_curiosity board")
> Suggested-by: Mihai Sain <mihai.sain@microchip.com>
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>

Hi,

Tested-by: Andrei Simion <andrei.simion@microchip.com>

> ---
>  arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> index 951a0c97d3c6..5933840bb8f7 100644
> --- a/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sama5d29_curiosity.dts
> @@ -514,6 +514,7 @@ kernel@200000 {
>
>  &sdmmc0 {
>  	bus-width = <4>;
> +	no-1-8-v;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_sdmmc0_default>;
>  	disable-wp;

Best Regards,
--
Andrei Simion

