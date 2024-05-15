Return-Path: <linux-kernel+bounces-179662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D86A38C62F9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 10:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CCC82840EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACABB53361;
	Wed, 15 May 2024 08:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="C6h/Jon3"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8C94E1D5;
	Wed, 15 May 2024 08:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715762480; cv=none; b=iI1qfEAwKX8MK9XjpMbmmpcL2OGoYIWRgivMrJhG/IOJ8ZZVyBEP/aFPaMVdV0Ny+zQ3uLAC/83dMoiY0052OMHVNEXl5abJSiPBSWouIl3KvUBfyxjhLxIehOuFyQj4kA2F8PkjGPvV0DwNhmgV8hFhZBkrK7afcHIkTYOwZSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715762480; c=relaxed/simple;
	bh=xKx1iBJVQyE6OY0pKYJKieZw+LeNvRWeQ9CDr99sWSc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=cjJc98eNolL7NrhUmRHnpxBNc0fAc9HqUios387uXZtp/KVWeXgzUp+i+hqm06mRxzTQD6HdNOYoM3mjMNXzfZIzglhhwGcJ0z2Bq3Q1AwoelxpWCxczH24iPORZC5YEgIZHGeyoZI/b9jDbVghI9KeG3t6ksXxJm0om/fsQxq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=C6h/Jon3; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715762444; x=1716367244; i=markus.elfring@web.de;
	bh=xKx1iBJVQyE6OY0pKYJKieZw+LeNvRWeQ9CDr99sWSc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=C6h/Jon33+0EU1N6EeDXSJy7wEm2/I1k9XKW9c/m97lfPA9h8moFiEphCdri6tGz
	 Ss/MLA2VZr/Q2A5gdWBn6m4/B73gztikDT4vLwLb5Ht0+K67GK3YGMeaJ9MfP2CjR
	 nrdQKEmBG/7CT1S1zn6XIpfsnQWz95DuZcb/v4Or+Oi7Q46X8k6U0y9yeKjvasAbU
	 3ayfggtzUkwK5hq8OeuRWFm69upuxkbCIVrM9OnwUn8xAfyQM57FH6gl01KeonGd0
	 fIxBRSOLItDyQ//zQ5Z4+rc1FBHNs8aIZmvyPa3xkIy8eXEPdZnnhSsSPpTwOl7QE
	 mUDWp74EYnIIcUVRXg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M9qcr-1sAiQo3xHZ-005v2U; Wed, 15
 May 2024 10:40:43 +0200
Message-ID: <883f3203-4881-47d7-92d8-dcee8872823f@web.de>
Date: Wed, 15 May 2024 10:40:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 kernel-janitors@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Wu Bo <bo.wu@vivo.com>
References: <20240510023906.281700-1-chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: fix to avoid racing in between read and OPU dio
 write
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240510023906.281700-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WoBp+pQNsbGtn0uCXtam8f96hQPzjewAWmYVhOx0rogxOsKmmFY
 hZEIjxz4LrRRXwBGULJvaRzdbN6xqhQB+7X/nOBvoz3pt1JEXn1cDKKR2kYEk3miK7uLBZL
 REMr5o9T+Sf6AQ3QssJiPHYNrTh/Sf7xCf3XPbVF/e5WE4UrMDZZOnPZIXBaU2hBGqh13IW
 DBEgUT/M+07m5hIM5letQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5Q+5dyLui7Q=;Pu/hzCEAK2wZaw3m44gO/txjITZ
 8ZXO/XH98YoduNOvl39j++MuPwEMlksc9/ye3idq3SywHkvN4oy4CN4Mn6gpzKPyGs464Ioak
 o9d5zFDZI3TPfKSeQL2KnoBfjtt7ExCEz4Os6fyx6HUWRlSWQRueUkohRyz5EY3c7iUjXG/0t
 Xn0vMJcSnZVLdemBzSNqhmp1ejUohp04b3O2M8uAxPhyuhOy+c31oLPHTaAKy/dMf3V47FSAz
 rgeioCrhcsdeInopYWXrP9BAi3OWhtI7eNBaVpXghidJE5ZZ/VwLRYHVQdHflOCN58aA4Yw/3
 kZJeQ3yyuAkCbQKf+3JReV+M7sSVkpzHipAaaef004o/bDIAtTfcObduJwhtt+y/v+3zFk8pR
 3ORwy/gLhVlZSQ9BIXypXmgHlhetSxRpj6v4JipmX+kKIm4M1dBUvGgN6qW5XvMZziYoWyLB9
 S4C/HsyBF+TJOPCUIecGRLy6LIQhERxH5iGvVSB3E6S5aHpEqxl87sLMSUTP5f1aC+D2FsJdZ
 6evj2iFsX0rM5PkcOKhS9eYGgmcZ6lkEuN2Aeia6tdnCH5tMGVGGAFndAFwAc94DCiLFKskMz
 NJpMuRiTykELBxPEDbYpq73CnwObaKq7HkundIFtBpc+OjgiAoC52JpxPz5WurRQ7/p1+XBE6
 uA9d7j6kRxfw1tEEwOoxzrpM0UULD3D8tq9uxiusZ1lckyTq+xMQbKFWNk2B7kKCWgXExAKTI
 AYwzFNM7q+6ecniWPCmh5PdRguGzKxyfxW0td7uTfxo0Xzf5ivAjQNYNEeQB9f7e6aLIrvEq5
 C0cB24La4Gc5FXddD/2tA582J8UBntgyPBft2WGxtjTdU=

=E2=80=A6
> This patch introduces a new =E2=80=A6

Please choose a corresponding imperative wording for an improved change de=
scription.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n94

Regards,
Markus

