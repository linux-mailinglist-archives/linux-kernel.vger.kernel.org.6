Return-Path: <linux-kernel+bounces-168945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B728BC008
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 12:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93DA81C208FB
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3D4BA45;
	Sun,  5 May 2024 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="DIeLuyK+"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C814B66F;
	Sun,  5 May 2024 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714904659; cv=none; b=NWkE4dmdwuH20DUH8qP/CQznis5MURdutdADHXoFoBdK9nhP4PrzNWg9a0lktY77mhadPIXKtkK4fC/F0kPQQsRCD3/M7fC/atzuGUm+CmKz6PQ92R1KJn9tyJN8+JmhGxlsWuUj9TnT1L63eLqb2fXqOMc9vX2k4v0jLahqPHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714904659; c=relaxed/simple;
	bh=krTWrmldQ9hOktxpGyHo8fR/YGfYNwVsJObJ5dbGFro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efHVWbv0243LCIVP9dAAXKB0HxbZZSG20XtAQshCkEbzhPa8d3cvO34KExEZ53cahZYROPzKY9Y+wtqhXuaNEHH7LKG4Em2ngcyzFvvDZ86a65K4wg0zOq+QTwseHLMfW5CcKftYR1bNtTDY/7A7cWpXMyjlPPKmeNXYDfx6F1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=DIeLuyK+; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714904640; x=1715509440; i=markus.elfring@web.de;
	bh=krTWrmldQ9hOktxpGyHo8fR/YGfYNwVsJObJ5dbGFro=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DIeLuyK+QCNfAEghChMwrOp+o/4CZ+/XPgqzKs+Sk+J6cOOSWZgKOeEh3k1jAfIe
	 STOeAYE35Eg5CdC9lEPoy3/ziJA2tLs8GqCaBuulO+ZWpTPRJJaWm84tnhMbE7Xgi
	 bv6FUChjWbG6O8MSnsqEr7+bVpH46QYEJ2PdlrV0/3Bt/CBc6rojd5JVxjKF5WW7+
	 ufav35TIh8kjKkGSOFqXrF2fmYQmUVBVdO3sARIfazGIlA7ok0wcx0lLSKkQr4EbN
	 afIFBlrHYav+IceTPMk+vWBrHF+hnMIwXYPHQtp576s1j6CBSiZEqCyU/UQfxdLS9
	 D6IU8vctnpUHNRhCdw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXXRF-1s8Anv2iSN-00XNA7; Sun, 05
 May 2024 12:24:00 +0200
Message-ID: <49994298-fefc-447b-a074-c6c91f8e5ca9@web.de>
Date: Sun, 5 May 2024 12:23:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] time/timgr: Fix wrong reference when level 0 group
 allocation failed
To: Levi Yun <ppbuk5246@gmail.com>, kernel-janitors@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240501195116.62669-1-ppbuk5246@gmail.com>
 <20240505085709.82688-1-ppbuk5246@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240505085709.82688-1-ppbuk5246@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GvLWzrw9r8AKC0L7sIhMcKF7LOng8CO/cP0UN6Yw4m7v3YyMoip
 pFM+9004v1BTv8kct7/GlHp3C7gVW5cIXeEo1cuSLdSjlxC/ULPclA8kdPYVEgCOALbVTIM
 N4Ptgo/FFsS+CixJgzioCcHxLwMGJkUrY4XJVEa/bcdQDMZMZBD/DwY8+hIvyWhO9ZJTF+p
 KcGI7dxtw1bI6LBIhm9TA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OaNKdLpxgE0=;02+G7YloTW1SHi3V81iLEnVVklR
 ziBaNpvBI2PJSyU4etnU5LkDXKjACCJlEuow+vrW3SsVHeHx1pGRU9rZyraxA+U4RMWOSkUcD
 tAw1hfymQ4Cun07cwMqRrOWyAERKw1C0oIPv13+AbzHjl75c75sTB1YyvHPs6TCBcJeLdR6t3
 0RQXIIvZeImehNDzL6OyjAYH1FjISJiWPDycDkmCCZpKVnf6NHfA70w1R7NSJDDcj68XrBq1S
 ogevNiUT6Akt+tgxiRmfQukauhEUv7UFsVmkwszH/G0Ip/fn6hFmEZqXrumkBdyZys0p8TvW3
 OC1twOxPYQnDZUtpd8a6erPa0VgiaFw465u9HQFUHqdJlDdLyWxCDj2q+EkQYnkkvqudPJTts
 ZU6rSodfgGikF6zKAQ6YereKHEOwxlrYbDgujbeTy3tRZsfbDf+XO9/emtOqm/xAaaDtgc2dj
 A2SgFUrmhmCrH+DSKQwXaoln3qs7lZTAMB3I8GvZrrB9qMmZvxx8D37+LurIXfHKh0/Qau5Vc
 Lfsw3KzWq6eaoJ2VJGcYEuQPbQyU8h/16v4OzVn7/MJjfnqJeJeqZn6I5cZg69GOwylP9Yl6C
 r8wKaIpPuKmYNo/Ppqy1INa7a9WT4BbByG7K6ZdnaCpjzqafpTnQz2Zv8XTcciTgEJwd1VcM5
 L4SZ2x3kcyZ0e8ZcfopeZZFxMWx3VZphka+ijea3SEVqxBHR8fDsZU5hqqMcrA61nU8qO/tQx
 jfkXSCID3MfL0us5sWgAxYFLDLgodf3qKSDQysSnxcPdlqOSIm3+KB6aUelFM1eS469K/LiqN
 HW4XhC9z9nCEGV82jhhQSqYmCh9h+5Z1Q/hDRlqdlhdLRfvCxHx7TE3vbPh27u6xRp

=E2=80=A6
> To prevent this, Check loop condition first before intializing timer hie=
rarchy.
=E2=80=A6
> Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
=E2=80=A6

Does this change approach represent a subsequent patch version instead of =
a =E2=80=9CRESEND=E2=80=9D?

How do you think about to add a patch changelog accordingly?

Regards,
Markus

