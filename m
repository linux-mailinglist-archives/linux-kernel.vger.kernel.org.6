Return-Path: <linux-kernel+bounces-559303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C4DA5F222
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:15:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B9019C1FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB39266EF5;
	Thu, 13 Mar 2025 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="K57RJVVr"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FEC266B5E;
	Thu, 13 Mar 2025 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864481; cv=none; b=VoWA+U73cH+IOE2qQcd3XMqbd2MFK0XiOSgmzCws6rWOcAzGCWmG85BNJ7NvSj33jj0cjaDhn7+y3iAb3gFCIANjqlyPexBzlLO4FpP2vP5E4CVzzZEx0O2thvW4y5kYmmoC1844ZWDTr+hF/0I2RoZqbJQ0EY6YLMe4tXDnstA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864481; c=relaxed/simple;
	bh=GxZRHUz0odpMCAdOXDZV2Gewb34GcPHensWB6qpYNW0=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version:
	 References:In-Reply-To; b=j99ihb3n1sPxb52OGt6UQudmhDvL0zFqnw5g9gJBf/2vvZZg49xjn6H1Lib4USiIxa5kKmOOmzfjiR1DN+pqyScwL2MKcpVxs3S72SPHxuPmzOjIOn38wjR1SM0cf1yrY+5961txstcxlqGjBLQxBqOXUXr+ATbdGL2YSTCA3hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=K57RJVVr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D6C2343152;
	Thu, 13 Mar 2025 11:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741864470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GxZRHUz0odpMCAdOXDZV2Gewb34GcPHensWB6qpYNW0=;
	b=K57RJVVry+aqhLyQrVxSO4IAxED4+E2G+7+fkUvNhgvK7Q9jpbbOqar2SDtepqXnrMWaVB
	LTT8Tn/GX2Q/yC3FHeXUxH1TrSQXNYQU+WJslfCY6/o6XRlpdl9RQbp1xtO0wDFIOfpORM
	itwbhKXW/COXgf3O68gErM3szNiCucaOtDlksnV+sv/rm4eVQ8kZn1EoUQE8D+gujujYZC
	G9acDWmdcUhDRR4QZksDRmrXpGOBpumVsOUYlRgUAT71aGXP3DaNy7KjArTC7vGRYOO2KJ
	qe/dqoT6aTaBp8x0FASOVeSyE91RzsvOKDRM51E8m4Uzi6OyGgeYDCySyDIRBQ==
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 12:14:26 +0100
Message-Id: <D8F3F4YLD0ZM.19X0451BIIDVO@bootlin.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6UL SoM and
 Concerto board
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Shawn Guo" <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <imx@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>
From: "Antonin Godard" <antonin.godard@bootlin.com>
To: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250310-varsom6ul-concerto-dts-v3-0-551e60713523@bootlin.com>
 <20250310-varsom6ul-concerto-dts-v3-1-551e60713523@bootlin.com>
 <63f8aa7d-fcd4-450f-b3a1-44886a29fc7e@kernel.org>
 <cd2f3c97-53bb-42f5-a3cd-4385bfda5dc7@kernel.org>
 <D8CQAAKOZ1O5.8JVESQPJSSM8@bootlin.com>
 <20250311-omniscient-fiery-bison-8e7feb@lemur>
In-Reply-To: <20250311-omniscient-fiery-bison-8e7feb@lemur>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtfffkufevhffvggfgofhfjgesthhqredtredtjeenucfhrhhomhepfdetnhhtohhnihhnucfiohgurghrugdfuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhueejkedugfefffektddtvdehheeuieeggfetgfdvveeftdehudduteffgfevgfenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudegpdhrtghpthhtohepkhhonhhsthgrnhhtihhnsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrohgshhesk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgrfihnghhuoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshdrhhgruhgvrhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvg
X-GND-Sasl: antonin.godard@bootlin.com

Hi Konstantin,

On Tue Mar 11, 2025 at 7:34 PM CET, Konstantin Ryabitsev wrote:
> On Mon, Mar 10, 2025 at 05:31:32PM +0100, Antonin Godard wrote:
>> > And now I noticed you used b4, so I really do not get how the tags can
>> > be missing here. :/
>>=20
>> Sorry, that's totally my fault here, I forgot to run 'b4 trailers -u' be=
fore
>> sending... :/ And I don't think it's part of the prep checks?
>
> Mostly, because there's no clear picture of how this would work reliably.=
 All
> other checks are on a "ran since modifications to the series" basis, but =
this
> one would have to be time-based.
>
> Should it check if the trailer updates have been run in the past XX minut=
es
> (and how long should that XX be?).

Had some thoughts about this the past few days.

What about checking if it was run at least once between vX and vX+1? Maybe
during the `b4 send` command? In case it wasn't run, give a hint/warning to=
 the
user before proceeding?

This could also be enforced with an b4 config option like
b4.force-trailers-update - either set by the user or the project configurat=
ion.
Not so sure about this one though...

Now if I were to speak for myself, I would love to have an option that just
fetches the new trailers during `b4 send` and errors out / warns me about
it if there's anything new that isn't part of my series. Which could be als=
o
ignored with --ignore-trailer-errors or something like that, in any case.

Antonin

--=20
Antonin Godard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

