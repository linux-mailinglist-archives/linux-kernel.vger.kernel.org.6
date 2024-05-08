Return-Path: <linux-kernel+bounces-172967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAD18BF977
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 245331F24138
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0A5745C5;
	Wed,  8 May 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="L2RQNJRE"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6850773514;
	Wed,  8 May 2024 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715159917; cv=none; b=IlEcnhHox13yIRLdfyDI2nYDHYYeDo30KjxbdGjfxSPZZlJD41L7kYPK9oJljB/Ntfb7BCnLh0Brk/X67Ed1laVt+HNoudZvFaoT+NWfOKn6W0uXap0GFCYsJnnQpcObCMv+R+XfIJHPOArbgEiWTjDP3/2XslnAchZcy9Z3cAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715159917; c=relaxed/simple;
	bh=8zQKtPW1eJ2InIOMVxNlIQdRptMqkAuQ8gi1ij+1u6o=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=asO0XeAZXGLCZwXs+C0cEa7lcLsGLIrJBJl/Jv5ylTgWajGtxykhHhkPyhayOu7ACwmch+v+ZREYtpjG8Krr/L+RASB2shOHaCLsWhFWpyC8/aRoxTzP4rHloCgY36LdmzCPQiGYpZlIvfbWHy3wgGGbLqhQghhNljRWnSfwObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=L2RQNJRE; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715159905; x=1715764705; i=markus.elfring@web.de;
	bh=4K+0QbeFUqlSoTdyOHsVRQqCKg/ZfP7fePshKaGtvTI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L2RQNJRERCq0H1NdTRdJLCDvzTQaY0RmBdlY+m0an8VmpKh5awoUoQHlDmr/inYM
	 9P2CGB419ykVBD3W5/QdIr3b8XjlQyuS5kopMU67iTHa2ojjbSodhyDZnvXVw1HAY
	 vZCAArJzTYMyyOTKHkVmhYqTgbjyYXdFrQbCbeYVI0PrGPj7FGJOwZCUx3Sp8krCi
	 upQm3eGl1db+7Mvro69ttEIeIP/+HqTQpXWxv9K9n9inwp2JfQt8jBYMBYK8mcx+Z
	 HLWmGrxx2GAzZmAF0RLGaSBKLI/X0VC9kCmuJXnj/rgb3LaU6beC8TaBT+aN32g28
	 d2sCBVvlG3EAloTkxQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pYY-1ryc6Z24TO-008Our; Wed, 08
 May 2024 11:18:25 +0200
Message-ID: <67be5fa1-3b5e-4ec9-ad8e-1e230e618e98@web.de>
Date: Wed, 8 May 2024 11:18:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Levi Yun <ppbuk5246@gmail.com>, kernel-janitors@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240506213150.13608-1-ppbuk5246@gmail.com>
Subject: Re: [PATCH] time/tick-sched: enable idle load balancing when
 nohz_full cpu becomes idle.
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240506213150.13608-1-ppbuk5246@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uRfiZVpxWGiezQy+aEUvp20o1nVajWnd9TIyhD5Au2rp/3Objou
 fpVE/oTBzeXsHkqOohuaD5aOLfaE+DakiQkQ3sc4d9w7LHkT1DYh8b5cpaNLtWn1eEaVJdr
 eDZ/BaOmViO+AkA77vkJl+RF+R0IIDkV98ciZBMdfQV32gGBWhgF9zCoe+9i167hQJnC99n
 FaB9Q84m1OfqRVUyUOyHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CYkllL4xYGg=;4YI41hZYeO8UyocHIJITssqvgDF
 UPCIp3xlETBUWHEEJVkb9fNgjeXSjgj2O26vwQgBTmWFt9DvshPcZ148ebqR5dgWQlYAEBCO3
 oVUMPyilquloVdhNRcGZrMj6mv/Bd0Fmg68VpvB7z4rHupAsrMKlerjl39sfxXNY21lPau5Oj
 xj9CKlsY916UnSprwoT+6PfQm0AOhJm09pLWmHDLGAKqPfIhVwAYvmk+NGNDzWhNHCBBXYVRj
 ZDNWjULzQTYrQwmoHVcWj5FpI3D8GoeTBeOSBYTcNgxNwV4S4gvI9UGrDqxvOD39gfz5JUD7X
 DGaxZWCQK4tb6I4wMLOEcwfI6dmJtu0h3rKeGzfnbmmBY8ZUlIjC0Ud+wNqVssmeMZyutYl7B
 4PQnaduWmGdyIIFadk4lyu1N6DflRUZA01zoNCPFMLSTAbtUc0LH/S8fEbhERBZtcePRadR9P
 1tVDb7yaOLH80rhg1DUF7ovSLtOrrhSPFI7GWSzU5kJbE0YD+ijF/It+/SYF8TW2f77g8hqB6
 H/k0YZ+Fifh6yaqvwqa3DDv315OLKniJQIR0DPtyHKyOm6jD2GQhb7/fQWQC/1A+v3jC9w+ST
 gtoztJLUkbWOJObW8b/rywpdLaN+WfvSvVQyHbkm250E/TBbsSedbipZQzy0AD+xlDZ6JOJ70
 wTBdXfmguLgV3s1nOiI03D9PisXu/lVN8ZQmPGpIugw1AuWUeT6M7ugTgab03HWHDpWsMajFJ
 yzm9Ri3xu0zswfnjPQprfn9bUP2lWV30IOpvZHnj/INm6Yo3WrugpUArDxzbrWVVMA+vRg9f+
 2axfeyzEmw6PcGQWD56aSkP7BCGxhgFqXEesb6Z1t6r2U=

> When nohz_full CPU stops tick in tick_nohz_irq_exit(),
> It wouldn't be chosen to perform idle load balancing bacause it doesn't
=E2=80=A6
> So, nohz_balance_enter_idle() could be called safely without !was_stoope=
d
> check.

* Please avoid typos in this change description.

* How do you think about to add the tag =E2=80=9CFixes=E2=80=9D?

* Would you like to use imperative wordings for an improved changelog?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94

Regards,
Markus

