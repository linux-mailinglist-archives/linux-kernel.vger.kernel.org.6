Return-Path: <linux-kernel+bounces-403664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7609C38CB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 08:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34D91C216C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 07:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4B815533B;
	Mon, 11 Nov 2024 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="r+63b0K0"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2A51BC4E;
	Mon, 11 Nov 2024 07:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731308484; cv=none; b=jeRysQmKbie/mGO8Z2A1Kn18SxGxt9ftb5dnYNu5MyjWqncTb74AR2CNLWMOy5Yl/5ThjjyTVFtsEkSN2iMAMJ6qtnfQLUb/4V2yQ+PUyOlNInj2IUz9we37kQPNnPTrk+Ni9dnPvxh51sufxLAbe2/Rw1Nf4VWjaIADYs+30jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731308484; c=relaxed/simple;
	bh=74vSH8jCobkm++QUMiqDjqjUNoYfF8wPfC9bI7z4j/Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lBFYImTYbZHd0oHJxjFedvDPoX0TVToX+vlNM1rngbRgBbidjzMW21P3VwngrgXAVnAuEjpUDYiNQAHhKiMAVSD9E/D14/Ts/pBcWNNeXhorBP/1c+bnhfwsfgsn7CnnXuwxmt49FBUla/4Ncqj3HzXzdM3qbwwcUld0JpwFW1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=r+63b0K0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731308422; x=1731913222; i=w_armin@gmx.de;
	bh=zNhs8knv1TCaWn97GwAPPU6qGMOy7JbpyIodoN/c8QU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=r+63b0K0P/0U822PPvBcdwoKSfYLY6jp24GrRIA179qU8ezuVLXYFEMqpUMiLobZ
	 hwGZ3VG55oq9n8IwptrUkDzbVG9iaZbEGa5IOP0hKvht+uiLbV4n6zEKflCPcMpiX
	 hqc9mKYaQKpaOpcwdJogJoQwAfHI3wkAaBOpN78o35XFI9VB3s/slo4rwKMvRE7xc
	 are//8jab7jRnlVrC2G72FYN+EDQHDVfhQGImUxTR6uHWiAw9FCBQTx24vl7T+j0f
	 JFIL+HQUqRHDdGIioycReXzY0+UPcS0CxZSJtOhu7WLPuRTN9FZdYTJp15/QgU3tg
	 +OHc6z5OXqPDyq8KQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wlv-1tuCZr1VhB-015N07; Mon, 11
 Nov 2024 08:00:22 +0100
Message-ID: <ec54d642-3aba-4e7b-954a-8fba79e73e31@gmx.de>
Date: Mon, 11 Nov 2024 08:00:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix thermal profile handling
From: Armin Wolf <W_Armin@gmx.de>
To: corentin.chary@gmail.com, luke@ljones.dev, mohamed.ghanmi@supcom.tn
Cc: srinivas.pandruvada@linux.intel.com, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, Michael@phoronix.com,
 casey.g.bowman@intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241107003811.615574-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20241107003811.615574-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HjN1o2zjOt7nusRjgNryQIspf3nQlnHJ20jI+aY6jUCCHOWxJTX
 fUDA24rsPsXLpURTTf9ACOpoV3H7gnGTsrDLybtFoN3SNx9Di9OODiN7BJjIWlB5VOBse6O
 2588EUC1hvFNfphUd1yRJLg8qUd47PGwm2TnZnhx5QMfjbT6fpmwUw4kClkcP+QF2k98jtg
 glgnVXxHe6NhBx6RhhphA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sZOy9ODJwEA=;ZK1mtjO4E5uQQjd27Zlj9JP7vXv
 v2NJQggl/ijGXS2YYhi1bDJQZm1Vhg/iBvnt86UZP0+bCf9ltilgLijXASS7MpLEqy06NvOsn
 5QzqoE1NkF1+y+hXQyjLD5LJ0aoh1bA8DEKiomBoAFGB/lsPSXw6wBXOsAz62isj8g3HzKY8I
 iU2Q8H725Zz15tmZeV9r3YoyyWJeRqowgLPFAHmOsEPuYSrn4ck3D23ra+A7tIp/cA+BlgyiZ
 rSP5DnjcVU12YQCaXJm+yLk7Y/qe4NRvQ2UTTCWP+4vbgpHemV//st+wCfA5uKnh+6kUeFS6L
 YwD9RDdE3l9FOViTecda1g2bfMjemiFF5dDj+RKajYxhRHREXG2QYJXSXdsL2KoTJPayO6i40
 KlOGmLLnRbeSA4OTbKYHY/y2cvulG3x98d+IORXZL12A/IFtSVWQC5hZ+1IJl/S5DsZcCMBHC
 ibefX+L/lJrQXKVoVZ6FjMxc95eZynSIwo65oLA987vPyxNJrfX60y25Wv9mpZjJSZm5PQrfC
 TzDV08XQwQno0ezjYqLZ56txy2bcOkz81r6+iwovPD/ve1x0PZDoMajXJNCKQj/whFCd/QiR6
 8nRwIjt0p1XEtWL427v2q9D4aIP7AqE8c7FvrXunqeGYY8IYEkMT5KOZxwOa2Gyf3X7ex+EkW
 u6lzrNRaAqFe/LffQ9YrUUX1DzdLeVmNqjC1p2kIZsCO+gAKUbhEbMa0pdfP3X3qJOmwnruXb
 P/48w8cWsMNN/Ktbf21TY7kcqdRd3m0XTelDs6WRnBotElYMCdKIrPEZlrlJKDQP6c3m0Z3rl
 vgOxBNUpxLvJixbgZVfwTrlQ==

Am 07.11.24 um 01:38 schrieb Armin Wolf:

> When support for Vivobook fan profiles was added, the new thermal
> profiles where used inconsistently.
>
> This patch series aims to fix this issue. Compile-tested only.

Whats your opinion on this, Ilpo? The first patch was already tested by Casey, and
the second patch should be low risk despite being only compile-tested by me.

Thanks,
Armin Wolf

> Changes since v1:
> - drop already applied patch
> - change commit description of first patch
> - add second patch based on a suggestion of Hans
>
> Armin Wolf (2):
>    platform/x86: asus-wmi: Fix inconsistent use of thermal policies
>    platform/x86: asus-wmi: Use platform_profile_cycle()
>
>   drivers/platform/x86/asus-wmi.c | 88 +++++++++------------------------
>   1 file changed, 22 insertions(+), 66 deletions(-)
>
> --
> 2.39.5
>
>

