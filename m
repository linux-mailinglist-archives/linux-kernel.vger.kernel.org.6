Return-Path: <linux-kernel+bounces-231615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 712CF919ADE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACAB1F2226C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2980E194099;
	Wed, 26 Jun 2024 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="m4VXxnK+"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4520B181B80;
	Wed, 26 Jun 2024 22:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719442441; cv=none; b=L1IQomC1doMvhfKU1Od/R6owp0tQoU6icEuqJAtscU9lj0tka16WAn8wl6WVRS53GrBelq4/q4BPvUrCUkPJf9gx1cMWlqiFs2oAo29EIjYJCFqJSfxeIjKf5hpuFs4Y0nwbwvTrb0yyXFQJUVf746nFnftI/vqhaOcqcZp5Kig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719442441; c=relaxed/simple;
	bh=MXcwd1AySe+r1RbBzCqAio8xnq/XOvwhYo4NQ/jl+YI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XAKSeDpzF/olgWFBAr2+pffckb8BKA9hjAhcZRBDt3O9XqO9WC4Nz2JpzUT3WAtryfruG8HVRhWGN5+pgGtYB7qHH40UGW4LgnxKMpJOIN16P9serr/ohYq2ic9tMqKdw11nYmMMUOxQCnVVDEZ+XaabVjlXwZ2XXqb01ELocAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=m4VXxnK+; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6CF0245E2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1719442439; bh=HcPuh9+3lV1231cCkd9D6FG8V6xbr/keHFzRGKjSs7I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=m4VXxnK+w3fAExDBBEaie6y0a2Pi/yLhV9dqed/ZcHniPdA4VsbTeaG1KDQ4QcYly
	 F1/6TQdSIjahB89A4Jm86nqcuni9l3XfnTCU/2e+oh+lYDHA+QhlhHbzOK6dNraHw1
	 t56ix5jwNziJMlVm2rZZOQ4udqL9+EH+6ZwQsdBJTPZaw3mYxSU0cMJVaC6Q8vtqpI
	 DxySX/mu2fYeIEaWQhgZVANVpCvAMe1o5t96mcrwKRNH/kwFRAoNCgJFL3WcmDvwlz
	 BJd/spNn9UeUNmg2BkY+U/87iVhZTHEyFPQdzsnIXstN/UBevvmKfcgagxcOE0LBOg
	 b3aa+ey54tfGw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6CF0245E2B;
	Wed, 26 Jun 2024 22:53:59 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
Cc: rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, bilbao@vt.edu, Carlos Bilbao
 <carlos.bilbao.osdev@gmail.com>
Subject: Re: [PATCH] docs: Extend and refactor index of further kernel docs
In-Reply-To: <20240622194727.2171845-1-carlos.bilbao.osdev@gmail.com>
References: <53bd3bbf-0410-425e-84e7-1d34cac60412@infradead.org>
 <20240622194727.2171845-1-carlos.bilbao.osdev@gmail.com>
Date: Wed, 26 Jun 2024 16:53:58 -0600
Message-ID: <87v81vxqm1.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Carlos Bilbao <carlos.bilbao.osdev@gmail.com> writes:

> From: Carlos Bilbao <bilbao@vt.edu>
>
> Extend the Index of Further Kernel Documentation by adding entries for the
> Rust for Linux website, the Linux Foundation's YouTube channel, and notes
> on the second edition of Billimoria's kernel programming book. Also,
> perform some refactoring: format the text to 75 characters per line and
> sort per-section content in chronological order of publication.
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> ---
>  Documentation/process/kernel-docs.rst | 68 +++++++++++++++++----------
>  1 file changed, 44 insertions(+), 24 deletions(-)

Sending this as a reply to previous postings badly confused b4, but I
did get it to apply this time, thanks.

jon

