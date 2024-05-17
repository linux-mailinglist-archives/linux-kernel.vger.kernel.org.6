Return-Path: <linux-kernel+bounces-181763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CA98C80EF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 08:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601A11C20FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 06:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC891426F;
	Fri, 17 May 2024 06:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="pAyHbHTW"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C780313FE7;
	Fri, 17 May 2024 06:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715927272; cv=none; b=UvahTJGWUq0RSFuPhPmI+0bqM4KkTwsXBhq8Sy2E29ulUURVuaONzCiL+UvyRuB5xWePe4Sf2bzs8gNKBZYHZT+bjlEVIoZqM4s/t7WUZNXKUmnzjRhOuRhNlwefs5ftvvuizaFO0l+IpKgVXSRQii1ljsZOIB00GVYkj7uLXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715927272; c=relaxed/simple;
	bh=KSti7LZBJijnnjjGg+r9r/T80cHLGp/ZM8X5SLLmURE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rj1cUXW4+R3duhM9SKIoyem0+Ii8d+hWKBfDku590DVSK/L0bI58mKO2T0cy3Khnh8kkhN4R3DjKbzr6DDtloDlHV/wo8FrdT72RhdGeBdeD7XufztxbZ9gZvWxF7SP6wUtoOkkXXEYhXXFsHtlwmQgSZVndOnTHXjOtKaJihKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=pAyHbHTW; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1715927247; x=1716532047; i=frank-w@public-files.de;
	bh=KSti7LZBJijnnjjGg+r9r/T80cHLGp/ZM8X5SLLmURE=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pAyHbHTWAucMKnf5hZV52obw5cl9MF+XJ8nbO1LT6OAQjmOLvvW60GZlEieN67wC
	 Wl/B7UHv8k0sspKoFRSK3vqKceOkgZohdzu4wGcp8PVAvVJ8dygd7C4HvZDv0p/n1
	 /QcVF+yLgTjFmtOpSH1xgspijv4D441N4iJIh8+nt+lg95aT8RR1CKfi+b3hwW0Ij
	 DN8C+I4cmY+AKtXdE//T4Zs/S+lM4alGhadJ492Yf86igmjCfa0eECbxTfLJjaFSS
	 +oEiDfDlViWSc9aZFuf6hkHhg34GpLlBvT9hepl5eK4GCc78bb/F1vj6bp0ItlGbC
	 4PNi8mDcM0y36lw6og==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([217.61.157.120]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MCsQ4-1sGcVK3k6C-00CO8K; Fri, 17
 May 2024 08:27:27 +0200
Date: Fri, 17 May 2024 08:27:24 +0200
From: Frank Wunderlich <frank-w@public-files.de>
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
References: <20240516204847.171029-1-linux@fw-web.de> <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
Message-ID: <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Kf2A6v05q+qtEmd2sdgj+X3dXiUTxa75IbK9gn0tp+6l79sLMxj
 v0xPOTwHoe9+p63e9G/VEtFaWz2dBUk0ZburZoeH4Pfr3q0eNPoegr2h2sr93a/pxMwx/IO
 cvNBVDojRXmbcw4AZyIf/69QC+mCTv5GVgKrcyzuWOKaCgY5u7zT09JH/fBlK6SRuTonI3B
 yQRc6G1v85K8U9r+wNvmA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lA743/OJgs4=;r/sYu7nzWZ3+S01iYf5EWePZiH3
 bCW2LwckE9ONLkbibSk6ZQeva9RYiL7nJ23nCVr7LTGRxa9Jl9sl+aZw9uhfw+PxAh23XIlhA
 WShhBbq7qTJEHBLELZmBolmbFIjbPdu/tA3rQQTdoALCTlmjgwsDVEWUZRCO3uhDmjJdu32e9
 TZQlK9gDqQ52Q/bxx7kxRQhHYW/tMLHhuXFUtIudW79l9dBppnCMVFYDALT6XpIVrYZwyG4Gl
 6RAcps6WSvrduK21eKGK9AISI4LZ/oGYhLWGHk8GKq5Nqh4dgSOmz1iregZgSd24okIeNPSZW
 mjeJi+oD54cMWU8ytubZs8QGVuGSp504pCxf297v/+ITcmTB96xKQFhrDSYXR4FSB11sY0TJk
 Hx9WseiXQgxXbVr+ls+h5/sz+NWYjaIW9Y6Dl6rtdgtAuovq6EooUy90cZHcx7mfVAvHS4zvx
 9DNdJ8qKOm6EsoblygiBeV2z0KXCwiMihVu+En3uf4hVZBw6wfSx8uuagoE9zp3KNNDV5mG//
 nRrLdllnEq8O2RN9dpKEoFgnlRPBNP3QGsRKUIZc9ZRCcm4phfb6Wcoe5+WoU2oCzC6lbt4OQ
 tQvRAPWashvtNtCv9T+Atv41R39pN0j5s5Xhlqrcw8+7ynUlBIYnrXdzRNCF5pL6q2Jl48LwI
 bK4hsYoumvsy3364WSQfjgXAdeTq7y6njwLFutRdlSXzCF6BVihTDvSgPGTUf+qOXeFPZCaaP
 A4SNPd6NA94ChFkcS5GK8PNxk6cTf2FRo5201g2FNj9jLVzmGZdskzi6nGC9tHszAlbeP9SCD
 PV+VKLMUaNMo7rZd/yBFPbf+HdLbe7FFYwpoW7SUG1VBU=

Am 17=2E Mai 2024 04:17:47 MESZ schrieb "Ar=C4=B1n=C3=A7 =C3=9CNAL" <arinc=
=2Eunal@arinc9=2Ecom>:
>On 16/05/2024 23:48, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>
>>=20
>> After commit 868ff5f4944a
>> ("net: dsa: mt7530-mdio: read PHY address of switch from device tree")
>> the mt7531 switch on Bananapi-R64 was not detected=2E
>>=20
>> mt7530-mdio mdio-bus:00: reset timeout
>> mt7530-mdio mdio-bus:00: probe with driver mt7530-mdio failed with erro=
r -110
>>=20
>> Fix this by adding phy address in devicetree=2E
>>=20
>> Signed-off-by: Frank Wunderlich <frank-w@public-files=2Ede>
>
>I don't like the mention of the Linux kernel driver on the patch log=2E W=
hat
>you're fixing is the incorrect description of the switch's PHY address on
>the DTS file=2E Whether or not any driver from any project is actually
>reading it from the DTS file is irrelevant to this patch=2E That said, I
>already have a patch series I've been meaning to send the next version of
>that already addresses this=2E Please wait for that=2E
>
>Ar=C4=B1n=C3=A7

Hi arinc,

From=20my PoV it is a regression in next/6=2E10 because the driver change wa=
s merged (without "broadcast" fallback) and the dts patch [1] is not=2E

I agree that my patch can be dropped because there was already one=2E

regards Frank

[1] https://patchwork=2Ekernel=2Eorg/project/linux-arm-kernel/patch/202403=
14-for-mediatek-mt7531-phy-address-v1-1-52f58db01acd@arinc9=2Ecom/

