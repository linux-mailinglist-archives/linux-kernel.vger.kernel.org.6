Return-Path: <linux-kernel+bounces-427699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 783299E0510
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32D2167C21
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972302040A7;
	Mon,  2 Dec 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="QNXhE5p2"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE820371E;
	Mon,  2 Dec 2024 14:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149782; cv=none; b=KKQEvl/Han0X14QUyCfipba+2TopqzyeisjFV9pYRlrlTWvBuLwoKNnMloye7WWI95llIuG6pe5YM5kaMRlzEM7uRXBGra1fXTIhF5TaeojyTnm4timsKmLg/Z8VhGXIYQU5eA25UDSiXNZPwZGa+tA4zV8UkcjqRGqqhZB/VYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149782; c=relaxed/simple;
	bh=GI2kUtT0OlfNGGETihup6P26nEgr9k/Vnd4oVTiQC8I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=g/sBeNvM6Oi1WDAJyH4LhsCuqWRPAiT8bN7WXd8oC/d4qqXOnjZ1TFD9fK/9lcjPzR+KpLW1/R2sKjzvlyQV670yOV47qoUQ+WhiBNKeD8rP3+3i9Z3tEGcy3vIfIUQqIFkdv3Uojg3HakEU2uigXjUMdJXzolCBxhWqZdGCUWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=QNXhE5p2; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout1.routing.net (Postfix) with ESMTP id 8DD39410AF;
	Mon,  2 Dec 2024 14:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733149777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iiCaU9VCsrHrARnis/Mwz30VnwpZh24c7z+5gmG2wQQ=;
	b=QNXhE5p2F5VZToy6Ij+oy/Pp3T8prS8YPnb39rnbgMQTfHrkEdYgKmF3fYbXPBDvAVVYlt
	8u8W19vzGs4HCYBBtY6JGFOzCRGWZve3fZewwFh+w3C4JYjEUinvrQi9DNOtM112D8cLFN
	xhshK1jH+y/vfWzcWDmK+fX0lHHuftg=
Received: from [127.0.0.1] (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id DC85A1005FD;
	Mon,  2 Dec 2024 14:29:36 +0000 (UTC)
Date: Mon, 02 Dec 2024 15:29:36 +0100
From: Frank Wunderlich <linux@fw-web.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_11/18=5D_arm64=3A_dts=3A_media?=
 =?US-ASCII?Q?tek=3A_mt7988=3A_add_chosen_node_on_bpi-r4?=
User-Agent: K-9 Mail for Android
In-Reply-To: <0fb58a4a-7bad-4623-99c8-67f5763558bb@kernel.org>
References: <20241202122602.30734-1-linux@fw-web.de> <20241202122602.30734-12-linux@fw-web.de> <0fb58a4a-7bad-4623-99c8-67f5763558bb@kernel.org>
Message-ID: <D92CAF3C-F6B7-46DC-BF83-A71907E2D7EA@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: dfd265df-7f00-4998-b30b-86ed5c96f812

Am 2=2E Dezember 2024 14:46:24 MEZ schrieb Krzysztof Kozlowski <krzk@kernel=
=2Eorg>:
>On 02/12/2024 13:25, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> Add chosen node on Bananapi R4 board with stdout and default bootargs=
=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>> ---
>>  arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts | 5 +++++
>>  1 file changed, 5 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts=
 b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts
>> index 9037f35857a9=2E=2E1c2a806f6f6c 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts
>> +++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4=2Edts
>> @@ -9,6 +9,11 @@ / {
>>  	model =3D "Banana Pi BPI-R4";
>>  	chassis-type =3D "embedded";
>> =20
>> +	chosen {
>> +		stdout-path =3D &serial0;
>> +		bootargs =3D "console=3DttyS0,115200n1";
>
>Drop or merge into stdout path=2E

Have you an example to pass speed setting to stdout-path? As it is only a =
phandle it is not clear to me how to merge these 2=2E=2E=2E

>Best regards,
>Krzysztof


regards Frank

