Return-Path: <linux-kernel+bounces-406704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FFC9C6438
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:25:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CAE5B34E4E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3818219E29;
	Tue, 12 Nov 2024 20:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="i7pXQKor"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D8720ADEC;
	Tue, 12 Nov 2024 20:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442963; cv=none; b=c71ethLf8JNx8PUGN4EHsseqQVNE1jUnmMRUOTsJaa2NnB+2dT19SznhgNfGtoJLIwk0n/7u0jTj6tRr78ka1vGJAceiehHyAoTn0GoUvLK27ohGPEVt8svGTgOHGQ/lTn2F4DYr0/cGJ4X5uAELI/pMn/qN1ktIbwmAYANFYaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442963; c=relaxed/simple;
	bh=j94YPPKHW+HGIR9yGse9SApV73HQ5pPkVnWZ6EPbohE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PPrNqWU4hbBW7DGmdt6pOD8Ii2vKuAExqofwxaz2zgWhZ+6XFU1ZTZ/YmIJVin8ofJaWkVwvOHhMugKwm/u8kkTKMUgt8t9FWphbW29WnY68mAenqTX2hJTOTYYjFp4ILQKfUtkD+QLeg2fN5BpufC6wZAQJo1OCN0ILZABBh3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=i7pXQKor; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 22C5E403E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731442960; bh=2rETktBd99QqoCTmMdd2okuoKC8zuYCdjVSFBuTiRx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=i7pXQKorhE+a7z0fOmtLA3DIJZ2yunwHFi5AaXefErA5kpspQj/NocH2omEjQJoWc
	 XSpVhG+oVlq1HX6TRm30SHiZGfdLBgyEmg9i0q2XudThYutlZsWRbBceMAjXUdmVlM
	 /tvWDIVkc6NrR0s8aBjHVwT/WOCE2ftrgglGBxgO8UklutlxsaYl8SoVX9LWIHiVrN
	 LAXGVBDTVAVbvHEYJ84/sYWjccNLBPQQuG9Q4d6gUAnlrSxZ1iigI7a0/uOvSLvKap
	 FstOwfmgoSvfH9tBba/Avi/rOR+cdyBinVV+ps6W7BClz40p5Ls1jjjmI+Z/8Or6H5
	 U7Gzg4mZUyzSg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 22C5E403E4;
	Tue, 12 Nov 2024 20:22:40 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Abhinav Saxena <xandfury@gmail.com>,
 linux-kernel-mentees@lists.linuxfoundation.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Abhinav Saxena <xandfury@gmail.com>
Subject: Re: [PATCH] docs: fix typos and whitespace in
 Documentation/process/backporting.rst
In-Reply-To: <20241107061911.106040-1-xandfury@gmail.com>
References: <20241107061911.106040-1-xandfury@gmail.com>
Date: Tue, 12 Nov 2024 13:22:39 -0700
Message-ID: <871pzgqk1c.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abhinav Saxena <xandfury@gmail.com> writes:

> - Fix repeated word "when" in backporting documentation
> - Remove trailing whitespace after '$' character
>
> These issues were reported by checkpatch.pl. No functional changes.
>
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> ---
>  Documentation/process/backporting.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon

