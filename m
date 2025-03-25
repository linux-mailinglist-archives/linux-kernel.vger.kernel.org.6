Return-Path: <linux-kernel+bounces-576068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0206EA70AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 820907A7A6A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFA91EEA34;
	Tue, 25 Mar 2025 19:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oqhfabVN"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1509198851
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931649; cv=none; b=TpckW7Xyh8h/8q51QGiJf3XKd4hotgZk+qPrEouYw6/0DdATq608A1IBdAZwqH4rFQrKcUpbpBMqSRnZYaEblxETiYmLnLbfeOVd1cigM/1wzkK7bkWYP5iNWd+dbplQnnZuw2eqkqa132l9DlbGWi9Z6rq1UTV7mMzR+Ll+KFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931649; c=relaxed/simple;
	bh=MUK3eOY2D/KmMRtrOOOx7NdkICr7244cBlfFLWGWFEc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DYTYRwAIFR0n6nyHG9HGem74A97n4Ek/2I8kU63OuCa6fyaJmZggNvTEz0hzR0yd+KmEd80Id9Y2ZZ7CthtdRQnA41ClGqq24vU+qy3U+VBoWtYHTeKOx5TZLO+3/LzdgfNGSRKNwmzWzVw0/ZFnfJNwvxzUNjpX2PbVGgJUOVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=oqhfabVN; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1742931633; x=1743536433; i=markus.elfring@web.de;
	bh=MUK3eOY2D/KmMRtrOOOx7NdkICr7244cBlfFLWGWFEc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oqhfabVNARFH29r2ecI/pNSIltbvM67/UER6jddeIq0rlSDwzooejt5+7UoG0ZiG
	 sLb7AZO4U84Wiv9NfXLPJB1heLdFa2nI7QGUvAO2fN2J6Azybc1JQ3lJzFXkHCzeP
	 MopQrctiqKju4eX2wtgbhPKSNyEzQtqceYDl4Ev23zgz3SBAdaRMW7MTisa18WJmM
	 ka/Wihz1IiVJchtNEdr3X9g+zWBuWW88xAzKtp7ncRPEMFZka24Dqnn0PPTcNLVhH
	 8W0dj642ZoDKzeNYHdrxkuEWL7LMIb+Osugl6CZYcUxq836M19caPHJ1e2j7XO9Gw
	 LpXqgY+Umtokb+eUgg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.33]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgNU-1tsGJ92I8A-00E1qR; Tue, 25
 Mar 2025 20:40:33 +0100
Message-ID: <a873663d-21f1-49ec-a8aa-fb3297413e02@web.de>
Date: Tue, 25 Mar 2025 20:40:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ye Liu <liuye@kylinos.cn>, linux-mm@kvack.org
Cc: Ye Liu <ye.liu@linux.dev>, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>
References: <20250321062053.607044-1-ye.liu@linux.dev>
Subject: Re: [PATCH v2] mm/page_alloc: Consolidate unlikely handling in
 page_expected_state
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250321062053.607044-1-ye.liu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UgEk1ORp0/i+uMTKzIfCmrtKxA0juMUwUWsfNAlNmVynz3rC5VF
 1ibT6D6uso66A4PGADZPx/QitnDgjL+bT0K+gqSumRg/TKW2RAFFceX+jKQoDucOG5tRUxI
 C9d3ynTsk6Gt5F7cNnAmUzNWm9j2P4LJvOnT9CznnnqCoHliyzipxzMJBgj8r2uxwbY7G+o
 KjIO0nbyS2yCgNsX2Ph/A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LCOPm7V5d7I=;roML/cMHZWNSlaNAMzdXmsfSmq6
 mMtzmoL/9MQYtxXgSwjaeNwz6t3Dv5Z4yDDARekc1jXcpIqahNSBCCoctIhzymu0d+gNwLzJv
 6ylKjcrTNLGH++KZBkc00wvsWZb4lrBes0iWTZhDCmpJ6jATc0Bn32mkRNIig10oaliTaH7rY
 HMFpD/dfNgVI1D5pvBg9ck14L3AAiRNIPsvy4LpVfKzHYhHXK488kZPuWAJ3XUdAQ3yup19yl
 Cvul1I5IosIFPw2L2yWuqMCOxY3jk9XRSASlhD2nfSV88rm2YsEfJs9fPMv9rsXU4B7bxFo7e
 VD7LSZ33BweJXtsIjAEZH4VIfjXLVGLC6dLK+SGm6xAzCX2kX4+I3y/zqihZ2A8v8yMllchcj
 5zNLDHFyQC23HuKyE+FMGlM7mEJD0beEsH2QxyHdsvvoBvUEXqIN1rQn9BQWB9STeRa4hNUBM
 JLkegkVT1TYZJLaoWBrAvgIMcxNaWzbTr52PIWDsYmFhLeOpzSNLT8rD+cVw6WU0z+yFH9YHz
 gZZPtqT8RENCYn5dQ4mUSLDhXA9oT9CRrvc1Lttk2OrVkkE+NQXXwMBe85IVBgVRyM5Qq3CtU
 FDo1FvGlU50l8++Ate84W5yEWXPXVeMjPRfBdc0F8nIu5RfmBP+6VbuFt0RON+Xpva7m3doqR
 CLTjcOckJkyPu3mOJyCueiK+Hm4JBOIBqiFAzUmaoGJve5E71cpd8Ya922UiuMsEgjW9H32UC
 pDiy7r3vOMrmuyw5BN4PCUihnvExqgEmnKgvDelaY/mJTg7sy8p0kq0toLJJf97DjW8Ykxst0
 dAp0L8J6g18PmOxsFKT8P4gebR5fIjUDt+lh4iwuvotRKa8Y/xxPwiJFDqQg6W2Q6cb0tTSKc
 CdgnfcQCR15ICTkX+O4/gXBuktAXSTgWx96MCOhfe5mnZ9o6fST5HX0+LapR2Qj4E8nJXzcEw
 FtLXLsiQjhc2KFgec1MJZT2D22Md66NfDof5iozNsdMsU3eChSGtvOdiOIxpaY39qI6TB0Bwb
 IxKgBGDZfMn4vkaLQMrYijvSYs1KanFZVV2RPUJOzB9uvyurbHs2jR7+monMKvS2jIZUE+tjG
 RSYZyiITd5S1GUOO1YRmX+01pBT91VIGxcN2ElRMCT1P3L7VvLjjeM6c5vvf6yiFGzLQl9FLQ
 sM3agOz3aLpkqgfZ5w85ktHj6A1Kv4DjqwckX1BzK9yNDQwpA069m39NK662MrhFG+rSzxNAd
 QTUWzYV15XANN/E8vznbADmHG+PEN4AskXuL71ayUbw61m785X7gb26r1m+aINLjbgbO+/v6W
 tdnUYGUz+eiIM0HNZErACLrJI822AzcA/4Nyz6DtZ0MdMXivAf/Akqkon31GzECquGKRWu3RH
 vgosZQ1WLFxOunX1ETLNIt71u707RqDgNUKgWG9UDvwBh+t+jsIWZhUW8vMTlEBDHpE/TTsbA
 x2Qn5JboegAo9Jw4bg9RvEmaAL5XA6qKoeyBQPj9vYUVMPMgb

> This patch consolidates the handling of =E2=80=A6

See also:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.14#n94

Regards,
Markus

