Return-Path: <linux-kernel+bounces-566557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73281A67983
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 17:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82DD416FCFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F5E210F49;
	Tue, 18 Mar 2025 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ovt7yvZp"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE041A2567;
	Tue, 18 Mar 2025 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315509; cv=none; b=ebTwvfHrBE6TRKjr5elQKx6RuUpMhezwqfX5J5uF+E9J/pW680WJ9YFngs6bSPwJAVsIxaHlBcDBU8RC6Fgt8MPZCiREiKw3FWDeYgmnptfCT9bUafZxOA0N1Rod8LOprhZUF1Dg1KpBZzQG01pGkbJIi8eL2zoV/x0cJIiyPNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315509; c=relaxed/simple;
	bh=lYF0uNKy5hSX2n2Y0s9Y6GZGno5OJdtw+hEgTadHNVc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=KEow5tGeAtEgeI8StIx7Q3UM4a/MsLX4UETSlOcUZ4JWYZC2O/XiGhspKV/hdb8kOwpXWDn7JbxEl+uzkRb3zbhnoXBqXULZv8sLHFSY14S3Udlr7qytmrM8/afuslHNnmzKUm4NLk6kswC5Y5eobwzPq078JElPEC1QjuOY8SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ovt7yvZp; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6BA5F441A7;
	Tue, 18 Mar 2025 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742315502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OxwdPq+0w4lzQU1YvxN7G4CPCE7PE516l9RTO3tt8eg=;
	b=ovt7yvZpxUSVeEF+sv0JZGD2daZ0iG2rS/n+tnM2susDCa8vU7sjRJwfP1leMVQC0jTlAZ
	84e4wTksMS+mv6tGRXUJSYA93plrdYbMRas9MtIfTkku2/+ljX5RLVugz9xiZSDOdSaLQ3
	+3K3PLTVlHiPuf0TcHj7ZODthvskcJ8OwdW3W+xE31qUHvoUdSf6yJ79TTlila53n3nkWt
	1mP5nGVlsmP/i/bZtQB0b1vTTF+/JIBkYqiIb96wK2gZMhAn/vpaG9wy9/hgJXjVQiYW8s
	ga4K4mR9MQ2aoS43mQOEdOQrxL2CttG1X7Q/jGaw6TbyaYmhgbFoKzrtfrJPsw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Mar 2025 17:31:40 +0100
Message-Id: <D8JJAQZ3SY5R.1XI12I6O8SRZB@bootlin.com>
Subject: Re: [PATCH v4 01/10] dt-bindings: mfd: gpio: Add MAX7360
Cc: "Lee Jones" <lee@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Kamel Bouhara" <kamel.bouhara@bootlin.com>, "Linus
 Walleij" <linus.walleij@linaro.org>, "Bartosz Golaszewski" <brgl@bgdev.pl>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Michael Walle"
 <mwalle@kernel.org>, "Mark Brown" <broonie@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-input@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <andriy.shevchenko@intel.com>,
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, "Thomas
 Petazzoni" <thomas.petazzoni@bootlin.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>
X-Mailer: aerc 0.18.2-0-ge037c095a049
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-1-8a35c6dbb966@bootlin.com>
 <20250216-lavender-goose-of-variation-6b5efb@krzk-bin>
In-Reply-To: <20250216-lavender-goose-of-variation-6b5efb@krzk-bin>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvleefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegggfgtfffkufevhffvofhfjgesthhqredtredtjeenucfhrhhomhepfdforghthhhivghuucffuhgsohhishdquehrihgrnhgufdcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekhefhhfelhfekjeeugedtudelueetffejfffhkeeivedvveelgfetfeelveetvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopehlohgtrghlhhhoshhtpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvggvsehkvghrnhgvlhdro
 hhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghmvghlrdgsohhuhhgrrhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

On Sun Feb 16, 2025 at 1:58 PM CET, Krzysztof Kozlowski wrote:
> On Fri, Feb 14, 2025 at 12:49:51PM +0100, Mathieu Dubois-Briand wrote:
> > Add device tree bindings for Maxim Integrated MAX7360 device with
> > support for keypad, rotary, gpios and pwm functionalities.
> >=20
> > Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com=
>
> > ---
> >  .../bindings/gpio/maxim,max7360-gpio.yaml          |  91 +++++++++++++=
+
> >  .../devicetree/bindings/mfd/maxim,max7360.yaml     | 139 +++++++++++++=
++++++++
> >  2 files changed, 230 insertions(+)
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof

Thanks for the tag!

I've chosen not to include it so far in my newest series, as I have a
few changes that do impact device tree bindings:
- The ngpios property was removed from the GPIO bindings.
- Bindings for the pinctrl support were added.

New version is available here:
https://lore.kernel.org/all/20250318-mdb-max7360-support-v5-1-fb20baf97da0@=
bootlin.com/

Best regards,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


