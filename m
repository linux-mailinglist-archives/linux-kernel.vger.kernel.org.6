Return-Path: <linux-kernel+bounces-429617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A39E1E9C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 15:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7779228140E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3627C1F4276;
	Tue,  3 Dec 2024 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="f/f9I4fq"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D49F1E531;
	Tue,  3 Dec 2024 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733234657; cv=none; b=jeRuBZW5T3/KSb3B7NIK0omGB1d44MYq7Y1OlsDteUBL8hBY8TzfnCl0ALLcfDtwZHofKDHn/WbjDwqrh3y8kE7JbOKS7mbvHX6XhQC/GP2jJqzui1zpDUGARboxXJ/bO5lwgK9OqHqRRqHREH2PgA3f1UX4thloxihoUnXs6J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733234657; c=relaxed/simple;
	bh=/hxNfUgTKAKWg/fW/yT1/bivZwyQzsotorQ707wyY4I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aAqICK4kocloc2iOwFqyADFnICBlcLrwKdQZX3yDMAu7poA87vFmepF4pWtqqAWPlKH9ab+3fiAPIns7kGVwtCayA/ZmBpJvIfxTJJbiipVTnIYBQxjBlOYumtbFXlrucO/LcgYaLHt9RscSTAPMRz5TH6xjPOu6dWimChklqA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=f/f9I4fq; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout4.routing.net (Postfix) with ESMTP id 070F01014AA;
	Tue,  3 Dec 2024 14:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733234647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vipYl8OMCsQxnZufHGtofiUF4Z2+hpq2hYwJztq2ER8=;
	b=f/f9I4fq5LUsvvQpJUc3j1tOct81A9BEm3uROVGNsp3TLmmXbO9sFsRSKeUvdcL8UaGN+O
	taLldzn55kEQ8I6u5N1hdFcMb7sX+tlqFTFHXU5trIAUErQc/M2tu5IgbOBvMsHkACZu7i
	PbzSPZJLA3nEMAOAFuDHJgiDa7Y5ZME=
Received: from [127.0.0.1] (fttx-pool-157.180.225.184.bambit.de [157.180.225.184])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 4E8E0360048;
	Tue,  3 Dec 2024 14:04:06 +0000 (UTC)
Date: Tue, 03 Dec 2024 15:04:07 +0100
From: Frank Wunderlich <linux@fw-web.de>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
CC: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 14/18] arm64: dts: mediatek: mt7988: add pmic on bpi-r4
User-Agent: K-9 Mail for Android
In-Reply-To: <a0137698-43d7-4cb6-a69c-98a5e90b13f8@collabora.com>
References: <20241202122602.30734-1-linux@fw-web.de> <20241202122602.30734-15-linux@fw-web.de> <a0137698-43d7-4cb6-a69c-98a5e90b13f8@collabora.com>
Message-ID: <9CCD2C57-7632-482F-80A1-8786403243B7@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: cfe3b074-989a-4be9-864f-32e0d9121ec1

Am 3=2E Dezember 2024 10:40:35 MEZ schrieb AngeloGioacchino Del Regno <ange=
logioacchino=2Edelregno@collabora=2Ecom>:
>Il 02/12/24 13:25, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>
>arm64: dts: mediatek: mt7988a-bpi-r4: Add MediaTek MT6682A/RT5190A PMIC
>
>The BananaPi R4 board has a MediaTek MT8862A PMIC, a rebrand of the
>Richtek RT5190A chip, connected to the I2C0 bus=2E
>
>Add the relevant node and, while at it, also configure the regulators
>from this PMIC that are used on this board=2E
>
>> Bananapi R4 Board contains a MT6682A pmic which is compatible to rt5190=
a=2E
>> Add its node to the i2 controller=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>   =2E=2E=2E/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts  | 51 ++++++++++=
+++++++++
>>   1 file changed, 51 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts=
 b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts
>> index 13ca016d6a67=2E=2Ebc1ec73b8ddd 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts
>> +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts
>> @@ -2,6 +2,8 @@
>>     /dts-v1/;
>>   +#include <dt-bindings/regulator/richtek,rt5190a-regulator=2Eh>
>> +
>>   #include "mt7988a=2Edtsi"
>>     / {
>> @@ -65,6 +67,55 @@ &i2c0 {
>>   	pinctrl-names =3D "default";
>>   	pinctrl-0 =3D <&i2c0_pins>;
>>   	status =3D "okay";
>> +
>> +	rt5190a_64: rt5190a@64 {
>> +		compatible =3D "richtek,rt5190a";
>> +		reg =3D <0x64>;
>> +		vin2-supply =3D <&rt5190_buck1>;
>> +		vin3-supply =3D <&rt5190_buck1>;
>> +		vin4-supply =3D <&rt5190_buck1>;
>> +
>> +		regulators {
>> +			rt5190_buck1: buck1 {
>> +				regulator-name =3D "rt5190a-buck1";
>> +				regulator-min-microvolt =3D <5090000>;
>> +				regulator-max-microvolt =3D <5090000>;
>> +				regulator-allowed-modes =3D
>> +				<RT5190A_OPMODE_AUTO RT5190A_OPMODE_FPWM>;
>
>Does it work like that?
>
>regulator-allowed-modes =3D <RT5190A_OPMODE_AUTO>,
>			  <RT5190A_OPMODE_FPWM>;

It seems working, dtbs_check accepts it and i can boot up with this change=
 and see no errors caused by it=2E

>If yes, please write it like that - if not, I'm sad - but regardless
>
>Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino=2Edelregno@coll=
abora=2Ecom>
>


regards Frank

