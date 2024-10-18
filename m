Return-Path: <linux-kernel+bounces-370931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EE49A33E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 06:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8A7F1F21FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 04:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653D017332B;
	Fri, 18 Oct 2024 04:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="b5zFpXEj"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830120E31F;
	Fri, 18 Oct 2024 04:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729226151; cv=none; b=aqZoaAwRtfjTTZDsAkJnidvquLg0Gtp8LakzCeTOALSmDxTxwFUDwMHTMrxPe1S8fzWKFf/Kg5V67Zc+7aNUrjEJKwaeG/dkFkKNH2yr/bIWuHHaQgG83FthxIMtq3dBDM68rTgsxtfIwcPiNFCKqHgaHue90JLugF/fy+UUdjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729226151; c=relaxed/simple;
	bh=NP6NRlGAEnQ5DtECIzxbpzRPTglwkI6hJiT85COeZ08=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZBMaJnxkgPaGtKxB7suPBoaadHLYcs6UhzeeNMNys/cv9/e43POv+uwoq//yGDK3ik5OHIdACt4Arl4Xdyu670Y6U+XpEfaJueuSYUFBIq4QiGdUzlLfUYDuTNeh8q594xDQgzLNAM83ddGuQovb5C6pzxTUNmnC1McfxEbhs6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=b5zFpXEj; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729226148;
	bh=NP6NRlGAEnQ5DtECIzxbpzRPTglwkI6hJiT85COeZ08=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=b5zFpXEjm4MUZAcbjgBPLYTCResrTNytMosa0d77qnI+oRFx4+Lx/Fbqp+I1PdGMy
	 WkCK+ulvFt6yvnspwxFkm8q++0f/A4VQJ6XJfs75LXG4Jl8T9+FQ/eVzgRGbBQdaDa
	 vm4s4i6LjuTEWH4LkOFp98t4IygoiaCXjFXL0StvJEGW+48QTVKnvlfl53agABsUck
	 Roo1uKq7MM+qrYCRJ75Rbdu8rHELyMIjpF6iwFjlfcTWJEc0WVweC/UT35ucuNxUbB
	 cFtofEqrt+NEL0wqn+xF39N0Qz4VSV5ZkaI4RA/Rhr7C6/ldTkDoICzEsGluod8tGR
	 Ip2jyKQFt5yOA==
Received: from [192.168.68.112] (203-173-0-39.dyn.iinet.net.au [203.173.0.39])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 243FE681B1;
	Fri, 18 Oct 2024 12:35:47 +0800 (AWST)
Message-ID: <0361287ca986cb6101fae2b269b2fe14eea84158.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: Add device tree for Ampere's Mt.
 Jefferson BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chanh Nguyen <chanh@amperemail.onmicrosoft.com>, Chanh Nguyen
	 <chanh@os.amperecomputing.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Khanh Pham
 <khpham@amperecomputing.com>, linux-arm-kernel@lists.infradead.org, Thang
 Nguyen <thang@os.amperecomputing.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Phong Vo <phong@os.amperecomputing.com>, Conor Dooley
 <conor+dt@kernel.org>, Rob Herring <robh+dt@kernel.org>, OpenBMC Maillist
 <openbmc@lists.ozlabs.org>, Open Source Submission
 <patches@amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>, 
 linux-aspeed@lists.ozlabs.org
Date: Fri, 18 Oct 2024 15:05:46 +1030
In-Reply-To: <b16b82d7-60e1-428d-bc7a-8a236ebb98ca@amperemail.onmicrosoft.com>
References: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
	 <172891445289.1127319.4114892374425336022.robh@kernel.org>
	 <b5919d904c9f06a618a54d49bc895c3081a511e4.camel@codeconstruct.com.au>
	 <e8e31fb4-4a9f-4ea9-be4d-9ba29d824cc5@amperemail.onmicrosoft.com>
	 <7555c528c90e6151f54d0e17c278527f95fac184.camel@codeconstruct.com.au>
	 <c42be4ea-9902-4fac-8b1e-afc38fe04bad@amperemail.onmicrosoft.com>
	 <f833ef3b873d0e71581dd138f046b19fa3fdeaf2.camel@codeconstruct.com.au>
	 <b16b82d7-60e1-428d-bc7a-8a236ebb98ca@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-17 at 17:02 +0700, Chanh Nguyen wrote:
>=20
> On 17/10/2024 07:08, Andrew Jeffery wrote:
> > [EXTERNAL EMAIL NOTICE: This email originated from an external sender. =
Please be mindful of safe email handling and proprietary information protec=
tion practices.]
> >=20
> >=20
> > Hi Chanh,
> >=20
> > On Wed, 2024-10-16 at 17:26 +0700, Chanh Nguyen wrote:
> > >=20
> > > On 16/10/2024 12:07, Andrew Jeffery wrote:
> > > > You can also find discussions where other maintainers (Guenter, hwm=
on
> > > > maintainer; Krzysztof, devicetree maintainer) have asked that "pmbu=
s"
> > > > not be used as a compatible:
> > > >=20
> > > > https://lore.kernel.org/all/f76798ea-6edd-4888-8057-c09aaed88f25@ro=
eck-us.net/
> > > >=20
> > >=20
> > > Hi Andrew,
> > > I checked the discussion at
> > > https://lore.kernel.org/all/f76798ea-6edd-4888-8057-c09aaed88f25@roec=
k-us.net/
> > > . It seems the maintainers don't want to use the "pmbus" compatible f=
or
> > > specific devices. The maintaners require an explicitly compatible fro=
m
> > > device list in drivers/hwmon/pmbus/pmbus.c .
> > >=20
> >=20
> > There are two problems:
> >=20
> > 1. Describing your _hardware_ (not drivers) in the devicetree
> > 2. Binding a driver to your device
> >=20
> > You ultimately care about both 1 and 2 as you want Linux to do
> > something useful with the device, but for the purpose of this patch
> > adding the devicetree, 1 is what matters and 2 is not really a part of
> > the considerations.
> >=20
> > What needs to be the case is that the devicetree describes the device
> > via an appropriate compatible string for the device (manufacturer and
> > part number). Prior to that, the compatible string for the device needs
> > to be documented in a devicetree binding. This may be the trivial-
> > devices binding if there are no extra properties that need to be
> > described, or you may need to write your own binding document for the
> > device if it's more complex and one doesn't yet exist.
> >=20
> > So whatever is in pmbus.c needs to be fixed later on if your device is
> > not yet supported by it, but that's a separate problem (2) to the
> > problem you have here (1).
> >=20
> > Who is the manufacturer and what is the part number?
> >=20
> >=20
> > Andrew
>=20
> Thank Andrew for your explanation! I'm so happy to receive comments from=
=20
> you.
>=20
> I'll remove the PSU node with "pmbus" compatible in the patch v2. We'll=
=20
> discuss more to have a suitable PSU node later.
>=20
> I'm preparing the patch v2. Summary, I need to update as the below list.
> 1. Add Mt. Jefferson board compatible binding as Krzysztof pointed.
> 2. Remove the PSU node with "pmbus" compatible.

Sounds good. Thanks.

>=20
> If you have any other comments on patch v1 please don't hesitate to=20
> point out; I'll update that in patch v2.

I had one query on v1.

Andrew


