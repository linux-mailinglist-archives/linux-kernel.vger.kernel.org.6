Return-Path: <linux-kernel+bounces-531222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3A16A43DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E47B9171098
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940F4267B10;
	Tue, 25 Feb 2025 11:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="V7FuE7ho"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA072BB13;
	Tue, 25 Feb 2025 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483388; cv=none; b=kfsZOpDS2qbQ4x3xLY+0S2fx9UG7kS7potgwFb8Ka96/F+NjnCgJGNLid39RpjFeUZC6F5km5K6vQGdS9Rjd/clZypJQ2zwB95vHUkYBBOEpPtzuWzP8+V85ZVRpgnS2z1KKSk8aGmASFDrvTkT67j68aJhm0TEWf3QYV1nIn64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483388; c=relaxed/simple;
	bh=XSXQkSNfHVfAji6Qga19qNRS3ySY3v284h56HE3j9iM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SFh45TbJnh7O5fBdNFRU2ocuAiKyoyvbz83pDLvXEa/K7sAFdsMluGEbkgBZjXU9Z1cGapHhKqmr80U7eYEg/T/1T8fAXsLF4guDvb3ulwdgyr0vpQdTcbiuGsNilihW90jomLe9NxLwXOpaHAf8ZiXZ9l/VNUQTayCjDp3tk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=V7FuE7ho; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1740483369; x=1741088169; i=markus.elfring@web.de;
	bh=XSXQkSNfHVfAji6Qga19qNRS3ySY3v284h56HE3j9iM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=V7FuE7ho5fK+UzxAbcPBBVe/d0lvU/AH8cB59FViUwWdbbMWCv3v7BKESM776SZ8
	 kPFR6MxK2g9jwB2Amgkt0eGWleOaSQSNHKzUjPkmd4LvDRplkW1rtYP1Bmce+jyrJ
	 W/j1HVKIzeCm2AgUeDTdVuvYiHu9jrI1JvFmZFN4MByfdx+EBzR6r4w4wF1ozRAHg
	 jd1wIGmH7T5+f9m1B9k9Qq4LdjDvyXJ3wvZMJ/94RwVKG1pmfpSpNHlZBPcN/e5pY
	 oCwoowleGfehJy1bBDKhoancA+E5LXtkEQONqys/pu6USBQRAkS3lnRXAuGYvMpC9
	 TPcHmdWMUjILFQ+oGQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.36]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MCGSW-1tebUZ2gEc-00AeO1; Tue, 25
 Feb 2025 12:36:09 +0100
Message-ID: <4b9c2253-b791-4baf-a790-e776e15baa89@web.de>
Date: Tue, 25 Feb 2025 12:36:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andreas Hindborg <a.hindborg@kernel.org>, rust-for-linux@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Benno Lossin <benno.lossin@proton.me>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Dirk Behme <dirk.behme@gmail.com>, Gary Guo <gary@garyguo.net>,
 Guangbo Cui <2407018371@qq.com>, Lyude Paul <lyude@redhat.com>,
 Tamir Duberstein <tamird@gmail.com>, Trevor Gross <tmgross@umich.edu>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:emM1oVo4OgmYvdYDIvBGF6bjMWxded2V7mkGXrPeA4lSIJk50p8
 ddokKEf421Drrtr0sXaXiUKZKbTalP4BGj6mEMeH1c6F88Sa8BqAgu4RWa5beljwdGJIoeD
 Scqez7UDd5xdNkMZeKQ4By8kzDkAW0O/ndrNyOcjNeH/vY2xWzGrrHTGnt5a5kUoqdaMbVz
 ujNbyj59YAd57l1RbydMA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1aVejK2bEug=;YXhMc/mmp8+bgn6ZEiLaEznYsbT
 pomV13ySw97UToqat9ePt/yTqlYpyowW9TMpTJNE7yFubGOzxXyTbTjzFepN65aUUT/lBStta
 H7ttRSrx/XfHET1vpLfCA+XCJOUJW05YARSiIcb9oV+VMmmgQY3OGe41JR9WPBEwJ4LRXHVSL
 SaZzNVYYFkv8RS4YIq5s8WtlXoCZvopDJ77JTp/TRVvDImZuG2emZ5fD6M446NS2cOvJDGAAE
 xkFWTjrp/DkHPt8n9a4MpphrwOuX/H2lmT/qjO54ud0Zq1RZQbUnNg4foXB41UpTZdljthGnA
 GwSIDYwbFPtY/87NqHgHPwh/Rvhm6tQ3lG/QO/nHxDynlgGpfTWwuzlgax1pVXedcuj+GNAP1
 MeTY3q1l2yISHfsPOLad+UJBx00HXocAqOxDj2bTzfM75pPmRopx+RcueJVNA1mJ9QobHUHHZ
 o9GeDuw/L3Gk1OJS1dDhy9zzpR0YzBA1gdpKNb5srvUx3RnxzuSB4hIsvKQCbM2WeaG4m/Hbq
 1pQVOYw74pEmBxoZE9u7OBrcYnrfptnaf5ycMLXPCsmkzpRYM+iUxaeW6TCtmg3NxYkBIKzXC
 2ecCiEoGH0DqiLkEZf3Q33t0OHmXN5YI1Vbs0SzTsVwiCwI1exgzear07DMo3Ir7l0f/t+eX0
 FopHgnPes/eJZDBO+Zi9/PSDyRIU+6qjZyIfq8C4rEs71rQaEIfwElCUs66X2Ht4GZERrq37v
 te2vvz6dOOUtILZvSBFZYbMxLHcv80Aq3TfLwXntVN0oHr6QX98RKn9nJlbiGcfmYA8xzEnz0
 TKghQqzl4oVyzWRGyN7kCsX4psT2J5Ls9+PxkLg41CyldTPGDHcQmk70b+dVQwKbZzZXVET83
 vxMD453QaCyMOvVmMpYluBWhqGGUX+HXXkeUao4uF7OduU3yZpz6sJrqPyqJMs4XJuU7zx3iy
 7kwNJ43lK7GW5WGuxpgsbfU+mqwIEqe1VkUisk+SprTwX+m9w2o3d0+hGkaWlIY4PgGWnjS7o
 zokXYtxFgtG4pbmnvhhqZNAfQzD3nB9w2RQeasqnnh5a+onVS+9dEiKc4lGTjjIL/Q28CS8JB
 AMi92nWaWZxserqR9nUC7j9zEr8Iaf0LkjFxvs/HSWl3Yt3fsZ2cH7Esbe+PfzHkmvNDQPaI7
 2vo+fS1/4ndHNzu2aPlHVTyP06y46snDYr9+60rgrh1a3kcCoSHjJ8/qAi9zvWMnfRnxin4oO
 VTy5faXlnD+P9C4/Y/tGnbdLeYiBBAJXEJIlrzGWbM11TxKxR4AQcJc5ViMcGG1VMpigcl7TT
 Sjm3qOxqDrJ3d5DoKFVdUYZjjRPderZcvkUJuwJMfZuhsz8buGM+Y3vbd9HdPgTlx6pG8GJbG
 VSlfYLnBoq8pYMl+RcKslaHqn22wW48NA08IAY91vqsDn11VVEyezimXwI2AfK5kSmNu9CJ+f
 KzMfPeNWsC7mNz1hIIAuCQNRpAuY=

=E2=80=A6
> This patch adds support for =E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc4#n94

Regards,
Markus

