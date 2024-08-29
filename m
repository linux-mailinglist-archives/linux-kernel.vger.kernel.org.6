Return-Path: <linux-kernel+bounces-306219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B21CF963B60
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C11228640A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475801547F5;
	Thu, 29 Aug 2024 06:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BbD8ahth"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD36214F9DD;
	Thu, 29 Aug 2024 06:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912761; cv=none; b=cM2NGxBOXS6P95FQU/WQqD5Vd7P/D6jJV4UVWmohe4YNpgoE2YAHYr0iMW0L8OfpIMmmZlXRiN/vsKD7r6aHVDqwgU/aFRyivtLM4ml7AgxqD93YlKP8T1JZc0qt91eZGMrr8LPe6SjRGvnwmFQ7KI1Qg4t5wUhOhQZdM0XjoKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912761; c=relaxed/simple;
	bh=XX5yiFG40Vu0EaajbD7Aharb11NO9doEpS4fEzZSC+0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=vGDe5s2quo0paeJMlmhjStPYE2ybdtdGCc2JiRbbTZgQ/fvf8Hg0DwpvH2ZVeG+xiah1ervJq0Tczkji0EAdw2Zxd73K0DRbBU1KoG19e3s3SywgdAj7nuiK9bxoOZyBXsd4G36fA4QwWpci6NEzkFmBY95rkCgJcqFm2RtALIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=BbD8ahth; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1724912747; x=1725517547; i=markus.elfring@web.de;
	bh=HIW23CZzXcXcZJuHDzldiRyWNruWFM0jw+ALZdzsRJI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BbD8ahthxTdDh4iOqi8w/69UdP4aQ3VREJnUDlX559vTevgUEVJAQTx84crfsPdL
	 5WXY1eRSBtLBg7ZojoWecyD9BEK0m3cojOgVT0C65by4pH9CSdmdgPqeOZpve1k1v
	 VMRRU+2CfFIxqlE3R7rE3uxemmwo7LqiffgM48qU1u20TGwFZEgWKbwB1FyYOxgEk
	 GEXnye9JIUHOG8ym6+beQsFXAOwxVCnxG5pvtgQEfFxd0lSFUFJDx4812LIcjM7x+
	 dWTR8UcfF0lGQVlOHicRyHc2hOoutZwEcQZu7H+U+jYS2QnERLyWqcvZ9HRCJcFhR
	 uqUkxnQLfspi6WoDVQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4eCL-1s3iyj3rbr-00xbLA; Thu, 29
 Aug 2024 08:25:46 +0200
Message-ID: <716f7466-562d-4bbe-a8ec-851a0b289db5@web.de>
Date: Thu, 29 Aug 2024 08:25:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, linux-mm@kvack.org,
 kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240829055621.3890-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH] tools/mm: Use calloc and check the potential memory
 allocation failure
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240829055621.3890-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9prvbxVevokm958741Min2OcUnei7T7YdduuG/Xc3BV5BGBfg0C
 ye1/tUbYLxKdBNxgR5QsRpuCSa0aRX1EYjfreae41IPQXqCQTaRVVfVfoDxX781dytZkZCM
 2SEKZfQ9/MtsjxNE0WMJJyW/acU4wb6orZWb0uAEyCEQZxCgxT4lSHACHjA2Zbiad10e/kN
 H+bXBLSVVAJKcXqllkh6Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HRznMeMAbUg=;dGwIw0IeJ/A+SqIhr7kg9ecNdjU
 kqH1WmdGyjmsTEYp0Y0UNuh83lB0H1KhzRG6DKahpqziFNRqaXk9IXdg7l4tRUH8qDz9gL5ou
 pWLYhZuWi137xuU7dIurc8NlFdU3LFbbulSc+FAyrcIvvbhPvlL/WXq3hK3eOmk4Tkpquy2Pl
 16TyKaVkq8YtfLxsKUfqgZl1YTf5bumjgP3NfPuvxWGJtsBYJ6AZIuSj0yPn7+0mdDHXQIFRV
 uhdLTKgz+qI1EuIyj8kAprTnfW6jF34Zl3RSV+m3xFvHM6aH3CBf0fWY47Yi7EDefsdMHH69P
 1WR2VlTSeW/0IyotHM5uzg2UrdrUqhxOkM1xxIpaOqu8WwJOUa9NEvywCa+Cyf0bwNwYJEhDK
 XG1/1vX5tTN+QNcEBwqlLr8FBseQ256BLvGuAjflYQ5KJ14g7sP7PAyGRyTvGcYRyYOHZBteg
 CLwCd1F6YYCq8M27amplH55myXzzFnY3EaPiKnX76atuaoXNxDebfBDGuOJ9xn3OzazeMpqIh
 1XUUW84qmtaGQvmv+cbtktVBP49xs7Sk00wpxf7xAcgT4NiIq3w9AcFzNh/ex7lK6WDr5NMnX
 u1t+Ts6VJDHo+QKkmpx+y2rx81P+rHVb+Z2X46JvNgiC7yH6Afq5YWSaEIL3G18DoNTsDiiej
 1PghmRF+6QBJSqZLkbHVpw7EmM08jpWORf6Kr9dzH1GBBRHA9dpeGbEkqBf+TAcooEY93KLaI
 2gFOpZQLoAoKD0JVmZHQXfQxAqpKCiHGGvMB3JpW0nejNnzAwMS0CtUlqweOmco8IOGNXGIP1
 CfrGV3XxN+i0YgyGtwnfij+Q==

> Replace malloc with calloc and add memory allocating check

                      memset(=E2=80=A6, 0, =E2=80=A6) call by calloc()?


> of comm_str before used.

* Add also a null pointer check for the detection of a memory allocation f=
ailure.

* Would you like to improve such a change description another bit
  (with tags like =E2=80=9CFixes=E2=80=9D and =E2=80=9CCc=E2=80=9D)?

* How do you think about to omit the statement =E2=80=9Cfprintf(stderr, "O=
ut of memory\n");=E2=80=9D?

* I suggest to omit the word =E2=80=9Cpotential=E2=80=9D from the summary =
phrase.


Regards,
Markus

