Return-Path: <linux-kernel+bounces-520453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A59BA3AA0B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 21:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76F3C7A6EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 20:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EED71D9A7F;
	Tue, 18 Feb 2025 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="VvIGNbwj"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7921C701F;
	Tue, 18 Feb 2025 20:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739911089; cv=none; b=r7OWlp9KcAhxHzzjjkaBddqJw+881gWoBaP8XpShVrgahB9aYC+cPZ6O2O9n9z6ewwRE/ayUdBfqI8vdsMBC2NrYlbO2/uklAln1bX5J7QTuyStbw5cnJzH3R8bgSQn2n1u3tKz4eQOr50oZO8GZYxvU+LVM8N9oukKtECkQnkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739911089; c=relaxed/simple;
	bh=8Xm80OMIKF8F3+FgBRC2wsyDdjzSXrv9PO6XAc90CyE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ontlxuRQ0GVVQ3jgiWXxzceWIqObXtn57IofFrdYSCJrjv+VvIEN9QMLlYrpllDfx/uBTxblHfn0rSX9oxw92PYrvloyZBsM5dXoW+p/iaaAInhwBuafipJF2vd8sFbTYjWapnZEyTOYscO/EgyHXpdR0cPrRAq5zvk2PEC8Gq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=VvIGNbwj; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 87FB4411AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739911087; bh=kfxH1fSDUa2wfITOdeg5XChJKZntzYFLimcNseokqrU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=VvIGNbwjJDEYsawGgsN5kLBStJjeZwXVGIkl+u9KzUNP8HtyWN0gkhvtR0+WqBdgl
	 rzWnbvTjqi8pnOaWnTWsmLeapyhg+vnb0IX/kdMugvjc4taEZBeuBqvW7vhGuoBKam
	 NxQOgIWOZS7LJqd7euM1rjv42+xXEs3Wq7ZPriBwc/JP6VWBbdrHXoMLBY+/I0JuFR
	 aSwPDX7Z7tnsiEzshaALMOAl4JvCLeIdNb/sKXzGfZxmXoda68Euk5rvLq/fmSu4KL
	 KOGP4MUbj0QCAvdgjgR6dyC/mrGj78xlyolXFp6qB53M1JnrTEzb4ovSHjcxT9C/Aj
	 sN7G6uL7ym6eQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 87FB4411AF;
	Tue, 18 Feb 2025 20:38:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: alexs@kernel.org
Cc: Alex Shi <alexs@kernel.org>, Yanteng Si <siyanteng@loongson.cn>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] docs/zh_CN: add maintainer tree for Chinese doc pickup
In-Reply-To: <20250213054222.21776-1-alexs@kernel.org>
References: <20250213054222.21776-1-alexs@kernel.org>
Date: Tue, 18 Feb 2025 13:38:06 -0700
Message-ID: <87a5ajng41.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

alexs@kernel.org writes:

> From: Alex Shi <alexs@kernel.org>
>
> From now on, the Chinese translation doc should be aimed here for base.
>
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Cc: Yanteng Si <siyanteng@loongson.cn> 
> Cc: Jonathan Corbet <corbet@lwn.net> 
> Cc: linux-doc@vger.kernel.org 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Both patches applied, thanks.

jon

