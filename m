Return-Path: <linux-kernel+bounces-251156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C37F2930154
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 22:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B0D1F239F3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6E13F9FC;
	Fri, 12 Jul 2024 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ibapAxmn"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95D22941C;
	Fri, 12 Jul 2024 20:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720817235; cv=none; b=s3LXKDb+te41yFCqSrevn21Gf11TQ5CDJu3XKL1szNBgSIw4HEy+unTQfVx9Jor1PF0li0teP+eEy7NZWU6LLr1f7x3MVez4+s+/qOKLXYbcMeAWI0lmDS3l82CCfBmNCCPq5eZjoduuw3GMS65qPm5xHzYtfNdeG+TE18NFt74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720817235; c=relaxed/simple;
	bh=lgTJHKqPYIS2woWZubF3qRugCb3qZDNjviLkuMpDoRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ot0D7WLytnk5uvjB149s2O8XfubQSPiDXgGgLCMyGd28zMrUVkLwVA0hmmvXjcLHfwY1ktaKTpWEHG9ilQiLc7ofzzSijrpIGRTsUY/6rZQrXaazOv/2ZMrlzknFE8sMkrcjI+A0QBrzr+G3/QSbZZugAWthF0LptON3Xkc0S2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ibapAxmn; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E5C3C418A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1720817233; bh=U7piIa03AuGl6QcRVjk8/r5+Upbp6ko5VGS82niP9Cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ibapAxmnfQ6WIeHowxF+5bVkPEkW2bEKmrfZM+AHjLk5ZwfJxXjNRX1/WayEE3Vym
	 9uINNKS5RuY7Fzlymc7nbKSbma7V18bCzhNo9hrnS2oJPY0lem9MXde66WVRdSGr5V
	 RfF58AZD1Gm67Tu8nm8KAenzdu1mwPubok8735eh8sRAP2ZfbJw5t5LvO72yyWP2Pd
	 gNp6NDjvXo0GOw9jiYXdpSOyj7eghmAxFuad5PRtF00NBL5umqlKCSVQ3x/T0mIgfG
	 LZy13OHQGDT0O2bD8fDtm4RaejD6nvz4R1toFx97FfzR5N1LgPTmjaQGLMvK1Rr1jf
	 bWNpt3/TMx3OA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E5C3C418A2;
	Fri, 12 Jul 2024 20:47:12 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Eric Biggers <ebiggers@kernel.org>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: driver-model: platform: update the definition of
 platform_driver
In-Reply-To: <20240711200421.11428-1-ebiggers@kernel.org>
References: <20240711200421.11428-1-ebiggers@kernel.org>
Date: Fri, 12 Jul 2024 14:47:11 -0600
Message-ID: <87cyniz6b4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Biggers <ebiggers@kernel.org> writes:

> From: Eric Biggers <ebiggers@google.com>
>
> Update the documented struct platform_driver to match the code.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  Documentation/driver-api/driver-model/platform.rst | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Gee...if only we had a documentation system that could do this
automatically.... :)  Meanwhile I've applied this.

Thanks,

jon

