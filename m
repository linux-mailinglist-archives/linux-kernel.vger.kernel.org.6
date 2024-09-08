Return-Path: <linux-kernel+bounces-320292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E954697086C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879A3281F2E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF730167296;
	Sun,  8 Sep 2024 15:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BhFvfe1b"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73B134AC;
	Sun,  8 Sep 2024 15:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725810039; cv=none; b=JSXYXqRrtq3YyG1PPmal1+pZHQX9VP+fXcZ3CctkOlQ0SYr134NFp6ch/saTTD/8TS5Jla05uVCSv8dg5+mScIIkKRji8AaEXN6XKb6tMldHjhiUpSvjhOBzafc8C4IPC/1uO31exwYXFUjqQstN0DUzTSmiTMbIb8enZZsrc/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725810039; c=relaxed/simple;
	bh=q+Kh6wwc5YZa16QFaGgnd5UtQDrNcPs7tb9A0peheWY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XRgiOlGZaB8nDctP6mSw8UJYUUQmwt1zCOldsyfjuQAAhfXHE5mODDoMnwspyQAMMzeDXqNI42k4TI5GLj3cUquNC57CVhvNrhgViHfUFOGxJpiGWXyosyIHF6BTTDLDUGdKn6yuKY+p1LEIzfJ8bfKF3huF4lfrIxIpkFkM6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BhFvfe1b; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1725810011; x=1726414811; i=markus.elfring@web.de;
	bh=ptJ9KRiiwKf0exozRFbwa/8czRd8EAb1dHK48JunPuE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BhFvfe1bxXq3j2XOXGqlULvp0rUpex086BwxYXZuqyPr3iZsuey9mq29XvAUk3CE
	 jssBSeILm/C6GhjBcGEgQQKFD6YYDhyyukvplVY4ovhBdDjkHI55T9vrP4bZmX0jd
	 ShiaSjvKJ0N0BtP6ugcQb9JIWyqDH/ibuLq2byp7HFEA7XbEungeHJNsc4bde+kga
	 UyGw8uDW+Zbj/K9z3r25bIO/QOhccOxjRrG4OYKtDZA2ZDP7sjpMEAYUQc+xY7US6
	 lwAgdh1u1MH9NjjGGt9KT5WSndiJRUS95xWCPz611bG1SnX0BRwyGTuhnVwaTmsMd
	 F02ND+aMKXghHHk4vg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4NDQ-1s4bKn3CeU-00w1xz; Sun, 08
 Sep 2024 17:40:11 +0200
Message-ID: <a2d13042-c19f-48cd-bc1a-375ab44c89d7@web.de>
Date: Sun, 8 Sep 2024 17:40:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tang Bin <tangbin@cmss.chinamobile.com>, linux-sound@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240908140259.3859-1-tangbin@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: topology: Fix redundant logical jump
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240908140259.3859-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YRbIm10HrBGUnXPEZk/8HGrkF2hkx3G0aojXPAOUAEvEXXmySiL
 4JPdxNtfhxQyWZwV1KN/LhxE1uCYNN5QmZ9GnMjkD2Lm7uWeICyrc+JO7AsPvqMkulWiYqo
 dd2bsHcAOsX9rd40SdDrkO+2t54YJ159Lka+M0Y5TPm0sAOlfzR51yXdP656DVmGhN6K5/h
 rAIfd2mBX7mF9M6EZWOiQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EtzDlGTjLO0=;aJ0dU1KNayylHLRXh6wH+DXxFT0
 suYlg8zmX3kJ6RAN7yDh1wLLbh22m18tOqTVP2zPhXFDepW+ugFRW99coZVPWgO+f8DG8NDJT
 0NWYa4Nc+WiiLeCP6d3Q84d+NXreOc2xNWzyc+RqEz4PD7pEIkb+cfcr5ajetYH08zt/LEUBL
 Gk+4k4mQ37Xzmiso3eydwUCcfeZdzuStWgN3QX6ezelpRvoqu4pj2YKX2h1VQyaWJL7UhY6vR
 ksvKkq7wRDkERQucp0ET1eAC4w5xn8Gd/PCN/pYeai9it3Nmlev9Iu6Wl7DWRJHFs/NumWEM2
 6S7BghwAUGzrsFAFGjaq44PyEjVHAp3Bne8kcK0fh2Kval9xvqy2JQ4BHeVLmFpTx5kPbH0m4
 vSvGlI7nB1AioTPCkkY1VHB37thWH/Mn4cSErJNaA5K/M0noizxsvB0D08EYdMHYuhycxSiaH
 UK30IoAwH42AJ+T02YQv7pxmvsyYf5cJSePRyLkWkP8zxpzWZ3htDUGdJK93q2zUanmKf1xYS
 xhN/oNMAwO2+GWMxsVzQrrXbjL5DirpYhaTyHICdTfBfARa3vPFyaAcwrAK/RCcyIgagshVdz
 uOQU6N4IxVPn86+xn9x3WTJ43R20BkgECKMzMLNRF4vMsB/ezxD+sdLdzdCaXUPmw9fHG5LXc
 ZAPZtAOn4ii7dKS+BamCXAEHcG3QcVvxVrApfUrXsw7cW1moqN2yJssVdYTTvZzuFWpn1vHuv
 xeSCwfb2Ra+ION9aipJws3i7OmFQryg4UfTDZaG5Xk+niAGAfz8T74i2zlEfh5vH1yE+AR8WA
 1cHcBwA76xesv+khFwOi7DQA==

> In the function soc_tplg_dai_config, the logical jump
> of 'goto err' is redundant, so remove it.

* You may occasionally put more than 53 characters into text lines
  of such a change description.

* Can it be simpler just to return directly instead of extra jumps here?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?h=v6.11-rc6#n532


Regards,
Markus

