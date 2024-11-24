Return-Path: <linux-kernel+bounces-419430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 867519D6E07
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 12:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 176DE161A10
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 11:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86927186E40;
	Sun, 24 Nov 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="pPazDl5k"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F087CF16
	for <linux-kernel@vger.kernel.org>; Sun, 24 Nov 2024 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732448043; cv=none; b=eRU/E+dbuPwlqAefAqJPS2oI9jz/DyMFGBkF/justINz5KK8udbyPaCRzBLpmmnvzU1g4UN+7pGRKD2jkNNImXyiXH8bheWHrK5qoXFzZpyn8qACo/NmIMaFyD643G3o6CuhG2X0ne4SOehLyPfzMJ+3T9gaVFfWzgjXUqk097U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732448043; c=relaxed/simple;
	bh=+20jePiGcKXZV1OWPzMyD9iziENqKYEFTcv5guvOmng=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Z/UK4z3lqKTWWU+EcplG89Hha0s1w92gRPVFw88X7SFBEK5FfKnQxgTR+2rx6OP/E39TXqXsVAPdkBAvNUCctX5nRujSfoYQodaElJlGBlFbbbrZZ4p9fR0bIk8RErs4U0o27e84sC2FIzvyGfQBTq6dMZh1ZT64MO5h2zHxJSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=pPazDl5k; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732448011; x=1733052811; i=markus.elfring@web.de;
	bh=+20jePiGcKXZV1OWPzMyD9iziENqKYEFTcv5guvOmng=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pPazDl5kDBh2V6g/q/6BoaVPe56u3SDpOj5JlSUl6zMb6IHd3/77X4drH0klGKbd
	 bYzB+0EalpqzkP3Hbmgru/yHpobEyJRI0J6q/qrsixkbaYJIgbCuLcbsV6Sc7Q0A3
	 DGAVLZpT1o17KnndV8ADMEp6Z7TWOKcMxo5TjENZMa+MgsHs/DfzWKSDp+wfPb9u+
	 v1Gnup76XXWtssiLiViyboY0/XIYpbj6bxwusbLppJjPiDwuMEWa3SdbQbBsx6Gtl
	 titl9o+n8jvLI/8qHtenUSAp47vuHj+8xzYemwNLUDvaPCocQmjP9YqNHf/A/E2zX
	 Jyvet8soi+IN1ps3Mw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MA4bA-1tPeCG3OG2-00C4X5; Sun, 24
 Nov 2024 12:33:30 +0100
Message-ID: <c249c855-aae6-4020-9ace-3b9528fd8422@web.de>
Date: Sun, 24 Nov 2024 12:33:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Karan Sanghavi <karansanghvi98@gmail.com>, linux-mm@kvack.org,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Christian Brauner <brauner@kernel.org>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>, Hugh Dickins <hughd@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241111-unsignedcompare1601569-v1-1-c4a9c3c75a52@gmail.com>
Subject: Re: [PATCH] mm: shmem: Fix variable type to int to evaluate negative
 conditions
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20241111-unsignedcompare1601569-v1-1-c4a9c3c75a52@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Smf0Gyv15CTQtfhx/lyXsj4kVBbxInuur8nNO99ZnNq02noE0Ha
 OFJwv6mi3icfncJiFMTa+Qxk6DlnFn+fJroa5cl6TbMhKWEKITQ3eUX2WMkpgMyeqmCbTCf
 36KqbblaItxnxHsYhdsH3NXNB/aKJ89CCFk5yWWPsSUss30MpxAIFh4gkvhOx84ZaxhhoWs
 igoF23QINPO0sYmVhkpHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vfgbS9vsiyQ=;PeWv49VoBGhsa0bY8W1On+vyvbD
 duYevf/UWPTMjBWHDzNECERF/SJaW5G5ErBIP6doVTiC6HpFUgIbz5xlZz8VWLuWG3NtfqQvQ
 pUc2X9oG0+9Ab7oFmBRtktkLq6TjzOaW9rcIGpf9sG7komTjaZe7yoTmrBbuxCrcAy0qp9rFl
 MQkP3Az1qiAe4jGOn6SZPRyK/kGKbEemUmZ01DrAo/A0+fCGyjs9cq7bvRuyMLMNU6zUyIJUY
 FIlAG6PPjOMgg3s+Gq5O3PvM0HJfR05QZ7/DbXlKU4g4drVy1LQdJtdOfID7fMSKASJ5q9iqp
 tzsImYJW+1UnEcrLAvhHRHCLuw+/En/E8qsIMf01DGTSPn5ehvXt6XXAjsL2yUVARAh9OTuCe
 FzCUbzvgzkGMAO0K1L8cRDNC2vakz/3tGO9bIr9tEhP72in2b/9FChsWmPsewk+FMXyvkmSuf
 IvNzjVUEe4B5EX1lbw51KOURIXPIl7Iiz9TX9gZ+BzLLFOhy5rvcT/vUGTW/vrL4SaW+JU3mE
 xq5/oaGr4WiMDhRFtTo3OGbfKJRMYqlqHL7LBW77terxMaUHj+MfRfjWm/lvay05TtJNqEEzi
 MdgjYfRJtDujqWF+r6TjY4YJUIPqHutboz5lXmc33MEm4RqX3sMxPWtmzIZIgkbRvlMqHiFA7
 fYLuKgAGTUZXN0A2yw8CF0Vn/tAx6q88iSsa9XDUzmRO+Zx9l+i8sPcEV3s7OoOtxvyAS2q4r
 JpC0d7gv5OkpGXhWTfYC8ejHUilhk+2Dj1dxjaVRuQiPsEhH0LkcjZS+G//nkoKd2PniLsjBH
 m06erObUKqDAWx11mUsQuQcDeUQh1f4lhRb7at+ip5JVvZfL3yXHerFCCBEplOrqDPh51aqjg
 cUBQnZL2r1pMMuB2ihFyPCuD4VCDdUcLVa6JiKGIMJbexAQZra7uFt01BkCJqsCJ9L9v2404V
 gIFLFBM43Y7yUMhRrWWI6lHHiOpFKPHTTuRWORB4p3ivygR+pkVY+Ox7gYSqdKsqquuhf0Fs+
 0oNvRFZfHpD3YxnsHTyHvnosXOfxP009ap6n2yj1tIYUcQa6b6wINqMFF33ikeJh5N9jzi74c
 B6NDZLROE=

=E2=80=A6
> ---
> Coverity Message:
> CID 1601569: (#1 of 1): Unsigned compared against 0 (NO_EFFECT)
=E2=80=A6

Can such information become a part of the change description?


Would a summary phrase like =E2=80=9CUse signed data type for version hand=
ling
in shmem_parse_opt_casefold()=E2=80=9D be more appropriate?

Regards,
Markus

