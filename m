Return-Path: <linux-kernel+bounces-180351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6FC8C6D55
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 22:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E351C21F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E32D15B0EA;
	Wed, 15 May 2024 20:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="vYdauxoZ"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E745A10B;
	Wed, 15 May 2024 20:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715805429; cv=none; b=XC+sRuJtHy1Ji0oWU4We6OSXGS/rOPsO95tiU/irsnCccoeJ9npJ3/rSDQFAGiq6/gblHGet60fv97Z11ttRU1jV9iuWmGg6JE8Bo0YWYjooGqiEu1PhS1O8hFS8tTJccI8Zdf0MkCeAF2EQmK7sx9bG0hrVT9hrGbukktGqoBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715805429; c=relaxed/simple;
	bh=sdz3zA2QNS5KCDlhoi4KnGrlOMS53U2mLcRDwFndvR8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FZcf5eWBHYukahbZejF7n9B1NXjQCqYWlHTFGGyq0oMmaQJ/MBsJPv11d4zQYNKBSCH8Az3knQwsdLOj9F+9gKbrXpXO/oY4Z4/2s4ucMkA2rwqK4zQfjoKBAYPsnnGR0CvraiR6o/3VVfKUeZZIsGemCIRJc3XRd3yVzwMRnk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=vYdauxoZ; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715805425; x=1716410225; i=markus.elfring@web.de;
	bh=sdz3zA2QNS5KCDlhoi4KnGrlOMS53U2mLcRDwFndvR8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=vYdauxoZ2l0R+13LAPojHUlUNojL5xXfUB965op6QLzdaaP9fho5DU1N4hnzl13W
	 tF40NS4qcklm11RD6Juvgsr3w3hYFjcpqX+AxMZftEQyugojdC7fD41yZVo0yUCi5
	 KtdYMAlxsXafU77pDKPtcRov6qS2qxoRs1zpinHTt+iyFQ2pP1T8YS1fE2MK2asOc
	 p9Y75Se0CzwSHMzuJZH1FqSuGgdWEF9kDsocZdqS3Dj60q0bsPMCwd0HrPPj+yZVy
	 U/S8+C0QROP84+rcrf/wtM/ScUEscc1nZFRloYczdqXAhZiGnaovyQWUui7u6CYA/
	 ENiDu383iIjyrt8qBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MElV3-1sN1Pa1w5b-00GH4W; Wed, 15
 May 2024 22:31:01 +0200
Message-ID: <fe55ddf4-b86f-4d9f-aac4-373c5f2a46ac@web.de>
Date: Wed, 15 May 2024 22:30:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sui Jingfeng <sui.jingfeng@linux.dev>, dri-devel@lists.freedesktop.org,
 kernel-janitors@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Sui Jingfeng <suijingfeng@loongson.cn>
References: <20240513001243.1739336-2-sui.jingfeng@linux.dev>
Subject: Re: [PATCH 1/3] drm/loongson: Add helpers for creating subdevice
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240513001243.1739336-2-sui.jingfeng@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w0F7NCoqBz6nd2t2/BLUjMjeh0EdR38pQr4i8RHXlrv9MsVW1ym
 eqfZd01UP6inoqqkFcXgoH6gV/kkoOD3LH0MRqjuHlwCpBYBn7cicw663GLcGCNRF0rdXqT
 +hxNNKu9EN0qhOLuFCH6Fglo8Hl0YuPoOPDcD+q3Kjkx9Q5H45n8E3ubw5YIyT5LLfcIe2b
 Ib6t4olqGEvLcz9rwxHWQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hg4gcWxOf5Q=;fe9NF0WpG2V3r/gNoSHv5mNklxV
 LhtyQ55wMFVyT5w71N4HHCY5B7CgbJx0el1jc96XlFUH5fqnd4r5bPbdSYQsS1r+SAenDdycj
 BMhlqTJcTa33TQh2uYZzpEova5Pn0j8uxusvQnmYBLbR1cqLAN/4URb2OF4/uRLBZOxu7G7mw
 XDVP7yXUlOhKc/xPGhsYNuMMbF0D8jlMbT5oAdtJ7i4CUb3wUll8f8cgYaw+ZAYCRdnUQTQF7
 NET+oSzcZu2PT46SZrClxFB/0aEq3DvmSSfIaIfdjxwa9xleMlwtwCwK2oRfofd+lMrxjmjF0
 phll674F79zSr6I4+5tUPaNIIBle6mq+3BxdO1rGhgwIFtnZpKhOZE144EJ9B6Ez+T0QgnkAH
 VvGnTogvGqTjVk76ebUvDN7eAmYHuvpYck1jn1NaUDtY5a+Ec7CbLsoak9ZJG39T309LGbGou
 x2KzSIPnH9V3M7prFFQ/OIwKmLLTZZA4cbVHjaMkd49AsY6I0+244oNk3TUellL5VaUwsNkKu
 vLUZZ+vMz3+yJuASdbUcFUy+HudzUF4RWq5++exRWT8sbkNE5WhMGawICKy3Yg0yFypkBOLG/
 iF6wcrwETlaNTr4XluuxuvX6s4MaM+WF92BeZHBHppD7XD+5Xne4olnwqG6vdxoIMJqvNXqAK
 QPwZ5Od//oZH6R11XLHcVAQMar1zuV/C+JUEMZ4Ik6dpNzqI+3w0n3Ht0sZzeCW3Q32n2hBV7
 /bUIOIKuz6yDe1UEPNxxs8NHZC8Ty2WrdRnXzutpSFLsOBcox/6nSBqP6o4Jx60Y3Z13RdxwN
 BZ07MzO7fo7qo3iGlbsFL4XtmJ9yROLfqVaSxrVkf0uQ8=

> In some display subsystems, the functionality of a PCI(e) device may too
=E2=80=A6
> of the functionality into child devices can helps to achieve better
> modularity, eaiser for understand and maintain.
>
> Add the loongson_create_platform_device() function to pove the way =E2=
=80=A6

Please avoid typos in such a change description.

Regards,
Markus

