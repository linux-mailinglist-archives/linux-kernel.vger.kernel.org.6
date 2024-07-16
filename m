Return-Path: <linux-kernel+bounces-254100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51256932EDA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D182848AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C0719E809;
	Tue, 16 Jul 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="u02CQzIM"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF138F86;
	Tue, 16 Jul 2024 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149588; cv=none; b=Aay+4INVRY3TqLdfGCejP+qnKdlZin65rBGG35/szB6lc5ZVYgBjr3ABKhUt7v53JUf1ztly0XRJF3ClAw7fVjhkYDaQFr4kkAxikmI+1M24vwKgnfjqnFkoKpc40Gpvyms9kUUcDVyZDmsoESJOJIm/4zpZHuchlWHcdSHdhBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149588; c=relaxed/simple;
	bh=CTFLJ1tFOpCdo6Z+uUOeq2NaqEQdFeHdHEFbaGqKoXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riPAzWr7KY9SFbt8rkARG3sugRUtX8GIKlJgmy+/I1vjLJOMi75t4qYz9GMk1dT+raux/EdkV2swAiH9oFQCUMawOD3UQ7XdSCFt2j0mgiiBPzZhEXs27rKCnEqhqEYXzcqf797D9BRQh9IXsAQFDgKHcj30q+QqfbTrFNjFhZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=u02CQzIM; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721149571; x=1721754371; i=markus.elfring@web.de;
	bh=WI2HQO09kTzqMlteA5rHfvcpuDHcyI2lVAEZTKhhHMY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=u02CQzIMH45HPETAUci9UtBD1e2BTOdfqnrSnn+RcvfWZdSVfrfy/U4m8LiYlXQs
	 I7CWZxtrr4LeCbITqEvLE2t2OJAa21QOKWs92Y8GTTkIc++Ik2GDyVrejEE8E2BW/
	 wTJgIf9RCF5hLHfGBZCfuVOotvxp3M5g4Fo/v8vbsHzKxfb8sQQwF55d1+VhJrsE9
	 UjovZ0GGDmrhyy7Cbb6tdlixQWMySv5Kbx5BNCowq04QUC44svBVEdXqFuyW3XF4M
	 eeMBEe8teit4hYWP4n+6hh4S/CLvEpD6Nv2zbcYAN24z1MRDIYAUyP/T02VdoHAtQ
	 JAWk44L+cvydP6Z8Gw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCogm-1scX4N0qsy-005vFu; Tue, 16
 Jul 2024 19:06:11 +0200
Message-ID: <a1b7f067-efa9-4550-8351-8923a71826fa@web.de>
Date: Tue, 16 Jul 2024 19:06:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: latencytop: Use seq_putc() in lstats_show()
To: Joel Granados <j.granados@samsung.com>, kernel-janitors@vger.kernel.org,
 cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>,
 Arjan van de Ven <arjan@linux.intel.com>
References: <CGME20240714100031eucas1p16b701d3e5852ccb40305a73bdb2a2759@eucas1p1.samsung.com>
 <19c77c4d-7f81-4980-a124-d6a8e14675d9@web.de>
 <20240716154520.vtlqv4jxlihy2h7r@joelS2.panther.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240716154520.vtlqv4jxlihy2h7r@joelS2.panther.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WyOQD+X28tCW/Qvf/kz9Vcqc4NhLzMy2C6g9lKCntQYd/eB80w1
 Xn8r1xtVsBUAbkejg3ujC0EMUq+5695j3IXVujwrVsncQfFrw9eqMIpKM46Q3Gy1rwH17KQ
 aBbbOc9pQA9QeGK1X1Ct8uf5TF3pSFDSN+udZeuVtfhmu1cZPA16P+RxOacwDn1jRlqTygP
 vh/mIOrGJEoMUkkmGgHaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W6zPfW2N2Xs=;5msfO3uVbffYFwXCu2wubJVgo/4
 ohjGFfS3vsqUfN2/Icw6YZLcVlMumvDAtwaCQALWzFoqPCQoqrLlzoDJJeZL0qdbl2osHBILZ
 G4+uuBw6gVNBEvS223mcNAjMjgCv5/Wcxlf6k0fkJ+/41lv6AmALk/I7D3IjCQShuctYlLw7o
 InYZ+z7nSm2TphoTBHDFnAievoE8piDVChC9p0nzfAbDcMtvrDr87danEs1cyBs3+jY9TvISa
 NQbLRJpW3NxsIsssGAdAKRRZAzqAAVE+lNh+facbo2+vYy4DAikyHVSUeDforurd5vivN9CUK
 Md1edlpwZLJEIQbb6YQwkVjpMldOgi31/yGB8mW9RY3i6G6nULP0HGKOwICegu20gOPoHdv4f
 A9M69nv1n7fQOeeKlCV0lZzHZhRaipgpQqelEjYe63xMtLnJF+2kKy1uT8cG6DgB0zzgxuKF2
 k03rNeuu2GkyTbx9XkiqgkICz+X5U3Ad8YrK6pVtryLYqDnI0ohP0ckmk5xGbMrqDcHQDlNAC
 UZsh+/zj2EwogMtkoW6PyAyqiOPo5HCyFY+inzpq8jUTEBboM7rhW5evtbrWKQ1lE+SSIKUao
 7SPk6JjzgIwv/G3fv4TBLfPlQfXSz0QEghOklxx/5A/1tCZAwlI+yHy8y+OvrkDBdLWLALEd9
 WvBUe8dWcD9NgGhYajXga9wVDsc3K1N/JwLI9U4K1hG0DpN6S/xHWjss3ipyB4tDy6/YrUt6D
 3QOwvnC6kw8CStUqTNT7Z+rJoKDYnOI9G4N37zEaJlRKBkrqnCPytk4xmo/gDduV+/eZLpLhd
 KoxT0a8sCqgViMEJC1xdqi4w==

> Not sure why this got forwarded to me.

The script =E2=80=9Cget_maintainer.pl=E2=80=9D pointed your recent contrib=
ution out.


>> A single line break should be put into a sequence.
>> Thus use the corresponding function =E2=80=9Cseq_putc=E2=80=9D.
>>
>> This issue was transformed by using the Coccinelle software.
>
> A couple of comments while I'm here:
> * The "why" is not clear; please clarify why a single line break should
>   be put into a sequence.

This is a desired data processing effect here.
https://elixir.bootlin.com/linux/v6.10/source/kernel/latencytop.c#L263


> * I don't think that a one liner merits the "coccinelle" comment.
>   However, if you *really* think it should be there, please add more
>   information, like the conccinell script.

I would appreciate if another SmPL script can eventually be integrated
for the coccicheck tool.

Regards,
Markus

