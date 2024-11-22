Return-Path: <linux-kernel+bounces-418195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544A99D5E78
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055E21F213A5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 11:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB641DDC0C;
	Fri, 22 Nov 2024 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pzeM6uSe"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61980524F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732276666; cv=none; b=qhdbpZ1XvJbM/qq47px7Cav3h/0Gr+Muwr3843GVGfjkfa4ghNeJN+kknHA2tpqXdA306PDYCoVo/tCXRlOMkjJXWUbfbKMCs00AX25zwKYv6AwrX0P6AgG6Na8OqdqSOEUeh/HUVLtGGuciGixc11uD9F9iJQf/HqQZVirU0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732276666; c=relaxed/simple;
	bh=IUm5K1QpDLqrSIFnFvSWxFRNljNOtCpXkwifZSl6pK4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Qjk1r90TxRHvUvnwqemGkpHfx8WPONEKstZ+w0xCyka2Y98jWvmaiLP28njX00DwVykdGvygg3MoauKA8Q3Mj8dqtMihRE31d4lxLweLIZSAgBDJeI8j0wbWpZSzYAKZqpJ9e79bb/ElGt85sh47xcaOeDfVoIc3qwE0FEL1qa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pzeM6uSe; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732276661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IUm5K1QpDLqrSIFnFvSWxFRNljNOtCpXkwifZSl6pK4=;
	b=pzeM6uSeH2Y5cOTdDA1cSo4d3+jVXmy43WTztqwzhyNhn383H14aJG1eu1zAUXG9pXJ60C
	HJ+/v4lPAtkVwPX2wOeRH6DSstoUW7VaDpNBWpP2FAZryyDVn6UfDoi2feRDxCWk3jQXj+
	4IVx7Z4o5JLz3uRBxdxjhzyQWEqfDF0=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH] powerpc: Transliterate author name and remove FIXME
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <87v7wuy3p5.fsf@mpe.ellerman.id.au>
Date: Fri, 22 Nov 2024 12:57:26 +0100
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Naveen N Rao <naveen@kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <55B1EE24-BEC9-4A8D-84B0-ED32FCC070A5@linux.dev>
References: <20241110162139.5179-2-thorsten.blum@linux.dev>
 <87v7wuy3p5.fsf@mpe.ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>
X-Migadu-Flow: FLOW_OUT

On 11. Nov 2024, at 02:11, Michael Ellerman wrote:
> Thorsten Blum <thorsten.blum@linux.dev> writes:
>> The name is Mimi Phuong-Thao Vo.
>=20
> Is that the correct spelling?
>=20
> The github commit below suggests it's Mimi Ph=C3=BB=C3=B4ng-Th=C3=A5o =
V=C3=B5.
>=20
> And presumably the author preferred that spelling, otherwise they =
would
> have just written it in ASCII in the first place.
>=20
> =
https://github.com/bminor/binutils-gdb/commit/6603bf38d74409906b3814f6a26c=
0483a5d32e41

Hi Michael,

Are you suggesting to keep "Mimi Ph\373\364ng-Th\345o V\365" and a FIXME
instead of changing it to "Mimi Phuong-Thao Vo" which is how she spells
her name on her LinkedIn profile and other websites?

I doubt anyone prefers their name to be spelled with octal escape
characters.

Thanks,
Thorsten=

