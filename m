Return-Path: <linux-kernel+bounces-530224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB314A430CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 00:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 036DF3BBC5C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7831EEA4E;
	Mon, 24 Feb 2025 23:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="eR9BwiWN"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCAF20E70A;
	Mon, 24 Feb 2025 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740439410; cv=none; b=Sp8zB4SXQ0lytwlpMVJL/ieA0ZMYKstlM0K8D5rOz6pYS16t3Yym/SlufXkok9hiCJkghT0AjgJsS/tFTeeDh9xUCggHkp34OMf2RKHwC97pcXfuFsj4KvO4HeCqNu/d7BuE+nctRbUQ4NGBNAwv8r4uaLSjAMGIB5C3+hTWkpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740439410; c=relaxed/simple;
	bh=xygo3kUZTNGVK5pB6Ij39BzUiIbzZnVa8VVlNDIgOYw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IsItUoXdb4PSztpDiep0HS+R380y9ds9kqUgOFHKWCcgIlGqKx07g7InAmX/eXdywIDWyuYO6M+9frH0acnNN1e0jzEHzX7TCsN9DdmU61r53qKkVNxKRgPSC10w8rxZkO62ajVaX3Q7ZSh2cJQZp7NUOtEDW6N8yVxodcEpFrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=eR9BwiWN; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 39A9148EBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1740439402; bh=gL2D1i5dRb9ZF+OffPgZEQhQ5FHpsZCqJ8vifWT81V4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eR9BwiWNoBpZwCuOeoxb9Al0vkYgpqnxJetx5XR5bPKr57y1G3Hj0pYHEUz1nh+u4
	 eJ2j7VWhgqwFAf2ei1g/JUjqlYRmdDtqsUOAn4R+wC/3DhLzd+EYNegJQmJVmObolG
	 Mkg7x64ymnlDoWM9NSS7DnARRDm19ivFQuMvNDjrlOiX0vvx+b6ngdtLPOkbqit97a
	 hQyfA1cGY9b6GskNSxhRKu/6/BK5TWt31TN5SsbmEk3cQht4j2pvhZIfZfnWOXwHGN
	 +M063gr4amYLoTNMewcUb2QkhbvTnJK78nTL2rst7uW8NLYy5M3zCV96vCnx7JWRh5
	 C/Jkii20DrDXg==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 39A9148EBA;
	Mon, 24 Feb 2025 23:23:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Mauro Carvalho Chehab
 <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/39] scripts/kernel-doc: rename it to
 scripts/kernel-doc.pl
In-Reply-To: <52d0e3a45dac63af3dfad23103cd4365fb12686c.1740387599.git.mchehab+huawei@kernel.org>
References: <cover.1740387599.git.mchehab+huawei@kernel.org>
 <52d0e3a45dac63af3dfad23103cd4365fb12686c.1740387599.git.mchehab+huawei@kernel.org>
Date: Mon, 24 Feb 2025 16:23:21 -0700
Message-ID: <874j0j2ahi.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> In preparation for deprecating scripts/kernel-doc in favor of a
> new version written in Perl, rename it to scripts/kernel-doc.pl.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/{kernel-doc => kernel-doc.pl} | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename scripts/{kernel-doc => kernel-doc.pl} (100%)
>
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc.pl
> similarity index 100%
> rename from scripts/kernel-doc
> rename to scripts/kernel-doc.pl
> -- 
> 2.48.1

A pretty tiny nit but ... this isn't bisectable.  I'm not sure how
worried we are about that, but I thought I'd point it out.

jon

