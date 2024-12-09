Return-Path: <linux-kernel+bounces-437730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CC49E97C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3B81670C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5DE1BEF81;
	Mon,  9 Dec 2024 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="AepJ/Y+J"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F21B424F;
	Mon,  9 Dec 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733752044; cv=none; b=sFpMHW+P3RkSW9jN/fWzOMQKQ7BoB4y0yJUbhG0kHWE9xUD5nnsKzGDvd4QLCZyVFr1oyIp4sk7V9xA3xCPm4KY3Vuz21pMLvloeCdAn8IWaCfx4KlaadOIyBoePtdGwHXrbmDjxyVQ7ZVbYEFGEaXKFU7W+ObAVm0Mo+QQQVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733752044; c=relaxed/simple;
	bh=OWK9BmtU8SoylfONS5umnJSsgPj9CZ1NuxrjE2vmeD8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Bn3zTn1CGxn9glEqTxdHAyf/BNHlYyLSGcq5WINSjhQbO0DMhw7WKN2SbH8VHBjWrcMLOX30wpK7psh1xmVy49WaQJq9Cf56v5SzbvqQqkMLQBVy+M+hiBmH3UjZAIDig2A0R3lbAOoylBMUu80ZUK9/Lg719Ox4XnpY3vaIPmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=AepJ/Y+J; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1733752008; x=1734356808; i=markus.elfring@web.de;
	bh=RJ7S6xkYcjMsl89YuTBAOu/UbbpWls5LjLBD4ZsW4Ac=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AepJ/Y+JEKo/4vyZzGM4THxUIJCrxKCWBek2wL2JRIoMrwN9g4z0ad7UwtbGQ7nd
	 FOn2XeApR8zpGdq11M3F/3R2+6txmzCHOuLpOQRFrAZLyg8pDddWGMO8Y5jwd6F4Q
	 iVHHIBOZrrwExiDe2UDpz0TYgZX1aWxW44ZSZE3ixhsDdWloUdj53I1/0chnFDkpP
	 RtCrclbbAsuBe6pg9utZcTobdcDxpWzQOJ+UHYLrXMWcGpYOjcJv8K1m4BQALq7BG
	 L7wcwvPnA3DjjuA7XzKB0Ej1ZQ3xdyMIxewVVSKUEK2rzt1KQyLfEfZdX5aOB7kx1
	 XeAnuWy7/zXTIj0rHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MD5jp-1tTgef2WNV-00HCGs; Mon, 09
 Dec 2024 14:46:48 +0100
Message-ID: <cabca893-74f3-441a-ad27-9589819cb1f4@web.de>
Date: Mon, 9 Dec 2024 14:46:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 Mark Brown <broonie@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Basavaraj Hiregoudar <Basavaraj.Hiregoudar@amd.com>,
 Jaroslav Kysela <perex@perex.cz>, Jiawei Wang <me@jwang.link>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sunil-kumar Dommati <Sunil-kumar.Dommati@amd.com>,
 Syed Saba Kareem <Syed.SabaKareem@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, end.to.start@mail.ru
References: <20241209101320.970571-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH] ASoC: amd: yc: Fix the wrong return value
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241209101320.970571-1-venkataprasad.potturu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dGgUdE03nz5a1Q2rmEDXGkDahfBzqXKiIuduBiULxsxXBJ4DeI7
 /9CfE2YeBKXU4249i5wn18PJ1x7f7E3xxZ/pAQtXpUd3vhhrD30S6m9rTZnCRgp/5kUYJ/Y
 xhOsj0BimHALxUY25jalsrjDnBCZX8/BftXS7bWsERAA56MMfUTPDXC4sUXg/RPpqt3ixk6
 tYFJd85nx/RFMjvbdgQgg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/tAO+DmNoTc=;d+/h+8iVKrYO6oBbOOOvsmhy1Ef
 l+HuJCZpztCumPqKBQWd6fXl7FdG5C9i1HdufeKajQbxtzpRP5YY+f+hs1mpOf0AW1M0EbhZe
 Woq8elam2WcvWJrKUlXI05NZPYleYvBpcKNqsPEW0fs2LpnOlTeOkmuT7/YcpQN3NCu+Rkh+e
 ZAOiqeY1R5J5StLWq9Y+gsmq4JTSmlwxSgTD4nubJDUG/yg6PDgGiWv6Ex30fh43bb4tswhTT
 kufeoBuaix31G4CBbSZQzTpzUlzFmzIJETEJ7DVfFYRf2qk0hoQFrvREr+SM56AEnCP0i1iZP
 RsTybgNs/IDihW84IsCvlzVRPboOXYanhp4lQnwVg5ONMDKZxeqOh0xEqWbGaPQ5ONjspqL1N
 gZe4dqbr77j1oS3guCmU45GcwrcfIMAgpez64UcioZvEZHHa3lFWkaQypfC1U+64BifqnwmgI
 93Lb8Y9VDOIRdqxmkihe8AEiG7j/3Omm/Q7Ds9Kx/RrLS/BCpm5K0WfJT4jR1+kwXB1rvsu2F
 i4Z+j0pMnyK2OypmKxZ/95sSgOjhc7ZwAWOBO5I7yGWBjJCRKORbNLsPcUNR6/TPlsNk7Qg5B
 oRP6a/6SFBu7MLn1J9xTAf9zYdMi2g3D4UIVtQUpwfr9nFjk7p64KRdCWokhyYtSquHfpFmVR
 739TIULKb560JBkpQPyupIye3b0LEvzmWBxMJs7baexYktrV5YOK0LQhzBcbeAsbRdGlNZx2Z
 L+FRdp5kKdtZoRK/boP1bUkRaL+sKGs8biFwXyfQ6WFQIZh6qyU2Eu82cNseGEhb2xh4poAVy
 EjEASy1sOxR7yyLI11UX45qRBjeLla0cLcxe2cSgToOSTUQ0E7bjgzAezozaLlp7Zd2tsQXhd
 4teXkxAyctQJh59Zh+qtwwt9CcSr0aujDHbaBm+COf7flrP4hbRRXNBHC5kheQcNnaXdTPNDL
 cbXVyC1fETLhWmtrDL9ScYtBC0LcrUKrEV/8fPy8OdCAzid7QE7wnAKLjG9+r+HeuEdlUslL1
 HC1jd+QAsS2pbd3z08VI7BOViUjDTvQOadJOTT7xwSrfHHhemSkOsuLGNAVFCN/n2zz8wXCdM
 1GqF9JU/k=

=E2=80=A6
> Add a condition check to jump to check the DMI entries
> incase of ACP driver fail to read ACPI _WOV method.

  in case?             failure?


=E2=80=A6
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -578,14 +578,19 @@ static int acp6x_probe(struct platform_device *pde=
v)
>
>  	handle =3D ACPI_HANDLE(pdev->dev.parent);
>  	ret =3D acpi_evaluate_integer(handle, "_WOV", NULL, &dmic_status);
> -	if (!ACPI_FAILURE(ret))
> +	if (!ACPI_FAILURE(ret)) {
>  		wov_en =3D dmic_status;
> +		if (!wov_en)
> +			return -ENODEV;
> +	} else {
> +		/* Incase of ACPI method read failure then jump to check_dmi_entry */
> +		goto check_dmi_entry;
> +	}
>
>  	if (is_dmic_enable && wov_en)
>  		platform_set_drvdata(pdev, &acp6x_card);
=E2=80=A6

Is there a need to adjust another condition check accordingly?

Regards,
Markus

