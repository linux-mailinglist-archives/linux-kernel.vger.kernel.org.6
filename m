Return-Path: <linux-kernel+bounces-303222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B33960936
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E61E280E67
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A96919F464;
	Tue, 27 Aug 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="R8RN5Eot"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3E51A08A9;
	Tue, 27 Aug 2024 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759107; cv=none; b=UC+bCDCiY/IZjgiAzpseU9ylt5dUHI15zGKdvTxXtwbQQ2IdYxAd2kNvhWDFhuUPp18z8HtSZ4HQZkbUbCPN+wLXVmTYE1VRuiOZ+K1a5itAU2E5lK+5jb4m+xKZ+IRCndE2zx1+nIrvMQtsGLUwJ+rGFf1Kh1o0q9mCOWk+ws4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759107; c=relaxed/simple;
	bh=qQ5rnwHBebdoqbagT23hX6UofBKa8mmMdLPucmPVnks=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=c3Q2zCsjTv+ghr2Phcff1KlkXaJBrfCvamaS0DXXs4+4kgI/y1vgnNiyvyVwDA3Cmc938nUbOxEqC51XyAulEoL2ibwD0ASC4rxbK9k5+hdwheg7fvKsRDvdczTinjVbL4lf5GlOoz+hZdbENJImFHef0eoKOGLgGxm65JQUFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=R8RN5Eot; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xLXPfKWDxExyWqYh9vtXpPA+hwYuofc+hgQ3XeMgQEI=; b=R8RN5EotjK+Krdq8wnD52auW0j
	zVu8/mHLkhcE3xaGIpM1UcXdL1qZEHnT/6q4HEPw/9lPNFT1pYIcJNkU6QLanbEgsRZAqz+57p8qM
	O5iIxC67NNogtyNOu74OCzmRoBPvcqoNLrpp3aVMXmI+Z9uBem3zmeCyf7z19OmfivaCWxgSE1KGb
	3Oke7WuMtYI4WG1jglXzaN+TUKSKJ/xzS7kX+F8RjNXs5Gp/qjSMOmd06vY4Ox28QL66toCcYxMKL
	/kntGsR1sO4xOyaXzTaDE6zJ6aDafl4VLjUM3kfN7DDvvKZ8k09B6pYm2+MQ0gf45TonWZ5rVxH6l
	vORb+vJg==;
Received: from dynamic-176-006-142-117.176.6.pool.telefonica.de ([176.6.142.117] helo=[127.0.0.1])
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1siud9-0005QN-9R; Tue, 27 Aug 2024 13:44:59 +0200
Date: Tue, 27 Aug 2024 13:44:58 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
CC: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: arm: rockchip: Add Hardkernel ODROID-M1S
User-Agent: K-9 Mail for Android
In-Reply-To: 1ec02fa5-4b11-424b-a595-c715b62d105e@kwiboo.se
References: <20240826205538.1066103-1-jonas@kwiboo.se> <66ccebeb.d40a0220.356790.58caSMTPIN_ADDED_BROKEN@mx.google.com> <b69e5a0a-acf9-412c-90b4-ebe00c7e07d4@kernel.org> 1ec02fa5-4b11-424b-a595-c715b62d105e@kwiboo.se
Message-ID: <99731A50-58FA-4829-9785-339051E791B2@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Am 27=2E August 2024 13:29:34 MESZ schrieb Jonas Karlman <jonas@kwiboo=2Es=
e>:
>Hi Krzysztof,
>
>On 2024-08-27 08:52, Krzysztof Kozlowski wrote:
>> On 26/08/2024 22:55, Jonas Karlman wrote:
>>> The Hardkernel ODROID-M1S is a single-board computer based on Rockchip
>>> RK3566 SoC=2E It features e=2Eg=2E 4/8 GB LPDDR4 RAM, 64 GB eMMC, SD-c=
ard,
>>> GbE LAN, HDMI 2=2E0, M=2E2 NVMe and USB 2=2E0/3=2E0=2E
>>>
>>> Add devicetree binding documentation for the Hardkernel ODROID-M1S boa=
rd=2E
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo=2Ese>
>>> ---
>>>  Documentation/devicetree/bindings/arm/rockchip=2Eyaml | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/rockchip=2Eyaml b/D=
ocumentation/devicetree/bindings/arm/rockchip=2Eyaml
>>> index f08e9f2f5dfc=2E=2E9e29a5ecc94d 100644
>>> --- a/Documentation/devicetree/bindings/arm/rockchip=2Eyaml
>>> +++ b/Documentation/devicetree/bindings/arm/rockchip=2Eyaml
>>> @@ -598,6 +598,11 @@ properties:
>>>            - const: hardkernel,rk3568-odroid-m1
>>>            - const: rockchip,rk3568
>>> =20
>>> +      - description: Hardkernel Odroid M1S
>>> +        items:
>>> +          - const: hardkernel,rk3566-odroid-m1s
>>=20
>> hardkernel,odroid-m1s
>>=20
>> Why adding SoC name to the board? Can it be Odroid M1S with RK3568?
>
>No, the M1S (rk3566) is a variant of the M1 (rk3568) with less features
>and the smaller SoC package, fully agree that hardkernel,odroid-m1s is
>better, will use it in a v2=2E
>
>I mainly wanted to keep it consistent to other Hardkernel Odroid boards=
=2E
>- hardkernel,rk3326-odroid-go2
>- hardkernel,rk3326-odroid-go2-v11
>- hardkernel,rk3326-odroid-go3
>- rockchip,rk3568-odroid-m1 (hardkernel,rk3568-odroid-m1)
>
>If you agree to a vendor prefix change of rockchip,rk3568-odroid-m1,
>maybe we can also drop the soc name from that compatible at the same
>time? E=2Eg=2E change it to hardkernel,odroid-m1=2E

I'd also agree with going with compatibles without the soc name in it=2E I=
t is an ABI break but I think except the chrome devices no other board actu=
ally uses that part of the compatible ?


>Regards,
>Jonas
>
>>=20
>>=20
>> Best regards,
>> Krzysztof
>>=20
>

--=20
Diese Nachricht wurde von meinem Android-Ger=C3=A4t mit K-9 Mail gesendet=
=2E

