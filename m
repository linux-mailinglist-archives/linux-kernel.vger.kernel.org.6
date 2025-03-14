Return-Path: <linux-kernel+bounces-560897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 648F9A60AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57792460A18
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B45219006B;
	Fri, 14 Mar 2025 08:03:39 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEF712CDBE
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741939419; cv=none; b=ZcxZyJzrftcPFKy4cWPBxjNHypNy4pmcQN4kLVXWtt6lIqsrWIH/igIkbQ6IcLOYmcQGEApPGgXOgtOgd1j7xHvFKXJlWOPKWRXA4UJTeRnEKHbEki0ZEVGMvXuFcfr4O5Py6ww1gf7LHSmY93rpEQZEU1QIWqJ9zdXjenjQpKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741939419; c=relaxed/simple;
	bh=Rwh+yPOdpzWJ49oGUODmMO2VD+m+JBj1xEVarGZKsWQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMHw9DoQS3h7cjsROjjL60U/TrrzB4qd5GU/E/knp0BLZzFrHkZk2OAtjkOg6v5Rj+CRtAxGROVfEf5Kabfeq8+7KS0hPvpJNNU95sjLQiQCOX3Kqrs+QVsJrqUjUlbz3rFcqVJQC/RFphQPgA0Jyk03+lJvjxh2P/pskP8hURk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTP
	id aaf96d0e-00aa-11f0-95e9-005056bdd08f;
	Fri, 14 Mar 2025 10:02:26 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 14 Mar 2025 10:02:26 +0200
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 07/10] gpio: max7360: Add MAX7360 gpio support
Message-ID: <Z9PikuvAR-XsYhPF@surfacebook.localdomain>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
 <20250214-mdb-max7360-support-v4-7-8a35c6dbb966@bootlin.com>
 <Z69oa8_LKFxUacbj@smile.fi.intel.com>
 <D7UOIHL2WOZP.LLGRKMILNJFU@bootlin.com>
 <Z7OXQqyPjtGgTySf@smile.fi.intel.com>
 <D8FAEPI26C8F.397VN87KK9VIO@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8FAEPI26C8F.397VN87KK9VIO@bootlin.com>

Thu, Mar 13, 2025 at 05:43:00PM +0100, Mathieu Dubois-Briand kirjoitti:
> On Mon Feb 17, 2025 at 9:08 PM CET, Andy Shevchenko wrote:
> > On Mon, Feb 17, 2025 at 12:20:13PM +0100, Mathieu Dubois-Briand wrote:

...

> > > A datasheet is available on https://www.analog.com/en/products/max7360.html
> >
> > Thank you for this good elaboration!
> > I will check on the datasheet later on, having one week off.

Note, I have only briefly looked at it, not a deep study and TBH I am not sure
I will have time to invest into that.

> Thanks for your feedback! Sorry I haven't been able to work on this
> series for the last few weeks, but I finally had the opportunity to
> integrate your comments.

No rush, this will miss v6.15 anyway, so we still have a couple of months.

> > But what I have read above sounds to me like the following:
> >
> > 1) the PORT0-PORT7 should be just a regular pin control with the respective
> > function being provided (see pinctrl-cy8c95x0.c as an example);
> 
> Ok, so I created a pin control driver for the PORT pins. This will
> effectively help to prevent concurrent use of pins in place of the
> request()/free() callbacks.
> 
> My only concern is: as there is no real pin muxing on the chip, my
> .set_mux callabck in pinmux_ops structure is not doing anything. It
> looks like I'm not the only one
> (drivers/pinctrl/pinctrl-microchip-sgpio.c does the same thing), but I
> hope this is OK.

Hmm... This is strange. The PWM/GPIO block has 3 functions (GPIO/PWM/rotary),
How comes you have no switch between them?

As far as I read in the datasheet this is controlled by register 0x40
(and seems implicitly by other registers when it's in PWM mode).

> > 2) the COL2 COL7 case can be modeled as a simplest GPIO (GPO) driver with
> > reserved lines property (this will set valid mask and let GPIOLIB to refuse any
> > use of the keypad connected pins.
> 
> I mostly went that way, just a few notes.
> 
> I chose to not use the reserved lines property in the device tree, but
> instead implemented a gpiolib init_valid_mask() callback. In believe
> this is better, as:
> - We can automatically generate the valid gpios mask, based on the
>   number of columns used.
> - It allows to get rid of the compatibility check between the number of
>   columns and the number of GPIOs provided by the device tree: DT
>   provides the number of columns, we deduct the number of GPIOs.

If I understood it correctly it should work as well. But let's discuss that
when you issue a new version.

> I chose to number GPIOs from 0 to 7.
> - This might be a bit questionable, as GPIO 0 and 1 will always be
>   invalid: pins 0 and 1 of the chip cannot be used as GPIOs. I'm
>   definitely open to discussion on this point.
> - Yet I believe it simplifies everything for the user: pin numbers and
>   GPIO numbers are the same instead of having an offset of 2.
> - It also simplifies a bit the GPIO driver code.

In general you should follow the datasheet and mask the GPIOs that may not be
uses as a such due to HW limitation / specific configuration.

-- 
With Best Regards,
Andy Shevchenko



