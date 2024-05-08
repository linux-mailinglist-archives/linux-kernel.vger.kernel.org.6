Return-Path: <linux-kernel+bounces-173715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 278C08C0482
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 20:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C634D1F2233A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6DE7FBD0;
	Wed,  8 May 2024 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="b3OiFtcx"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259CA39AD6;
	Wed,  8 May 2024 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193556; cv=none; b=bA0f2farMVXeQ0O+pcddmpnw81kuJJQNJb/lbqPHNQOjf6kRrBwMeuDcuNGtR8rlDGk8ZELdXS2miuN8eaKs77I6SO86hfEIU/T4+AOUrGtl+HKf+zjv7qyuV85i8XCW06EFcIA57tuYOybEy9pLJyVm7L3uEOF/+ysSrkNJdNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193556; c=relaxed/simple;
	bh=HhXpmjqMcV9Nx3ElggKSa1+qM5Zo87YAlC4YZwg7Ypw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hwdfdbNEBjc9f6RpJ13oR0Xs2JBuNtljQySGJI1ScChD9dBJjfJcAkUTHLnqq0Pt255N7ykN/fzjmQzoqodUOn0/T6VRgkzSk6DMPSoTMfxiop6nMnrVJMaL2EuWFjdnvJmEt0oIkvzCNQWjvNt9OO5nuq6acEsM3oLHPT/UsU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=b3OiFtcx; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715193537; x=1715798337; i=markus.elfring@web.de;
	bh=mnjR+bhkQyg2ec9mqTa65YQGCETC7UMatVLhvFCuAbg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=b3OiFtcx6X3TjYMtdp2PagOy+8aZ2FuRTMUL2uN2hq5zVR5rnEMTVN4VjjkpQvCs
	 bl2a19TndjNoeF7a5Uhkv0nJB5Eid628TWuzKmLf3/W47lX0WiEuEibo5KU5OwCjL
	 lFTDckkbeGcbvK8US/qPtS4NuVbwMzEs1fdJo5S/NEYPnuXZKEZRTDtPSxTWvlwz1
	 YaUJDYrRMP15oDKcVaxz84tYjK6y7fC5SDkRLIHEBz96vNqfoIg/n45cyEdIFmPBG
	 3SvrdVZx+vIkAl54CzPRWksSIbmgY60r64KLk/e5ZCS11uW71w4jdxK+I234sN/q0
	 G8XrKmhFM08u/Wg9+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk4e-1sAnWt0RKc-00THTI; Wed, 08
 May 2024 20:38:57 +0200
Message-ID: <b4156f2a-ea8d-483a-b485-db4b5a80b1fe@web.de>
Date: Wed, 8 May 2024 20:38:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] time/tick-sched: idle load balancing when nohz_full
 cpu becomes idle.
To: Levi Yun <ppbuk5246@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240506213150.13608-1-ppbuk5246@gmail.com>
 <20240508172621.30069-1-ppbuk5246@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240508172621.30069-1-ppbuk5246@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vI0kdZc8ldOBS71LgW9lNsV9hIjeBDgy5VG+o8EqSRdvzzm/Ez1
 Gyd7FSGlOMEhu8Mj97kVRXLLyxH1t1wBzcgu68xNrsgrVGZV14gT8ZuQoVLWK+QabaQ4QQt
 DOUrHmPD9+Z8XT8JS0UAo5oUXifT/wJIgc0KylJ6o1wdmpszLlP5v5oT32SQ7LT8AfA2xqm
 0TszyLniKWkoBGvWhq89w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dN2KT5UCWdI=;MbB77xwG94SuuOHmvmM+pT+Bte+
 CqtUXorw9/w8qR0RZMTmJ9f9LV0TyX0UWkvMHtEEHIijOKXVg8DKHYfdSw+jWhVYDpFsAKbek
 jdDuIwTjUIWUDiqThpQ271rzc3sxkAhS7eGSgjXGToxKmiUCbR9bJ+RgMaJ30YF7fte5ottjz
 pNNifhI8T3v3+gP0dDr9cq1+n33gqWUXDJqdIZvRVTpzo9uEU2vmEsDPPPGW2MdYc0aAR+IQg
 0yZ202VejmVrXlSRaP/bIzDzpa6uGI905ZE+o9G7P6YfY9fCpV9Pdvf75i5u08CQULnn2HjmL
 drkhLb6+iNydOg1j2lRrfXFcTF6mU/yg5muBpK3wgV3LHznyl7pu8z8Pki16jhSIlxRJiccNE
 aTHCLLXezwvyRXZ4k0s/CxohZtQlt6nvQTw20C9EbQ+ho5YlT0DFpl5j27rfY7sVhAhdzbsr5
 gRIHu0HFp/QETKlv7p5xpS+8pZ1zgpbGpVy3fNE2NVxrindwGLOo6Jy6u6zqnzApnhU7zSU3u
 Por3efO3kviRUbYf5n3JGpxbmuOx2YuI1jFrqiBwvefVGV6YPHQGUPzyYJmkPCPO9sbj2J7Ho
 fF7FnNFIOheQ8hYRRfVFZv8AeG1S7lxz+IhZi33nnVx/OSycmkr4IlGiTdwFc0HQGDztWGgVW
 RyJNG03vNw8v4mdFZv1vTsmv5W/5LfFP1U29nDSrmpgKK6yoMz6mBZ/omRSEzr8KyGI5Hwuqv
 mzbyZ8ZAlmtGVp/6bBFKOB9jPaCOv5GgUTPl9zjIWM+2dlA/Y/3C/1s3eoU5O3QeMrE9Kza4q
 JPvpm0uuQaGsqvxrDHiq/Q6WPxPMJLyQ/Ke/IGR1j0/Ww=

> When nohz_full CPU stops tick in tick_nohz_irq_exit(),
> It wouldn't be chosen to perform idle load balancing bacause it doesn't
=E2=80=A6
> So, nohz_balance_enter_idle() could be called safely without !was_stoope=
d
> check.

* Why did you repeat typos in this patch iteration?

* Would you like to take the relevance of imperative wordings for changelo=
gs
  better into account?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.9-rc7#n94


> ---
>  kernel/time/tick-sched.c | 6 ++++--

Will further patch version descriptions become helpful behind the marker l=
ine?

Regards,
Markus

