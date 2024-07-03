Return-Path: <linux-kernel+bounces-240080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C6C9268E8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 21:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9627B23D45
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 19:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8457B1891DC;
	Wed,  3 Jul 2024 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ylxj6IMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CE028379;
	Wed,  3 Jul 2024 19:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720034205; cv=none; b=cX6l1+Fmgz3XznF4QRjMc/B1aTHL/2/zPMFdYer0aYe+4jxsfnezDcH0J4P2kTVzhVUC6oofSuU8gwenfVwkp3v9gJ/Ky1I8E47BO77w0W6xmVm2EY4w9NJWQ45HmaS+L4qKl9OzWpdiTOJLcZl7y8HpgQwCaTDsosnJ4RNdSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720034205; c=relaxed/simple;
	bh=tTH1saI5pGobSBr04685eUj/a1+oS9zrshXQwR0UftE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7Q5v/yuO8GgMx+WiD6/jP3Ui10MAt4BuQYy3xHkMrwMtpXUR6sTdMJLwGe1rvIPjO//++UfMOwwloV81WypOW8BAKAjGeNig7XTuCKV2029NYksT25LVfz34iPQFpHeLfLuzG8l8SOAb4bfohiLPPwOycQQjlmKP66TcCpBk0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ylxj6IMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA490C2BD10;
	Wed,  3 Jul 2024 19:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720034205;
	bh=tTH1saI5pGobSBr04685eUj/a1+oS9zrshXQwR0UftE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ylxj6IMFoO1sbc5lu/Z0hI1OwpF/pwYTMrdDWrOS7Z+PXSKvtxa2zB6oBrsfh7Qyi
	 dEEDDtcwcAJjyLU2ChXs8RrRVWQczpPZMGjHEVg3cOgIg6XG+OXuP/eBvG/20Voksb
	 dhQ53mU5JkVyoV1EvtNETq4lI4fR6rV+06bI1DFssWnfKDm3Y/LqH2bz7XTJrs4mMK
	 Dv/uIWO5Tnh/PkoMBdN8ifU3jAvBVBt6chNvQICMQJqHubwKnjzEvY381qaSk+Fw2G
	 hm8gpwqIuLXiESPw7432zbfDV6CEePbPDUERRssWHh7d/pnIsrmscVDaWb7oE6gnpM
	 N8RklHx2fhbUw==
Received: by pali.im (Postfix)
	id B6A0189A; Wed,  3 Jul 2024 21:16:41 +0200 (CEST)
Date: Wed, 3 Jul 2024 21:16:41 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (dell-smm) Simplify with cleanup.h
Message-ID: <20240703191641.i5okrz22exrt3mgk@pali>
References: <20240703083129.95955-1-krzysztof.kozlowski@linaro.org>
 <982dc693-dbb2-41a7-ae0d-3b3c05c28117@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <982dc693-dbb2-41a7-ae0d-3b3c05c28117@roeck-us.net>
User-Agent: NeoMutt/20180716

On Wednesday 03 July 2024 11:52:14 Guenter Roeck wrote:
> On 7/3/24 01:31, Krzysztof Kozlowski wrote:
> > Allocate memory, which is being freed at end of the scope, to make the
> > code a bit simpler.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >   drivers/hwmon/dell-smm-hwmon.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> > index 0362a13f6525..e72e26db6e10 100644
> > --- a/drivers/hwmon/dell-smm-hwmon.c
> > +++ b/drivers/hwmon/dell-smm-hwmon.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/acpi.h>
> >   #include <linux/capability.h>
> > +#include <linux/cleanup.h>
> >   #include <linux/cpu.h>
> >   #include <linux/ctype.h>
> >   #include <linux/delay.h>
> > @@ -1095,9 +1096,9 @@ static int dell_smm_init_cdev(struct device *dev, u8 fan_num)
> >   	struct thermal_cooling_device *cdev;
> >   	struct dell_smm_cooling_data *cdata;
> >   	int ret = 0;
> > -	char *name;
> > -	name = kasprintf(GFP_KERNEL, "dell-smm-fan%u", fan_num + 1);
> > +	char *name __free(kfree) = kasprintf(GFP_KERNEL, "dell-smm-fan%u",
> > +					     fan_num + 1);
> >   	if (!name)
> >   		return -ENOMEM;
> > @@ -1115,8 +1116,6 @@ static int dell_smm_init_cdev(struct device *dev, u8 fan_num)
> >   		ret = -ENOMEM;
> >   	}
> > -	kfree(name);
> > -
> >   	return ret;
> >   }
> 
> If you really want to clean this up, just use
> 	char name[32];
> 	...
> 	snprintf(name, sizeof(name), "dell-smm-fan%u", fan_num + 1);
> 
> I don't see the point of all this complexity.
> 
> Guenter
> 

Lets first ask a question: And what the problem we are solving there?
I do not see any memory leak here, it is neither mentioned in the commit
message. So I think that there is no real problem, and code has just
clear and explicit alloc/free pattern.

On the other hand proposed change with __free does not make it simpler.
It has still same complexity, plus magic around.

snprintf with stack allocation at the first glance looks simpler.

But has a problem that if in future the device name will change then it
would be required also check (and maybe modify) size of stack buffer. In
its usage you are specifying pair <sizeof(name), "dell-smm-fan%u"> which
has size not related to the string. But something more common sense
would be to specify pair <32,"dell-smm-fan%u"> which could say that it
is always maximally 32 (and you can easily check if the string is not
going to be larger). So for long term maintenance this is maybe worse.


What could be the real cleanup (if some is really needed) is to use
kasprintf variant which allocates buffer on the stack. But I do not know
if such printf-alloca function variant is available for us.

E.g.: const char *name = alloca_snprintf(32, "dell-smm-fan%u", fan_num + 1);

Or maybe just alloca_snprintf("dell-smm-fan%u", fan_num + 1) and some
sanitizer can calculate that the function never allocates more than some
sane size (because there is fixed string of few chars and %u which needs
maximally 10 bytes).


And anyway, explicit specification of the buffer size is lot of times
reason for overflows (because is specified incorrectly). Why cannot
compiler / library / etc... in year 2024 compute the correct required
buffer size of us automatically? Ah :-(

