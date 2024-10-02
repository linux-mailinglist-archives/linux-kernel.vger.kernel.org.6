Return-Path: <linux-kernel+bounces-347337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FD298D14C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 12:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5548B22B67
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59EF1E632E;
	Wed,  2 Oct 2024 10:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="gsM87NnK"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A601E5022;
	Wed,  2 Oct 2024 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727865112; cv=none; b=nc9dgd7n4sHpWE/PqNWbZy4gXcTs7vDbm5Hmn6c98ByqMWYSLYpErkn8mLxLVwm4LhjM2lgJI2kBcWDjB92ctwv/lHNNP8naXeEAM9GYB/hNL5CgxYRZ4jEO5T4PdizQYIVNYKO4mRjoxXwnQo7pVE47JDcvmwTLwNyyHcdzkZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727865112; c=relaxed/simple;
	bh=BZQu3MKWVvMacvUKcyQlysIUATw80nYaO8kh3HRXFwg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nXfJu2+DTSQ3jgOaylNlPrPpx9d56suklY0DFgEKq/ew2P4NJcPpJZbHTvpGKSjER5bm0nOOMTuV37ZBhfT0jzM/e793kTnSkD8uOfNNcHhjI+mu8joCxT1qX3nBqe7PO+4ircROSCeEVQc3O/wH6RvZb3nKoU94uWpgDA9nrPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=gsM87NnK; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727865110; x=1759401110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BZQu3MKWVvMacvUKcyQlysIUATw80nYaO8kh3HRXFwg=;
  b=gsM87NnKSee69siZXaHnra3EcqnU1dnJ2sEznYnWAZbA/ZswTUoRwoky
   ibGynwsp+tkqht40egOBcQEQG24u/XzLxk1e+xX9ntQiHX20Q3gd2hGwv
   2lnxXyJWIPV67JYz1VyfWz6P1M12y9RhFqjW59DPjvR3Qgya1usFFc6ZF
   v9pCIjFdrtXcB+MSfKNmAAiWPm5G2eskhFi5ZwzFclzb6yU5mam8Yf6mK
   7R8tb7SCr41lMw0HEPQkKwupIZkpH0/XdoNU47azkcYjkbwvn/oxoAvWv
   UQs2RA/7C/ZV+fKu3UJLkeP/nRXXkEyj1Fs7tD4lG9uxCIqifMFSt1KWg
   g==;
X-CSE-ConnectionGUID: TfueWziQTJ+RLI4R25HrfQ==
X-CSE-MsgGUID: KtQmdZ+2Q6KLbvDjR+u5mw==
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="35785390"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Oct 2024 03:31:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 2 Oct 2024 03:31:08 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 2 Oct 2024 03:31:06 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <conor@kernel.org>
CC: <ada@thorsis.com>, <alexandre.belloni@bootlin.com>,
	<andrei.simion@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, <krzk+dt@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<nicolas.ferre@microchip.com>, <robh@kernel.org>
Subject: Re: [PATCH v2 4/4] ARM: dts: microchip: aks-cdu: Add label for LED sub nodes
Date: Wed, 2 Oct 2024 13:30:45 +0300
Message-ID: <20241002103044.108413-1-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001-sleet-bronchial-867258945373@spud>
References: <20241001-sleet-bronchial-867258945373@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

> On Tue, Oct 01, 2024 at 06:25:41PM +0300, Andrei Simion wrote:
>> Add the label property here and use the old node name as value to stay
>> stable and avoid breaking the userspace applications that depend on those
>> paths.
>>
>> Suggested-by: Alexander Dhal <ada@thorsis.com>
>> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
> Shouldn't this be squashed with 3/4 so as not to break it in one commit,
> only to fix it in another?
>

Hi,

My intent here was to give credits.
If this approach is unnecessary, I will do squash in V3.

Best Regards,
Andrei Simion

>> ---
>> v1 -> v2:
>> - added in v2 by suggestion of Alexander Dhal
>> ---
>>  arch/arm/boot/dts/microchip/aks-cdu.dts | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/microchip/aks-cdu.dts b/arch/arm/boot/dts/microchip/aks-cdu.dts
>> index 0c3373ad1723..b65f80e1ef05 100644
>> --- a/arch/arm/boot/dts/microchip/aks-cdu.dts
>> +++ b/arch/arm/boot/dts/microchip/aks-cdu.dts
>> @@ -99,22 +99,26 @@ leds {
>>  		compatible = "gpio-leds";
>>  
>>  		led-red {
>> +			label = "red";
>>  			gpios = <&pioC 10 GPIO_ACTIVE_HIGH>;
>>  			linux,default-trigger = "none";
>>  		};
>>  
>>  		led-green {
>> +			label = "green";
>>  			gpios = <&pioA 5 GPIO_ACTIVE_LOW>;
>>  			linux,default-trigger = "none";
>>  			default-state = "on";
>>  		};
>>  
>>  		led-yellow {
>> +			label = "yellow";
>>  			gpios = <&pioB 20 GPIO_ACTIVE_LOW>;
>>  			linux,default-trigger = "none";
>>  		};
>>  
>>  		led-blue {
>> +			label = "blue";
>>  			gpios = <&pioB 21 GPIO_ACTIVE_LOW>;
>>  			linux,default-trigger = "none";
>>  		};
>> -- 
>> 2.34.1


