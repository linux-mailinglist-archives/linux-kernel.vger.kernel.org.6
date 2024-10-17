Return-Path: <linux-kernel+bounces-368920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C679A1683
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 02:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C74A2847A3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DEA6FB9;
	Thu, 17 Oct 2024 00:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="PdIzXG2o"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF0E10F1;
	Thu, 17 Oct 2024 00:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729123715; cv=none; b=JovLLILVZOaEkTB5Y6hXarQSaPifnCgF8/0J5bh+70t3sPFSUgSk7vgD04M8eWlYhWTEUd1aBQMJobdSntqbPSXtmMZwe6r3xoqbx13NR2SFOXp7fwP3GdC/sj9gvnx32xGmziHOVZfS7en1oSM9MCENMm2EQhJd6LaPgKCAi+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729123715; c=relaxed/simple;
	bh=MJLV0tcHDxYrAJWRYnY4HRU2T9JXBQ/Ox19qpn6RCQY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZvLUJq/WuqnqmV/kyemB53FGOyEefv0ZSocbeqpb8FOcexYwD2+dxEa2fcSM5R2Ni5Q7Y7JeRZGDwhm++ysBdnawGBTvcSXHIq7wwb9A19hXjNUpq06SsRj6NdD/41gSF9DgosuiQSzsfdA8pivaN5fDFmN9ICMBVqHNSJwTY08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=PdIzXG2o; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729123710;
	bh=MJLV0tcHDxYrAJWRYnY4HRU2T9JXBQ/Ox19qpn6RCQY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PdIzXG2oo8nlIjIt6YdEvK79moJ6OhTLC/559NkVkW3MmTY58QSR7gPQ2bMIHvFPP
	 K0jYXX6ycnnuKPOQrAUJeXy6ScnODBUZNqR8dMda4SDR9uglT/iFxny9G3M41bYOpc
	 X7Ic9ngP3FWtxLnyhAK29dxGRG5XcISMN1L4Z51H2nZ7c+G9tMRMhgP+PiM+VV1XoA
	 20HeD6o6Hikr84Z4Pr2tfKanhrxUbO7LT03hNeSt9ClkUIvB+6moOuJTHcQga5u3As
	 5+Ucba5h9Cw30ZS3/6cwBRcxAKBVgYE/y6HDHu0vkmhsf06bI+PO56Qx1DJUrSQWhW
	 Cet5g3j+8MMbA==
Received: from [192.168.68.112] (203-173-0-39.dyn.iinet.net.au [203.173.0.39])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 913C667E1F;
	Thu, 17 Oct 2024 08:08:27 +0800 (AWST)
Message-ID: <f833ef3b873d0e71581dd138f046b19fa3fdeaf2.camel@codeconstruct.com.au>
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
Date: Thu, 17 Oct 2024 10:38:26 +1030
In-Reply-To: <c42be4ea-9902-4fac-8b1e-afc38fe04bad@amperemail.onmicrosoft.com>
References: <20241014105031.1963079-1-chanh@os.amperecomputing.com>
	 <172891445289.1127319.4114892374425336022.robh@kernel.org>
	 <b5919d904c9f06a618a54d49bc895c3081a511e4.camel@codeconstruct.com.au>
	 <e8e31fb4-4a9f-4ea9-be4d-9ba29d824cc5@amperemail.onmicrosoft.com>
	 <7555c528c90e6151f54d0e17c278527f95fac184.camel@codeconstruct.com.au>
	 <c42be4ea-9902-4fac-8b1e-afc38fe04bad@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Chanh,

On Wed, 2024-10-16 at 17:26 +0700, Chanh Nguyen wrote:
>=20
> On 16/10/2024 12:07, Andrew Jeffery wrote:
> > You can also find discussions where other maintainers (Guenter, hwmon
> > maintainer; Krzysztof, devicetree maintainer) have asked that "pmbus"
> > not be used as a compatible:
> >=20
> > https://lore.kernel.org/all/f76798ea-6edd-4888-8057-c09aaed88f25@roeck-=
us.net/
> >=20
>=20
> Hi Andrew,
> I checked the discussion at=20
> https://lore.kernel.org/all/f76798ea-6edd-4888-8057-c09aaed88f25@roeck-us=
.net/=20
> . It seems the maintainers don't want to use the "pmbus" compatible for=
=20
> specific devices. The maintaners require an explicitly compatible from=
=20
> device list in drivers/hwmon/pmbus/pmbus.c .
>=20

There are two problems:

1. Describing your _hardware_ (not drivers) in the devicetree
2. Binding a driver to your device

You ultimately care about both 1 and 2 as you want Linux to do
something useful with the device, but for the purpose of this patch
adding the devicetree, 1 is what matters and 2 is not really a part of
the considerations.

What needs to be the case is that the devicetree describes the device
via an appropriate compatible string for the device (manufacturer and
part number). Prior to that, the compatible string for the device needs
to be documented in a devicetree binding. This may be the trivial-
devices binding if there are no extra properties that need to be
described, or you may need to write your own binding document for the
device if it's more complex and one doesn't yet exist.

So whatever is in pmbus.c needs to be fixed later on if your device is
not yet supported by it, but that's a separate problem (2) to the
problem you have here (1).

Who is the manufacturer and what is the part number?


Andrew

