Return-Path: <linux-kernel+bounces-551595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FA0A56E56
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE59D169525
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ADC2405E4;
	Fri,  7 Mar 2025 16:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KJev8qlq"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4EC23F401;
	Fri,  7 Mar 2025 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741366241; cv=none; b=rjZGjk/B1jKxTU3i4UijVapPDNsj7D9lGUk5sUivjt16TtGTYEyeFFmYVL//0uD1ZRGxT8sT81Qo/Otn+IFeJc8ID7rCIe7Peh54VQX8jVnVcXmFmkZOOiYjNqW056/kSTsggatRJrXFioypsbSIlxXNkEwsc0f8BOxKT0eM3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741366241; c=relaxed/simple;
	bh=rUXD9TcSMWpiIaqwioMcbkWAcaPs5VI0GxZ9OWztz90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SgfxLHH5U+2qDTHFeXEXFa4wZD1LXwuteDuh9oyrYEWanvOnp3kz+obezc4C/2j00j6tdyfAbfTCXIl5iz9diry6kWD3lLUttvJOyjakqdy1cwFc6crqaKpnUCq6NqKRGk7iYKGzHV101aDr+A9WnzgSy9uyTtksihB95BMlVrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KJev8qlq; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E33C3433C9;
	Fri,  7 Mar 2025 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741366237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S57DKTWXLs/9f2IPDzxcNXYUu/FS7kJ5cAjwwKfx/Ds=;
	b=KJev8qlqpoqNIqLvR5qWEghesnn+TdwjmMtw/IYaX3Vk1G9bDZIH3e5M3i4RL7AHdr57HI
	MsN/sqnsV6QEZJ1wpqnWVmcXuhkkiOqEk/TPVJfWwMDWh/zGMBbVs+o8miFzDeZA1W3AzC
	Lmi7n1K+uL0lit+uItX3LhqBnQ9drzZDEZm+6NisnCfrfsO9TvbtQtfAlhNWfPDhm2zZjL
	O5cplwqVUuR62syad3UxTxWDKaNU71vemFOy4zfIU+mysGNh26KfUl4ZRJfJbgMhxtDX0C
	XuEQ3mqQ6dngNXKbtWMR71TQrXfL4ZZkKMbh2Vfy+mv8sOdYqO5Hi5gAmoo8gw==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: marvell: armada: Align GPIO hog name with
 bindings
In-Reply-To: <6bed3249-9905-4949-8031-52217f123f2e@lunn.ch>
References: <20250116085947.87241-1-krzysztof.kozlowski@linaro.org>
 <6bed3249-9905-4949-8031-52217f123f2e@lunn.ch>
Date: Fri, 07 Mar 2025 17:50:36 +0100
Message-ID: <87plis23ab.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudduudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfggtgfgsehtqhertddttdejnecuhfhrohhmpefirhgvghhorhihucevnffgoffgpffvuceoghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgffhgedvhefgtdejvdethfdvieekgfetuefhueekteetgfdvueeutedttdekgeevnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemledtrggumedvvggutdemlegstgdtmeeivdgstdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemledtrggumedvvggutdemlegstgdtmeeivdgstddphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhriiihshiithhofhdrkhhoiihlohifshhkiheslhhinhgrrhhordhorhhgpdhrtghpthhtohepshgvsggrshhti
 hgrnhdrhhgvshhsvghlsggrrhhthhesghhmrghilhdrtghomhdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigsegrrhhmlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-GND-Sasl: gregory.clement@bootlin.com

Andrew Lunn <andrew@lunn.ch> writes:

> On Thu, Jan 16, 2025 at 09:59:47AM +0100, Krzysztof Kozlowski wrote:
>> Bindings expect GPIO hog names to end with 'hog' suffix, so correct it
>> to fix dtbs_check warnings like:
>>=20
>>   armada-385-clearfog-gtr-s4.dtb: wifi-disable: $nodename:0: 'wifi-disab=
le' does not match '^.+-hog(-[0-9]+)?$'
>=20=20

Applied on mvebu/dt64

Thanks,

Gregory

> Hi Krzysztof
>
> I believe the mvebu pull request for the next merge window has already
> been sent to arm-soc. So please repost after -rc1.
>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>     Andrew

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

