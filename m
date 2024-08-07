Return-Path: <linux-kernel+bounces-278427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBB994B021
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 20:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4985A284813
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86F3142E79;
	Wed,  7 Aug 2024 18:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="V13uMQFF"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8AE1422AD;
	Wed,  7 Aug 2024 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057016; cv=none; b=nh3bNRmzPlW9GtLsD8mUzKWtxYc2KHEWp4fN6zcrSRw3l8b98MPxhnJjuTm6LZg47kX8kBEdNwEFeX7CqwzEJqvqjXsUQtHGAm9fWfLilg5bygeHWZbdf5O2qiPnHg0m5cS7RMoJuu/3zyCuwuPYeHgumhJenKGsTyvhg4aHNAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057016; c=relaxed/simple;
	bh=0wItnGiatP6yQGYXS/TeiEih6p9cu8aCkK632lXRqfY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mdVpNn7mAkSNj2YVWCxR6gZ3kT9bqcOVkHHyiyFftc4lLT9qrPI+Sej9O+yYN8cqXbF9KlgEZOP8hwRsBjzrS3IN+zW1tEKY4UuxyOzZjWrl0fjO0JxYf5v8ni8yrw3xeW7lAOYJTSO2DxTImO5RHg6VGkbl0nA7ebHQsqsi5IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=V13uMQFF; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D49E5418B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1723057012; bh=nkHc2ioZ4tR8NXnTSXDp0ccyM4cU1xPTceTaYDpYIZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V13uMQFFftB5j+Ti5ZTfKxCPftMIaLzWtzCkIgKCwmN7qo1f1Qg3A4ba6OH2FsDtE
	 LpQ9JMwBvW1jWcsOCJQSlfgEU6pM211MMy3pkZqiVnSJRexuF1xB76FaALeM0nbYy7
	 J6rWoPiKrQlNmSkxh4dwBl+OlwyQTPoclA9MdWF00zg7d9slb0yoe0i5yOLkS3OzV2
	 fYSg2vehrkAHideveMYZdYnD64wchRPJN/28rT/EHV+gcPN4ZEjhJoJlDiRiy+3ZiH
	 gjft9ZxfIstzayHfcduF/VnyOWl9GeAfxnIfzfu+8h1Gj552DykaGJFWJa7DHVeAZ0
	 mSkblazLAzKkg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D49E5418B1;
	Wed,  7 Aug 2024 18:56:51 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Karan Sanghavi <karansanghvi98@gmail.com>, Karan Sanghavi
 <karansanghvi98@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Karan Sanghavi <karansanghvi98@gmail.com>
Subject: Re: [PATCH] Documentation: core-api: Fixed Typo error
In-Reply-To: <ZqqHMIKdcNRVgAFd@Emma>
References: <ZqqHMIKdcNRVgAFd@Emma>
Date: Wed, 07 Aug 2024 12:56:51 -0600
Message-ID: <87le18rwjw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karan Sanghavi <karansanghvi98@gmail.com> writes:

> Corrected the typographical of the word "instrumentation"
> in the below mentioned sentence.
>
> Signed-off-by: Karan Sanghavi <karansanghvi98@gmail.com>
> ---
>  Documentation/core-api/entry.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
> index e12f22ab3..a15f9b176 100644
> --- a/Documentation/core-api/entry.rst
> +++ b/Documentation/core-api/entry.rst
> @@ -18,7 +18,7 @@ exceptions`_, `NMI and NMI-like exceptions`_.
>  Non-instrumentable code - noinstr
>  ---------------------------------
>  
> -Most instrumentation facilities depend on RCU, so intrumentation is prohibited
> +Most instrumentation facilities depend on RCU, so instrumentation is prohibited
>  for entry code before RCU starts watching and exit code after RCU stops
>  watching. In addition, many architectures must save and restore register state,

Thanks for your patch, but this mistake was already fixed back in April
for the 6.10 release.

jon

