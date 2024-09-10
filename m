Return-Path: <linux-kernel+bounces-322854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D32869730F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 12:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110DB1C24C79
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06C191F63;
	Tue, 10 Sep 2024 10:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="geiVBppQ"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D661917D6;
	Tue, 10 Sep 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962627; cv=none; b=OsyKoJqzyOgLTwjWAUZsXFvv79MNyA7Kz1o0r/J1xh7wzsSiVDLKQ+NTkrJbpnpBi2DtoozrJgLRL7DTXJ6lefD+FH9N+iVFc3FMAAu6U84vACuUuDp9XWH84jXT0BTeWwHqJEHpIdY815OjnRAVfsgckH3mVzhv7RCihoSlsrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962627; c=relaxed/simple;
	bh=W64MFvFVpIvTxWzm0aAbmkcRhJVLUdYZqRBC9+A2u+E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=AgrCcDLkmzpk27fndR+oX0GqYpMjGwrjvfSG/68QFe17bPjh8V6IzoqTr2d1VAmJkLenk7OeXpkz64rq3hdVGaZe8nq9hZfJ4506VZr+JcN+OW7sMm1MlutotH7G36YqLHxPcIutFbQkOfTSr3TgElRiT1j8NdSDWLD1cl71/bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=geiVBppQ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00348240008;
	Tue, 10 Sep 2024 10:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725962617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1Un8sAVYGgks6pYsecrKnYuyHFKooLsXNJOWsSFhmI=;
	b=geiVBppQsTTU2/i/dssl1ET33GdvY1dSOyrplSTQuyTNCWXJFmG2RJ92d4RxEjdlc19GLQ
	jxkKFCMr3ZkGwKro92VR4lgklTYEHLJkK92NFmqTFDYqGKCD+I/X6YpZml50lI8C2fD6xE
	VVlnnNFjWmJAzqzFmOEFWNNCcVYVbRDx6Gdj62H5zZQuZjEcC1Xk2P33BH8PHnsIEIY9NA
	q+k9IMis1Bdt3geooQ5BcU9fNWFmgG+3PxASPyqy1PWPXrhVOZ72u/mE7u4k/1dbs2AR7J
	B4GWxoiSnAL8Q33N40V8D2bSDeQ8YS4BbyhY722YnL4sdqpl8/ixQRhdObryGg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Sep 2024 12:03:35 +0200
Message-Id: <D42IONMJMLQS.37KAIQ5GKLRTU@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH v5 02/12] dt-bindings: usb: ti,j721e-usb: add
 ti,j7200-usb compatible
Cc: "Mathias Nyman" <mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Kevin Hilman"
 <khilman@kernel.org>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, <devicetree@vger.kernel.org>, "Tero Kristo"
 <kristo@kernel.org>, <linux-kernel@vger.kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-arm-kernel@lists.infradead.org>,
 "Nishanth Menon" <nm@ti.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
 "Pawel Laszczak" <pawell@cadence.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Roger Quadros" <rogerq@kernel.org>, "Peter
 Chen" <peter.chen@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <20240726-s2r-cdns-v5-2-8664bfb032ac@bootlin.com>
 <172202197161.1924212.4114467370508864411.robh@kernel.org>
In-Reply-To: <172202197161.1924212.4114467370508864411.robh@kernel.org>
X-GND-Sasl: theo.lebrun@bootlin.com

On Fri Jul 26, 2024 at 9:26 PM CEST, Rob Herring (Arm) wrote:
> On Fri, 26 Jul 2024 20:17:50 +0200, Th=C3=A9o Lebrun wrote:
> > On J7200, the controller & its wrapper are reset on resume. It has the
> > same behavior as ti,j721e-usb with a different SoC integration.
> >=20
> > Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
>
> My bot found errors running 'make dt_binding_check' on your patch:

Clearly this patch was wrong.
Past me trusted future me to verify and future me trusted past me.
Sorry!

For reference, new patch content will look like below.
This doesn't trigger a warning on:

    make dt_binding_check DT_SCHEMA_FILES=3Dti,j721e-usb

------------------------------------------------------------------------

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Docu=
mentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 653a89586f4e..d14c18b64086 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -14,7 +14,9 @@ properties:
     oneOf:
       - const: ti,j721e-usb
       - items:
-          - const: ti,am64-usb
+          - enum:
+              - ti,am64-usb
+              - ti,j7200-usb
           - const: ti,j721e-usb

   reg:

------------------------------------------------------------------------

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


