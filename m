Return-Path: <linux-kernel+bounces-302214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ECFC95FB35
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 23:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70A9C1C218F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 21:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA749144D35;
	Mon, 26 Aug 2024 21:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="dzGBTuOF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A2E881E;
	Mon, 26 Aug 2024 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724706473; cv=none; b=OvtrB7kN8x/yEkUfz/+s3h/aUwqHgOISj1dnercZdlDMmQnPXS0ev1Tvt0HOLo1RDEIti5I9JjBBdxSS7qkJ9RLp1jMzgGRJuURMJiSc48yYmrRcSjNX5TJ9RNooZoJDgas4YRmiuBboHOr1di6D/RoTvCQDrZY0sXf4UaHsmS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724706473; c=relaxed/simple;
	bh=0EWEuJcdwdIyzNP12HmlUHMkhgWA6mZVV/NN/fG5VKc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SO2hS3YEs+ltykf1uHIrBP9tkcZ9I10x3dCReTiMFPqJJtBbnCF5YwpTGD9FtDKE1fFWciswuEaz25Oz97EsvS8IBLHCXeTBNDB5NYuCQdPZbNMgwh2cXRMdnQk6oaHV6imgj6B1uTMhJhN5F+2/tGh1JbMtLGY8JwOK9Q+uhsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=dzGBTuOF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4E13741AB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1724706463; bh=7BfkKSZi/7KMqOZYo+q/HR6MkuZYJQFCXk7/jN/sUAU=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=dzGBTuOFkv4ezZ+Lrrq507biq2o+lR7aY3PV7JV9mKlQ0ODi0CN+2+pEelNQs9ZkW
	 EjkHc7S48M+PvmPAK5bl27GgMx6A5dcJqPg8hO1pEjMczMwQSchaI4i35k67YNnfEQ
	 6GRVQwSTOCwNEb2Fx9iQJ5WQKivc+x3bm6dQpwL5Wg9KqLtVuqNweGh0JqUsk6zWaX
	 pzZiGl2hCULVZ2638+qit7jiAf0Qsdaoh1BiW600WuplJaMjfQSmSIc8CV2skUhsqA
	 XadlCVpJhFg/Np7ZTB5Xqys6RfNgvmcWK0eceWfz08nvT3uNc+RGz5qlA++PNEtZGY
	 nRgtn/RUPpZrA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 4E13741AB9;
	Mon, 26 Aug 2024 21:07:43 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Aryabhatta Dey <aryabhattadey35@gmail.com>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: process: fix typos in
 Documentation/process/backporting.rst
In-Reply-To: <rd2vu7z2t23ppafto4zxc6jge5mj7w7xnpmwywaa2e3eiojgf2@poicxprsdoks>
References: <rd2vu7z2t23ppafto4zxc6jge5mj7w7xnpmwywaa2e3eiojgf2@poicxprsdoks>
Date: Mon, 26 Aug 2024 15:07:42 -0600
Message-ID: <87r0ab6li9.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aryabhatta Dey <aryabhattadey35@gmail.com> writes:

> Change 'submiting' to 'submitting', 'famliar' to 'familiar' and
> 'appared' to 'appeared'.
>
> Signed-off-by: Aryabhatta Dey <aryabhattadey35@gmail.com>
> ---
>  Documentation/process/backporting.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon

