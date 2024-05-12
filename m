Return-Path: <linux-kernel+bounces-176967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED948C37E2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 20:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9645E2812E3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 18:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935D34F217;
	Sun, 12 May 2024 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="UJw315u0"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD404EB31;
	Sun, 12 May 2024 18:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715536867; cv=none; b=oJja6LjeK2MPCoPAHDWdoWCBLWW8FNvF99Zny+dZsMVz7fWMmG7eGy8sgehg0qmlkoYPBxBSx0zDnaKEeUMYCBC9uhvMZ7n6PP286+y9rwlgQKnUVTKpQww0lSBrfLK8PDdGeCy3UWry/0VBK4poRdYJkAFhfGct1YmyUzG6yNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715536867; c=relaxed/simple;
	bh=RKrk+mnnV+wIwQ7PaTNB3/I4d0ChWtnaUI2Hz1coUXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkYXF9VIuzMcGIYY4Eu14305KyqLxmFWuupzSULdXQInRcgEOFwDmMYVPbUGGFkaAopEiuMpsuW8W9Vwmg0g3ZjaV05qUeBlO9dZgQRqmAo4pqDitfpFVIf3n57XJAo6E7QganxD+GSw0uFiXRqkZjmxW6fpgkbBC2vfAxrtQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=UJw315u0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715536831; x=1716141631; i=w_armin@gmx.de;
	bh=pPsk17yMpJ9jlFmK1Kmja1no6QKrs/3/eiUBETAd7EM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UJw315u0kIylllUBwYaElghO7YNXguX1kIU0tfO5Kgsl1gfGWzsT6oppD1BWTqE1
	 d4VHVBwMSNLyEjPgomRKWIUKcIvZn2HiduHnJHc9FfTdAJp71qOLqK6fGBN3MaXqa
	 SA1W2sY6c6o2mSJdXoiThgMJXQCZg/amaLl5kjIqoY+foinVv/3DM9zF9mp5CSgGn
	 Uc3hbxMbUQW5OH2iLwo7OjonavpOEdoDx6kQBpfa63Gj0RNWqGvhCBNF4od85VENn
	 xIeYAAKBN0BLArGG3d0fJ1TG+U0yTIAO9aJFuSZpa1Xgs6otyKAuPju1wJENnXZ4B
	 NcMIDrHcx5qznoPSzA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUowV-1rxFDa1ytd-00TyQN; Sun, 12
 May 2024 20:00:31 +0200
Message-ID: <565b4f5b-524b-4093-9c24-9e34cd0643f2@gmx.de>
Date: Sun, 12 May 2024 20:00:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] platform/x86: dell-smbios: Add helper for checking
 supported commands
