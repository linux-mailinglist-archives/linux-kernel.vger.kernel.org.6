Return-Path: <linux-kernel+bounces-570603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C40A6B264
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 01:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65283884BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 00:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1913D2A1CF;
	Fri, 21 Mar 2025 00:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hNvtqjzo"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D52E23BE;
	Fri, 21 Mar 2025 00:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742517584; cv=none; b=MGRXFfJIJLs7McOFQ2tx1ph75hAdgvznZ0JrYvxZBbEjsn5yITjW0LN8BA4yc4Tyyh5npUPa9tGIAKHh748GuezZ+Lbfay9wffjg1/i8ayid4xEl6xkcsJIVEH0H0kP4DbNP73cHiKNriWZytDJPKbO3Qo2aJYF22OI0nJJY930=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742517584; c=relaxed/simple;
	bh=81e5U12yQNl/T/++JQb1aWg02Oq1JzXIwoKQeuPOf/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IVCrMY+WgWLYIQXCuEwGCY3oi9spEe3r9r5skscvlM4lJZDPWtHaRdmNV0WUQu79G7+Qdwaz11RQvLTNALxrJ0FrWIyZ93AS4ly036FlFnY/A8OJXFVTzWZjPgHkBHQJTeorxJ65b6JddfCvYRWq4U+aHrOiiH0Eofy8Su0e9yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hNvtqjzo; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1742517572;
	bh=81e5U12yQNl/T/++JQb1aWg02Oq1JzXIwoKQeuPOf/Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hNvtqjzoDLk8nMsNRAwLiBQBq+A/jaZLOBJz+AKXu7nVybKAhi3bpWyAN3UwvUAb8
	 X7W18/K0L0z19l88HAz/Q+IzcU8f5p+yOmbFKNjjC/Vr6SM/ECKFUy1ENppiVPOAp/
	 ls5fZFHmu4slQdo12PDCxxBwT5rPrsOrlZ17+Ww48dGtZIE59RQ/1bEcHzhclY2HU8
	 524k15wq+Y3mMZNo+dFMqrzObb2BHGo0BTtsJ1wRv4OL3ScntyzPkIbI6NMg+wO5DT
	 PuIlnqy0QducLALaoV3cHepsDSaDVxG96w28MCkSn5/NUiqE6ORZLXIuI0PM9Lhd3U
	 Y+ASm+H464Yfg==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B61B17A4E7;
	Fri, 21 Mar 2025 08:39:30 +0800 (AWST)
Message-ID: <158f6e8e6c41250d6b88c5f2b5dc6df5d728222b.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: aspeed: Add AMD Onyx BMC
 compatible
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi@amd.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, joel@jms.id.au,
 robh+dt@kernel.org,  openbmc@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
 jothayot@amd.com, linux-aspeed@lists.ozlabs.org,  krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org
Date: Fri, 21 Mar 2025 11:09:29 +1030
In-Reply-To: <174233663954.4094319.18412685456723022993.robh@kernel.org>
References: <20250318174730.1921983-1-Rajaganesh.Rathinasabapathi@amd.com>
	 <174233663954.4094319.18412685456723022993.robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-03-18 at 17:26 -0500, Rob Herring (Arm) wrote:
>=20
> On Tue, 18 Mar 2025 12:47:29 -0500, Rajaganesh Rathinasabapathi wrote:
> > Document new AMD Onyx BMC board compatibles
> >=20
> > Signed-off-by: Rajaganesh Rathinasabapathi <Rajaganesh.Rathinasabapathi=
@amd.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
> > =C2=A01 file changed, 1 insertion(+)
> >=20
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
> =C2=A0 pip3 install dtschema --upgrade
>=20
>=20
> New warnings running 'make CHECK_DTBS=3Dy for arch/arm/boot/dts/aspeed/' =
for 20250318174730.1921983-1-Rajaganesh.Rathinasabapathi@amd.com:
>=20
...
>=20
> arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: mbeeprom@50: $nodename:=
0: 'mbeeprom@50' does not match '^eeprom@[0-9a-f]{1,2}$'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/eeprom/at24.yaml#
> arch/arm/boot/dts/aspeed/aspeed-bmc-amd-onyx.dtb: mbeeprom@50: Unevaluate=
d properties are not allowed ('$nodename' was unexpected)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/eeprom/at24.yaml#

Rajaganesh: Please fix these warnings before you send v5.

Andrew

