Return-Path: <linux-kernel+bounces-279926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F73D94C37F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43891286AA2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D615D19149F;
	Thu,  8 Aug 2024 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="NQWFVlzs"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DBC190489;
	Thu,  8 Aug 2024 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137534; cv=none; b=S/zl4/MW6ASdf/2h/aZOnVEMyQb9+2AakFNKNOK8g6UkwCXoBl5VwnFJ2VYTZWrHW9SxbDEtYJtkkPOuZqsxqTGRYAZ1CaA28nHshoRnbLeetnFzhg4FW1mLvo8PkyF5CRhtYSixnv8+tzfimAhyQ2t8S2oLwA6oMD7VHAvV2Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137534; c=relaxed/simple;
	bh=JrSXbW78BBvltW5zTtJmVM7MolzdgvsvqxQzyXZaNN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4vwqMqICac5MVNXhsoGaXVK17OwfdS1HQw06krnAvCGD9ZpX2hZctHzEJpBs7z3I5ANy1F7kU2iggoN+cWpfJoDzji5YUpdj9PzT5vTlo4jPkSGbArV8GrIvH0tp4zyvbC3FwanuvC9uacmEQP9MwYHwH7Bo5GEon74/JTaH9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=NQWFVlzs; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id EB2DA88AE8;
	Thu,  8 Aug 2024 19:18:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723137524;
	bh=086U3Jb85dhQ8wqypwcThzdIbKqXbwFJ+apnXhRSD8Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NQWFVlzsCZ5+QebqY+rScFJvFNcYFKh0nAoKTXPMzI6Bp4AEUl+SA/UHLpxyKXZ10
	 429uI3kZp+sAPIVKjkTIvffsiUJse5AvqjR2lt23EVHS7K5xWp1smWU2mjhuznuiiB
	 uxbp6H1/I8YKd/C4sVGTe79ICxC+0+WvfazvNnrJVdrE6BYtW/Hd78oXLzkFa1vuj9
	 T0bfBaAvTugasy9Ndw57HcxGQ7yreKg5MWrMdYz/FcqgNxBXyjQsakju0M40tS8Wwt
	 U59XOPusddY7wxKTK/Et77UUOfCuFHF1adR+JxVLvjSSO/SmvBc4RUjsNifl7NtdMV
	 5MdBfnFx4+N/g==
Message-ID: <7fc515f8-a74b-44a1-9614-715f87034e05@denx.de>
Date: Thu, 8 Aug 2024 18:57:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: dts: imx8mp-data-modul-edm-sbc: remove
 #clock-cells for sai3
To: Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
References: <20240807-fsl_dts_warning-v2-0-89e08c38831a@nxp.com>
 <20240807-fsl_dts_warning-v2-4-89e08c38831a@nxp.com>
 <CAOMZO5A3FKPurXZ6ZoUB7zzXBC5xRLEHPsTQ-hRyDs=g2ZaqUQ@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAOMZO5A3FKPurXZ6ZoUB7zzXBC5xRLEHPsTQ-hRyDs=g2ZaqUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 8/7/24 8:42 PM, Fabio Estevam wrote:

Hello everyone,

> Adding Marek.

Thank you Fabio.

> On Wed, Aug 7, 2024 at 11:52 AM Frank Li <Frank.Li@nxp.com> wrote:
>>
>> Remove #clock-cells for sai3 because sai3 is not clock controller to fix
>> below warning:
>> /arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dtb: sai@30c30000: Unevaluated properties are not allowed ('#clock-cells' was unexpected)
>>
>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>> ---
>>   arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
>> index 7e1b58dbe23a7..837ea79741e8d 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mp-data-modul-edm-sbc.dts
>> @@ -499,7 +499,6 @@ &pwm4 {
>>   };
>>
>>   &sai3 {
>> -       #clock-cells = <0>;

The change is correct, thank you Frank.

Reviewed-by: Marek Vasut <marex@denx.de>

