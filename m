Return-Path: <linux-kernel+bounces-341325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78AC987E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 08:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FEC2839B1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 06:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510ED176AB6;
	Fri, 27 Sep 2024 06:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hvXoLJvB"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E912215D5C1;
	Fri, 27 Sep 2024 06:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727418519; cv=none; b=Kb2gCCitA8tVDnzyGO+z3VYnVfn3QPNQ6GLesEyUo77St03pBMCQSsV6LuAHBNNuDQ+QAfswDgaYLMtNc3JK4q6iNK5Nv9t5kW90J0UZEQZ0Shzx66/gYmLFP91+N9JV37DBrgeWPSLd1XVQ9OkUrSrwR8T5yUu8j96PZ40LOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727418519; c=relaxed/simple;
	bh=Py70J+qsFKOzHKwovKggJjoeyCbIouq1GSbx9PBnfzo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MPWWHZ+hMN+BM84VSocyQiWY2+aq6cvVKXWuSvf4xGg30+wjFHWa/7+r5x5y+gWE35x7yxxtAn1LwlRED1NrDxS5pBLxFcS3MNTQvKyBR7iyJiiIhtLowIepQ/Wg+GPW8ciHa3YfexdMqHF/uuqA4i1poopTnSp5ThcKEgCiQK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hvXoLJvB; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727418515;
	bh=jNmakUXF9nFiw23nJHwLmNqrMrEr852fUIAk37NrrB8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hvXoLJvBl0haqgB9gLlA5P7D0kpS7Lxe1BqXBsMzkz8L6h4g3DrxdzyEJ2/5jd3kh
	 5MoA2DXjwFlmM0E1NpmelUA6lD44TU3cKLK7B5qPfxYCy7XXnpEOzl1oRv8/IjFFXm
	 Le2Lnmqle6RCJ+QHaPqGke71+CTmlm1tqM6HT6RSWXstx0ONEDS7z7RjXn1Tcm2o8M
	 JsluSpJpYopW15KGXLH96pH3DhigLtu8Txil+jbIl13uPyb4o+1BzLL7AWqFc//Hy1
	 sXjFNkcmD4TrAvChxTRDs3exFvwzGQZeEnXedkxeXyk+62edYoD0uewbxubLUo0G1A
	 t+ZEmPk5eqCKA==
Received: from [192.168.68.112] (ppp118-210-187-73.adl-adc-lon-bras34.tpg.internode.on.net [118.210.187.73])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F397365029;
	Fri, 27 Sep 2024 14:28:34 +0800 (AWST)
Message-ID: <7fd8cffb3212de8ae6acd7ab434a22cdd94d7279.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the compatible
 string of adm1272
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>, 
	"patrick@stwcx.xyz"
	 <patrick@stwcx.xyz>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Fri, 27 Sep 2024 15:58:34 +0930
In-Reply-To: <TYZPR04MB5853E2B3197AAD9268A0BAB2D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240926013411.3701546-1-Delphine_CC_Chiu@wiwynn.com>
	 <c2ddf0375eff2c9c18fd26029fc6a1be7ed23a8b.camel@codeconstruct.com.au>
	 <TYZPR04MB5853E2B3197AAD9268A0BAB2D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-27 at 06:21 +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
>=20
> > -----Original Message-----
> > From: Andrew Jeffery <andrew@codeconstruct.com.au>
> > Sent: Friday, September 27, 2024 2:01 PM
> > To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>;
> > patrick@stwcx.xyz; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Joel Stanley
> > <joel@jms.id.au>
> > Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v1] ARM: dts: aspeed: yosemite4: correct the compat=
ible
> > string of adm1272
> >=20
> >  [External Sender]
> >=20
> >  [External Sender]
> >=20
> > On Thu, 2024-09-26 at 09:34 +0800, Delphine CC Chiu wrote:
> > > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > >=20
> > > Remove the redundant space in the compatible string of adm1272.
> >=20
> > In this case the space is not redundant, it's just incorrect, the compa=
tible string
> > doesn't match any specified. Do you mind fixing the wording?
> >=20
> Sure, I'll fixing the wording in v2.

Thanks.

>=20
> > >=20
> > > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> >=20
> > Can you please add an appropriate Fixes: tag?
> >=20
> > Thanks,
> >=20
> > Andrew
> >=20
> Would like to ask where should I add the Fixes: tag?
> Should I add in the patch title like:
> Fixes: ARM: dts: aspeed: yosemite4: correct the compatible string of adm1=
272
>=20
> Or should I add in the commit message?

It goes in the trailer block above your Signed-off-by tag. It will be
worth your time to review the following documentation:

- https://docs.kernel.org/process/5.Posting.html#patch-formatting-and-chang=
elogs
- https://docs.kernel.org/process/submitting-patches.html#describe-your-cha=
nges

The expected format and other details are described there.

Thanks,

Andrew


