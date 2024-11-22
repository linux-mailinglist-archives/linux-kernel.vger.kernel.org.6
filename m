Return-Path: <linux-kernel+bounces-418126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBDF9D5D84
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65C8281440
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68AA1CEAD0;
	Fri, 22 Nov 2024 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="bUZEEQse"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EE910A3E;
	Fri, 22 Nov 2024 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732272786; cv=none; b=QJivWIMt/DOCwk3GQJzvQXpmQNW8qJXenPqr6j7LdAQjEzKZOGGD2AvK6cDP3qdMB+nDdekcna1OOTPagXxMpJzPi/acIv9qvQaqMiNfxWkjb3JSPiFRi8NLdvoE6urm6uSiwXrOTupLDSE+XLplGQ2fc9zBzCz0aEmdAhUnqOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732272786; c=relaxed/simple;
	bh=Opm0Uag6Tn/qHtwFCeuktHeQ5SSHWP8iUyMZ0AXIaHw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=kelsGpCqLUwGDkq2RL5AFz0K7Gh/dhcjvOrrPhoRiVxz/DlugqZEr7+5kYPhPbiuTTmukMsyNJulC5yCRTPiFtAWyFEOKWqRFNEtKJE6Aaxi+KkQMCcxA6u6/YrpMDkdF3MwzdtHeTC4KlEDrLW8ifEXxIElsLgufII7XtXyWdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=bUZEEQse; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732272765; x=1732877565; i=markus.elfring@web.de;
	bh=61ry4edPNxCuNRBy1IwrZKEtdY25zzE8aRAKjDIlzek=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=bUZEEQseerSEZWaPJwWTIDOlfNrOCV3Br06vAdhWk8Ahince6V3c8HeN7M7zCr8d
	 oIMIY8qr5LHOjyAJzAq/9SmX+KamYKYDmXliRT2Nsxo/d1sgYG8yWcIib9Pvsak03
	 Sp4r9Hz+pNnwlp8Lh0SIL2V3Uf+Drfy9izBTnPowU0JZVWg7aCBCJVipSqzJviqbF
	 sEXC9flSFQ2gsUxy8V8ZIoPqQSUONV4Pat6rZVAH0ZQt+rSrBZC1l3r672AhrYfXo
	 IKZEz6jJpm659neg4DfvkenC7yPfF/kVsXBjHLygKRqS4sFW/z9zbPHvDQkwNQs9m
	 rIGvfCznSFBoQlP8Cw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MBB86-1tR43H2250-00DcBn; Fri, 22
 Nov 2024 11:52:45 +0100
Message-ID: <ac730eec-e447-495b-8637-9c11a268e371@web.de>
Date: Fri, 22 Nov 2024 11:52:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, linux-sound@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241122055231.3463-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8188: Add error handling in
 mtk_dai_etdm_enable_mclk
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241122055231.3463-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GmQzr0ZnmJWTazBDBy9rLexiwHSkJuYvSOIIwQYIV1b4dUiK32W
 0lZqoDO/cwLrprsNuikXcVG8dtpPZ6s4woy2SO5ZD+mEKkX/IreYmNW80TTBlV/7ZNRZKDD
 KijEbz77zkmaHzk+moXi/fWVvT4mEOH9G6OvvwT2KlIx8jR7lFSSDN+4KSikVpdtYsFkGIV
 LGsx96eadnHg8MlkQ8bhw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aPeuCtx77M4=;/kQ1N/2tkJDzcS7IbzBA/UrOpng
 zlnmRmyp1ExMEhtEoZ8JfKGRZB+BTgjqexBpEfRDZTVlACb/pY4+2QTsfymAKC+f9koPc0CT+
 5lelUS5DZc4GS6mntxa9sRYpPJELdd46FbcsRqly3erV8VR8TPLj6ha+UwpWaLJGWpNIigM4o
 YDOzk8ryFn9xg39MCr/XCc2DslRk0vMExmZaHRMe6wMp4ETnyHj1eOe+RRkcC2eDk04CvV8do
 LDZWhaqfHKJKUSaZ0J3JyZ7bGKIbKMiVzZod84WXTN1EWP9DKjyKtjOGAfiqW8AjLFHU9w8de
 3w+9Z5jHXnxS8ybNtvRmsK/pGUHz2J0d2xTbzVFBHoFjg08Cd2akMUuQD5uY66zEM/yjUrenN
 mmSDC19dQUw+sZ5WJxejvduMEXOAnFFqgkkDJzaA91rfn3JRqu18Zxy491NG9VZH2S65LjeoS
 B4Ej/pk5xvR59d5VxL7wKiEa4fLB0npL8aKs+LQWg0eLnEGHROHLjGxWuw2+8YoMALGOzFTmy
 Lzdpbka274mgYEinuaby9RmcWr32YpCueWokCNIOBQ0rGHFuNT/XMRYwrXPQHWisPMrya21aV
 o/znJOZrjSAZRFk2YfgGGqRa+tlUSRl3EcpAZs3xDduFMZzpfJbPqDSlPrGYOIcZdS5FcqrxP
 trQIXskPY4KD1GB8szZcok4XjhBcHKE8epikn+NWk5h8W65eu7g56mr3Ywp/4CflpwCPwI/lD
 2mrAW+rWvLb45d3/KeviOtbfzePk346/r5Lp9UBwskkc+qsTl44SGEwjAbZ0ta1PNU4utVlgM
 UPZfvTz9qYBEPbw6UxVylwxF7oULqPVAREOF9Jzo7cy+qrfi9qzad/TCsq9Jm0u4ivC2yoZBC
 UBYqzU+ukc9YZfx2M+/8uVO5mugeDInuGat36F3WWPHPO3Xr7OrDfK+HJCfm7yhIb5SFo8H6H
 LhFxz4QEEd/Z5xCi57g9JbogIeiDI+xyDeppl2g90k7LmUWIYOZZi/cvPc36YYpEiZ615EvvZ
 odibG/HhU9bUHGsJ3yzKJmF7FWQ5MJxKKALNYZ+Wc4DzUKK056LGHfIEmiUKKESvWLbSxFq1m
 P483EiiAc=

> Introduce error handling in mtk_dai_etdm_enable_mclk to ensure that
> the function returns immediately if mt8188_afe_set_clk_rate fails.

* I suggest to append parentheses to function names.

* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12#n145


Regards,
Markus

