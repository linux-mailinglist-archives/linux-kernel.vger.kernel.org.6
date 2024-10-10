Return-Path: <linux-kernel+bounces-359544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514A5998D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0852840FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 16:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252941CDA0B;
	Thu, 10 Oct 2024 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+GetVYt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881D73A1BF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728577005; cv=none; b=fJmqJIQ4a+PU2/egJ/h8S4hegyoJqMkoauG4yHb78JGRKGr//9Xtyywydd5GlW3V8Hvdg49jybeKpD1cuQnt8yEh/bifUx8ZVseUgmEmu1VRRPcmRMDAMKSZOD0CBhasni9ATHaJPmFPwxBigiqwn84gTlz+R9vXLyLr/ihP++Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728577005; c=relaxed/simple;
	bh=3c5Kt/iLXawGDWZ2PMV6WywGBrzzKss62a1eGMkGnhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nOT714wUsYlfcO/gkfVP8zzGYiN6hhcudR2scB8Vs7upUmb7fASDkf9eRE29QM+Of+4hRVT3ZngBbCmgXGtaK9GMw3Q2w68OR5D0kekrC3bnPNGkQXUHMziewx982HZdu15lKgW4vQCiGDb6bnU4j2n/MsH7fZ0iXzI1jIlzO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+GetVYt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE894C4CEC5;
	Thu, 10 Oct 2024 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728577005;
	bh=3c5Kt/iLXawGDWZ2PMV6WywGBrzzKss62a1eGMkGnhI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=a+GetVYtZZOhc6clCxaL0eFw3qhOhkdw68ZimCDwSUpT+iPvTJzcvVvk15OVkkGST
	 GBOzByWVDDuC3s/nNcMljOt9qBINt2yR0+Hd2VxIGiZCpezqR3IdmFA15/HoZXIevs
	 YkujiAqWcjQlHRrake0VNYHPKKfKkzEmrgJ0KiM43NKNoxwPua7y0y/p/fh9U3Wzh1
	 DvgODEtNNLC8qEfm07IxYEcotPwvj+TCYo0VrIjvolSLiwhMhPvXBAJAHuDmd/Jv0L
	 6wbtech9zRfAwOzDiySbqR8I+YJnnMlGB+AVNAoSL0CIjYnIV5OH4PfH6ft2x21uix
	 6gVo6tJrz+xDQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, linux-riscv <linux-riscv@lists.infradead.org>
Cc: Charlie Jenkins <charlie@rivosinc.com>, Conor Dooley <conor@kernel.org>,
 Samuel Holland <samuel.holland@sifive.com>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Drew Fustini
 <dfustini@tenstorrent.com>, Arnd Bergmann <arnd@arndb.de>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: Github RISC-V CI (BoF follow-up)
In-Reply-To: <CAJ+HfNjwqMhAFUvKRsWEAD1BZNC19ouYmJ9XMNP2HrcyKo6Ltg@mail.gmail.com>
References: <CAJ+HfNjwqMhAFUvKRsWEAD1BZNC19ouYmJ9XMNP2HrcyKo6Ltg@mail.gmail.com>
Date: Thu, 10 Oct 2024 18:16:42 +0200
Message-ID: <87jzegrl05.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Following up on the discussion around CI that came up during Plumbers
> RISC-V BoF.
>
> TL;DR: There's a CI running builds/and tests for RISC-V. Check out [4],
> if you're a nice person, try to fix what's broken.

I just added ACPI (U-Boot) boot tests (AIA, and non-AIA), PREEMPT_RT
fragment, and a "-cpu=3Dmax" variant.

