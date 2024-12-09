Return-Path: <linux-kernel+bounces-436958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7646E9E8D17
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:15:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3695028175C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3532135D0;
	Mon,  9 Dec 2024 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="s00cOUJ5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B56154918
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733732143; cv=none; b=CcnSLtkGnNdzkJG1fwCxlj4FCV2564ekt9Tg746ju1/nxGzSFGqCxYZb3GdHjoj6Y3J2lbeYrugG7YQ7pqU1xUQhjMoJ19myb4h/r0JwqOYNEwbEd3nrOgyZkvEOiA0bMu8p7qFqiSvrdtr3yHVzgKmVSS1blMrbrtDWAAncZQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733732143; c=relaxed/simple;
	bh=ZcPczIrFdqcCCIC/8LP2IK2yKWfNDzsDd20ms77e/Ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pXXFrAgJ1SR+dBnn3yz4O1JDe9VCf9+7USv3OveNmtkVLL/q9pSyayFkZWA67t8y5sgboG/gaJn9x5FP2lGJ9FF9ibc7wFC0934LRiu0+YhETLfBkjqQLY4fz1p4az4sWfhABFBFTZCkiSrYIYQrsNOl12s8dpbaHYoedw+kOV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=s00cOUJ5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733732142; x=1765268142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZcPczIrFdqcCCIC/8LP2IK2yKWfNDzsDd20ms77e/Ew=;
  b=s00cOUJ5KvAOyhDXezmKKVNhX4vZfgVghpPjYkcAIa6I18KT3QF7Unit
   QR1MdC2UoXYg+FogifkajFvDNJwi91LnkEHIyLBUyRicDrLL+5PeGbpi+
   FrNaKJIbJKOAKAloRXv8gpfmMYPZ/AeB6QcR4XVYwFosvr7SHclj+1uY2
   VqmTlkSlIdzoHox2qrw4bkCFUivJN+De3EiBnHJY31P3tJeRLDJpyx8rq
   yDyk9w8s0WATpGHHQChiRNBMuoKdDmRoISdb4Y7arVzhlLDtr/WcOxkMd
   gPF6h0rugtztoiSrhBFG5GgSyuWwcbk04nJsHfYDBF/jgR88sEPW/apc5
   w==;
X-CSE-ConnectionGUID: fximzRWUQzq03/rIjTMi1g==
X-CSE-MsgGUID: NpHfH2OzRRyYYCqOHeO4jA==
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="35290676"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Dec 2024 01:15:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 9 Dec 2024 01:15:37 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 9 Dec 2024 01:15:35 -0700
Message-ID: <af867f52-37f9-4caa-ab6e-8d7e409bbc87@microchip.com>
Date: Mon, 9 Dec 2024 09:15:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: at91: pm: change BU Power Switch to automatic mode
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Cristian Birsan <cristian.birsan@microchip.com>
References: <20241125165648.509162-1-nicolas.ferre@microchip.com>
 <32b1ae9d-f55b-43d0-bb24-1fd486440ab6@tuxon.dev>
Content-Language: en-US, fr-FR
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <32b1ae9d-f55b-43d0-bb24-1fd486440ab6@tuxon.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 08/12/2024 at 16:48, Claudiu Beznea wrote:
> On 25.11.2024 18:56, nicolas.ferre@microchip.com wrote:
>> From: Nicolas Ferre <nicolas.ferre@microchip.com>
>>
>> Change how the Backup Unit Power is configured and force the
>> automatic/hardware mode.
>> This change eliminates the need for software management of the power
>> switch, ensuring it transitions to the backup power source before
>> entering low power modes.
>>
>> This is done in the only locaton where this swich was configured. It's
>> usually done in the bootloader.
>>
>> Previously, the loss of the VDDANA (or VDDIN33) power source was not
>> automatically compensated by an alternative power source. This resulted
>> in the loss of Backup Unit content, including Backup Self-refresh low
>> power mode information, OTP emulation configuration, and boot
>> configuration, for instance.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> I've added the fixes tag, s/locaton/location, s/swich/switch.

Thanks for your help Claudiu. Regards,
   Nicolas
> 
> Applied to at91-soc, thanks!


