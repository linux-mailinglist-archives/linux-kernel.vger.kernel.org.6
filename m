Return-Path: <linux-kernel+bounces-566059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2F4A672A1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7228017F7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9185820A5D7;
	Tue, 18 Mar 2025 11:25:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D18B7E1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297116; cv=none; b=VmOCfZ2/AfsSpUkLfYdzkSw/Fz1uttneQRr+Q4SbojgSMSTvDerobXY+1rR153iu1Uij2WJqSanoD+MVYxu9hCZvpq0P8nvP5bfAQvHK1ywa5I+vcDM7/wmWigBx3Uf2V/G7LeRYH0E1e3CpqVaktQrkGugckIXrQYiyev4df3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297116; c=relaxed/simple;
	bh=saqa6yHGlpU27FXw7Mx8JOTa2cv0Z6CwVrAzxHujd+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5FqtQ7gLax1UK5MKTz9TMCadUNXqRDCgSs408nqP+ygfk2yJMG26sY7ywsjDr1cvxC84SiXmkZqjixZGKXXYIOWHjhzB2gp5zA/aZqs/x93VVu0cCx89XRo6qL1aC6injHHF4PQuLwmgXlDG5G1s2QqcunqgXuwWdyho76VKtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1tuV40-0005yw-9C; Tue, 18 Mar 2025 12:24:52 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuV3y-000Pu9-2e;
	Tue, 18 Mar 2025 12:24:51 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1tuV3z-00317U-0O;
	Tue, 18 Mar 2025 12:24:51 +0100
Date: Tue, 18 Mar 2025 12:24:51 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v7 7/7] Documentation: Add sysfs documentation for PSCRR
 reboot reason tracking
Message-ID: <Z9lYA9yUx62wNISq@pengutronix.de>
References: <20250318094716.3053546-1-o.rempel@pengutronix.de>
 <20250318094716.3053546-8-o.rempel@pengutronix.de>
 <cda899c6-4330-465c-80b2-63c9da73505b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cda899c6-4330-465c-80b2-63c9da73505b@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Tue, Mar 18, 2025 at 01:17:38PM +0200, Matti Vaittinen wrote:
> On 18/03/2025 11:47, Oleksij Rempel wrote:
> > Add documentation for the Power State Change Reason Recorder (PSCRR)
> > sysfs interface, which allows tracking of system shutdown and reboot
> > reasons. The documentation provides details on available sysfs entries
> > under `/sys/kernel/pscrr/`, explaining their functionality, example usage,
> > and how they interact with different backend storage options (e.g., NVMEM).
> > 
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> > changes v7:
> > - document expected values
> > ---
> >   .../ABI/testing/sysfs-kernel-reboot-pscrr     | 79 +++++++++++++++++++
> >   1 file changed, 79 insertions(+)
> >   create mode 100644 Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
> > new file mode 100644
> > index 000000000000..9aa3df8f2fc7
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-kernel-reboot-pscrr
> > @@ -0,0 +1,79 @@
> > +What:		/sys/kernel/pscrr/reason
> > +Date:		April 2025
> > +KernelVersion:  6.15
> > +Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
> > +Description:
> > +		This file provides access to the last recorded power state
> > +		change reason. The storage backend is configurable and, if
> > +		supported, the reason may be stored persistently in an
> > +		NVMEM cell or another backend.
> > +
> > +		Reading this file returns an integer representing the last
> > +		recorded shutdown or reboot cause.
> > +
> > +		Writing an integer value to this file sets the reason to be
> > +		stored and recorded for system analysis.
> > +
> > +		Example usage (values are for illustration and may not reflect
> > +		actual reasons used in a given system):
> > +		  Read:
> > +			$ cat /sys/kernel/pscrr/reason
> > +			3   # (Example: Power loss event, may differ per system)
> > +
> > +		  Write:
> > +			$ echo 5 > /sys/kernel/pscrr/reason
> > +			# Sets the reason to 5 (Example: User-triggered reboot,
> > +			# this may not be a real value in your system)
> 
> nit:
> Now that the 'number' <=> 'reason' relation is fixed, we might drop the "may
> differ" etc. Perhaps just:
> 
> 		Example usage:
> 		  Read:
> 			$ cat /sys/kernel/pscrr/reason
> 			3   # (Example: Power loss event)
> 
> 		  Write:
> 			$ echo 5 > /sys/kernel/pscrr/reason
> 			# Sets the reason to 5 (Example: User-triggered reboot)

