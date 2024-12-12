Return-Path: <linux-kernel+bounces-443284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3EA9EEA89
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 16:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CCCF188AFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A671721660B;
	Thu, 12 Dec 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5W1KWBF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1099B213E97
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016254; cv=none; b=PNng9rT1drv8/JzE2OB0OxIIAq0kS4OaX3gTqvxF7JEvk1hB2/X2NXgBEZgydl8a8LrubO7vT5PAc3d+/9ErOwO2vPG5zhfEZ/Oevt1D+q5n2MWV69ZriaD/saKDWMdMbtUiH+e+e0lVvcIz9n74tAVq/Y3+8JjTGBsdBzTO5bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016254; c=relaxed/simple;
	bh=0vtbrOrYixbByfdmk66uzpNcSH77xhWI3fb1PysP9lI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HfpcO4h2s9Lp1eDGuZSZxVb/hYOrj+sbhMQggZRxRsw0Dz5oEHZYW51l8RGVQD+R5owxOnCVqFHO9mXDrhDHSHw1rICz43M1+83mr6/eNyMirYDJhlARmo2RrZi3V2xQeGP8PuXX+mHaRjxvB/9Tx0sMCM/Mm2m1rtruvEdrUQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5W1KWBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F974C4CECE;
	Thu, 12 Dec 2024 15:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734016253;
	bh=0vtbrOrYixbByfdmk66uzpNcSH77xhWI3fb1PysP9lI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=P5W1KWBF68AAiY0vBM/YnnpTt1t4LwE8HtLendCapfFre+Ib2gGnjTHPvpyGPeq9R
	 GB6FR9WVvpSz/q8VAEqNKpty9881HwNX9vS4FTwMSALfWpgY/2jbbyC2NuWL5FvAgE
	 MmUI6bkpgAXGU56iYVTKolyAZo02NNRW+PIjznTnvUwiXZKK3OpVAvDAd9iz3utbgS
	 ZAUMXkzSzzjNFKuLWDYR9NcOrH6sDhk49dNh6Ql2lJZ/6vdQ7O1xT4JdQQWMvw+SuC
	 qO831lSajPQCe4J9Cb3icPW6Rj0VUicSI12i6zvq0KAGoHfavVePbkS37UJFT8Om+a
	 NUFbOhAnmFbnQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as a riscv reviewer
In-Reply-To: <20241212131134.288819-1-alexghiti@rivosinc.com>
References: <20241212131134.288819-1-alexghiti@rivosinc.com>
Date: Thu, 12 Dec 2024 16:10:50 +0100
Message-ID: <87seqtos1x.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexandre Ghiti <alexghiti@rivosinc.com> writes:

> The goal is for me to get a kernel.org account and then send pull requests
> in order to relieve some pressure from Palmer and make our workflow
> smoother.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

It's the 6th anniversary of your first RISC-V series [1] (I think).

Thanks for all the hard work -- keep it up!

Enthusiastically-Supported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

[1] https://lore.kernel.org/all/20181210062146.24951-1-aghiti@upmem.com/

