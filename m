Return-Path: <linux-kernel+bounces-395733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041719BC233
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364691C21C33
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4318DF9EC;
	Tue,  5 Nov 2024 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="FPFPtVNR"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F2E1CF8B;
	Tue,  5 Nov 2024 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730767903; cv=none; b=TE4LAayV3zl3vixwibIdR+s7lul09FpNhRNs0v/09aWFLyUk4lgX2CuiqhXQRSeUaZZB74YtxgV6+FkAW6YbP8ervwmavslquTbrWo00h6Z0zsV9+HZILnwDAmck5kh4LC69lhG7502NLEFxf05kcOdHSdNZAy7yKMH+xZzzJRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730767903; c=relaxed/simple;
	bh=ITYUF412IGD3EXf5hD1+vyGezOoq2SuNalYoAo0K4NA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kZqsxdTouGPOzbE7L6EY6OfdzLDAqXs6HLh/Z53Hi8RSuo804cxFg4LuvBp37cQdQFCiU3p/a5zDhlO8gwu/yjYkQldNvfcolnwhmI1C7GbMF4pABuvy+l+IHQUg3SYBx+/qxHcZPXuEml6On/6L388zv2rSuboOx7iVThFzMfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=FPFPtVNR; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1730767899;
	bh=ITYUF412IGD3EXf5hD1+vyGezOoq2SuNalYoAo0K4NA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FPFPtVNRiShJlJ0Qg62L7d998Pti/VPhPeYaN2btBSrxJ2FjmDvcud1KBsQgcf2XJ
	 PN2ictV8BhlLcRND/BI0gJnNGGNDqTfnHxgQy0vzJiKbptXY7DjLz1ra3oT0riOQg4
	 UCmaVo4J3B0HuWJkfvPsKIFJWGwzM6yxvFzbyps74OyOdZEP/U3kvKltHWxOoIR9Zf
	 zFY/qah/vHZX2L/a3CPnB4cDffEkOpExPl1GQx8E1zOYKcKLxZdWC6XM7/tAHQwHsz
	 WfV/M/LIUiAHbcfGWpvBYOAXPEq0yLC+fonRmPKLkeIxFzOqsmsWfEybeh7GqRGNkQ
	 g+6mhyxPAi86w==
Received: from [192.168.68.112] (ppp118-210-162-114.adl-adc-lon-bras34.tpg.internode.on.net [118.210.162.114])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DADBB6A3C9;
	Tue,  5 Nov 2024 08:51:38 +0800 (AWST)
Message-ID: <957c987a4eccc78758ed499eb09e32b5d7969c4d.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: nuvoton: Fix at24 EEPROM node names
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Avi Fishman <avifishman70@gmail.com>, 
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
 Patrick Venture <venture@google.com>,  Nancy Yuen <yuenn@google.com>,
 Benjamin Fair <benjaminfair@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, openbmc@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 05 Nov 2024 11:21:38 +1030
In-Reply-To: <CAL_JsqJBeoD4yPj1Wva5cbPHweK3RU6pF-Vn=P+MsW0-RhKhZQ@mail.gmail.com>
References: <20240910215905.823337-1-robh@kernel.org>
	 <CAL_JsqJBeoD4yPj1Wva5cbPHweK3RU6pF-Vn=P+MsW0-RhKhZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-04 at 07:26 -0600, Rob Herring wrote:
> On Tue, Sep 10, 2024 at 4:59=E2=80=AFPM Rob Herring (Arm) <robh@kernel.or=
g>
> wrote:
> >=20
> > at24.yaml defines the node name for at24 EEPROMs as 'eeprom'.
> >=20
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > =C2=A0arch/arm/boot/dts/nuvoton/nuvoton-npcm730-gbs.dts=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6
> > +++---
> > =C2=A0.../arm/boot/dts/nuvoton/nuvoton-npcm750-runbmc-olympus.dts | 2 +=
-
> > =C2=A02 files changed, 4 insertions(+), 4 deletions(-)
>=20
> Ping!

Ah, thanks, I lost track of this one. I've applied it to be picked up
via the BMC tree.

Andrew