To: Lyndon Sanche <lsanche@lyndeno.ca>
Cc: mario.limonciello@amd.com, pali@kernel.org,
 srinivas.pandruvada@linux.intel.com, ilpo.jarvinen@linux.intel.com,
 lkp@intel.com, hdegoede@redhat.com, Yijun.Shen@dell.com,
 Matthew Garrett <mjg59@srcf.ucam.org>, Heiner Kallweit
 <hkallweit1@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240511023726.7408-3-lsanche@lyndeno.ca>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20240511023726.7408-3-lsanche@lyndeno.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zLcsYzbqk8Z4beBlpUuz2Dzov05NQfgP2lp0UVzpIfOxKisAHqw
 WyGaAAJihQzMLTvNebWpc2+vv68CiksxdThUAX/TOcMPoRltmEqVw6a/EqCvnNSouZ4NSQ5
 Pq1cVrQBeML5CkcdkhvV+Xs1EGzWNtq3WFMebBbmyu6GQKW8Jev4ylmU/Qv3xr70BozBrJh
 Z4Z78tVIvldoHyGA1EB2g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wvSpFdmVY/I=;uHacvFpzaERGLYrJEsniU9GhTCr
 GhoWKYRIlGGGiR2gc8pwdwyqiamXIOpJXVuwjwk7MP2KB9Y2hVJvtz642UXm6lujAYre1QmMj
 bVZhVZeHipXWGpmwf8eI5zG58xZg2xkGZR/kkSZfXHQD6KhXcCA84A1PKPFib7FpeQX5inlOu
 zzZNtEaTAG07Yq4PDcQjgzp1KXIrHMOgnvnt5eh3VOj4ndPIFJCMNYYxoK2Q4eKLr4Iuz++YQ
 aF309Q/F1KSX1q95Hlj2d9P7ahWlADsaqNgQ5Wc18Pxa3ICRxn1cYsKj7cbYiUTMRH7ReC4Oa
 kvG4Hvf7WxfqG2lZGh3bZeAiALfIca+oMBRto4Q/SN2WW8Y+hcB32PL43xss9V6IZBAMqjHlo
 nEsnqj18wBhi6gnp7Buos12odCwFIserFc2o2Ld3c7BeSNOZyIu5Tf+Wkc59Rbtgzp6vNBQzJ
 2CojmCrFRf79dAeyUntqpY2xbvgig5dDMgMKyko8ILekNvDRstZeyDzpEXj+17gbxvng5YMi3
 iJtbjitjvhFjIRrOpM/TFgjKIjTTH/Gi0IbsuxhhIrcTvfQtZRIZxyKD6jKqEDf+j5pwKlTGF
 LxWXJb+J9cyePj++gw4sowglrs0N8ak3v80FczyT/YbaudQ8ykQV5L5ySRXwWmL7lLjTZo3Ix
 oE1aHRdUm9K4I3+XPXcFkP2/qh0aA6sfrurjX4zGIpOyXmIhHM3o4wz8EFzmp1wwKDWSs9L0M
 a4TuJ16x3HmJrdjpm1IB2A4qEf8bq4nK6exgSKW6aGyfy6+zScOanRdGJgE6Pt/jU09cdYYAy
 nKDRjqBmRPcMGvQlgf5LP9XqnSB1hcvEIPjVrSD6KIm6E=

Am 11.05.24 um 04:36 schrieb Lyndon Sanche:

> Add symbol to check if a specific class of smbios command is supported.
>
> Signed-off-by: Lyndon Sanche <lsanche@lyndeno.ca>
> ---
>   drivers/platform/x86/dell/dell-smbios-base.c | 6 ++++++
>   drivers/platform/x86/dell/dell-smbios.h      | 1 +
>   2 files changed, 7 insertions(+)
>
> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/plat=
form/x86/dell/dell-smbios-base.c
> index e61bfaf8b5c4..6ae09d7f76fb 100644
> --- a/drivers/platform/x86/dell/dell-smbios-base.c
> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
> @@ -350,6 +350,12 @@ void dell_laptop_call_notifier(unsigned long action=
, void *data)
>   }
>   EXPORT_SYMBOL_GPL(dell_laptop_call_notifier);
>
> +bool dell_laptop_check_supported_cmds(u16 class)
> +{

Hi,

the function dell_smbios_call_filter() says that classes above 30 are alwa=
ys unsupported,
so please check this here too.

Also please rename the function to something like dell_smbios_class_is_sup=
ported().

Other than that:
Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> +	return da_supported_commands & (1 << class);
> +}
> +EXPORT_SYMBOL_GPL(dell_laptop_check_supported_cmds);
> +
>   static void __init parse_da_table(const struct dmi_header *dm)
>   {
>   	/* Final token is a terminator, so we don't want to copy it */
> diff --git a/drivers/platform/x86/dell/dell-smbios.h b/drivers/platform/=
x86/dell/dell-smbios.h
> index eb341bf000c6..63116671eada 100644
> --- a/drivers/platform/x86/dell/dell-smbios.h
> +++ b/drivers/platform/x86/dell/dell-smbios.h
> @@ -73,6 +73,7 @@ enum dell_laptop_notifier_actions {
>   int dell_laptop_register_notifier(struct notifier_block *nb);
>   int dell_laptop_unregister_notifier(struct notifier_block *nb);
>   void dell_laptop_call_notifier(unsigned long action, void *data);
> +bool dell_laptop_check_supported_cmds(u16 class);
>
>   /* for the supported backends */
>   #ifdef CONFIG_DELL_SMBIOS_WMI

