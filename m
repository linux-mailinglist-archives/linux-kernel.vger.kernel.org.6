Return-Path: <linux-kernel+bounces-170037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 357778BD0F0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 669CD1C22E2E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966591552E2;
	Mon,  6 May 2024 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="PYyaAqGW"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681BE1534E5
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007597; cv=none; b=ZH1gipUFKYybR/KGQYRVl8Fj7TtBp/ZONytWXKg6LiLQyPvKML9R9l4xksFcFx82ujVT3gMAGla6MLa0R7rl6JLB4yYvpvEDLDPEQtg00Y9v9NLbRc7yaVmawyk+FvJcsdpzF7lBSoonKNX/Fjybycqi8aV3bRxUb/vRc/9dlZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007597; c=relaxed/simple;
	bh=IsQXgenx0IgHXQ1N7Z+RO59XFLQpA/LLVcDV38w5d5A=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HFGMO+NPffIx4FaCty54sJgRWL6L7wOAcYRErQ67JoQ4znBjybU0INmdYVobO5zSe/2KQuqsrcRNVO+En9bmUZPI1sipRxQn9d1C47wxJS8inEpqYhNrOitm5VGPv8SyhZ57/ixawsJ7L8CMMD2suHRnvL7tu3T3H9ffselsMQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=PYyaAqGW; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1715007594;
	bh=IsQXgenx0IgHXQ1N7Z+RO59XFLQpA/LLVcDV38w5d5A=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=PYyaAqGW4FPn3IdcdghzNZ+/3ltYIlYx0a2NtZ5jDHFyzEt+WTzwTfBFrl7gEEErh
	 1Z73mhVB0Eu6GPqAs3eG0S7587lW+oeRq3smaC36sEP2dcx9rKe5xIjaCH8hZrqo7m
	 XymVYrVi9GeDvb8Q8TKf2uIzx0OM6p+dexVqVZQE=
Received: from [IPv6:240e:358:116c:3f00:dc73:854d:832e:6] (unknown [IPv6:240e:358:116c:3f00:dc73:854d:832e:6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 12D90670FD
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 10:59:53 -0400 (EDT)
Message-ID: <c9838ca5991fd21a28b19436ed63956ef422134e.camel@xry111.site>
Subject: Re: Broken mainline kernel tarball download link on kernel.org
From: Xi Ruoyao <xry111@xry111.site>
To: linux-kernel@vger.kernel.org
Date: Mon, 06 May 2024 22:59:49 +0800
In-Reply-To: <ff46715a28b6810b1582bed386c79cf6f090e21c.camel@xry111.site>
References: <ff46715a28b6810b1582bed386c79cf6f090e21c.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-06 at 17:34 +0800, Xi Ruoyao wrote:
> Hi,
>=20
> Now on the homepage of kernel.org, the hyperlink for the tarball of the
> mainline kernel links to:
>=20
> https://git.kernel.org/torvalds/t/linux-6.9-rc7.tar.gz
>=20
> But this link results a page saying "Unsupported snapshot format: linux-
> 6.9-rc7.tar.gz".

It looks like a temporary issue and now the link works.  Sorry for the
noise.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

