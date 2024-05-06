Return-Path: <linux-kernel+bounces-169575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2E18BCAB6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A681C214CE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49FFD142658;
	Mon,  6 May 2024 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="hyxdcExm"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404F11422D6
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988049; cv=none; b=BbAqRptorKlEg8ZxKgwX1MJz3ze8eqZonqu2SXURqLdIUgZOatCCZiz8cpciC9QKaMhv2LVkI29J+EKHXBWsysx5cXuuURumMYGPpkFNFl1kNpUvHCcJ8CCa8MKFJ8XJjDyqUsS/xUHxx4qnJk3ovNX2NZmQlXO6qmx1+m7UVKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988049; c=relaxed/simple;
	bh=7OF86DztNEgEGP33zEtBbhPkFcoR/Smj1/J4ZnBZc7M=;
	h=Message-ID:Subject:From:To:Date:Content-Type:MIME-Version; b=hIOO29sdRjxwHvUa/P6UuIaLe/a5qRicFV8Vht0GSHd4p2/JJXUJlWLe+Plsq9oQTAK+xvbeTwSEaYShN1Y5s2t4vqGRZl6WRORjG/HylMhGzndMkWF3RrwaAAWn94gQWOJ2XseaY9wTP1lTsNCnySbsPOrrtqOAeFLHVYy/yRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=hyxdcExm; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1714988047;
	bh=7OF86DztNEgEGP33zEtBbhPkFcoR/Smj1/J4ZnBZc7M=;
	h=Subject:From:To:Date:From;
	b=hyxdcExmrUDFeMq08hWkYed6VRfG8qhoogmm1H6UxGUlT7e6aGRIwFZiXcSBbBpsp
	 9W/g5HwWCG3of2rmq/13G2mRH0iptGjkexi5CsR5ySXJzJydNmpv0vNdk/gqoYN/wU
	 OvP5tMHgECgkTACyhcIyva2MUvuneJHzglYR4ASI=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 4A5B767052
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 05:34:07 -0400 (EDT)
Message-ID: <ff46715a28b6810b1582bed386c79cf6f090e21c.camel@xry111.site>
Subject: Broken mainline kernel tarball download link on kernel.org
From: Xi Ruoyao <xry111@xry111.site>
To: linux-kernel@vger.kernel.org
Date: Mon, 06 May 2024 17:34:04 +0800
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Now on the homepage of kernel.org, the hyperlink for the tarball of the
mainline kernel links to:

https://git.kernel.org/torvalds/t/linux-6.9-rc7.tar.gz

But this link results a page saying "Unsupported snapshot format: linux-
6.9-rc7.tar.gz".

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

