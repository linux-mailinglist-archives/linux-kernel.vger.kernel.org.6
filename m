Return-Path: <linux-kernel+bounces-237397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED19E91F074
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F6F28119B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F2D146A68;
	Tue,  2 Jul 2024 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PnJOadbx"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C705D4CB23;
	Tue,  2 Jul 2024 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719906254; cv=none; b=YI4oA8IrEufyXEytIRAuyDyMyNtReoibHq5bGOAF82hdSZnjVMQRYVFp1t7ywCPdbflKINCwtz2Bs4/E+v6TiEsC2MLY4NLAwiUAA6C9aGXqeqZq2X1DJEGiY3A8T4gVbS9sdMITm1PI5yWfDWkfQZh/+G065YcQorMs0hbTtK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719906254; c=relaxed/simple;
	bh=fn4RaCmHrO9+zVKpSE0wWG6jPB3xjXWqbZjeoZN34aw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WauTvt49vDaNoPXtlV0PnQiDbHz6TNjJnF83GmZwIk2eK5v4uiF+C1xO7+Ver2boj4kAOWwZTXWIyYgI/SF3KDllNOJ/PjEPVG9t/R3B2uiAXD8D9gvHjzLBOGYfYe2ctXIKKI90h6RVGJfQLiF++1lv6f+92xAkLzkykdMwqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PnJOadbx; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719906221; x=1720511021; i=markus.elfring@web.de;
	bh=ZeB0+Ec+5YJTZMxHaSrgvr/vw2xhzk6rdzPpdj+oVNk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PnJOadbxr4esfuE6745tixukJpKsRRQkJ18tzFwU9pVK4ZSbEZK5m5eW+E4oarJN
	 O+GutjpwaRY4to+eeAaAxEKpJp/4ha7/ChFO4gxn8tbVZwAVRiEGGN4TeXsCL9fCu
	 7Bkz7W1MVJnbFLkSZTFuBXXxX1rs8t78pyYvNI0CAsL2rmLCIQfAvW8cviyAsvrEz
	 6Cw8MIJRRVwL0T/go3KtTCqhHGQ5NBhGu3CYypDsEkD7LZOn+Dn4aMM6H1ZEk96st
	 5ieQ+JFA4HTupP4co5mg7gNkjEjxxnm4IAdII0pYOoAzELo/jLZl0YJKhYYTEDgBI
	 sQpU/hpWC3MS7JbR4Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MTvrs-1soQmN225q-00P0wZ; Tue, 02
 Jul 2024 09:43:41 +0200
Message-ID: <def496b0-ea98-467c-be47-77d965bb3a88@web.de>
Date: Tue, 2 Jul 2024 09:43:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] phy: cadence-torrent: Check return value on register read
To: Ma Ke <make24@iscas.ac.cn>, linux-phy@lists.infradead.org,
 kernel-janitors@vger.kernel.org, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>,
 Sergio Paracuellos <sergio.paracuellos@gmail.com>,
 Swapnil Jakhade <sjakhade@cadence.com>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240702032042.3993031-1-make24@iscas.ac.cn>
Content-Language: en-GB
In-Reply-To: <20240702032042.3993031-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TmT02C0EJt0645VtrOXQUopS0Jq8aD9KBO2DE1l6rE2kT6u5q3A
 PYlpyU5J45O9aKHQ1qo/FWWrE7yJezI3J10KlULC+z0rBZly+bVhHNxktTPLmmkztjNUo3Z
 +BNmdX0sCOV6RIg9NmkaAfILn3IC/4cDfrDtnFcJ0m1W6VMGbyhBYH7WyVzhbWabDnKUseo
 yKI3FxFNEgS04N5D3A41A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pvNj5+zGnmQ=;bX8Il3e8Qp5ktsIFAeklq16Olka
 szIIGu2zpvxwwxxAFxb0YleBppFB2Pdcl3iy6gXNiQOdj/ANJ2OiGJVzGC8I7+UmSASWPhTIW
 cWD42OsCgfRNDFl7elDZ/ApYQCeU1/nXwhJiHq7wdkeTjvGd5rMJ/V1TIhuh1aapbM1GB+90O
 oYdAWVf6Y7lVTrPkyIU/f+qkkVKVsTR6dNkmhm+J968beMelgGnNWCk9NlXhuydh3va37+Krr
 VkdDMgYr1YVMN1HwEu5oNGFJ4SjkY5YoadVob7fN5pVpolL8t8ninmr67UGa3A2osuZELD2qb
 91lMi/1G5xt1cHh1BDOfwKGKLnvPctd/av6sgZwzDVO9jQrqZtqbLE7sJYGeB/QN8mKBdUG4u
 chZvKZNRTISyffjxf6eHk9gGkaMUzXih/Qi2OlRsDjJxN7cyc9QecgRodtc7y4fsnMrNLrw4f
 0FT6G7u6t/vDxAMpyud0nWUVXO1UXm3niWx2LGSd2XAB3k7TrGW/lr7vUUhoxd+MHBlXb/z6d
 JBk+jBLGBZx2Pc+gpHHuwZ4B/lH6NJgr3U0NY1RWAhsHdWGUMOIUn+ljlPZtns9c7290UzxIZ
 xofsEeCiBmPEiyUK9rZbOGlbPCbKbCU9TlYehALvXXARJ6zpZr/X62yonTohQ/ncoIqwQu2Lk
 uFx7TvFVGU3DZL8UQ42w1qWhvk1pjV3nhkHNyefeNMtqOFvB9l7kVm2DuA23tsTxlT3E7QrjE
 fpsi8eGLkUvaH+UKlk4gE4xlbH1kJvLa++wfWJvvR1NkeuLkXzuwN3CyehJ2hZg5W1LFlxjkl
 +x8MjNnAlGCvEeVHdzSRYqOEyNAz/bOBakEdayIF7MGHQ=

> cdns_torrent_dp_set_power_state() does not consider that ret might be
> overwritten. Add return value check of regmap_read_poll_timeout() after
> register read in cdns_torrent_dp_set_power_state().

I suggest to improve such a change description another bit.

1. A return value is stored in the mentioned local variable.

2. Unfortunately, it was not immediately checked.

   * https://cwe.mitre.org/data/definitions/252.html

   * https://wiki.sei.cmu.edu/confluence/display/c/EXP12-C.+Do+not+ignore+=
values+returned+by+functions

3. How do you think about to avoid a repeated reference to a function name=
?


=E2=80=A6
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

* Why was the personal name =E2=80=9CHaoxiang Li=E2=80=9D not specified he=
re?

* Under which circumstances will applications of the Developer's Certifica=
te of Origin
  be clarified better?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.10-rc6#n398


How do you think about to use a summary phrase like =E2=80=9CComplete erro=
r handling
in cdns_torrent_dp_set_power_state()=E2=80=9D?

Regards,
Markus

