Return-Path: <linux-kernel+bounces-349363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C774398F4CB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 19:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E38B1F225B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE9F1A7250;
	Thu,  3 Oct 2024 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BI3RaFUO"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28A433C1;
	Thu,  3 Oct 2024 17:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975136; cv=none; b=R/BdZsJ5v4i2zEu57TmL7g3GdHdGKFAmP70Ww6RUi+ZV12zcMG8E6RnnUYwankKuOY9HMCcn6gGcz7TV7HKC0NW9QcTh1vtrBeJ3Xs8RfyL6Tdms4ikxMfQlgxunixzPTmXf2cuclq0PyTd5ihKoylvYXYWEp9gJtABVhj77Xs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975136; c=relaxed/simple;
	bh=1UVcQEoUaLBLHGw7elSGxR6RHDiLIqlA5Ci00ESzSjc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JbD77A+J6yY9qI1GkrxhmncrRBgCqd2+zbH5YdnzohrnkpeCdRUWqG60MhCAIcfQvXIET/8FjfGOUlttCk3fvIs/DWXZq5zXt4ssZEFZ8BChyECXNYmFYP+bP/XESWbMdL8BK4Vx5IapQmwyv9D2VEqjzXP5GNYP2qEtk57INYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BI3RaFUO; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727975111; x=1728579911; i=markus.elfring@web.de;
	bh=x1aRqowk+avzQDXULHwlYV3N6dqI2bTShLMMxvbXA68=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BI3RaFUO/IqVYSLIno2H+VgC6jRTGjRmvO6ARpvkaeM9bjGR7UaJ+cyudJiy/paW
	 SShRUCuF6za+2AiFLI6lVnpynfYCOXFXqTWcjjt7fFefj/HC/winOHm8gYeyejcNN
	 zep2PkPh2WYZ3TCEvTz9rAc3vK5rTllKtNDjXO1CUUSnbBNBtdzPnw+HR5gNCyRD2
	 yH2AErWcst71WingjBzq0LapmAha0LG4cBgLdfgq5fUlTQ9FtxwVnwfRpvI7mQIgi
	 yZC5IK52zBbs484UzS3E20fbAPULj0apH7OqA5yiGqdOAOiJQ+C6ZCGACWp/XGEwZ
	 ShT/jDC8FEPzfbNKXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MJnrX-1sco2x49gP-00ID8K; Thu, 03
 Oct 2024 19:05:11 +0200
Message-ID: <434320e1-2a30-4362-9212-ca17cdde8b31@web.de>
Date: Thu, 3 Oct 2024 19:05:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] powerpc/pseries: Do not pass an error pointer to
 of_node_put() in pSeries_reconfig_add_node()
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, Nathan Lynch <nathanl@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Moore <paul@paul-moore.com>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <0981dc33-95d0-4a1b-51d9-168907da99e6@web.de> <871qln8quw.fsf@linux.ibm.com>
 <a01643fd-1e4a-1183-2fa6-000465bc81f3@web.de> <87v8iz75ck.fsf@linux.ibm.com>
 <2f5a00f6-f3fb-9f00-676a-acdcbef90c6c@web.de> <87pm9377qt.fsf@linux.ibm.com>
 <afb528f2-5960-d107-c3ba-42a3356ffc65@web.de>
 <d4bcde15-b4f1-0e98-9072-3153d1bd21bc@web.de>
 <8949eefb-30d3-3c51-4f03-4a3c6f1b15dc@web.de>
Content-Language: en-GB
In-Reply-To: <8949eefb-30d3-3c51-4f03-4a3c6f1b15dc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l3pgyZOI07Bh3dnf7Bb4Ey6oOw4CTctWcTQzVYrYpobYkMHHXRn
 OPk51Q8pvjKkh1GXivyDLMXfVDWgV17SXTn7dpTpoMJKyR5B9MPUpKdLhFHDwMw8X8qTCY/
 MpN6c2xOvsHPMUhN+ZeRQBCKXhtupcUjNvgF5A5UqRZRi7WsV5o26c+nIi+Rs4CrKnwe0r+
 5GUf7Wh3YrZvtuVgD4Hgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:H1JxztHArQo=;cU/Cb9YdbVJnqdRJnvh/1yWlVIo
 FGsQCXXnJYaq1CgPuH5q2GZ+CEH611VtAZDvcnNaGLpYX5BAgU4/XAHIGBlD/nTs+SKQg71Ez
 OqRQzxJYKJQgHvBjH/Z3o/sbKrzHDdmuYxN2uclk4dh6P+Jbe/MRnSqDS+MIl9WYxEv/jicPY
 1b2dUSlzSK0eKhi+sgXZo9KRzMsNPW+qBmWJam+j9YiRegdxCFUbfXcYdNhK/tDWO1IL3+jqy
 nBYxZRnoPVlchx9XTqwMsdaZYe8l/AgKKocM1pMgMSuRmm58aosPDTFYVsufYGzywLcfZliC0
 3hE/79L+d227eg3CTeVTOtM8jBn0rVNPi7PP9dnEzC6or/Glmcj+XM9GI41j5wa9sxcbrg0c6
 lGSFR1BDbgrt2/hdpzqcC3WjkI6vWr7RwClPiGauzR4cczbL0e3fop8rCFfywcqDIJGkvxhXR
 HY1MS/npuLYQx3WGJ9ffLQXU+COEPhJY72h9c+PXAgywK/94sl6ixVNdjM21TSKjBojX1HNk+
 DNDyc0aTgcDPS9Es0t0e+ublIE6/Yu9+v04wYA0YydWiIBFpCCF/QQDk16KtCGoky/vjMSxS5
 rSMpHM5W8Zg6tUgI5+imto0tftAzfI7VtYpz3cu/N86DzcbS2Ck5gTdhC2QhHkMoR12wxpAhT
 6sCMn3+R0HBf9Jn6d+YPSY9H4cJ2VVkDCGyX9ARdlrnB6TkaqIhiWoinZUGYEXL3H8SJgArqf
 xkum2OQsKay1suUH7SACttEn9BJIMJyw2iwJw1kz0ZBhc+rKR3Pghhl3e8Qgv/SoLiSp5sEhT
 bbNhhBUhEWjGPwtEl3UmwuBw==

> Date: Tue, 21 Mar 2023 10:30:23 +0100
>
> It can be determined in the implementation of the function
> =E2=80=9CpSeries_reconfig_add_node=E2=80=9D that an error code would occ=
asionally
> be provided by a call of a function like pseries_of_derive_parent().
> This error indication was passed to an of_node_put() call according to
> an attempt for exception handling so far.
=E2=80=A6

I was notified also about the following adjustment.

=E2=80=A6
 * linuxppc-dev: [resent,v2,1/2] powerpc/pseries: Do not pass an error poi=
nter to of_node_put() in pSeries_reconfig_add_node()
     - http://patchwork.ozlabs.org/project/linuxppc-dev/patch/f5ac19db-c7d=
5-9a94-aa37-9bb448fe665f@web.de/
     - for: Linux PPC development
    was: New
    now: Changes Requested
=E2=80=A6

It seems that I can not see so far why this status update happened
for any reasons.
Will further clarifications become helpful here?

Regards,
Markus

