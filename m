Return-Path: <linux-kernel+bounces-168648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D458BBB65
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E180C282B1B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E247122F0A;
	Sat,  4 May 2024 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LBWlm1z+"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D038F6D;
	Sat,  4 May 2024 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714826083; cv=none; b=W+whtp+z59pdbYCmPOIDBdUHXnNbz43CdMRR5jMMTO3hdaMx3AF096Y5HIbNPyiLlZy/RbrMaFIsaYXUnxM5TVCg6HXEYXBE9P3X7igQlK+EklJ85XyLlZrCw5YnOHevVpO3w5/mq7yHa/RYQ/NifalcKTPFkELTZkJdNK75fEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714826083; c=relaxed/simple;
	bh=Yoe79Eg/PZgOm5Mey4BVO1eNMWWZbUND/eB3W2VBhP8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=o5WTWhdbmtEJaUNKfwoePOiUVTUX831bxgJMeYOM81qhunzvx8vlxMxX+PeX6ioJ40G7ZnCsVqfsPu/M1zL5aBPAkWFab/CudkID2SuYiQOLaGWvkW6mPwjKAje7YVrtmXkv5HB2x5JKv9nghLCqeUvm/tkLqprYcTexQP42TEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LBWlm1z+; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1714826050; x=1715430850; i=markus.elfring@web.de;
	bh=Dw0wxRu3LYsn0DKAaT4XAl0e0WxvZkPx1TNVOzFQ9z4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LBWlm1z+TprBHaq4hs79isSLqS/7ZZKPiUAyhPGMUmrLBvgIPqJYiXvDb/4M9aDo
	 I0LlL/JqCBK1Jc5PI+nf6d3Z/a4Di3++4FMhidtA14SPfnyrQzV4Y2VtM/p5kBohW
	 Q62yhVaGcxUJUAjPaR/xVWgQJKz4z0X8SZySOeZ7+ZeV4uHASE+9u8x472MiUDPzm
	 ysTC/8rjbHe3wdFEuRKlI2umwgDTTO59xikSXGKgeGmzyOBvB+bQy+Fuf1x4E2NHr
	 8HkDKrKI+ct06Fj1eFMq7WqfMauVukbHZZBfqeXz2ZiXf3DnoEwvA2h1m/VM2kS11
	 1Ex4y/2O5vD21YkTJA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MkVsa-1sUHQC0gOs-00kLda; Sat, 04
 May 2024 14:34:10 +0200
Message-ID: <182b7a9d-73f7-4529-b053-463eb3684c3f@web.de>
Date: Sat, 4 May 2024 14:34:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Levi Yun <ppbuk5246@gmail.com>, kernel-janitors@vger.kernel.org,
 Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Juri Lelli <juri.lelli@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan
 <surenb@google.com>, Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240226211237.48415-1-ppbuk5246@gmail.com>
Subject: Re: [PATCH v2] psi: Fix avg trigger being fired unexpectedly.
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240226211237.48415-1-ppbuk5246@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rbevdbydq7HBhBf18M2b49EYFp3SFfcSm82k3YedcewesMYIJFA
 bA0cfw5Nwvcmwl8PVRIcVDOBkGehMObENLRnOtVdB0GeiOpFLnqJPFYLV4+WUn6OsWKgp5i
 Ei3gh6pE+54goZDG4vyeckTFocPCcitbiSGoRwG8a+5SDcwVtSx+2hDP43K15Dkwy67c0LK
 46gF6tkwZq74qWU5y+Xpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:di5ere2P8Pw=;Jtoe6CFNxGvFyXGjU+gQK4mcbUy
 OK+75fDBaCYatvTn0ly7SlBYmqKxCW1WS8j1hy/tZ1wS/wMxdG6/2TkFJijNHYntd0ewK4Ta7
 mt2RFAnXXPGPJ8EFP1/G3sN4dPSOPRDrVW7m7/xl1BZw8yT/dKaiPdGRmrIa0ENc2PVg3O+OA
 0RjyEFR55HU9+4R51rCTsycWkFQzlApJ/c6LrXL4u+z9EKA04ah/+VvKpUsNhv8aLSvTVzOp3
 xEzXtV36J8dTV2TULz1954CAjC2DTA0t2TE78jcLC71f2czJh14gD/AIqm9o2vNnP50MCSkre
 1KABePaUvHEJx8fL/mzyH8jE+E08id8ZxDJDElYC56xB0kn5f8Z3DXrJ1fhy+uMVb0gDdQVT9
 3X16oSR7O1WBdy2d3kzt0349esNYW3PBgQ64aCm3orlGvnkXzcYLV1K19aTjxQxSRsVixh6Lz
 SRt+xYM8ZFJg79qs2K1x7J1b7tP0ZpS7SXfvxreODu0xJQ9Z7L42f6NFZ1uRGi1ehU4Ba9cPh
 EHRr8sx7qoJmDe6HmNT4/AsssLueBQEmjeWNqsjDbYGjIN8ugg970UKawnqL2gYeiul64Y9st
 wqhsGuQrvGebEFdrbVtkFvOAACJwYamNWQUHBQ8tWkzqcxf6vXEUEmjn6MNhizwUo4k26QiwO
 IOzWPKLugD4Cgrb3Ej28uy1zCZ+n0Jv7efjXnOWHQLEVtqxHNG0zwwQBf/WOhzoWKbeoFNKfw
 sMREHfuufTkwwDq3tTNjS8TL4J5bueFyyVjRJ7datzWfSi0uyxYz4nShi34hMVbBBn1q74Abg
 0P/424JN2UP9wuD+LztZVu5OWbs/qlbV/LuZ4cnjOuwwUpYCem602sTzUprwI9yZDr

=E2=80=A6
> But, for PSI_AVGS, win->value should be initialized with group->total[PS=
I_AVGS].
> Moreover, to get exact initial value for win->value, it should be set
> under each trigger lock to avoid concurrent changes to group->total[].
=E2=80=A6
>  kernel/sched/psi.c | 8 +++++---
=E2=80=A6

* Can imperative wordings be desirable for such a change description?

* Is there a need to perform proposed adjustments as separate update steps=
?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.9-rc6#n81

* Would you like to add the tag =E2=80=9CFixes=E2=80=9D accordingly?


Regards,
Markus

