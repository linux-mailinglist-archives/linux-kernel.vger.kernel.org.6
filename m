Return-Path: <linux-kernel+bounces-242436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5917928804
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 13:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C961C224ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 11:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199D6149DEA;
	Fri,  5 Jul 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b="dL3nFrWD"
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D14148304
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720179223; cv=none; b=V1z897zh0aDvWVwUfZDzKe+PwByDzOsbofF5GNusysGiR8QqdYKwzsXL4EL1FJAD1iVfI45isOP/1R+vhFsfswWUYs0sX/pnifgwBoMc6j0Et1mb3xXA27G4Rw4Tg5/iTNlrmhF3Kbni7nnnV4/5wEtXAGkNS3eAsy+QEV9pYI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720179223; c=relaxed/simple;
	bh=Yqm2Y05glE2XpD8UBy9Za6PAr7oCx+v4mZPjneDT06Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mUUxjFIAdf/GKnzOyvFBJ/1JjMIfTVO+a+3MZU36lFU3BP85ijwUi+wGZzB/UDwrB1PYFKDyor35p/x7yGdzocjrna+/WLiPQyG0lQIh1LEMbfrO2R0pizd+08yTkbRoVlpngrBTxwhbbkGjXUlO6EdKKwtVgkDxNRPGzz5s5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk; spf=pass smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace.dk header.i=@metaspace.dk header.b=dL3nFrWD; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metaspace.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=metaspace.dk;
	s=protonmail; t=1720179219; x=1720438419;
	bh=Yqm2Y05glE2XpD8UBy9Za6PAr7oCx+v4mZPjneDT06Q=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dL3nFrWDVRhvyLcNlSe+g65txsjpcHUKDo2psuBpjHU26zsoplUbmW9GeuPsbrX+n
	 lujfxAs7bP92/8FIDCZ6c9tHEvx01h/Vx+QiMcEqn8PLOjdWpaPQ/mKsiziRdQYvho
	 R77rhiVhRspH8MsomjMqY4k7sHKAmJOFqtecrGX1rlfvMDV6UnnlBFmX9zWst7/ikY
	 +UHxOYjzLHP2RuJmHNBXLeBymLdhY7+XfvEOly1iqN81lSdpkIWgmN0XcRCi22dYgH
	 XkB3YhJ683ifXyT8EIH5GEygFgeCmSkL7Qb+CcVaN3k5pF30YaryIDMnoNkt65B9Wd
	 32warv0r/NhjA==
Date: Fri, 05 Jul 2024 11:33:36 +0000
To: Adam Bratschi-Kaye <ark.email@gmail.com>
From: Andreas Hindborg <nmi@metaspace.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] rust: add `module_params` macro
Message-ID: <87frso2hvk.fsf@metaspace.dk>
In-Reply-To: <20240705111455.142790-1-nmi@metaspace.dk>
References: <20240705111455.142790-1-nmi@metaspace.dk>
Feedback-ID: 113830118:user:proton
X-Pm-Message-ID: 2b7babd3678f2e69ff10fab1e8f2a40279773b39
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Adam,

"Andreas Hindborg" <nmi@metaspace.dk> writes:

> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> This patch includes changes required for Rust kernel modules to utilize
> module parameters. This code implements read only support for integer
> types without `sysfs` support.
>
> This code is a reduced and updated version of code by Adam available in t=
he
> original `rust` branch [1].
>
> [1] https://github.com/Rust-for-Linux/linux/tree/bc22545f38d74473cfef3e9f=
d65432733435b79f
>
> Cc: Adam Bratschi-Kaye <ark.email@gmail.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Two questions for you: a) Can I put your sign off on this patch, and b)
how would you prefer attribution on this patch?

Best regards,
Andreas


