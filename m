Return-Path: <linux-kernel+bounces-354506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5281993E6D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 07:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E26284BB6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A867913C80A;
	Tue,  8 Oct 2024 05:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tJ5ul+FK"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D4C41A80;
	Tue,  8 Oct 2024 05:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728366248; cv=none; b=u7/xo9Rj6gFjmFUhV4Ydsjx0xzAtparVz0UbC1FQGhVxraG14kLoT+7WBMEOTLxFrZmzOOynAJnJnHANPwv57NvJigUp7exYRN3j84VNGY7QEvQGzMTm9jwGtUqUkkwkdzGgddyFN47zeQkeksn3RN6wmeIb9O3rzRR8GnFIzrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728366248; c=relaxed/simple;
	bh=Xb9IyN/BjczzIKS+5VBCUuKTg9ywM9OoG7zOpHGmm3I=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Ag6MQ+Zr8heW85qGUE6OpH3e8zvQ4G+L+g+LqGhGTiQIlNvOyGf+mMYKutF0DnclSQUolrzwTjHt0qmZen2P6mH9y/Ua386FEjJmS3W7zCsVDbSnlPKPrv2ejpCtIFD7k0xUpkR0eVZWDqh8fTl3qHg5lTtNBMKHdSaqn0gpzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tJ5ul+FK; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728366218; x=1728971018; i=markus.elfring@web.de;
	bh=4529eXuxU0IwSjtA7nBJzenTECqC44WFLa8QbCE90lY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tJ5ul+FKTzgF+hpHnfQ6tA6XaWVFfI4VrHnAsVmKblf3cDzEH5hQrWv+4Q+9nlkj
	 smgnnvLyz16T+C6sZDdNBJonORtdSMXQJ9+UymBq3VIhjcitjh3VJXVQel05FDOXl
	 UK7E44iVg+0xohycTicZPRDoZaRx2bbHe/8nok06d1eRCDhdYNmDlNsX7DOONWt9v
	 2e8X3KM5UHDNrDy9jEMh6x/QZXBRMiEsdiTeHHVvzI2Ut0I64KDC7N2Qtga89HEbM
	 vayvl0r7suSUW601ZF3CglqcSfp7C05MMMi1iVTHeDCxGa5EqHLs/GGxIyRM19pgK
	 FIgpwuozSSpjg167AQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFJnh-1tDmbL0Tqj-00HOQm; Tue, 08
 Oct 2024 07:43:38 +0200
Message-ID: <8dc6b92a-7906-4f03-969d-b61ed981f4d9@web.de>
Date: Tue, 8 Oct 2024 07:43:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, linux-sound@vger.kernel.org,
 "Geoffrey D. Bennett" <g@b4.vu>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241008031947.10906-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH] ALSA: scarlett2: Add error check after retrieving PEQ
 filter values
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241008031947.10906-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X1AD2u4/j5Ib9W4sKmZG3jmvbTw2qxBLv5zbc2IVcZGA2f6bHht
 k+o2WWpxTsfm1S9Ci87pMeX/Q2V3SiKvUBvv4q97wRuiDR/sbze2AkiybucW4RUm1HMTfbj
 zRUliQtMR1E+Q6RRbGxsHKDWSik+dNyz39p0yAO6WQ5KMif57GCtWEROTuAPnxxq1VlvDKh
 ZUBPczkxMa/oHY8EzoVIQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OAi+U4NDlRY=;RhKN1QOTYX8TZTruDebMi4krkoi
 502BccoegT29g0lZ5R478msPAeme1vKlP02e38vn4vUWXwP/7fxsaomyzezlVtwHgagK1GDem
 FCke41YQvuaBHREu3u+JfyjgkkYXPJMWm6pRx1lUBPiUZJiZgCKjBikGoYRhtfGoyD1vFFGLS
 gEtMclOhKFhBWnKFixJGY8q0zleH31HJx3jx7X+lRLMTHLzgeaAsV+pEVaAbrpJ0RAwRgecfC
 87qxn8oRZxi7sRhQu/aET3v6BMgu0Nf/dnnqZudkchTF6RU3g3Bmzh3yYvNpJ/YtQ9APbE2mh
 1pWCsGz5oVIRANdBm0qzSov+0NEScj+6bu5frdmBJAvopiDHPXvp/APDEaoGi6928Q5ChJAOK
 BgGSPXUCn7vasA45BCCDtDRuGMVlzN+Rn7c8ruW//2Bx7cZ2OK8KH0vDuhuCrhk+NRsTvnzrq
 J9Ycnw5h5/YtDbGBoiPLaTtXfGvgqXjDHHbQ0PEQeWN7lEE3Q4JkrTd9ARBreQsqSMbNVWgIB
 yFzUC4Vd5SXCjYMWl3yNr6ZkPzoQTAkNi9thgiirvBRGsEmKsXrPEA87+/BRIcLLDVQcmtmyA
 jHBuJ54OtLKIkwOMiiQjaPpvJO8uBMkxpnKty7xtdKwcyfpR19DRKeoS+Wkt1CmRs1Zs/bwrL
 qbgEV53e45qHk08u7jT8anR3zL6aBoeOMEn+lIJVkg6q9SK/DlL97QjXsc3+gNDUknUR2wLpi
 3OfJHjfLR8UaAMwvgfnSjfGe0UGzhUPIricE6hsVXjbjjZGW5nTigOxA3yPs4oWwoisVsApDB
 9wHb01parRtwnMn5n4XrfkIw==

Please check the subsystem specification once more.


> Add error check after retrieving PEQ filter values in scarlett2_update_f=
ilter_values
> that ensure function returns error if PEQ filter value retrieval fails

* It is usually preferred to end a sentence with a dot, isn't it?

* Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?


=E2=80=A6
> +++ b/sound/usb/mixer_scarlett2.c
> @@ -5614,6 +5614,9 @@ static int scarlett2_update_filter_values(struct u=
sb_mixer_interface *mixer)
>  			SCARLETT2_BIQUAD_COEFFS,
>  		peq_flt_values);
>
> +	if (err < 0)
> +		return err;
> +
>  	for (i =3D 0, dst_idx =3D 0; i < info->dsp_input_count; i++) {
=E2=80=A6

I suggest to omit a blank line before the return value check.

Regards,
Markus

