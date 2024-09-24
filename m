Return-Path: <linux-kernel+bounces-336709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB73983FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 09:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1147D1F24279
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 07:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C72149C52;
	Tue, 24 Sep 2024 07:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="O6agZlwy"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565804642D
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727164099; cv=none; b=kO953aOzMt+wn5L1b1camRIz/Vq0/Of5cdHiGWbQg7v4goUw3U5WT1Y1yP/VctThX/+SSziJiOdu8shN8V3IlATqsskeJg8Q5P+T20siG7QfEkpgRLMDmszIRSryu4xUQ9haiJIJnsbJRSiM6gkDpCGtsLfR5sCIxQU+NgJg9MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727164099; c=relaxed/simple;
	bh=jSIQCBOXb7xxJAqBcJ5TzSXLiMib7uG0uNu3M2NFxnI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZhwBXSHrQC4wZ93aA8FG8CgNOy7d5ZVYf3zLV7IOaZSOhd0p0Tza5s9lrqfUzbCgHiDaVNI37BezSgxOccFSSwCmrEi1xRRPLG6i18nKz7doQMoLFbZllnenXnEbQ17ImG4bInNR4g0/j2XFXn7dgbUTmDPIHtaKdY+2QDJXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=O6agZlwy; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1727164090;
	bh=vLuYCUVbyfHMl1SP0XrDP5FqPLARlZVT/5whgYll5ek=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=O6agZlwy+/uH6jawTyVcjCaY9rSqjo58L2prwIdDyCHQV6wvNLi6QUCY2HaUTWvO5
	 84i4G7Km9344VFRhtyYqtZn+TuzKZX14MWxdfG5RCBiBZB166DC8L3Iu0rVPRKK9iL
	 JmLOoGdWRonIYIwRmijFxMwLoA42anHrnTXRL15g=
Received: from [192.168.124.11] (unknown [113.200.174.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D199765B9F;
	Tue, 24 Sep 2024 03:48:09 -0400 (EDT)
Message-ID: <5154cb18303e4b902bb4f58e66f3dc22fedc4672.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Enable generic CPU vulnerabilites support
From: Xi Ruoyao <xry111@xry111.site>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Tue, 24 Sep 2024 15:48:06 +0800
In-Reply-To: <20240924062001.31029-1-yangtiezhu@loongson.cn>
References: <20240924062001.31029-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-24 at 14:20 +0800, Tiezhu Yang wrote:
> Currently, many architectures support generic CPU vulnerabilites,
> such as x86, arm64 and riscv:
>=20
> =C2=A0 commit 61dc0f555b5c ("x86/cpu: Implement CPU vulnerabilites sysfs =
functions")
> =C2=A0 commit 61ae1321f06c ("arm64: enable generic CPU vulnerabilites sup=
port")
> =C2=A0 commit 0e3f3649d44b ("riscv: Enable generic CPU vulnerabilites sup=
port")
>=20
> All LoongArch CPUs (not only LS3A5000)

There will be other LoongArch CPUs (some may be even not designed by
Loongson Technology).  So to me we should match the CPUCFG.PRID value
and report "Unknown: No mitigations" for unknown models, instead of
being too optimistic and report "Not Affected" for them.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

