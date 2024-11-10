Return-Path: <linux-kernel+bounces-403151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5E09C31AB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 11:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362DC1C20A24
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 10:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2246814F121;
	Sun, 10 Nov 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="npCXaA+9"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC09153573;
	Sun, 10 Nov 2024 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731235518; cv=none; b=X+2a4atDSzUZQ9NW6OUSrdnc+GABPSOGy4+CQtNMPtHGVDbR9a41KbTH1WH70GWysJEZBJ+fn7VmVSOOCCcHEcfuzH6jqjvYp+f/xylKpRTj63wwWEPzjWnPxfjbe82ghcgbnWo3+ciqqyjMdVdfvUusP/v6d460YpxltNtGY6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731235518; c=relaxed/simple;
	bh=RBkaVa+v3bdfSur4TMosKjf3T1UqOD8FCPd0qxXj+5E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=AVYZE6aQu6QF8d7FJn7g5WT5d8Rq/i3kr+Ywoq8v6XefhTEcXREKMKN67hx+bHI3rCL+3i2lgGwl5OSquj7GEEhTX4pB/cNLh2WN39xTkBywyu73A7pyb1TIi8l1UcghBZZvOUrbjU+eZAK36TEjXJyFEiiM4DFbDC33XhqdoKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=npCXaA+9; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1731235492; x=1731840292; i=markus.elfring@web.de;
	bh=RBkaVa+v3bdfSur4TMosKjf3T1UqOD8FCPd0qxXj+5E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=npCXaA+9LbaI7T4MUptHXIE9s/sTgjf3EYTUtUB+Z+fPf+8Vrohx9Uq7Qj04mhbp
	 vXAEOLtqNplPRibmcXOhHGw4UNiD8YzLJLPq1PrU6IC/LM0PpwwaQ7xTvkoEwYgY9
	 iv/hk/LP2/SBDjcUacZwMDU2RhRI84eGcNPr2PazTD1A1VlosUCq/Ri/8sxp6ZGEA
	 kNoZ7SvZC/1UVyNxLrzmLwwLmWtqL6rI1dVROPSLmg+wE0S2iUO+d9DLv26LJ2cSh
	 PunNhNo8bTt9G58fY/93IZsRjRPiHBl5aDViBvEs1KrEmSoZXwJTgHa4SLc0hLS8g
	 4QjBYf8v89CWZiNHDg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N3Xnl-1tssBb2LND-00tFjA; Sun, 10
 Nov 2024 11:44:52 +0100
Message-ID: <6ed94ce6-211e-4f6a-9479-34467e6ca7d2@web.de>
Date: Sun, 10 Nov 2024 11:44:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tang Bin <tangbin@cmss.chinamobile.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, Baojun Xu <baojun.xu@ti.com>,
 Jaroslav Kysela <perex@perex.cz>, Kevin Lu <kevin-lu@ti.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Shenghao Ding <shenghao-ding@ti.com>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241025082042.2872-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: tas2781: Fix redundant logical jump
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241025082042.2872-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:kq2cIavDfgtbPbNSQLm6JLpH3awd+E/fzjLmAO/20DY0oIkYfk4
 U6iqWBnEmLcu7h0s8lk/RD3Y0DDBdzQICiPLvt1/NfBWurjZiQxw6+vWhjXKL3kIy6FbtER
 0Mqn3I2Cz7Aa2GXWLqLt6L2qov+ZDPZLYINjjet5yQWpK+xF4NY74POlVQyxdJfi9wVAOTg
 UluwJ61bqcVojDU99xtLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1/WxcWUAL50=;NI6XhN6vHl5Cy63vKB5kyxF2Kcm
 vtmiiTN+CsU0/YgbrcgPKKS59yKWfV7NJw7GrR5y+8sTCMy7m4mWL60VS7sI2O7sfc7guZvHy
 Rz3Mni7eMtFJlwS1618bk+WYNvQsYmVJhVSzxKh7sTXlI+yukCAdqamnrEZvAMzDHl4btoD3E
 /108XPlr6Da/oIu5RRp8359wAkqk4VSfmLiP7Fsam5StD4C+SfA8tNAM5oXto5u0csQ38tPQt
 wSuuPCkawIOF6Z2gojWbGYdJ2ErtUL2nyNi2i/yQA2L++FjPoMJvAW9KnxOfGv4okkHRURxsU
 QmKloITV5GCO0ELLLP0OM41f4Xaysm1ZGXRRDoEs8cXIGYb3DdY2isCCWNYn75r7ihIWbmDyZ
 M6rPSf16AjJnssgZlFaTHb/AlobB81WrabFm8OI8uhyYEu48KIpk7OpEk5meVxf4HFGFFOL5+
 SyZ5WgPGBEBu2IcnS9ShPh9jeFGimX+pYhpO2rTIP6Mz49ZF9cbOhPinYwGyWgYlbYC6Vv2+Z
 Q6nDCXkLOKdyhIBDk7VFbry+WH7qe4dpLZe0LOYmDtRz71rrcXuZ8skJYAfn2DToxX5uqrXey
 iNcRX0z51Q9mBtHaRCU3U+xpeNKrOFPF/r9y6yV8dZe7q2Y9Q6O9Em0ep9otwmysTq0FtVXHZ
 w+OZihCMsjB9W+mdr9p3nHtQIG6wqHS4wuA5dQt4P3PydSlrTVmfZluDS7W6Ds3yCXltjkWj7
 MN3NM8kSALPNheGu5S9BIkGnT/n+1PF+nlopqfUhzXffFvZ2d9c3CzTllrNTWQM42X0cQy0/V
 uVppwj1bR7dR1ErWq5O/ODpLBtNF8M0zgyjSbL53voWD+21+1An0t9F/q7r9JkdqZoSSGlnOo
 xerYhEwPndfmdThlEBjYymJIKlTZp9wGSGPgZ1G6TaTWMANTuAwwCDwfz

> In these functions, some logical jump of "goto" and variable
> are redundant, thus remove them.

Another wording suggestion:
Return some values directly in a few function implementations.
Thus remove local variables which became redundant with this refactoring.

Regards,
Markus

