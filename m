Return-Path: <linux-kernel+bounces-237498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0697C9239B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A13801F21E15
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FA8152166;
	Tue,  2 Jul 2024 09:21:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422AE146D48
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912116; cv=none; b=b6B1QzuK7Zgm4tomtcBAuWPMR7B+hzewVNxZtW1EGda5j/WA+0d9JZTI19PklTZyUUzA55Gokeuh0pPo4YIDqdh8hZW6WoM71ISp6M52AHKUe2DxhR2r2ZBb0Dru9SJaig97ryxPrqi394ZoFw/K7gzgGIwH9/X/pQgySzBnAk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912116; c=relaxed/simple;
	bh=/+czjBljI3wS9Kh2OGhUIHaV5OrxeNvmtsSRi7Z2Kj0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AoFCsSUD6M7bs7bfo5WWT3fZauGO5zeuKetD6ZEfD2BSGBTYJtoEpqzTDoXEtYUpfceeKrAz4BdrFwMUFgX8ITIMEzw5epqy2C+xzOxntivxCS5897ReyBfSmyvT0voSuzSZfCD2tjmoDuKjrlzCzFFO7GYcAioDvQroen6w2v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOZhv-0005CB-Dy; Tue, 02 Jul 2024 11:21:51 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOZht-006ZnY-64; Tue, 02 Jul 2024 11:21:49 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sOZht-000426-0T;
	Tue, 02 Jul 2024 11:21:49 +0200
Message-ID: <0e5f6a7652e9813f638b16314ad1ac9a6059ac8f.camel@pengutronix.de>
Subject: Re: [PATCH v13] pwm: opencores: Add PWM driver support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: William Qiu <william.qiu@starfivetech.com>,
 linux-kernel@vger.kernel.org,  linux-pwm@vger.kernel.org
Cc: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>, Hal Feng
	 <hal.feng@starfivetech.com>
Date: Tue, 02 Jul 2024 11:21:49 +0200
In-Reply-To: <20240702083848.1947449-1-william.qiu@starfivetech.com>
References: <20240702083848.1947449-1-william.qiu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2024-07-02 at 16:38 +0800, William Qiu wrote:
> Add driver for OpenCores PWM Controller. And add compatibility code
> which based on StarFive SoC.
>=20
> Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  MAINTAINERS              |   7 ++
>  drivers/pwm/Kconfig      |  12 ++
>  drivers/pwm/Makefile     |   1 +
>  drivers/pwm/pwm-ocores.c | 239 +++++++++++++++++++++++++++++++++++++++
>  4 files changed, 259 insertions(+)
>  create mode 100644 drivers/pwm/pwm-ocores.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3c4fdf74a3f9..3b547ede2ce5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16824,6 +16824,13 @@ F:	Documentation/i2c/busses/i2c-ocores.rst
>  F:	drivers/i2c/busses/i2c-ocores.c
>  F:	include/linux/platform_data/i2c-ocores.h
> =20
> +OPENCORES PWM DRIVER
> +M:	William Qiu <william.qiu@starfivetech.com>
> +M:	Hal Feng <hal.feng@starfivetech.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/pwm/opencores,pwm.yaml
> +F:	drivers/pwm/pwm-ocores.c
> +
>  OPENRISC ARCHITECTURE
>  M:	Jonas Bonn <jonas@southpole.se>
>  M:	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 1dd7921194f5..42158bc1c8bc 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -440,6 +440,18 @@ config PWM_NTXEC
>  	  controller found in certain e-book readers designed by the original
>  	  design manufacturer Netronix.
> =20
> +config PWM_OCORES
> +	tristate "OpenCores PTC PWM support"
> +	depends on HAS_IOMEM && OF
> +	depends on COMMON_CLK && RESET_CONTROLLER

The reset controller API has stubs in case RESET_CONTROLLER is
disabled, so in general reset consumers don't need to depend on it.

regards
Philipp

