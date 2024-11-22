Return-Path: <linux-kernel+bounces-418145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D899D5DC1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E11B25572
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3901DE4D4;
	Fri, 22 Nov 2024 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="X3hFTbq1"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E25414A84;
	Fri, 22 Nov 2024 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732273550; cv=none; b=glfsWhZvh8Z0h1hRYXASxm8lYQPTvG4O25GKIQFx3DIKCALWcdx1VfB5AgVqdhE/EAq1UdbWvukMK58MMXSN0QPhQDoEkrr/90bdIOe8UBfutaX5uYPGGtOv3QjXJD+5yFUnXkezUqhl2bRdUpipP7V4LAHRyQ8fKwylIdEiUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732273550; c=relaxed/simple;
	bh=2LhxpixEryIOYw8r1gg7oz6iH9Pzn3cVsVOZpnngAqs=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=h8xUJ7X17ERp0RhUMNv0E83FeI4HCjOtAK9VKLuGFMS+iLtl4zfCQRCD/CkFb+G3kp8ONFwdslna9RVwVffxFD1J4py5/dAu+YRItNYhzu+0HpeU3r4DjWPD4xf1mv3AyXGzhPjPJEg62Ldpxrkjo7+2Lz15krjS+6rTVy1G6k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=X3hFTbq1; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732273534; x=1732878334; i=markus.elfring@web.de;
	bh=xqBLSHkLYHHmnFl7KvLPb0WxJGPtnhHm3e8o5bsIYAk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=X3hFTbq1EIIvNCX0PwuZu2CIphNiaUfOuuOTaIeJNCAR4/Nt1CWB15PhoFeko372
	 W0KnTUDDmD15wtKNQ54G2wmgB+1BszhnI11+lDA+5wVzL4L1NO3xy1HCYff0+Wn7e
	 4gEH4JVZ4VYU55jRGGWAmA3ZAf1qX1r6Zv68qK0c1m39taCRV9RmViA5Hl6e6NTzD
	 F3GAVtZXv7AkiMy9CkCdaL4rgyt0VVqKYAT9C7aONHGv2Ls/IhGwfwYeMjkScarhz
	 kbQE0m0pEx45zVODZEqPNW2OI4gdwUQ0joJfhXjkau5h3Ev/a6kbQEjg43gNlWaZ+
	 Fe8CaX9TSdrEdzVQqQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7WN-1t9fYg3TP5-00V0Um; Fri, 22
 Nov 2024 12:05:33 +0100
Message-ID: <fdcf685f-16c0-42fd-a4ab-886ce5fc21f5@web.de>
Date: Fri, 22 Nov 2024 12:05:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, linux-sound@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241122063257.4419-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: Intel: avs: Add error handling in
 avs_tplg_parse_initial_configs
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241122063257.4419-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9ywa6fyg/LpRxtTr/Eq/27yvtE5EIDrcAgPNVWbxkpirPTCz16A
 SlZOU9bD1QNXI5LQQBUiScz59pbS10aSWs84pHqXD30Wgx1WgS//eOvGaoAQcT0+5QoDfz3
 VCnYHwNy0yP6Br0mtz/LfRv5WcVOzkun/nWR2SzkpF74qBOIgKtZR+SKXoMY02bKwSS4+9b
 Xw6Eblff6tzs2bA+LvUQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KBP3J5fPg3U=;OmdofGCHLk43YYqfyfrmN1xVIW6
 ojUfo2iTja3qNX28rgNVm7cn2gc74gCfFpw36DaVtLfpZo4lJZFPFshzUak/Tw9yI+miy5x+P
 vz//E6oEwXd5nyLEJxuQZUXuiTKK5L6UrzZAwsKShEg3Ell1Gke1G8o1cjozDbMweCZopz2qO
 cv/Narm25sS3+JPkM5cXiGWaIFKRBLNOhLgqv06/5BYGmEMK9i5MzZ4e3BYB3bJQjQeu2W80c
 /VkAxyQLF2rjD5BxS32uBDMdrjEW0rt2rD6KVoJEn2GN82G/2C/MBOW+U2rTmirXpXJecF1o5
 GktaZRnlEoBWCeuhQcBq9TWJFY1XnOIVPXt6IRIF9YM3SB5SsGNI04HcQ/EaaGUSUn9l+Trl1
 fzTRinpCEKdI+TO5IwUOFEFtGebejYsVOD3BcINlfovyqDfSHFuH+w9jTB/7Us8taB/n7wrzx
 sXpWEFy4mYN0pF7IUZ7DHZuxsVP4nStcySQBnANaxKZk6tp6tB44An4jRT3C4ydQdr74CvOsh
 SDzsDFg4ZCjfSYiFZFoh/aK3KZH1btzXW5jGVgaOEtzLryJDdY59KLvRvirl+O/XEQZzx2K6E
 mS57i3zeIhed43W0mEQnjH82hm2JHjraucXGOVCodPkojlriqhIygAJx7KuHRx7bHQfhs+8dD
 qqrNqUTl2gmw0t8LeQMgpvh9hMLVVr0EuJSajKEJzcqGsHl/WJtSvFlj4klgcP18KZl7q71X/
 iO5akx9o7qdwMPXemwCSu/1EVBPmbKemFJr5A2qz09ATPn8MfbSy0awsFY4K5jcMFOn0A9YAU
 OX8FsWFQcmxnmc7XafRNhKw8Hc9f13KNtWmEmnXUj9oqjcItxgn8Lm5IkjqgXdCzW/JvnsCoh
 nI9VsEPME1NEZxEbZZmCzARz0fa5IjzdLYzf8t/gNsUoWMtRc21jEODJE

> Introduce error handling in avs_tplg_parse_initial_configs to ensure tha=
t
> the function returns immediately if parse_dictionary_entries fails.

* I propose to append parentheses to function names.

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12#n145


Regards,
Markus

