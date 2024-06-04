Return-Path: <linux-kernel+bounces-201234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81AE8FBB5D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 20:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138011C2200E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 18:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C990A14A4DB;
	Tue,  4 Jun 2024 18:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BiyVo111"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347B12E1CE;
	Tue,  4 Jun 2024 18:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717524960; cv=none; b=dVypF/pOtDApyIdzQsfLyVnKMjf8asUb8wPRji3dIpLiH3+JCuAmXs5NxTOGBhrE2jG1gtS+aNA1EoSGZcE3ahufhjcpstmZdUZ84PZ0B5zFK4YSTKdZMkaAruPv6DcoYgIwgRvchLs+dk8rQBqvn8T19Iw9s4xd8rxSskrSWfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717524960; c=relaxed/simple;
	bh=jYuZKxsQpb581PjD3Ptk8cZiajoRtaV88fAecHnSwLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaGhDEsuRJpNg8MpvyGTptWgD/IkE0hkm9x4tZdiRU2bhcIb5u4n56weP6z3MYHBdZ/PzhcW4xUTCmWVnzr0kSFn25Y/4o1b98LqZ0rYn73KjyKw2q7iW+qY1VDV/jOOxUYv95erdHkG0VBxKhtRnwaUCrgYIBTqRd94ZQgrSSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BiyVo111; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717524936; x=1718129736; i=markus.elfring@web.de;
	bh=jYuZKxsQpb581PjD3Ptk8cZiajoRtaV88fAecHnSwLE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BiyVo111CIpj8ApM5wiOiAPoZ4/m/cUGc86Zs38f9vL8iLn0do3Qr5afW/8LgZlL
	 R40oPsHdZwMtyRHi6l6lsGgUJv7n/M5W177LSS6BBXhJ0c6n9X56lwvYgzAz7A2LW
	 CPCPfBj9rjJsPzuatnMOBQ8XxvpNq0GfR2ntYeeCHAhrwpwFSN7Y+ycIIq5bSo1Rr
	 PG+HbEu5Bw/0vLrj8oIjsr5p3wB828EnaSOmEzQx9P4TUywiMUKpX4IIzFWlbEbwr
	 k/PAyDokRbJiR3aa/GygzhQJGxvAWhODZ9gWQk5j/fCLt2lu+zgkGd3UFmqYqdUln
	 FQo+hNup5VxgAbDI+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MY5fb-1rxjAz25lN-00KCAR; Tue, 04
 Jun 2024 20:15:36 +0200
Message-ID: <503de0cb-09d2-4716-99cb-de257a33bad8@web.de>
Date: Tue, 4 Jun 2024 20:15:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: auxdisplay: ht16k33: Drop device node reference after
 registration failure in ht16k33_led_probe()
To: Andy Shevchenko <andy@kernel.org>, kernel-janitors@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Robin van der Gracht <robin@protonic.nl>, LKML <linux-kernel@vger.kernel.org>
References: <0fc79fe9-da49-4cbe-a7ff-6443ad93f120@web.de>
 <Zl9B2zqbJqVAf83d@smile.fi.intel.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <Zl9B2zqbJqVAf83d@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:XzxZXsyOQkXt5iZ3/RqJDZ9HblXj1cvp//kPU5U2jLBOKZaW0ER
 i4flt4ib8b6jV5OXeJKRiiACOP8+ZEFaJzA73beglMckX/gVX6njC/vjN0nmCfAgxqFNFN2
 BKpY5fg2I9OXrsyr62NcaU2+AQIjVMDClale8XkFWuxDLUvboMXPJ5mt498zHo4IAEew7Ad
 VG9MVJnVIN3mqpIcXjJMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yXK4yK1g3E0=;kHGTcX+lLGuZzwdyL0aIM2O30LR
 eJL0nD1F2XoRBm2ahhVzqlrLS5WPEvWOdJ/a7m8rQaHJaWOHDy8mlKSqatdIeppIRPAdtGKUL
 bdydgPYivVR325ZCfC0Vx+EQafjzzVWl2dkEixb7E6yxJiQYuygz/VMhNUCTEte9NMK+O5Hbk
 TsNHbHf0XXk0y/D/td6LgYcWqA2rHsA7GhS+w7Tj05d9SCM3nPgC+jCDmB2HZlALsEixOia0e
 dp3sU7sWKxV2exxbgzGwmrhMGgxRSCM/jCdonP7OKDdo0TFAb8HaYGfsZmCe/n5S3Zo8BzmhB
 +0A2n5KfDT5B0seVW27QMkv+PDEN0e4tYZOu14SH5N48dXvV+tGCoafgQKZCbCpo6o4iRxxCc
 icH4uq92Q6MhT3qv/RsCDwFCBmxS5hin99RUOnuBW2aB6x+uI09T+BbidX8lPUhtan4cUh437
 cZ2xuZbU6W38J+XtdbtKgX9OruzV2zcR8wyPIArZUHVfSyPnDLm+5ASgZeNf9tF5TiIl/FEMc
 LdCK+3qp8h5iLFugmjcXKrINl95W1GW9U1FtuCr42lrh/06oeiw8GxWXmXgSAMORwczhf7FvA
 QXJjclrWzjB5VUNIBR1demH43ZBlfxfFGeDNw1N++FGVFLsybEMPeg2O2+y4j4t7KicKxZTSK
 d7b32t0TzmYZvF1O3/5Wb7lnGFLs3kln1hLsPRDfleULFVeYzkxy15gPNWjYuH4lSLEW8i7Ec
 XkeE1x2G/OEwGQRclwi4BL8nqg9pNywqmsu6eFAzZCuB45gkp/eX/NyuaEq/W8CoIJdTc9Qm9
 8Xea7JfNvqarvNo0Vvxzhpb7xctcqPcT+Xopy6UxDCo0U=

> But, by design we don't use reference counting after we registered LED,
> hence both error and successful paths need to have this,

Do you indicate really special data processing constraints here?


> so add another fwnode_handle_put() after this branch.

Will this suggestion trigger any further clarifications for the affected software?

Regards,
Markus

