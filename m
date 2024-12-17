Return-Path: <linux-kernel+bounces-449823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D95E9F569A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 19:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053BB16F456
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 18:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9091F8EE4;
	Tue, 17 Dec 2024 18:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jsrWMYmx"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A31F8ADF;
	Tue, 17 Dec 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461656; cv=none; b=CwX6LvspM7U0uN4di+S7mr13YNnJlCOnubEYRWxJLBF33RpQR3bbSMlqHcAr31ipWkS8dz/li6rCNL7nOCzD28wAVJUbIt16C9w2Ix5zdzq1TTE9fDfU/AdDrj5jeuaTv7vKd733BLmrZrHWITebXbnezGmb5x5DibHI4um1U38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461656; c=relaxed/simple;
	bh=AiaXSAppZt/mMAAT8W2evmJaQ5KeHMjF39PfKx+wRhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDUzEngv8ORMnQISUAZWxUgt/KabQ3xVhy1sc/j0xtiB9RhixwoOSyxIIISN3UUiLAigLX70k9ATJqWFaQKiMvJEtiRojCCQuKapL/zPmpXGUiAf0x7Is03GFBD0mR9wd475eLneumzvo1u68a0E2o7LQWglnhp1lU2hu/IMeIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jsrWMYmx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734461650;
	bh=AiaXSAppZt/mMAAT8W2evmJaQ5KeHMjF39PfKx+wRhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jsrWMYmxfta24/w2SpHyh/6TblZCH1538sXp9X+MtTYEFLPJ4phHi6f8NBVFf4BLr
	 On0EDODUk5/84lZ5amsFFoiwfe/ckHjqJx1mH95C5TsXej/FUalQ0O/y4xdfX3a9bF
	 4wnUKJG+iVv+MLqhuEkJW8YfzaYtcZbt1armsXJk=
Date: Tue, 17 Dec 2024 19:54:10 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Joshua Grisham <josh@joshuagrisham.com>, ilpo.jarvinen@linux.intel.com, 
	W_Armin@gmx.de, platform-driver-x86@vger.kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] platform/x86: samsung-galaxybook: Add
 samsung-galaxybook driver
Message-ID: <7e25c789-5840-40a5-b491-b97b24cbebd1@t-8ch.de>
References: <20241216103855.18457-1-josh@joshuagrisham.com>
 <13184052-baf2-4e7d-b8ef-9ba3f34d475a@t-8ch.de>
 <66897a27-5f81-46fc-898d-682456d7f37f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66897a27-5f81-46fc-898d-682456d7f37f@redhat.com>

On 2024-12-17 15:23:22+0100, Hans de Goede wrote:
> On 16-Dec-24 5:46 PM, Thomas Weißschuh wrote:

[..]

> >> +Keyboard hotkey actions (i8042 filter)
> >> +======================================
> >> +
> >> +Controlled by parameter: ``i8042_filter``
> >> +
> >> +The i8042 filter will swallow the keyboard events for the Fn+F9 hotkey (Multi-
> >> +level keyboard backlight toggle) and Fn+F10 hotkey (Allow/block recording
> >> +toggle) and instead execute their actions within the driver itself.
> >> +
> >> +Fn+F9 will cycle through the brightness levels of the keyboard backlight. A
> >> +notification will be sent using ``led_classdev_notify_brightness_hw_changed``
> >> +so that the userspace can be aware of the change. This mimics the behavior of
> >> +other existing devices where the brightness level is cycled internally by the
> >> +embedded controller and then reported via a notification.
> >> +
> >> +Fn+F10 will toggle the value of the "Allow recording" setting.
> > 
> > Personally I'm not a big fan to implement policy this way in the kernel.
> > But others may disagree.
> 
> The keyboard backlight cycling ws already discussed and handling this in
> the driver is ok.

Ack.

[..]

> >> +static struct platform_driver galaxybook_platform_driver = {
> > 
> > Could this be a 'struct acpi_driver'?
> 
> The use of acpi_driver is deprecated. AFAIK the plan it to
> move the remaining ones to platform-drivers and eventually
> remove the whole ACPI bus concept turning ACPI companion
> nodes into "normal" fwnodes like the current software and
> openfirmware fwnodes.

Thanks for this explanation, I was not aware.
It explains the comment from Rafael in [0].

[0] https://lore.kernel.org/lkml/CAJZ5v0g0B8UFqYza88ahMfC-1_FzzizeS6QN=Qtt7vGv9+TK1w@mail.gmail.com/

