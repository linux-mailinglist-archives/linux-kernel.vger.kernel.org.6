Return-Path: <linux-kernel+bounces-414744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA7F9D2CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D41E1F23734
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0509C1D1300;
	Tue, 19 Nov 2024 17:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LFDhoGYF"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890651D1F4B
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732037646; cv=none; b=CGCHiev+nqFbtR3a40Eg+5eb62Yjz4XTjNQkKzcILDa6vUAKz+b4CJ0L56/7zemutWTnpsYViokID0rAqAUwfOhXXhuKcXLP7cEOOM+OqjIR+hvqLebqPpvZD0JPjIXWkRF63raFkZ+PCQH5QYNBPCyfqBure8xZHtO3CTyQR4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732037646; c=relaxed/simple;
	bh=3naWIHzYr16I1lpNoDZN0GqMtSma+VJOVWPtus496Hs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rDr5LPKKiRUUjyGfy9sD0ctoYnm2I8Vw1nrDva1PrikrRGbUiv/yIHHJN6ttoByMxwZFkM8Zl9i3XAODTu86PD3ZbcOHqeAWd2hqMzcePGpHBmFDOdm5DdGqY3zEe0aEGYafwkCAnWdV9HziWqntzWSX17tTF/rCp/Yu//B0tfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LFDhoGYF; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732037607; x=1732642407; i=markus.elfring@web.de;
	bh=3naWIHzYr16I1lpNoDZN0GqMtSma+VJOVWPtus496Hs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LFDhoGYFWkArmL4J29WlQwSLAPEDZZUIWc/AxDam930t2nLXO/vKA4x0YauGuUPv
	 ngwp890UqjiZgm0PzB4QfRJIJFPwSpb3XssjjZLE4M4Lj+n8VuL8oFEciHQUK+SVV
	 ab/I2+AFd9911tLR2fU1dvrUbOAhfc/FPgjYJqaLnsWNdFkRRnnLaHcBWrt9RLCr0
	 Mr3b3rgQM1Hxuk1cy4MxG8ROE3RH5qSekSec640FdbNlHs7Kv5923Y4lXq92iv0tz
	 OwBEESIrreq64+6NjiGEXkS+1Y3l/7sKAoOZdqOnpV1tNVR8I5qxuI1BYl99rRFbe
	 2Abb9KNXASC5shwnHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.88.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1McZnl-1tjTw20czl-00bDFd; Tue, 19
 Nov 2024 18:33:27 +0100
Message-ID: <ea06c201-5a99-4875-b2d1-3bc4a35e2d5a@web.de>
Date: Tue, 19 Nov 2024 18:33:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: x86/sev: Fix dereference NULL return value
To: Shresth Prasad <shresthprasad7@gmail.com>, x86@kernel.org
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 LKML <linux-kernel@vger.kernel.org>
References: <20241119-fix-dereference-null-x86-sev-v1-1-82d59085e264@gmail.com>
 <9dd3d046-6949-4e42-ab5a-af505f9b3981@web.de>
 <CAE8VWiJ62xT9shaEmUTOPF1OAztaWsr57m-wY9jyMJt5WFke5g@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAE8VWiJ62xT9shaEmUTOPF1OAztaWsr57m-wY9jyMJt5WFke5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ox/a0VMdkzGG2NKz2C6o27ov3P7SaThK9NJplDXhPybA7u/Aofe
 bwmfXZoTj7s7+E2SKWEU1cjEQor9Ldaq8rdliYFSFD0RrWOfenvmIDzsnlUVY7WUX5OPP9m
 Ri47lJKDANSUf5AUNooYficib0w9meduZDzW31V1cJVHzH6DoP+5iyq14cxTS/WmLUT7hpH
 B8qi4px5+of3BARuRvkNw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:w4nzKtfb6g4=;synUxrgcIwFcuPrraj9fgjemeYW
 IethAPZq1/alrBzJ8YH9a64ZiUbTrIBWADRpC55yyF3Ttt2iIb7w4eEtQneTU48f9M0CsPlY4
 MLmf7ejr0CmI+EhaUezSx9/wa0Elv4u1Tmkg4P5TUcQVjpE2ZAQpPBbBlvCRZs2dPma0NnzO1
 UuIFCD9Wl0ooHpVuwfolE/16qmmukovObJ06j0pz9cxizsjgmTC9t42ogkXpjKBQqLlaG2ziz
 cqRKc0G4Xj0e9iBM7d2Z/ckLPbGqP9klBuZKIrwfGspw7HYa2aplNx0IHTc9/Ppc3W6sCwIZ6
 tJHGuSo7z7Hfg0BFvBU2HMzQTihL4K6/TFt5aBUrAd7Qc4Xsk8TohHCWaGjLPyEUEg4zrV4X6
 GB3k2UJ2a+jkO28CEAC4AXwFGdwZAirdAMjDmiViv019wzgRTP7SZIZWqPxAcuDgLe5UhjWCC
 FxQV0PslbeX0xEpCsdjbp9tu5/rNWh2oRqJ/jYVSa63mstTgoozJ8K2Craeqrt7fMwbNZBUAl
 EXkWDXtX0i6W7SL9AjRsxLsmxMRjSZ0Z8lmRJa489u5JgUa/hQSquNWJu/kTq6VG/Q9XSDNfI
 /tI4U3U95DVfUHZW9BO9Gk+FSgCLaEdKqso1y4kJWHdlaOgqnQzGW10mL4oU8vLwkEGd6DJkO
 YhYD3SUTsED+Z7bhcJgTmzju2YGrLWeuudHAm2hxJVgCNH3UZzGngQAx4rIv+28ZW7DOOHCu6
 6OH2hmaDp0sHIu4EsIinUDKYkP8Z+E/9hoGAORhfzD1/8/OiIcld9LJdmqVFIQnhpTYMrdlji
 n7Gn4MRxX0UlGvyWDQcFjdFsoKUgYbqQFRVb1SrgT8nzOD9+cakQLcPWdvLXNKJcjzdIbbslF
 BiZRhKs6L8kx1dGiBqpYdK9/WAQilWIBSEIJPiLutTkc3AbL2TrhgrQE4

> For the Fixes tag, I'm not sure which commit hash I should put. Should I use
> the commit where the function was introduced?

How far can the overlooked function return value be traced back?

Regards,
Markus