ack

> Maybe adding a note that not all values are supported on all systems.

Yes, there is after supported values.

> 
> > +
> > +		Values are defined in:
> > +		  - `include/linux/reboot.h` (enum psc_reason)
> > +
> > +		Supported Values:
> > +		Defined in `include/linux/reboot.h` (enum psc_reason):
> > +
> > +		+-------+---------------------------+--------------------------+
> > +		| Value | Symbol                    | Description              |
> > +		+-------+---------------------------+--------------------------+
> > +		| 0     | PSCR_UNKNOWN              | Unknown or unspecified   |
> > +		|       |                           | power state change reason|
> > +		+-------+---------------------------+--------------------------+
> > +		| 1     | PSCR_UNDER_VOLTAGE        | Supply voltage drop below|
> > +		|       |                           | safe threshold.          |
> > +		+-------+---------------------------+--------------------------+
> > +		| 2     | PSCR_OVER_CURRENT         | Excessive current draw,  |
> > +		|       |                           | potential short circuit. |
> > +		+-------+---------------------------+--------------------------+
> > +		| 3     | PSCR_REGULATOR_FAILURE    | Failure in voltage       |
> > +		|       |                           | regulator, preventing    |
> > +		|       |                           | stable power delivery.   |
> > +		+-------+---------------------------+--------------------------+
> > +		| 4     | PSCR_OVER_TEMPERATURE     | Unsafe system temperature|
> > +		|       |                           | detected by sensors.     |
> > +		+-------+---------------------------+--------------------------+
> > +		| 5     | PSCR_EC_PANIC             | Shutdown/reboot triggered|
> > +		|       |                           | by Embedded Controller   |
> > +		|       |                           | (EC) panic.              |
> > +		+-------+---------------------------+--------------------------+
> > +
> > +		(Note: The actual reason codes used on a specific system depend
> > +		on hardware capabilities and configuration.)
> 
> I like this. Nice and clean.
> 
> A side note which you can consider if you feel like:
> This, as far as I understand, will also make the ABI out of this. So,
> perhaps there should be comments in enum psc_reason and the defines in
> Defined in 'include/linux/reboot.h' that they are part of an ABI, and must
> not be changed? I suppose user-space tools may get unhappy if these values
> change between the kernel versions.

Yes, there is already: "Importantly, the order of these values **must
remain stable**, as bootloaders, user-space tools, or post-mortem
investigation utilities may rely on their numerical representation for
consistent behavior." :)

> > +
> > +What:		/sys/kernel/pscrr/reason_boot
> > +Date:		April 2025
> > +KernelVersion:  6.15
> > +Contact:	Oleksij Rempel <o.rempel@pengutronix.de>
> > +Description:
> > +		This file provides the last recorded power state change reason
> > +		from before the current system boot. If a supported backend
> > +		(e.g., NVMEM) is configured, this value is retained across
> > +		reboots.
> > +
> > +		Example usage (values are for illustration and may not reflect
> > +		actual reasons used in a given system):
> > +		  Read:
> > +			$ cat /sys/kernel/pscrr/reason_boot
> > +			2   # (Example: Over-temperature shutdown, may differ per system)
> > +
> > +		Supported Values:
> > +		Same as `/sys/kernel/pscrr/reason` (see above).
> > +
> 
> All in all, this looks very good to me.
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Yours,
> 	-- Matti
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

