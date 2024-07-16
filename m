Return-Path: <linux-kernel+bounces-254079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1983E932E72
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9933B2111B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D62119EEAA;
	Tue, 16 Jul 2024 16:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fx/6aA5z"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0133C1DFF0;
	Tue, 16 Jul 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147799; cv=none; b=Udlz3TPNrnL+HvZTGp1krcTHzYGK4E0FO3aT/9giwK+A9fNkMEbfDDEkLdOl76Qab2x+68/a2MB7zTf2J1fMcLsHfqCiKpK/nhkWc1V58i//IxGuPeRVPlzC47LhwW1Z61Byga8kO2WKkb6BAZAuHxTJAYDbUpqzJKSqE8gKq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147799; c=relaxed/simple;
	bh=N6DkqU9kVd50qY6QOEjJkCKPk7AYB/47AQ27J+e1OYA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cyiVbpVeNixxA8QHN2p8X1KlhRog3XGWIQ8Ukc1uCiD+7TbVjsmG3khnRa0fauX8shHRwx4Jbg5z2uaOjOy6jd2U1Kafc5o3VKFnJytYvV6tUCZImUPGONEalRIAG5nJ+tG6leQUVuKmC5+QC2gUJCvDhV3i2zECRdEHsbVZ1Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fx/6aA5z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721147796;
	bh=N6DkqU9kVd50qY6QOEjJkCKPk7AYB/47AQ27J+e1OYA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fx/6aA5zuQvaIkk6mkq8PLvb+pTVYcUuGC6mz0mWGB/BkOYANrycEf0eoQzQ1KfyY
	 zOuUAh3oW1zSdZqlAopHpuMT2m+UZ2V31N8oWRGPi5OiIbYdTg/ftvkiSJ1iOr2n+w
	 wJbeW233xmEalvqTJXKCy9Vxf+wRuPQF/FyBnqkrA351v07E1AY/WINt06/QiFs0cV
	 HJvJckQOBSNdRjgO7+hOi8z+DcdSB1dmyP5uRcZInGeWuXoUpQrIZYxQKvKeNMatKQ
	 LBiiui38EaoD6ZOUVtuzNicrjCITv4QUtG6ONesVIuP7x49EQcFdv4ntr1/VT9qZk5
	 3L8lpyL3cIAzg==
Received: from [100.77.12.232] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C502037821D8;
	Tue, 16 Jul 2024 16:36:35 +0000 (UTC)
Message-ID: <9f336131235de9f39a02b6bccb4d3d9a8f296bf3.camel@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: add Firefly CORE PX30
 JD4
From: Christopher Obbard <chris.obbard@collabora.com>
To: Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,  linux-kernel@vger.kernel.org, Kever
 Yang <kever.yang@rock-chips.com>
Date: Tue, 16 Jul 2024 17:36:35 +0100
In-Reply-To: <20240716-wrinkly-carving-686b84bc0933@spud>
References: <20240716-rockchip-px30-firefly-v1-0-60cdad3023a3@collabora.com>
	 <20240716-rockchip-px30-firefly-v1-1-60cdad3023a3@collabora.com>
	 <20240716-wrinkly-carving-686b84bc0933@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-16 at 17:26 +0100, Conor Dooley wrote:
> On Tue, Jul 16, 2024 at 04:51:04PM +0100, Christopher Obbard wrote:
> > The Firefly CORE PX30 JD4 board is a SOM and motherboard bundle from
> > Firefly. Add devicetree binding documentation for it.
> >=20
> > Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
> > =C2=A01 file changed, 5 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > index e04c213a0dee4..19e06e1253e15 100644
> > --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> > +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> > @@ -148,6 +148,11 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: e=
ngicam,px30-core
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: r=
ockchip,px30
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Firefly Core PX30 JD4
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: firefl=
y,core-px30-jd4
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: rockch=
ip,px30
>=20
> Not having individual compatibles for the carrier and som seems odd to,
> given there's no requirement to use the som with this particular
> carrier.

Thanks, I will fix that up in V2.

>=20
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - description: Firefly Firefly-RK3=
288
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enum:
> >=20
> > --=20
> > 2.45.2
> >=20


