Return-Path: <linux-kernel+bounces-189326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6588CEE6F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 582591F216AF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 10:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9171B11182;
	Sat, 25 May 2024 10:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="KPvVaMV8"
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEF112B83
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716631934; cv=none; b=NBygyRMuhmTUyGdjyXO5KkZjfUfBQcYHAIs5rKj2x/H6XqufgporqD0uT/F8VkBjMWSxNwnqU/8monGxqNL+l8q/zUcfgNoeCFOeAoeXFGfBsBVoQzbbGuiM02HI645RoXeTYdhth9H2RBDPhw5kQWRa+5oQUDvYzCYlgYrDcwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716631934; c=relaxed/simple;
	bh=TePywgtOZLSlmtUkwAJgRE8YCkoJVGql9P4DLoOhK+A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4BsCuQ8KJFoNjcrYJxAh6+tWj8BfIsUDK+1c1Tv+c6C5ZxdPOaMtBBEh7tQOkYWHCyd1U5NP3kT4fzKem0zuVJm+Qf6BCma8s4t5UiJrkKeMAgBce1xUz/rnSrlS2xkTsHH3PtdgU92PWQ4JPSauigyDC6bCh3Hcoe6W+9zx8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=KPvVaMV8; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1716631925; x=1716891125;
	bh=gZ2fuCsQeBrVCBT3ISM0nKpgpPhN28e/OHnCBxchjV0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KPvVaMV8rHtHFWfPQ4g9yuJT+FTqXmIBJsbiiD0/kJKEgAxhj+9tl9/T6CC/21ihm
	 TFqp/JSHzZNpiUn+B61AKe7ZTDDRX8Pk7HtX/rk8c+166y661YiccTF81wc8HF1SEb
	 FCR+yAY79pPS/E36JEijEj21tNDnxo2JN8TpH9/nlnf8koxoEAkCP5/q6mPg10l0yE
	 2V+78ziri+plFLLwy2+eUMl4ysU2Lnqbkd3Q3gE/GwYUDrVANM5Zl2GliKnHMBzgF7
	 e9moymGlkAhC8UxTmQqj4U24OAPxS8KRpTzkNQ3AFeGDNSa1UOlWcdWmbeGyUSRXfZ
	 CVGPlK9GNZ/1A==
Date: Sat, 25 May 2024 10:12:01 +0000
To: Markus Elfring <Markus.Elfring@web.de>
From: Henry Bell <dmoo_dv@protonmail.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RISC-V: add Star64 board devicetree
Message-ID: <caCBlFpvjmhO9G1A1_2qHImmuoGai2NoPYonB5RCVftq4zIrSxlP8Msh9z_FX9GwQXzfSrB40dRxy1zfxZesOJENeebWQsERa03sDvArzec=@protonmail.com>
In-Reply-To: <1b55aad1-1442-41a5-acc6-16baab90c021@web.de>
References: <IPHlm5mOKUzYfwGy0auyufx-oPkSrtQjUjiQLbtvspD69UPX9O98iB8P2mqM8ahNaerz0yUa009f4XABRniq7aj2PUp83hbRVVhhKmqT0Ss=@protonmail.com> <1b55aad1-1442-41a5-acc6-16baab90c021@web.de>
Feedback-ID: 106097379:user:proton
X-Pm-Message-ID: 587824850d8d4aa25dfd70065ed365efcfdc77de
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Saturday, May 25th, 2024 at 9:37 AM, Markus Elfring <Markus.Elfring@web.=
de> wrote:

> =E2=80=A6
>=20
> > The board features:
>=20
> =E2=80=A6
>=20
> Would you like to add an imperative wording for an improved change descri=
ption?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.9#n94
>=20
> Regards,
> Markus

I'm happy to change it, but was going off the format used in Conor's  Milkv=
 Mars commit
https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?id=
=3D04a228aadb84d894721b13197649ca741f3018bc

