Return-Path: <linux-kernel+bounces-513084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FB4A34192
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADDCC189409F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E4728136F;
	Thu, 13 Feb 2025 14:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AW4Tl/B2"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6428136C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455375; cv=none; b=qEErWewJYot3n2fnkXCeNMtzqO6SE7DRmyUUTnfk/Bb0VzeehNGpJnmaKWZ3OXNlahZstHwuNcfv6L3C6zHju/0YaOYKFquWDI3Xcx5YUJWECe0+PxGAKTLCg2CuG6oPmGt8nRPOqokSGKynCnliwBNU7vAdYtfH6QksLhAcJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455375; c=relaxed/simple;
	bh=rxX+eg13fxDpfHWq/ApyM3PAbAqxnDK+3oV6Gl1aZd4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ig6nY0kFcj48leMnI8Vp++WDLwg06RIczGACuVEXTVk6h5NDXnSqIgwa4t89wm2l77nSgPaxlZ4dDLz4baseEd4sICqviqEteVcPAeYW7D15qcmRz/PglTA44i7CRK0vsj2iwkedomMJuwAdEra943jZsrNzBMSqQ02u03dS0m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AW4Tl/B2; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2099F4431A;
	Thu, 13 Feb 2025 14:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739455372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rxX+eg13fxDpfHWq/ApyM3PAbAqxnDK+3oV6Gl1aZd4=;
	b=AW4Tl/B2OydqMUWe49A2wZXISyPza5vPrPhnmmnQgiLHmco9vCxAgXHuQS9S8F05rinDBs
	Mg8MXFsWE5hrZk0F06URKhbrwX4URMT5u7GVN75XTmjrOb4OvKXaRixwazuLpMm5J9ko4c
	taaFN7VmnAP0b8d+A98oi+RdRuBxdanx1J6byIqDAvR3B3umSsBjMfmkr12d4RJ4EMEDuA
	xIeNKCQYJhm7Uk2B7brjRGjw1jWCfg27csPgwgS95hYyM6wpGnzht1W3Dui0NmfrZdPAOV
	nsIrJy7SDil8QvRtQy2KoTKOVuEJm9DNa8ZaoCFUF638f9MXm4fN8CwjPdZmiQ==
Date: Thu, 13 Feb 2025 15:02:50 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?SGVydsOp?= Codina
 <herve.codina@bootlin.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: core: fix device leak in
 __fw_devlink_relax_cycles()
Message-ID: <20250213150250.4be60b24@booty>
In-Reply-To: <CAGETcx_WWxeovfDdX+oN8BreknNnQ5CBKNoxB5X9z2VQsOxd7A@mail.gmail.com>
References: <20250212-fix__fw_devlink_relax_cycles_missing_device_put-v1-1-41818c7d7722@bootlin.com>
	<CAGETcx_WWxeovfDdX+oN8BreknNnQ5CBKNoxB5X9z2VQsOxd7A@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegieeliecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthhqredtredtjeenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpefhkeeigeethfegleeiheehgfdtkeffvefggedvgeegleekheejteettefhvedugfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehsrghrrghvrghnrghksehgohhoghhlvgdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrrghfrggvl
 heskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Saravana,

On Thu, 13 Feb 2025 00:11:31 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Wed, Feb 12, 2025 at 2:31=E2=80=AFAM Luca Ceresoli <luca.ceresoli@boot=
lin.com> wrote:
> >
> > Commit bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize
> > cycle detection logic") introduced a new struct device *con_dev and a
> > get_dev_from_fwnode() call to get it, but without adding a corresponding
> > put_device(). =20
>=20
> Thanks for debugging this and fixing it! Glad to see more people
> fixing fw_devlink code :)
>=20
> > Link: https://lore.kernel.org/all/20241204124826.2e055091@booty/ =20
> Use the Closes: tag for this link. That tag is used to point to the
> bug report that this patch is fixing.

Good point! Sending v2 with Closes: tag and Cc: stable.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

