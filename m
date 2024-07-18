Return-Path: <linux-kernel+bounces-256152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B429349F0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E637728504F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD467D07E;
	Thu, 18 Jul 2024 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lLLRis9Q"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B5D74076;
	Thu, 18 Jul 2024 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291509; cv=none; b=B8GM/FBVaZfZ3dqnSjbc7SNmZ2NIXoXOMTKVzYKHIVL0SfXVrGT8xOOe5cy2qb3upzrbHrfDGGIdi1oA0rtQoq0b3GxORQCzGDgrhMp+pf2InLLqeWZ5MRRfFFLtK0pfPY1eAxOow9493JUX8HMsK7yTjkZPmv7tGpL03cvY44k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291509; c=relaxed/simple;
	bh=UfboPlF/HZBBn4a1P1PzaHifZoVrnrwWnCf3Un1BSvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZKVy88z5JFRiKlvrJ7I1bKmwWZizp7kVo+b+oy3GjMMW1iJaEvqbeDqeJf52wFgFd+uURJYiIIwgou3NeG+UbMhhlDlZv7q6DZfWx6a1uVNiyxaGoLywM04ZpfHxNz/M0EAsCvWaqYk5x4W555YbbvMLsqcPjOuT5/yjJCYCt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lLLRis9Q; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721291506;
	bh=UfboPlF/HZBBn4a1P1PzaHifZoVrnrwWnCf3Un1BSvY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lLLRis9Q00clE0k3WxllUf99jwGs7cE/uP1Njdlk8FL0KDIfsheQSaUuAUsTgWlg7
	 oSALNx8247kvwAcAhowq9jcmoj1l3wkkBuZjEiVqnCLKSW/Jb8CftQ+T9cmO0n89Jo
	 gvMSTHB7iKdQo3P6noWtziVeMgSnKz/UuVWLadj4N7FL+yIw3ooSh0h6LjIY/VUCAP
	 uC9bu/Q+C5jq3a44dgJiccNKgnwy0y4maZeOpEJvI1hcJpPZPwv0NQcpPxhDlf3sKL
	 7ML5aH+5E+ymf8oJcXjLIcfQYNy46uJY9YzwnYu+LIhdqRxq5s9P5Bj7EyZqi+DMli
	 9Hf1KDUJCLWpw==
Received: from [100.77.12.232] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 144A03782167;
	Thu, 18 Jul 2024 08:31:46 +0000 (UTC)
Message-ID: <e34f1a0a81de24437be7f582c719d3f128d44b51.camel@collabora.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: rockchip: Add Firefly
 Core-PX30-JD4 with baseboard
From: Christopher Obbard <chris.obbard@collabora.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,  linux-kernel@vger.kernel.org, Kever
 Yang <kever.yang@rock-chips.com>,  Collabora Kernel Mailing List
 <kernel@collabora.com>
Date: Thu, 18 Jul 2024 09:31:45 +0100
In-Reply-To: <0c804e9a0227904b16bfb779f2009af1@manjaro.org>
References: <20240717-rockchip-px30-firefly-v2-0-06541a5a5946@collabora.com>
	 <20240717-rockchip-px30-firefly-v2-1-06541a5a5946@collabora.com>
	 <0c804e9a0227904b16bfb779f2009af1@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Dragan,

Thanks for the review.

On Thu, 2024-07-18 at 06:36 +0200, Dragan Simic wrote:
> Hello Christopher,
>=20
> On 2024-07-17 18:46, Christopher Obbard wrote:
> > Add binding for the Firefly Core-PX30-JD4 SoM when used in conjunction
> > with the MB-JD4-RK3328 & PX30 baseboard.
> >=20
> > Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
> > =C2=A01 file changed, 6 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > index 1ef09fbfdfaf5..33ca8028bc151 100644
> > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > @@ -148,6 +148,12 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: e=
ngicam,px30-core
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: r=
ockchip,px30
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Firefly Core-PX30-JD4 wi=
th MB-JD4-PX30 baseboard
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: firefl=
y,px30-mb-jd4
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: firefl=
y,px30-core-jd4
>=20
> Similarly to how I suggested the new dts(i) files to be named, [1]
> the model names should be named like this:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: fir=
efly,px30-jd4-core
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: fir=
efly,px30-jd4-core-mb

I suppose the order should be the other way around to match other entries, =
e.g
firefly,px30-jd4-core-mb first?

Chris

>=20
> This would also follow the "inheritance graph" pattern, so to speak.
>=20
> [1]=20
> https://lore.kernel.org/linux-rockchip/38d7b7e9ab71bf1b0817e666f4233b9e@m=
anjaro.org/
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: rockch=
ip,px30
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Firefly Firefly-RK3=
288
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:


