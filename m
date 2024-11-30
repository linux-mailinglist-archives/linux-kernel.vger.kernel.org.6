Return-Path: <linux-kernel+bounces-426142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A629DEF71
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3492815C5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE53B14A0AA;
	Sat, 30 Nov 2024 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="tgPJX4Wv"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1D12B93
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732957647; cv=none; b=XixPcpdqtQNpFcdsfAqtHuIQAmVV9bsf55uA8GddfPrOi+hWvv+dok087+wxs7JeJOHM3wtEa7zc6cqN54KXTjKmfY1wroOXGPN1h1v2GfQswo6vgyiIW8j2sTrA5hCtjxgTNjD0/8jaoygpzn9G77osY7sk6ezV4PUPu0qMyOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732957647; c=relaxed/simple;
	bh=v3XiGRlFoJi38O3HfXRTZmLGrna0ussIYJTi+lvVRgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=fd8Ai+vNyduANxG/SWfCsA2sNTPUjqxqKj0wUswJ63XN9WyQD/v4q9nuSe0FaCN4xK7jLFPSE1KudTcVZQ9vI2fkJ3hqA7sfrTyMzFFmVDHBvPm3JhDs0NfWJnK7lIScw7c+rpAlyOAPl03sjTvY35/6Nod/giHmDXy2YvoEBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=tgPJX4Wv; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1732957620; x=1733562420; i=markus.elfring@web.de;
	bh=v3XiGRlFoJi38O3HfXRTZmLGrna0ussIYJTi+lvVRgw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tgPJX4Wv3ZqrSWtpjpT8fwPwlaooUGn3Gnh+ZGKLLN+4yb26j0q6bEvPyN83dVbB
	 oK1gMONdvTMUJMZsnV1YJy4zBfecUV9k03RoKNrHxPyyrpQt4AXPFOhpbvmfhKBGu
	 H3mVvC6q1q9i1GJmUAUVrGqjCig2/SSFuzr+CRsww6fgTvojIBLRnPmOLdgX9v+Gz
	 V1KO8Bou5F73ZBx6PcRI2vp+av/U4dk0ro8umASi2aPDuzy0JwZVfczV4KVMU4MqP
	 u1PKJacjJ4DzOdkj67g0xZL8GFezBsQeUnr1AMuKZdEBfrPYthccgAB4L2l667B53
	 ewjTeK7P7E+EjWqDag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2Phc-1tFfY228Ss-005wSW; Sat, 30
 Nov 2024 10:07:00 +0100
Message-ID: <17dd41d7-0bd0-4c38-aaf3-c68b3209f46b@web.de>
Date: Sat, 30 Nov 2024 10:06:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [01/11] coccinelle: Add script to reorder capable() calls
To: Victor Gambier <victor.gambier@inria.fr>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, cocci@inria.fr
References: <20241125104011.36552-1-cgoettsche@seltendoof.de>
 <20241125104011.36552-11-cgoettsche@seltendoof.de>
 <b30c7227-c596-4980-aa46-a75b1d429354@web.de>
 <667e5848-a8e4-4308-a464-006800039029@inria.fr>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgoettsche@seltendoof.de>,
 LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>,
 Serge Hallyn <serge@hallyn.com>
In-Reply-To: <667e5848-a8e4-4308-a464-006800039029@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:srVKkclM4O0bE293ZCMRz8INZsxhExnVXDBpD386uF0bQaeHsc6
 99l9nbI3AYUJxz6sJPK4LWb9tmseRHEVdvS9jN8FyqfN6PWgr+u/xOEDWe9W3OQYeVI70V1
 UEfs1wQox6vc2I0bCQi/KQegp8jMsXsDCZHk4a8FzRtmdTA2HnpaDKdYvSKu5S6cVL5u7J2
 dOf2GXcTl2UZ1Iya2eo8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PfjgmX8EOI8=;cyofF5wjBKdHn81m0/JDe9DKGLA
 hX1ca9dCR8N2EulZZyzekl7R8J6nNVZ1Xexl0VbYI+D0cxY7uz6qLi+5lDanjQyhb+pT0hs6H
 mw/W+laR37PfvLUO6fMJedkrDnzkwap5obXSlGsy4xBJQ1QoWK/a3pVg+gtGv4UakCThk704J
 1J9yGhrL+dkBh+qMdtyNaHK2lUWMcHtHtEw+7icwKFYe6ywGBCIjHmXDG1QZPGFmijGHf4lI+
 38VfeH/utxkFS1QlY5LOO+TaLo1itnsO6cjMm6kRHECjjcTWQFDrTWruHYq+ebi+K1j/VCdMS
 qTyX2d3tbvEbcDHPFjsV6WkWTttrSELG9jGai5YY5BUKK6F7yz87rI/WapT03gQyQJpKP2aXx
 c3JeWa76YIdRoYLg2TRLioZs/vJvSlH3KOkku9gm6LwcTPezojsDgHSaIvZ/+ctsnNhj+fSIh
 uK9VveYd4zvV2vykb1iJKY0OofNeD3x8fDDaaJuUV1AwpvfNeWgc+7OZHxQCcMsg7A5ROp2pA
 uX6sjHof+N06bkMAKUff1AHLQ33wFK+Qn6ng2jM9FZnZzpXpTe/LwGBGUGGUTlF3qc1jhykME
 biGyBSxAY6OiQYkcpzDPLhn4qFqR4AaM37ENPbzuIH4E3MnUaaRfSBMALK02SaJHtK6wdPCvu
 t+6C0SDzcruNzV+so6xLZiM3U3YEzvkW7gl6fmLN0gigBC2JBuAAiHgEEcMD7qAgA3QEG3fUQ
 9wM7mF525CO/lMsJL8bM4OHVox3i7lUAeQYCr9s0VhwYaG7U7vP5E+zkd4Qb6rIll5LXameNq
 ES1HXKBpcGhC+YbIC4qwMShb4rnHO3pWwxukOXun7sUK/RKAlXyUdJHucEAXNugxG/+DN0QaY
 9inFvHwtplVRGIc8Ggnr9wNuRh3DxiAmhSRxVhvqg/KjnfM4BBdYPGWJ2qvWNCWt0nuj6u1Lq
 vQoUTja7OA4zrLHk7sgx8mlNC4U1nZXniFsMHdHq9AROjuqlm2bHSUsd6aJ3/e/SUDo89oGVA
 GpTmsH+7EJAiHLkQD+/bUewowt7CUTO7qwNrQpgSHBya1WVTzZ+yo+TyCXFS41ycImOyuUqsj
 MvBTa5MyQ=

> =E2=80=A6, his questions don't make a ton of sense.

Would you still like to clarify mentioned software implementation details =
anyhow?

Can the willingness grow to achieve a better understanding for algorithmic=
 properties?

Regards,
Markus

