Return-Path: <linux-kernel+bounces-168587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 323A48BBA76
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2731F21DBE
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 10:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F77D17C77;
	Sat,  4 May 2024 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Q+ElHPU4"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5988A1799B;
	Sat,  4 May 2024 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714817407; cv=none; b=aPf5Sht7vfyHcwm9FILJ9NuDeTDn2fv49bdtfYuWkzg2cp1y+cg1HrSZM5PI8iEdx8yCVahYog2RVwlS110Xl3onuReSW7W3lf/d/TlNn/pr2v4hORq8EnRMhf5dTLtrBm923txZvcXezjkuQfK/KWNka1DE/IFUY7pMXCEKcKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714817407; c=relaxed/simple;
	bh=ueLGNJesIDc6zrJhj37NZFgvuqYhoxbM1MhXf6eg94M=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=lgVmeqWMRkDQ3C9wXAGNaijPRCJYDpYSYgba/0ecArBwsJ6urcCrK38mbQD78VC1o0eSdYNRCD+M9TZRGlUTRHm5IOkJhzC8+Fvage9iKKqt5jgw/BYglNZ7Hk2AAWnW7StbNBYehdtHuoa3dg4JguUcdmd8jgYcqVWHSDuky7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Q+ElHPU4; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714817383; x=1715422183; i=markus.elfring@web.de;
	bh=ueLGNJesIDc6zrJhj37NZFgvuqYhoxbM1MhXf6eg94M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q+ElHPU4+kbFN/vnCpu+9rOrgjxLkzmpX94gvn2JtkVLULB84aXeNEUw7fDCmIXv
	 0V0Sa0Ppxl1RCuVDZ67/Gx+s4aW8tf8FGAyZkKcgRhd1MR4TlsmQMCTO05WmyFnl8
	 nBoH/+cNPQ1ChSEdtiIzZ8WsMwwy55zX9TmZGLeTj/8z2h5fUuJ/VEaeMjWqRiHWq
	 VOgzpy8kqNn+6uDY/WTLuk9ORyiVI+kdkczj+qXFfPZDSPGqXdEYnr6iPApLW9WUq
	 sWYiQ4zauiMBDFGEV8e0S7J9k5kQvU6Nj/6nMiACKVBt2oc3krTCwGqTU0PpW5U3r
	 fzDUNmNAIapJSSCcwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4sXt-1s1pQG300V-001wW4; Sat, 04
 May 2024 12:09:43 +0200
Message-ID: <a664e0fe-1430-455a-9436-65ae8ae014bb@web.de>
Date: Sat, 4 May 2024 12:09:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Levi Yun <ppbuk5246@gmail.com>, kernel-janitors@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240501195116.62669-1-ppbuk5246@gmail.com>
Subject: Re: [PATCH] time/timgr: Fix wrong reference when level 0 group
 allocation failed
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240501195116.62669-1-ppbuk5246@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XJmTtw2TDp6kHImcmWMYMYIacmp8My4CR+16WlaLqPW70vn+ry3
 tXqS0PZRvnkXZcEVSoEZQ2CeESF+QKBWAgv2GmaIrHtOuNhSunUf3Z1OLPgRIk9o8GfnkJ6
 Xc5mAGpWpHfVQI7GLUJnoFCW/GGKZgFscuuTX+9pj/NdPRRQO0665M/sjG2CNJaVmg+Hl0o
 FHV/FcXnzkZPuFKNphv1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yutoUNxinkM=;cwHsPz0FR0jSvryOIBbW5cHUCkI
 GEWV6MHSTB8JC6Nl0bONainTA3CRIl+AZwTRUCc1p/evQqlFz6iAMJvhZXvD90GMlv+z2BWC2
 9QvnnwCy6+R8sFAJp0LF2j3Ilyr8Odbxaq6JC1zzD76y0wC+v1umybOiaqDclEy25veNYtyOQ
 09z8FKyru79pfNqSbmvmUQR+YAdrJk2lVeScSoNOliPATux6vr6nt7wGq4X0ldtMai/LlRAMv
 1bsv4L+BoozukXFuYQnTMACKz73V6HfOG8qDBivqXksAttluRtktVbGorkZ4kQTyQmwFwSBrm
 sHGmUQrk4nmw+asa/9s8d+2F215EjIrX05zl4Jkrrwq7XjtDFpqIoMh1RK1g1i6kxrriR4fY6
 GH2i8qIdchuGD24p7fxrQRf8mce33xgtYZFDg6aaRVbtFpiQ09ABNKyQwcanHDMNK3KyGzeqs
 A8ZCkSMUlvq8E//v7HPVUm0c1u8osrgu6ms3w+Vy40Hs8eYys86mLc04GfMUvRuoHBRVcLEnh
 3yiARLB8Vh393Av/x9KBGHEDdhNvkH4GpkcUf81vsLRvHwwt2w07uIqjtbWBnMNPCqtEqSFbx
 VsuomeSZ/YgfFxKZvkD6WMS3482MDqlqFPWDeKT8LGkO7R1XoP1orFnncd/JWmf6cJZ48CzqS
 YHpNtCzj696zbuP90IOau40nFfWJPXGoayWXonB5VcK8bmewplgIFB/JJllePhoJekx2H4kSI
 kHhU/kqjNZN/r9RU+Q/9aFnZhmnEAb7NS+LKlbRCrVEo51p46EVTe2416yEMTZk4JY8aIaaPg
 mxK4PNuNOtoHt9n18QiE764ShJ5syCvbbznhr6WiuvIXbcpTYMUOsAF2MsGwDw2v8H

> Changing group init do while loop with while loop to fix this problem.

* Please convert such a change description to an improved imperative wordi=
ng.

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?


Regards,
Markus

