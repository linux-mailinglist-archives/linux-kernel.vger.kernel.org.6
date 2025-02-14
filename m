Return-Path: <linux-kernel+bounces-514655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 220C5A359D0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA62816D32A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7974E25A62F;
	Fri, 14 Feb 2025 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lTG7WkdZ"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAC22D7BD;
	Fri, 14 Feb 2025 09:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739524149; cv=none; b=bLkS+Y8rZG+YnaBYcqfhQWHA/sdtB+WRTVZ5lZ1IebvDvha6/aNsyir/BMsxIt14KLSS7FFLLXjSasdB2jAETokWHcsODaWETUKfJLHFW7MCyckKo/D9zyVHkGw9COLj+DoloCMhlGl4xnHWnl6tbW1LRejxeSr+BV3ATCNhooQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739524149; c=relaxed/simple;
	bh=zSXL9VavN96hCcGl7o2PD1XEiCklnDkRNAAJzvQiyrI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=FPS4N4Ftk2yh537Ic7az+jw26PMQOHCvrqVx5umSBd7oOb7VrvwEirk78OMe6uQSgfjf0pN49/lsmk/OjIIRO4954CQOdLSV0qAmzenK8cS+3Bd68ZLs0pmSkllIWp2LG4UllHdlgPD4Kkt3K54/rsjtrlTy7YE6nw05MWzrv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lTG7WkdZ; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 621C54330A;
	Fri, 14 Feb 2025 09:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739524145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zSXL9VavN96hCcGl7o2PD1XEiCklnDkRNAAJzvQiyrI=;
	b=lTG7WkdZpod3DrN3h495gm9vyE38azAW/vRQVzjl+Q92cWbImYHQY3tgqxcpJpej2hLqyo
	WRpIZzWPFqRW9bBHGn8d8IvEnTuoppZsBMwrOI/PIfcvorI3nF+FslZltEH2NAk300hYf5
	03g8j4swULodty03nQtJCZTuhK/LIgyuQWPK/Cmw6zmBBCbfApYTHU5lc11n3Q7i/BPbtr
	TQS98JIX6qY7hySr0cJNzgMEgJ5Gd2cKBVs6OiWb40yBYH7TGVlTNoeZzfHAVQ7weg17OS
	E/1/zHhF+8tY7Y5anLz0kuva054ygWSEF1CkrysOddwTxvuD2oKcRUffNYmR1w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 14 Feb 2025 10:09:01 +0100
Message-Id: <D7S1UERD0S47.12JDXAO96967F@bootlin.com>
Subject: Re: [PATCH v2 0/3] Add Variscite i.MX6UL SoM and Concerto board
 support
Cc: "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Shawn Guo"
 <shawnguo@kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam"
 <festevam@gmail.com>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250127-varsom6ul-concerto-dts-v2-0-4dac29256989@bootlin.com>
In-Reply-To: <20250127-varsom6ul-concerto-dts-v2-0-4dac29256989@bootlin.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegledvhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuvefhvffofhgjsehtqhertdertdejnecuhfhrohhmpedftehnthhonhhinhcuifhouggrrhgufdcuoegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdehtdetteehfefgjeelieelvdeiveeludffjeegueefudejueeffeejfeevgedunecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemjegthegtmeeirgguvgemjeelgeekmeegtdehledphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomheprghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrg
 hdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshdrhhgruhgvrhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehfvghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com

Hi,

On Mon Jan 27, 2025 at 4:30 PM CET, Antonin Godard wrote:
> Add support for the i.MX6UL Variscite SoM (VAR-SOM-6UL) and the
> Variscite Concerto Carrier Board.

Have you got any updates for this series?

Thanks,
Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

