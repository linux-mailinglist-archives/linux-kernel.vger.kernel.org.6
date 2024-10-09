Return-Path: <linux-kernel+bounces-356506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E56F899623D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C0531F21891
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 08:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E83F184527;
	Wed,  9 Oct 2024 08:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jCIAx/Jq"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2135538DD3;
	Wed,  9 Oct 2024 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461868; cv=none; b=XFKHgO7wRv2rS9prbXwms4jH2UwAEm3niddCiYTlEO1akDjCVQsZX5huDEe66K98mAxexbn8ZMUCSEhB96s89h966X4VtkujNI+Sz3VM+kl90Xgy8frhB4fUuxqemvSgj3lH7lNU2Ke6HecRjLh/sfvOBLTA1t1lsvcvKRm+ajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461868; c=relaxed/simple;
	bh=iSvd8aPFyUZZBuQ+AR5WMqOGmSiQIEo51ImQV7aDJHU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=E9E7YhE/bqkhed25RCcLVh1OSKK/k0vKKr5huftnq2vCRQUUUAWai/tFBEBm9+zrsGSxTOMF3DnHmrK2yxtexRHXpkY4wLQAXgP79fQIzqlYalKovGJzNFzGXvdT2IDa8vbCd7rNsq8fv8ySnWFhiGk1VojXGYVymZrcFzSzKfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jCIAx/Jq; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1728461837; x=1729066637; i=markus.elfring@web.de;
	bh=7PiJpRMMVBxSbxLkDzlxCr+St75ZLwCgjt7ZLFx7fns=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jCIAx/Jq3vyxeEhs5k6FMl1IzsRKimXip2jcDEyOb6Os5nHK6uaOqR/q5hdmSt5u
	 Ol4ZhT+NeU/MjIuqQzoT/p0rfVLhQ79dzRgKeEymh/nnELzluIcLHSRE7DjvUhsg8
	 RjqZ9TSj1JK9adCPH1ykaKNuqY8FKfzFgA8MY811FOFwhRybNM0dVgsvRYV4bKvaK
	 4rD1YVbx1NwPHJdHb43hOLtMTHp0bqn7gxmCFwxtshU6jQVmzeaDTahsbnZ/1ZoL1
	 3Xa8lP3u5LtGAz4WDDCgGdVjjULPmrkYnQce1sl0dcs/Ivy7u3U1m+kv7PJKOfCqO
	 L2NPccGdwXcmt8nF7Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mrfp8-1tjpOr0JxU-00pKTg; Wed, 09
 Oct 2024 10:17:17 +0200
Message-ID: <988de26b-9522-47bb-b80b-a56bc5923109@web.de>
Date: Wed, 9 Oct 2024 10:17:15 +0200
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
Cc: LKML <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
References: <20241009073211.7266-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH v2?] ALSA: scarlett2: Add error check after retrieving PEQ
 filter values
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241009073211.7266-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WCNGedlj9GJ0PY7iX8rZzF77BbNgb2aIVhidQ1UycD01WZWWNv6
 W2NdifZxuHwmpZgpMJJsUV+wE0CVQK5Jnz0CXcUi1RGeJiYLH7ThQFkkiAZMXUcIHP7Ccn2
 DHD6hbQ0SWRJhmZxCLrxnCVE2joiArSx+qstSkb/0XNhGJbb2OYUQsraJFdq2xQ3AZYnp+O
 3RkDZcASfcnek47/f2Ykg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2q5Rnppax6M=;fAMY0EAcB3C12MP/ynbDIBvYfUF
 4ccMbn7DPnACJPsxpYM7hQslCbbSY1XBAEIVXfWo7+4AiUY4tGBrZWHbuuX9nF4NFpZ8tWcE5
 EKbRzkaO96F54YhrdVPhn7CmhECOGknomB6XlpEK+5ckWIQV2YTasyjIT8v5ich80ST4Ohj//
 a8Vt09xXgmxRhF6eHJMr6hOTmJavUVmKAxq0BpszPU5mv8Dk0xayqiVa2h9dv7JnbyUfoGl16
 EvnHhtiQvpzFrYA96926FqsRzW3/gaMMqpeI1Lfg7YPug5rHlSfRqlbQOfhyIc/tvIKm2Dmem
 cP1zTBBLlOlJWjGMID1J3ALNNN58r0Xi9Cfs7ef6zh6tn3J6ulLE6AkpDM7PZmXdr9uJtIaIn
 ffW+EJVRAfEPDYULO631xOqlZ7T5iIqddHtHi+2QxMAYkGKi2pPUcKnIcrD37HPOZoPLrx7NW
 jmgXV96T3W4je/Ls92o1mTE29bhEPC9m70komqoyMHxWK3njNcMdsXx8eMAW2Nl1Xj07gcuNi
 OfXznc9UDX0afsy3Pc/DVdsWhKy2YOxVgEsLhodcdX31qhx9ujAenDkQx0gqCaQnjbF3CTVtT
 LriF62O+5YRkabnTAI8/7ZYnEU2ql3DpOyy4GKTnh2EKL35Yvix3dqPjK2F/pUeNEB8OS+g/N
 EV98nV6QA9H56MIe6CkgzOkLuy3iM2lmfSr86LRC183rJ64ICp7ygeK1DpuP7lZDiGxBrQmb+
 P9onHSOxngqCSf6OjIwxfZvaMxn+uyIaZZLiG4QNG/EiNfzbSNxSj51GVhFhkq/fLGxU6Xq1I
 +mur+93rC1Ak0TZG9xdspTGQ==

> Add error check after retrieving PEQ filter values in scarlett2_update_f=
ilter_values
> that ensure function returns error if PEQ filter value retrieval fails

* It is usually preferred to end such a sentence with a dot, isn't it?

* Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=
=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc2#n145


=E2=80=A6
> ---
>  sound/usb/mixer_scarlett2.c | 3 +++

Please take version information better into account.

See also:
* https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12-rc2#n321

* https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+p=
reviously+submitted+patch%22


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

May a blank line be omitted before the return value check?

Regards,
Markus

