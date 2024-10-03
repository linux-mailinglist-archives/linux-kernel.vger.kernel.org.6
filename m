Return-Path: <linux-kernel+bounces-349248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC0198F31F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E4E1C21556
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37C41A3A95;
	Thu,  3 Oct 2024 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="uRKwIq89"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2058919B3EC;
	Thu,  3 Oct 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970463; cv=none; b=WVIaFltOzj1cxZjdY6kQESG14e1riRzgSYuH5y/MfEGnzgLtJXbnxZRVV/ycyOfg+UWzPlY57heM4kZcjM2YEiJzG5/VFd3JVtBUrR2IxdFPmdvdBH+s+6x4CBQX8iNnUNXpIA/ZcaAKwTridC8NsG98UFyJhE+gpIAcgEJ3o14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970463; c=relaxed/simple;
	bh=6YtWEy943w6XN6R2AHNa0OznWZOmWncdEFICHNQpfYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyMJnOwbTiQUFRspC2lCtH7fBNTCtIC2xKFxN1N0sozM5I77y9kfH9n1ZQ5zvW1RpXZ0Bqxt4VFkhc/CTuEYZUCVGaI7Ma+qMzSzrVSvs7x3hZKSHy1M/1tUAiUGVgwmVSk41RMCJ+Yl411237PbbxF1iSGwLA7jhr8mgV+/3VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=uRKwIq89; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727970445; x=1728575245; i=markus.elfring@web.de;
	bh=6YtWEy943w6XN6R2AHNa0OznWZOmWncdEFICHNQpfYU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=uRKwIq89YSdIDUSSN6xXQU2nxgDwzu+GmR2DgpocW/h55ZNLZnSWP9uBlEFhQnPs
	 9L6jHYFdPAFZp9magrXVsE3kkyBVu2IkLUt1R559o0aP/pMcbyDfG2006txOwD5wb
	 wACAJtxuxztRUk/CZiNLcjh8W7OWCsvvmVRZF3w1Zuv5SyyNGQtTsQfkbfLHcdCOq
	 6osE6+vaBsOjhy6nIwdMNWbdlhoDDbOuuCk7TAoiICbE/1RxKkDIXpL1TWVbK2Gkk
	 Cv8xmq8/Ucthxov1RL07qgsmCc2y11DzZQ5ivRa4VxF3MKw2NBHxDyK5K4GRjJKnR
	 CMakiobT8kqbkFynog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS13Z-1sTXja2faV-00QQXB; Thu, 03
 Oct 2024 17:47:25 +0200
Message-ID: <66655a11-888b-4c50-8e57-06552b82f922@web.de>
Date: Thu, 3 Oct 2024 17:47:06 +0200
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
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8edc93c8-b146-4507-8336-0709b2596cb9@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7MPgs994GP7PFwTjO44hqBW56mTWsQeui4bBMdSxXLvJc+I18VO
 s3LsKLJlB0WoxgwzjZ3tpXnNToRVLOajOQJrK5FHuToJD9iwBaTwB3/EYIyHLfak5541MD4
 z+J/lsV1Ae+bTBuAk96TDFTiscjOfyOrECsQUkwKqq8FY+kMmfdCeB0a1TdZ+DpOjv0/T3O
 ehS3hOXBDffyRnAy/y4yw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:GJwRiYMBY8M=;LW10UzlCbGnHFde9E838MAi2OIL
 wSC/ml98zkbeD4DWod8gSxUewZX3IEkJ5aExpsgM3RjbNjXc1PEtBUvuv7gOczmmdtqArMJAZ
 3czz0b56geNY56a8I6Pde7f9u0Lpz2ByxceN4jElHLmdKCDkPuTXACBmPZQVvxG3vJmPB42ZM
 nHPrJLCvnp2qz8H1swUjXdHY93ft1ten354QN1DeyeDzxOM9XvarY9sc2mTJedPK9C78yOROL
 svdUlaxvCGJ/o1nf06qMfLEc4SaYgG/AlmzFTpYk3WYiPmEekwyuIydN6t6+ujd7h5SL12DxD
 0yeUZifEA7Z3Au8tXix2iIh/PPo6YpM3O4P3nx00is0Lgmvv9TKxBRa/D+R5ai736S4KiN/GA
 7CQb89+v6OvVXWnxF+xUTliWQMD/VHtlD6EPcOaA3Hb35mWZigPOP1sTZNVawgdiqNX/ENM0N
 ALQw/4ri9OPoQhi42TzkJXUHlaLBOfGbCuBebLKqoqq1b2XQZL79tZPDQf6ZBOKStk7epP1XZ
 OvxsdVQzRv2GoSZL3pWUYHvYL84eFkme/bjS8oH/H/9UOttoeKaME+rZEn1geQ2thpRIUl7tt
 we0NIepxreeXWJA1xyOId/kD0mFoKnWvaicqFYXAAkYkvHPND7Nze62E5lfEzQRmTfT6dhl93
 Of8/rbbkxHPsBpXT9l4TzcwVnMPrJpxu3cDL+iFvbW/YNjJzUPXQ/jeJHYizZlAX+fhA486x3
 ePgbTSI7opOvpCjqhWv+IY4f+TvpzNiqh7owCEn+4FTfl8lNDApOHpTKaoUfAsYVNZNiagFyH
 pF/EzXXeriqSBJZ3hj8VYbjw==

=E2=80=A6
> Looks like you have messed up your patches,

There were special communication settings involved which hindered desirabl=
e
data processing for known information systems.


> there is no much we can do it seems:
>
> $ b4 shazam e68a714b-32f2-de9f-066e-99a3f51a264f@web.de

Please take another look also at published information according to furthe=
r
mailing list archive interfaces.

Example:
[PATCH v2 0/4] powerpc/4xx: Adjustments for four function implementations
https://lore.kernel.org/cocci/ecda8227-d89a-9c23-06b7-54f9d974af5e@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00079.html


Regards,
Markus

