Return-Path: <linux-kernel+bounces-267609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764B4941351
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13F48B254FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BD819F49B;
	Tue, 30 Jul 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BiMLWoPx"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D559F173;
	Tue, 30 Jul 2024 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346800; cv=none; b=JL2XYDCag0G1K5GfKUwgYcIthJoBmmnZcdGjIlZtFBr0qItAkIeuGsnxFje7ymw7aflM+xPlhKUaPtDirwISt6vsWKywzGXZ8nVVrfBAufKGwbtSy1OFerW2Tb+JZYADG38dFqTWYqcRrR+10CyVA7L803mSrY2qSwlq2rL7s9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346800; c=relaxed/simple;
	bh=4nssHIClDOrnnlbs0R9PN8Dpeh0f1bXJCOiVOkPfKxw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gDCyxnfYtahQoi3hYOsVw7lZ13035TUCPCM2qrlmNGQUE/4Pn0XxXnzAifilpcS5S6G81jSinxaCvw+7g4x163lNquioyxlwuOL/zAxXxy6zc8qWdMG/q4KsYGFA02cOIhucJq+LAB4KD75AHCdEnBjQAwfYvImaPFV5dPLiJqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BiMLWoPx; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C36DD418B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1722346797; bh=t3xQTjQMtPV5q2WQttbnSWnpfI6/6L7980+XxxM/nWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BiMLWoPxrZewnpF1c290GauTKXdA0WQ/1iZnxqFLysui48OfTFzNUTtgU3KrADIqs
	 exEwzPP36uwM4TXj8utLzHpXnbdfOu6nXZq00oUYeFp7ZJCHyZViWFwFFb7qbKA27u
	 +uFgTo3e7jFCTM3JRVE73VdU/ZqktsjEYB4HBdpwZ6iFQDt9Hkt9aVev/iWDNUId0P
	 8T8RXr8hOLWiJN8Fxf0fIqdDHz0CuXJMMKlXZMc9VaKA6K9aj9LmSV7chI3USZ3h+s
	 c/8qu/4scOscSfjVI9+eu1GPfucwlFl8O2SmbskyQrkMgwHabtbYJP8hiMiCMmZggm
	 P9Acms5i0jqqQ==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C36DD418B2;
	Tue, 30 Jul 2024 13:39:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <mudongliangabcd@gmail.com>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, chengziqiu@hust.edu.cn, Alex Shi
 <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] doc-guide: add help documentation
 checktransupdate.rst
In-Reply-To: <CAD-N9QUi58tO61usRakxJUY063+=51FPSeXPvTaRXgMnOUR_2Q@mail.gmail.com>
References: <20240719041400.3909775-1-dzm91@hust.edu.cn>
 <20240719041400.3909775-3-dzm91@hust.edu.cn>
 <87o76f98lr.fsf@trenco.lwn.net>
 <CAD-N9QUi58tO61usRakxJUY063+=51FPSeXPvTaRXgMnOUR_2Q@mail.gmail.com>
Date: Tue, 30 Jul 2024 07:39:56 -0600
Message-ID: <87frrr80cz.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <mudongliangabcd@gmail.com> writes:

>> ...lacks a title, so it renders strangely and inserts inscrutable stuff
>> into the doc-guide index.  I have fixed this, but I am not entirely
>> happy about that; this is a problem you should have seen immediately by
>> looking at the rendered version of your new document.  *Please* be a bit
>> more careful in the future.
>
> Hi jon,
>
> If I understand correctly, you mean there should be "==========" under
> the sentence "Check translate update". This would generate a title,
> right?
>
> Unfortunately, the "==========" is asked to be deleted in the v2
> patch. I doubted it, but did not make it back.

If somebody asked for that, they were wrong; I didn't see that.

> BTW, the merged commit version has the title - "How it works", other
> than "Check translate update".

That is just the problem I thought I had fixed; somehow my change got
lost on the way into git.  Oops.  I think maybe I'll just rebase the
tree and fix both of the problems at the source.

jon

