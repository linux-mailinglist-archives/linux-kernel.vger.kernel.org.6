Return-Path: <linux-kernel+bounces-349322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0395B98F452
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 18:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67288B21504
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1ED1A706F;
	Thu,  3 Oct 2024 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PlYLC98A"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39276186E3D;
	Thu,  3 Oct 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973511; cv=none; b=grobGn00aLdCCjFgyN4TSB71fTSHLnArEJXYln8Bt0FlBRV7WHjoY0XqkruoEk9vHHHJ8O/68J3S+246KYyPD6UXwWQLjYVtqVxkdXCS5WEUpvdRf5UH5CCEtgxKaMmW4au3fEc6CMb9mHoxMMZZfIZJzLE27haK6ApvGs48NdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973511; c=relaxed/simple;
	bh=F+1z7U/n6yl7iV1NAosWW0C7oJG63omhcZcSrRfRnkQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CbpF3doDV/+HDcWh7eYQwPlHDB2q5HJllI11nX0IWiqWx6wD1AVGzdhWQSLFDyGLxaspTzEeoBnHCdQCOktNDubL6F6VcChRqKBNgZpjmv+BEAJyhWDE82UUhG3G0m9agCsHWfTY5asNnpYI+MNf2ubg3vimk0sno6sGqGX9BgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PlYLC98A; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727973496; x=1728578296; i=markus.elfring@web.de;
	bh=F+1z7U/n6yl7iV1NAosWW0C7oJG63omhcZcSrRfRnkQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PlYLC98AgZWVQVABWHy0FwIo+UGIBQwvDWsb+JfI7bk/h2YmOmobUScKXBBvDyNk
	 AZVtxYssUmOret2w4oRvUW+es+aLuDUkCJbx0J+WaONFn8YkO4lQIyYb+24yzst7Q
	 5MzMGqCR/+KpGvzVvk3yD6uUDuG+b1OxLgYFGmKJApkjjZxR41O8fL0/Wd3FudXvN
	 VWJg1i883VelK0XpdDQgEdWZBHDPhD6UjzOC0rdxQ+kZdUFvhVmBKnejstxBffAgG
	 6zIw5AN2ehQdIefD+33Vsf93wh4E+wLhFHwJahoFo6A1b/3NCpOKxQrMgpMLWXz6K
	 RSR2OkZJG0jnDbtt4w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M76XN-1soRPz0pDj-005cKX; Thu, 03
 Oct 2024 18:38:16 +0200
Message-ID: <28632df9-0ea6-4fda-a83a-5ff7c23f97c6@web.de>
Date: Thu, 3 Oct 2024 18:38:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] powerpc/4xx: Fix exception handling in
 ppc4xx_pciex_port_setup_hose()
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Stefan Roese <sr@denx.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <72a7bfe2-6051-01b0-6c51-a0f8cc0c93a5@web.de>
 <ecda8227-d89a-9c23-06b7-54f9d974af5e@web.de>
 <e68a714b-32f2-de9f-066e-99a3f51a264f@web.de>
 <8edc93c8-b146-4507-8336-0709b2596cb9@csgroup.eu>
 <66655a11-888b-4c50-8e57-06552b82f922@web.de>
 <e843b3f9-2214-4945-bc07-68fe935551a5@csgroup.eu>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <e843b3f9-2214-4945-bc07-68fe935551a5@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RPueEfq7odGfIrQtPnI4m0PJ39ogJF2r0KLnd9Jt8NBOXvCvNQD
 v9sYqSOgYyLAwLzY2q2dSHG8z80OZGDse0kNGxc1wzRMAUQ4wpdl//k5KQVKKu8leMVdWUs
 AmUA9QW8FfX5I1VBApoGncX4nDU7bY0ldHefJ9WnIH7cFLDmtpmQ/2LgKvUqjUaDKG414PD
 3tRzt6aoGOCZK8T9lKkTQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JRKwEzXiVis=;rdSJHpinRPkxWnJHAGkZih/o0Do
 u/ArAjqkNbmv6kJMsjKj5drJblyzplTX04aRt4ebLVw50c0Oq3G6bfCAQ+3k1xb8AxPI/uLtl
 t8P9NbAOBeEew2jgo1YDAH1GjY4dF9n97YdNwi6/pVbmktpmHcIRM637lYzkt5/ydqdiQkIPB
 YlitfDzb64y3lptIErz2EHLx2Bs05Le89OTJrwn//+v9LFMq8Lx5Nv2PFUCWohHtoWeFIw+NW
 94dAsTkpRXA7ErHpX09COHjvxhWibtajQx3BviS/Cv5qoffz6MDd+r5PuzF83COcihSHfY72N
 ilc6Us1N0OIj0lIGWPvyTQXDTKnUI0ld1kt0U9T3MJ1ZJdW+PaWK0qQMKi85JlYOh7OfuBXJt
 RsaTL0aML/aX1lzkkAlrE++ybPSze97N9RJLG345Gk3gYUUQ++xnGIXikh9dtbkgSI/afQBVa
 Nq8cWzVD5TWCKa2+pSHp9pQQC5PKZlxZnxZIKxrRu2KUzVp3punbQw4xkfpvY8QEnzPbtygBg
 lzcb3rebeX0cWwn78YhShkA3/GqB1suWE1dGqQByVpPK2dHYDUyzPFttgY8SgL0ckUXu2A5Y8
 UpAF4ZBnxO8GwRMugza9FTMh/pq3brmTj49T+rd4kwquQr7w48YLOyOdUbz6jiufez527lDb6
 zWZfgYG1SAPSh61+b4Gevs7BddoC1VY74X1HMZxLPExmd7JDRasFBxJIfQxYTwtDxveuu2f2E
 D9RF2YJCX7faYhQmz4noX4Ycojok2G8hldUiNnOOMzvzLYc2hwZqX51hQrFZlJEus8nVhBq3p
 dowqb4xaL9WcqRhkKWRkey6Q==

>>> Looks like you have messed up your patches,
>>
>> There were special communication settings involved which hindered desir=
able
>> data processing for known information systems.
>
> Don't know what you mean.

My email address was blocked in selected Linux mailing lists for a while.


>>> there is no much we can do it seems:
>>>
>>> $ b4 shazam e68a714b-32f2-de9f-066e-99a3f51a264f@web.de
>>
>> Please take another look also at published information according to fur=
ther
>> mailing list archive interfaces.
>
> Another look to what ?
>
> It seems like several patches were posted with the same Message-Id and/o=
r with an unrelated In-Reply-To:
>
> b4 is lost and cannot apply your series, it applies the patch at https:/=
/lore.kernel.org/all/82aebf6c-47ac-9d17-2d11-6245f582338e@web.de/
>
> You may consider fixing and resending the series as an independant serie=
s.
It seems that another information system did not get confused with publish=
ed data.

Example:
[v2,1/4] powerpc/4xx: Fix exception handling in ppc4xx_pciex_port_setup_ho=
se()
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/e68a714b-32f2-de9f=
-066e-99a3f51a264f@web.de/

Can we benefit any more from such information already?

Regards,
Markus

