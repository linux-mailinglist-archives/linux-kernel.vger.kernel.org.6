Return-Path: <linux-kernel+bounces-408824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CFE9C83F6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BFA41F24CA9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6853D1F26DB;
	Thu, 14 Nov 2024 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ArSSdSCL"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A60619882C;
	Thu, 14 Nov 2024 07:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731569255; cv=none; b=C8xSbuA1QvJWSuUNUAlyiU9zmvwyXxwLfncnMSU6/f962WIW9YMBbweaZ0gvR1q95w/XcpODoPM1VP0FNcA4Ajk3rLP6fr8z2Zelp6yPYQg8VSl8Bhj49K3xOjmPzcU/PI396YPCL82nmRXRdBQ7anpAaHRhXL9SPynakSxqBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731569255; c=relaxed/simple;
	bh=uOsciCk3P5O8tfntCro0/6i1hTaA6tVaxFZM2XQWZ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dTAKU8kvU8E0mQmfXrU/Ilc+RRkL1/OoM/hNppup2KHxdbawdJ2rcrwkVYNokfsuU6wdGqqACrXvxBNcXOg5x7pl16rvaaFSy0MnUNjqt2zcmnlrvin4uE94ZtDf7TFwh5v2+W5+6+AtYME1H+KyvScbNAQMB8A0ttWVzHQgOa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ArSSdSCL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1731569249;
	bh=uOsciCk3P5O8tfntCro0/6i1hTaA6tVaxFZM2XQWZ3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ArSSdSCLVkB7g1SApI2NchDLbSn/BRnj+h1VP0q+XVj+X+OEe3lY5RSdhZjgpe3Jj
	 wXxsQTJhjKgKAdnFoQbRN7v14tVXxQDWNDLwg4nZqdmYrcD9sVhJJzFaAD9jZpu3XX
	 JIY4wiv704PTaC9zABU4bn1j31NyugsTgbFl9d6M=
Date: Thu, 14 Nov 2024 08:27:29 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (core) Avoid ifdef in C source file
Message-ID: <c3aaf724-a1d2-438c-851a-dedb0e9a3f34@t-8ch.de>
References: <20241113-hwmon-thermal-v1-1-71270be7f7a2@weissschuh.net>
 <041a52c7-ac0b-4a78-8b39-4fc4ac4d2fd2@roeck-us.net>
 <b6ed8499-bf84-486c-be5f-0ef13311eb18@t-8ch.de>
 <3f1914da-4f94-415e-8c46-8731834e51a2@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f1914da-4f94-415e-8c46-8731834e51a2@roeck-us.net>

On 2024-11-13 22:51:37-0800, Guenter Roeck wrote:
> On 11/13/24 20:40, Thomas Weißschuh wrote:
> > On 2024-11-12 22:52:36-0800, Guenter Roeck wrote:
> > > On 11/12/24 20:39, Thomas Weißschuh wrote:
> > > > Using an #ifdef in a C source files to have different definitions
> > > > of the same symbol makes the code harder to read and understand.
> > > > Furthermore it makes it harder to test compilation of the different
> > > > branches.
> > > > 
> > > > Replace the ifdeffery with IS_ENABLED() which is just a normal
> > > > conditional.
> > > > The resulting binary is still the same as before as the compiler
> > > > optimizes away all the unused code and definitions.
> > > > 
> > > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > > ---
> > > > This confused me a bit while looking at the implementation of
> > > > HWMON_C_REGISTER_TZ.
> > > > ---
> > > >    drivers/hwmon/hwmon.c | 21 ++++++---------------
> > > >    1 file changed, 6 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> > > > index 9c35c4d0369d7aad7ea61ccd25f4f63fc98b9e02..86fb674c85d3f54d475be014c3fd3dd74c815c57 100644
> > > > --- a/drivers/hwmon/hwmon.c
> > > > +++ b/drivers/hwmon/hwmon.c
> > > > @@ -147,11 +147,6 @@ static DEFINE_IDA(hwmon_ida);
> > > >    /* Thermal zone handling */
> > > > -/*
> > > > - * The complex conditional is necessary to avoid a cyclic dependency
> > > > - * between hwmon and thermal_sys modules.
> > > > - */
> > > > -#ifdef CONFIG_THERMAL_OF
> > > >    static int hwmon_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
> > > >    {
> > > >    	struct hwmon_thermal_data *tdata = thermal_zone_device_priv(tz);
> > > > @@ -257,6 +252,9 @@ static int hwmon_thermal_register_sensors(struct device *dev)
> > > >    	void *drvdata = dev_get_drvdata(dev);
> > > >    	int i;
> > > > +	if (!IS_ENABLED(CONFIG_THERMAL_OF))
> > > > +		return 0;
> > > > +
> > > >    	for (i = 1; info[i]; i++) {
> > > >    		int j;
> > > > @@ -285,6 +283,9 @@ static void hwmon_thermal_notify(struct device *dev, int index)
> > > >    	struct hwmon_device *hwdev = to_hwmon_device(dev);
> > > >    	struct hwmon_thermal_data *tzdata;
> > > > +	if (!IS_ENABLED(CONFIG_THERMAL_OF))
> > > > +		return;
> > > > +
> > > >    	list_for_each_entry(tzdata, &hwdev->tzdata, node) {
> > > >    		if (tzdata->index == index) {
> > > >    			thermal_zone_device_update(tzdata->tzd,
> > > 
> > > There is no dummy function for thermal_zone_device_update().
> > > I really don't want to trust the compiler/linker to remove that code
> > > unless someone points me to a document explaining that it is guaranteed
> > > to not cause any problems.
> > 
> > I'm fairly sure that a declaration should be enough, and believe
> > to remember seeing such advise somewhere.
> > However there is not even a function declaration with !CONFIG_THERMAL.
> > So I can add an actual stub for it for v2.
> > 
> > What do you think?
> > 
> You mean an extern declaration without the actual function ?

Stub as in empty inline function:

static inline void thermal_zone_device_update(struct thermal_zone_device *,
                                             enum thermal_notify_event)
{ }

> I'd really want to see that documented. It would seem rather unusual.

From Documentation/process/coding-style.rst

	21) Conditional Compilation
	---------------------------

	Wherever possible, don't use preprocessor conditionals (#if, #ifdef) in .c
	files; doing so makes code harder to read and logic harder to follow.  Instead,
	use such conditionals in a header file defining functions for use in those .c
	files, providing no-op stub versions in the #else case, and then call those
	functions unconditionally from .c files.  The compiler will avoid generating
	any code for the stub calls, producing identical results, but the logic will
	remain easy to follow.

	[..]

	Within code, where possible, use the IS_ENABLED macro to convert a Kconfig
	symbol into a C boolean expression, and use it in a normal C conditional:

	.. code-block:: c

		if (IS_ENABLED(CONFIG_SOMETHING)) {
			...
		}

	The compiler will constant-fold the conditional away, and include or exclude
	the block of code just as with an #ifdef, so this will not add any runtime
	overhead.

	[..]

While this primarily talks about stubs, the fact that
"the compiler will constant-fold the conditional away" can be understood
that the linker will never see those function calls and therefore the
functions don't have to be present during linking.
So a declaration would be enough. But an actual stub doesn't hurt either.

> Besides, there are several other #ifdefs in the same file, so I am not
> as much bothered about this as you are.

Your choice. If you want I can try to get rid of those, too.


Thomas

