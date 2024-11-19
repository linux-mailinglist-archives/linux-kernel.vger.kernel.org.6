Return-Path: <linux-kernel+bounces-414274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2299D25A1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 13:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80C7B274A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E901CC8A7;
	Tue, 19 Nov 2024 12:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WBbuNzLV"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BC41CBE82
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732018682; cv=none; b=GVKPuviepPbuHpjIHuo22DanX7AmZewLQynLpPa4iQEDRTPGTAb/K6/dd63i3CxSaXxMEWfaPBOy6n+pa3PCP/kUaLveUCeL2r7GU2Syz0qWeMtMqhhzjRDpbvUeUCQ1iVmKn8NNRJl/BPwk7m0n2n4nfJj84xyyjXLKckZyALE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732018682; c=relaxed/simple;
	bh=lK7T+2V1MgA9heR4Sl6qWm3BYlRl6nCbMjE5x85JwJ0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=t9BitZcXYLsVtnJinoVs9fZjfKJ9+Qfqt274yLdDvS5ZyZ9jgdKQP5TUSqz7vByFDHsz9guAbT34HmjM3dONP85Re2P3QuQJlTeyEj7Zbvbk5V5l/U8pamGoLNCWmg6Kuc7lgpK73pX0fhWSCBHPF8IZpwpscwRyKYOQJexBJvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=WBbuNzLV; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732018673; x=1732623473; i=markus.elfring@web.de;
	bh=DukZatltdcrhP13FuPdp4F4UvFIQYixlHk7TenU5JOc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WBbuNzLVYGjEvDGX5yeATqBYJe/DaMyQrR0+fZ+BmFV65Tt2Gv3fU/Bvu8pmKEys
	 d5qQaulpO8Dz1hr26l/lUGqgdn+OZBsiqTrRPCY6a8eQVQeEcF/4GW69luZUs3mHW
	 qmMiOHMgDk08+IS7dHo4UHql0i2buhQrYn7jhMznJSY3zF97tPXErdgbGLfZtgfJY
	 2L8An9yr7gTBpGT8OFe6EE5bAwikAEkl9pF/ruxPzDdGKNW/JMck1PUFfqwM1lhZL
	 MCY6yQ6ut+aIicMPCeA8qzOdL/dVi9s9w80qNr7vTO8B4ciwIbt7mtPR962OQBXNy
	 BH9mQkPi0WyOPllWaw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP384-1tNAbY495Y-00Ua4b; Tue, 19
 Nov 2024 13:03:17 +0100
Message-ID: <9dd3d046-6949-4e42-ab5a-af505f9b3981@web.de>
Date: Tue, 19 Nov 2024 13:03:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shresth Prasad <shresthprasad7@gmail.com>, x86@kernel.org,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20241119-fix-dereference-null-x86-sev-v1-1-82d59085e264@gmail.com>
Subject: Re: [PATCH] x86/sev: Fix dereference NULL return value
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241119-fix-dereference-null-x86-sev-v1-1-82d59085e264@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hrpfk9fW3pzc4/Tqk2j3G6U90xbItjLvzL5rAB0P64jfNeOMxIp
 baQfwTOWAVDssjFqsypOpymNGCAcj7NxsSzHQbYeQLHoKVrc6r37ZeUxT8MuwT2fIeFp4aK
 A2R4qUi7i0z0SYzpDXli1cBEHRun2PK7WEVQYIMl/fjnTXwBPHG0EnThDGhGN2+316lcwsv
 taJB/C5pgAwNBS6yavyHg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nct6eauOCpE=;SKvN5mWG+zsTj4WRweMqclA65Zo
 EbUTkcNaWlDMh+lbDfBPNyAZzeYE8yFx1yhvCAWtFOX86ecrkkqGPtEbXRdW+iuW2GoEAaPx/
 rTlWBIPTnX5eBsNI45BFOFJa+ZQ1W9kK6bkDv8uYWfhjnhxdhU9jZIDSTeQZE3+trS9fz0sTi
 qUVSKI6nBj1JdWA2zBQZCFXv6H58Q/1bs0sKkBaWt4zDT7is6BzOUvZ5VJVcaNlnZJVm4MT4k
 MW0Y1ONXICsTPqAe9L3zLKRZ94L3gJJv8FBiyJeihumVeMqNrEQMWH9WfSYOcQaEdXR/0njDI
 Fdls1Z8Wh5BBTLgQxrNMS2vJM+R03RaaXXr/852FchTWaYqHuqcIgwz9VMcrJR2fEnDrauQ46
 20tP8kSPFxdD3GT8S/hhZFI+xuoWsjBWELuQzmDGuySuH92IBLzMXcZgRL+ze9KXiBZNbPJYs
 KoZYdmTOSlSa/0XIipxafY0EimtDivT/2gD+JeRyAuYgdhUe5bEdvQdxqGQV01iKJXRmiZrHo
 CD8S8kygUZDnV4iGMTjUBDZgEi67c0UYpz1dGLd2z9OrHoZF+tAPHht9s82wbrEkYT5idks3v
 AvOwXPZpy2eYrZl3seXTIig/VMH2kMse8RTdeMB5vn3gCOvvSTzHnuR4pblOEiU21ej/dpiXs
 fCY1QhAj37JYARntJj3swjRJuWFw1F3Bfob8zKRBEBcacpQd2MajblmeToMxXkgS7NSVuETpS
 ZjwZjxHxpg8fcuXpmweGh2aQTHiN16FB3K3kaUjUk730zAyfsYnuNGy0PrnXkZ+whOg5JPZPk
 79zqViYnQtCCRqevgg76wSCSa0WuY3DdxvkCoJY2XPpgxj64qdGmqtZkH3O6xavh+8/yTfcZu
 G6Ek3AKc/j7gwf9W0Gnr2xfHlKsqkPer/dnnXDyE5Ga8JbW/ciT0+Fmla

> Skip to the next CPU if `pte` is assigned NULL by `lookup_address`

                          a null pointer was returned by a lookup_address(=
) call.


* How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and=
 =E2=80=9CCc=E2=80=9D) accordingly?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.12#n145

* Would a summary phrase like =E2=80=9CPrevent null pointer dereference in=
 snp_kexec_finish()=E2=80=9D
  be a bit nicer?


Regards,
Markus

