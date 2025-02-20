Return-Path: <linux-kernel+bounces-523865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B284DA3DC41
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8B0E3A3544
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8000B1FBE8F;
	Thu, 20 Feb 2025 14:11:29 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D91E1FBE8D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060689; cv=none; b=cQbeZUb/QjpPblbWfk2UM5foe4DhM5traajvmohK8FD5GGXTuo3WCDpRpYMGzktZFu5QHklL8MpRuDf4AjtGHKS19wGACu0f15L5n2gxjzVySKj1k1yqP666tz9U7nRRn6c2YJwToRV9Ggx7lyiFNs6di5BBvOd8+MelNFu4vdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060689; c=relaxed/simple;
	bh=LI0Je3OsQZgBdDqnX2MsMKsQ8lnkBp+kiW/gf9oGHNY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kDCvrhoevJ1i4tCEuR1fMQ7rRwcpST2s7SV1yDUXC/5dC/znCBYIL3GTA/cFEmstqtv+zIktQJgmxzaK5aTAXUdbqEQmXn+SGCcj/PVZbCwiPXlSOp9U2oDrY6IuudgMH56IBjmADmC/m0Eehw1xFXtd82AIw/I8KBqwC+fdJ8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.pengutronix.de)
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1tl7Gt-0001Vy-Sa; Thu, 20 Feb 2025 15:11:23 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>,  Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  Steffen Trumtrar <kernel@pengutronix.de>,  linux-leds@vger.kernel.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] LED: Add basic LP5860 LED matrix driver
In-Reply-To: <20250220-v6-14-topic-ti-lp5860-v1-0-42874bdc7513@pengutronix.de>
	(Steffen Trumtrar's message of "Thu, 20 Feb 2025 13:57:55 +0100")
References: <20250220-v6-14-topic-ti-lp5860-v1-0-42874bdc7513@pengutronix.de>
User-Agent: mu4e 1.12.8; emacs 30.0.93
Date: Thu, 20 Feb 2025 15:11:22 +0100
Message-ID: <87zfigaeph.fsf@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


Hi,

On 2025-02-20 at 13:57 +01, Steffen Trumtrar <s.trumtrar@pengutronix.de> wrote:

> The lp5860 is a LED matrix driver with 18 constant current sinks and 11
> scan switches which allows controlling up to 198 LED dots.
>
> This series adds just the basic support for the device on the SPI bus.
> It is also possible to use it on I2C. The interface can be
> switched/selected via an interface select pin.
>
> Next step for this driver will be adding open and short detection of the
> LEDs.

for this next step I wonder what would be the best way to propagate the failure states of the LED to the userspace? As far as I can tell, there are already TI LED drivers (lp55xx) that check open and short failures. These drivers only emit failures via sysfs_emit.
I need to be able to tell from userspace if an LED that is supposed to show some state info isn't broken in hardware.

Any ideas welcome,

Thanks,
Steffen

--
Pengutronix e.K.                | Dipl.-Inform. Steffen Trumtrar |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

