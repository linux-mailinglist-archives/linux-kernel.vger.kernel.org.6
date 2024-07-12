Return-Path: <linux-kernel+bounces-251126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9619300F5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF3CF1C21767
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FA52F855;
	Fri, 12 Jul 2024 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="f/GLhxog"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992682941C;
	Fri, 12 Jul 2024 19:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812502; cv=none; b=P8y5Ilq1NMSSTyyEHfpeFZzm9u0evo1e5ljld4tkBfJD4M8WN2q39N4+KhnBt27pYG2FutR9eLOqxCwqNFTEENM8yDTd2dzMYpbwhgOKIjHBYugKnXUUZzCSg0x7zblzrewwcjSlIGr+l9VzaQcS5udPiSgJwcBGIn3C/V8tqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812502; c=relaxed/simple;
	bh=W281CCmUUMiP3TQluVjVobFYoS5Y7Blsjj8LngTL8Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XVCar6ufZtPJ+j4jTTNcoqm0t9wV2bwmtUEabNZ/YSRjQyO7WoQtF/36iB8Ii8qGSERr3APitLB8e63fDjIY7rQW7abYi9Hw91T4JC1SHtYYTh7k5gvs3txZTdCJiD2xY79e4WhM1C4hrZMutZpRudQV9IjNWXz8TSZr2bFa6yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=f/GLhxog; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720812479; x=1721417279; i=w_armin@gmx.de;
	bh=ICQlSYkMltWe/isrb0y1hYVhfN3pn7hHveOTMdIriHI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=f/GLhxogaZF24DWIqW8y28nl6M6WrDFlaozJMoyHPCd8InC6ngLmGyf8EIiaf4Y4
	 DNyQ/IiURrMmLP1MzF81BXX/wel090Lb1dsuYq7t0+g8aO+orE4+bRvTyBBDO+V5r
	 VTsMUhucwGrzcaB+2Gy9N9P3rn3zS4sZGRPhK40ed5Db0IX60+1tt7LEHHchkBIam
	 4PWsG+ej+TBaMPoD+4eDx1I2miRUhoXa5rhyXU9MVLmB0IGelqNr9xATCIbYYWpIA
	 /gKUf4f68CsWCmdjj9pEG8pZG6C0ggdEdOS/rUc9DyByqGW8Ki/w54RAj+WH+WCg0
	 q2mfFOzgh/bBUpkJIw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuUnK-1sBEUP2c0w-00zwY5; Fri, 12
 Jul 2024 21:27:59 +0200
Message-ID: <34a94b40-9532-45b0-b745-ba0c2e9846c3@gmx.de>
Date: Fri, 12 Jul 2024 21:27:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eeprom: ee1004: Unlock on error path in probe()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <b5c51026-a2de-434b-8f45-44a641ab1c82@stanley.mountain>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <b5c51026-a2de-434b-8f45-44a641ab1c82@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XoJj1mClfAdiUnVK05XDWWLKjk8HkFbwyIsp6Of+TkrgvIcWzwH
 ZlHrUZpj8k00+FyYnExlQuSjs/DSRPST4eoGLMuMmzufcZCLUTFdi+n6W+589xaa3QCt7pH
 usKWVjIFuaOOVzoNbvO4MORzVMHgKdF+Pg0P7fJOT91bPP0ycHdKpz7vpTCQFVrlvHxz1/X
 s7qSXnPSAF+DOniGRrgsg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cPJ8eIH9NMA=;Q+VH2abwOn3iEuQ71eCpIecVJmX
 hkoWishAL701nCFegn3V7uuiB7uZSemJUHORcmBWu5Wvn3Xvj14J7aCv7vAY0kUoAg33QNvAu
 642vW4i1rd1iEXm+XC+cVKi3ywHBEsT8IgXfDsMT6VGYnLQJp3OLpbAvlS7HnOQQX6KKdQaSB
 4c0q+u1vJvFSspfHshdT6JGwW0pttvb/mmXQkAq2AASt0zPmx3eipGO65UBCKa3UuFD1v2lmZ
 /rHOHQFS3U19GGlK9qL66pYQX4JldBo4bhvg1KNr9tAqZbT46FMUBJZlZSwhFFxvzzeSkPs+T
 9/J01PomRIw+nnQMvbx+lZvzUgp0PEhthDJKPe6d6u/DHLt4BJI5lBT3yv0CO3Zp+HhAzSdrz
 Z/WY79eb7L9M5HdHxRxURJc3U7vnyPzpui87NzC4Q+TT7Nrsll0528oThwstL5lCOsfm3BF9T
 bQpnayVbbIABYa2+tDlRsr4OM48f18i8/OFlpP67EqT0Zz4yuZMHSXqO5wUBJiDCqzo/ed5MS
 LFYvKCrjTUXFZNX19CeqLyIG1MaUM1/R1kyhzivhz7ytRAVBkzlcwoEi/k4PiSDoC7LsI+blB
 75mPgRQJn9UTtu6yZgIDroFUmU2YwAL6M/MXK0ffastQU4oVtshOMpskQ2nazug+89Pu8sONy
 rCd6qO2WQ6q/hEnOvnmGDebdn7QMx+8wiLnlWfxXHjCGC1090K4vsGR9IERxcrvg1JvBpVz5u
 iycGC4bmnqMOffXfalv0IXa0G8s40NIaNunNEMDYXI/BeoB+Exp25a0mfnOoPBwHtI/3goffR
 xyPx43lsVtVE+4bElXPqx5Gg==

Am 12.07.24 um 16:04 schrieb Dan Carpenter:

> Call mutex_unlock() before returning an error in ee1004_probe()

Good catch, but it seems that i messed up the locking part event more, sor=
ry.
Because if devm_add_action_or_reset() does a reset operation, a deadlock
will occur since ee1004_cleanup_bus_data() will try to lock the mutex agai=
n.

I can provide a cleanup patch to fix both problems.

Thanks,
Armin Wolf

>
> Fixes: 55d57ef6fa97 ("eeprom: ee1004: Use devres for bus data cleanup")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/misc/eeprom/ee1004.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
> index d4aeeb2b2169..adba67cef1e7 100644
> --- a/drivers/misc/eeprom/ee1004.c
> +++ b/drivers/misc/eeprom/ee1004.c
> @@ -272,8 +272,10 @@ static int ee1004_probe(struct i2c_client *client)
>   	}
>
>   	err =3D devm_add_action_or_reset(&client->dev, ee1004_cleanup_bus_dat=
a, bd);
> -	if (err < 0)
> +	if (err < 0) {
> +		mutex_unlock(&ee1004_bus_lock);
>   		return err;
> +	}
>
>   	i2c_set_clientdata(client, bd);
>

