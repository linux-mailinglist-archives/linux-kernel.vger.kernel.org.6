Return-Path: <linux-kernel+bounces-335351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 856B797E480
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 03:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4D72812A1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 01:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9329A2114;
	Mon, 23 Sep 2024 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="VPnfWP/C"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEED0184;
	Mon, 23 Sep 2024 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727053753; cv=none; b=MQhWSvQKvmGBZXZ6MmRRBdYCk1CW3Pe4rburtCcGOixZMUfU8nWXfLGcP7KxpY8iFMChwqSyWgnTa+QXUjyLODdZpq1T3fTJxm5fA2VlNrK7czbbD+v+LCqskFftpOqIx8qdIIXmyndOOb1gcgUrCNjczJo4YRzMwcxGi2ZlNLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727053753; c=relaxed/simple;
	bh=tWhZQpczfUoyfOn3SVXRMh0oUsuUO0P7TY3yGm7/BeI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sKYKb/OcfD7KFmjSNWnFqYGKdcJp5FhQCrc1qyPIMgFmeyTAADRm9x2Tv2EbsynG9QzGBdPgeUT6m1JPr0cUo6TLrPG9cE3V5UnKHFByqBi8Z2iGxLtf8ywCQBwUA16PILJouvUE6WA7bQtdQNV5rmpVY/OcXZ7hXbfWxz11qGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=VPnfWP/C; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1727053748;
	bh=+G0XJf/d/VA4rBfpqhj2Iciipn6AYGuPI900BalqIjA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VPnfWP/CS4BJC3Ym9/6/A95bxGfS166HiF09LDabbS3pKJuQyzlUMlAk/VdBpium4
	 f8rw9uQVUCKGYrxWXQUOjafLr74zaRd1B+Ya+Qy+LIY4FKFACd2TC5+41AcNYMXBgN
	 58sNuwy9X7AwrmGKVnIYGoS31qyd9Susx10NmNhiwOlBAwsv0wMv018U+kOy/Bnvlm
	 u5nGHmKypLjwb8kynHTxDBuWMmNXQdeFDtjueQ0V0j1ast8Hr0e/FcB9C4uzCBZNA7
	 XfE5o0ogJ1ex2QO9hipuVSw7pyw+iGpYNu7onj02iPTStQ00gqQ/2UclPpPFSN6v9W
	 KhAQnLM0ysIdA==
Received: from [192.168.68.112] (ppp118-210-177-92.adl-adc-lon-bras34.tpg.internode.on.net [118.210.177.92])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id CBEF1640E8;
	Mon, 23 Sep 2024 09:09:06 +0800 (AWST)
Message-ID: <516706cb77ac88ff1b9d94a69b0e1ed54e184ec9.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 2/3] dt-bindings: trivial-devices: support MPS MP5023
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>, Guenter
 Roeck <linux@roeck-us.net>, "patrick@stwcx.xyz" <patrick@stwcx.xyz>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>, Joel Stanley
 <joel@jms.id.au>,  Peter Yin <peteryin.openbmc@gmail.com>, Noah Wang
 <noahwang.wang@outlook.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Fabio Estevam <festevam@gmail.com>, Lukas
 Wunner <lukas@wunner.de>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>
Date: Mon, 23 Sep 2024 10:39:06 +0930
In-Reply-To: <TYZPR04MB5853BD9CD0774B40BAEF7BDFD66C2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240918095438.1345886-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240918095438.1345886-3-Delphine_CC_Chiu@wiwynn.com>
	 <bf5258b8-a5a1-4cf3-9bd0-1fa44696c3b0@roeck-us.net>
	 <355b19a62e54aa979451d796c3ebe1e294a0cf45.camel@codeconstruct.com.au>
	 <TYZPR04MB5853BD9CD0774B40BAEF7BDFD66C2@TYZPR04MB5853.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-20 at 01:54 +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:
>=20
> > -----Original Message-----
> > From: Andrew Jeffery <andrew@codeconstruct.com.au>
> > Sent: Thursday, September 19, 2024 9:24 AM
> > To: Guenter Roeck <linux@roeck-us.net>; Delphine_CC_Chiu/WYHQ/Wiwynn
> > <Delphine_CC_Chiu@wiwynn.com>; patrick@stwcx.xyz; Rob Herring
> > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dool=
ey
> > <conor+dt@kernel.org>
> > Cc: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>; Joel Stanley
> > <joel@jms.id.au>; Peter Yin <peteryin.openbmc@gmail.com>; Noah Wang
> > <noahwang.wang@outlook.com>; Javier Carrasco
> > <javier.carrasco.cruz@gmail.com>; Fabio Estevam <festevam@gmail.com>;
> > Lukas Wunner <lukas@wunner.de>; Laurent Pinchart
> > <laurent.pinchart@ideasonboard.com>; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-aspeed@lists.ozlabs.org
> > Subject: Re: [PATCH v2 2/3] dt-bindings: trivial-devices: support MPS M=
P5023
> >=20
> >  [External Sender]
> >=20
> >  [External Sender]
> >=20
> > On Wed, 2024-09-18 at 10:00 -0700, Guenter Roeck wrote:
> > > On 9/18/24 02:54, Delphine CC Chiu wrote:
> > > > From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > > >=20
> > > > Add support for hot-swap controller MPS MP5023.
> > > >=20
> > > > Signed-off-by: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> > > > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> > > > --
> > >=20
> > > The hardware monitoring mailing list was not copied, so I assume that
> > > the expectation is that it will be applied through some other tree.
> >=20
> > We can take it through the BMC tree, but I'd prefer that the hardware
> > monitoring list were copied regardless.
> >=20
> > Ricky: Please do so for v3 onwards.
> >=20
> > Andrew
> Hi Guenter & Andrew,
>=20
> Would like to ask how to copy the hardware monitoring mailing list?

Not sure how best to answer this, but add it in the To: line for your
patches?=20

> Should I just send the v3 patch with only this dt-bindings patch for MP50=
23
> and it will be added in the mail automatically?

Well, if whatever process you're already using isn't adding it
automatically, I doubt it's going to start doing so now.

You can add it using the `--to` option to `b4 send` or `git send-
email`, for instance.

The details for the hwmon list are here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/MAI=
NTAINERS?h=3Dv6.11#n9836

Andrew

