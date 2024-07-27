Return-Path: <linux-kernel+bounces-263946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA11193DD03
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 04:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E3061F23DAA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 02:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858284C9B;
	Sat, 27 Jul 2024 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fDPTF0TX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0834A05
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 02:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722046122; cv=none; b=rHaaKBw+r1NFspL0Hi0PdlekinDOkR6m2Sw2FJmMzq2NtJ0fhZPJP+F9FI2aQV4TAuWhVaj4VAAiqA/l1lYLM9h7djrHZAWARTX/xPOPzQTPk+0JKC3kj+XrUHzvUlDNaKLR0jtcuoKjPf67L579SvF2DmghBYkC1e1HvQIb3Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722046122; c=relaxed/simple;
	bh=EB8cHQVJrTeVloffs5C+C1VejYBEXLUAZYRSR1ifYIo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DNLatdjD5qWuubbCic/kW90sf2zYwshepKAUnz1+n2nY57jIuO6wsGlSmZiClVx9GUhZkJeogrB+LiEMV+E3zdP9wIooNE/hYEz5L1G/ams9V2kG8XIdwSkM/E4MQQmAYjZ9oFrmuU4EFDvE5DcZkoLckucFeOCUugwDAbi+ar8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fDPTF0TX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=EuosPWo/SMY3Ag8riJ+kOIDiKjmJxa9RY3PBvDWQSxU=; b=fDPTF0TX/T2HkQpbmD8SvDtoca
	LAkH3dE2g4a8UBqTqSdSfS9tMWNzxTge7fyCKqHlzHHpfaRvY6KzpSem8kM4IzcE9u7deXb5gkmso
	P5VA6B5KAZz83Fn3UobaRY64xRECEdP7GWkEG1bkFkbSUhHKKKsj2vJ4BzgfvTPMBQv3smJAQD8cd
	aY9zuKqzSlMnYceRoxmItnYZg4tjELfRmGbLk0x8mnvTjoCaLGcQWswbCZqGLbQ9EfMdWi3VLxBFh
	Sc9x+o2pYB1K+4PhywYUGufozKMueE7FTScvPlWzVJSr4qxWPZIXJSTVYLlyqs0VHsCSByIeca8OK
	rdMFP3Sw==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.8])
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXWTp-0000000AtEt-1Dk6;
	Sat, 27 Jul 2024 01:44:17 +0000
Message-ID: <c7858827-b788-426a-acaa-9563c154f58d@infradead.org>
Date: Sat, 27 Jul 2024 10:44:11 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH 1/2] MAINTAINERS: Mark powerpc Cell as orphaned
To: Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Cc: Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org
References: <20240726123322.1165562-1-mpe@ellerman.id.au>
 <60581044-df82-40ad-b94c-56468007a93e@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <60581044-df82-40ad-b94c-56468007a93e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Arnd,

On 7/26/24 22:15, Arnd Bergmann wrote:
> Geoff, are you using spufs on ps3, and if so, should
> we move arch/powerpc/platforms/cell/spu* to the PS3
> entry in the MAINTAINERS file? I don't think there
> is any advantage in actually moving the files to
> platforms/ps3 if we delete the cell blade support.

ps3_defconfig has both CONFIG_SPU_BASE and CONFIG_SPU_FS
enabled.  I think one of the things users want to use are
the SPUs.

Updating the MAINTAINERS file sounds OK. Do you want to
make the patch for that?

-Geoff

