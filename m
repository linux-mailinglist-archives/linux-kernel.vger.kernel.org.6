Return-Path: <linux-kernel+bounces-535714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00EEA47656
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 08:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCF83B189C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 07:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98A22206A6;
	Thu, 27 Feb 2025 07:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="euUdS0+c"
Received: from mail-40130.protonmail.ch (mail-40130.protonmail.ch [185.70.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E44220687
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 07:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740640160; cv=none; b=PNjZlP2iX8qRoQEhgo64/NX/Ca3OZLoarQFhR30929/9L/7Vaic1gaV3SEfOL0RRH0oDJn3JP08xtoWE6ku6swmzhEwvHQ01mlZ4GmZYw174gYBFJdQLrszknKZIx7rXwGQ9ycB1jSt+vonZpDEQSzyAufOr98zdjS42SAEOICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740640160; c=relaxed/simple;
	bh=QwtUGQCAe+YyijMA6Hed2HBvlJ9PZ2BdgHTgGuuWDz8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fg7dj15wRVeg5mdOKetYWm84a8lZKdBbhQVEV6n8uJ+KQz9GYvJd4NuOtsmCo2GGFbUb8lFuofibQbX5Mgtb7lfJjNyvFrJ3jLrwfmeo3aoDP9JspvMtfwuSbBtFovyTY7vUD+gC4OieNY/U8MJRuHaka4dEjf62DX5NTGaM27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=euUdS0+c; arc=none smtp.client-ip=185.70.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740640151; x=1740899351;
	bh=QwtUGQCAe+YyijMA6Hed2HBvlJ9PZ2BdgHTgGuuWDz8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=euUdS0+cs86bHBPLDAqNQO5EZ1/kszAb76FgqgjyNMCO6LkMDdr/u6GsUecxr0OjF
	 35bXv/OwcLj09WVfIEaOFTD672kzHCtBjOqWooCCH8X6bnUKBEW7XKZwP5pL/C4C+S
	 TG8tHue3birwD5qRCmkKMZsZeXQjGvxcaL5Ug3/59xQT9YQrTN09W8Y5B3nFEMZ3KM
	 1LgaoIyhff9WkRfKqO+TRgOu4TkcsQTeULG5yDeIaOGzzS3EbgkY9M8nseBCAbCI9I
	 tRpvUBymjB2gRdN8CAbXD20edMP8l4Ey+OPLkjOz1F3L+gQuBmYX/U45bjDmNVvfOs
	 nLRAfva4tjL+w==
Date: Thu, 27 Feb 2025 07:09:08 +0000
To: "torvalds@osdl.org" <torvalds@osdl.org>
From: purple_eater1988@proton.me
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulus@samba.org" <paulus@samba.org>, "phillips@istop.com" <phillips@istop.com>
Subject: Re: Kernel SCM saga..
Message-ID: <7VvWYf03SoimV_IsYBSEl5rP_VzUpbSWtPzneWeuuHyOGq6W1o1Vx1GrmmNGNGLRZCiqah-THhv8_Qi8iynAkwKen2PcCFOF_7-0gqAFhz8=@proton.me>
Feedback-ID: 126560106:user:proton
X-Pm-Message-ID: 472e378a885524ae25414f3861856d15f95c4835
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello

Sent from Proton Mail Android

