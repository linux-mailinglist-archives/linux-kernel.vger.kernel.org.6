Return-Path: <linux-kernel+bounces-231607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93527919AC3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 00:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D826284C70
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098EA19415E;
	Wed, 26 Jun 2024 22:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="gPY6XEyC"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F6A19408C;
	Wed, 26 Jun 2024 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719441352; cv=none; b=C2pmpyqgQ7a2VIiEG/kSp8BpzNZ9Khmo3wVVVDzqqm14KeLDCPYUIy56fYQrNfoEwdSo0mmL1F41CzWONvqUQfAwMvqShhpBQN1IIFaglIihyYEPJBfpImTSm2OnR9hY4nDXcphHB1tvxdMrWWaxrIB895qjkkktquAyfhlMIWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719441352; c=relaxed/simple;
	bh=arS+qhZ/1pk1KC/uIFXr1FYLp22G1oEMnXNyBt9xGE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RtiU6kKDzZUw7ZreP+ztsI36Y9np76WcHbgeVhzWDho2d+KtfDWTaN2PIveDlvmGpD1ljEs/h96WoMy3KcN246hQnzu/WjxalEh2VylQJ/95AHrHnIJmW6o0dYQTmeQ1FitP0ytBMRvymVDbBfUpsa20tTOUX3oi/YM6WSCI0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=gPY6XEyC; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 24D3945E2B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1719441350; bh=n/97nY1OJR6YacbIL1zWcSLDzq/jx6pSS2FN/gq8ikA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=gPY6XEyCzlVUwyKsaaBFosmuOHMztArpRptCe+kZKG+ukR6NollQMO2/TTzIHymY3
	 AK6acU6e8DehAoIQ/AIgJLYoC/v90gNiwpLOq5ydjoKIrV+YMh33cNuP/hV6SOttsu
	 PWCyIqs0rw/MzOT6sF3KHzMnEV2ovpglh3IHRyYAHOiH5rl+I4XkLhLMQX0UJeuLzH
	 0Rp8gbtu4N55RsAhuyFU4v0y2TRXQIC5x7YJNUH7UqTjNWo3kwY+cyU6ZsIHYSUg4u
	 /SVDRsTGpKzG8czX0WLL3KbOMQTkEWQhFighGjqRUs5xqKKNui5DEc5mK4PQhFFOzW
	 8S64ssn8J4sGQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 24D3945E2B;
	Wed, 26 Jun 2024 22:35:50 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: SeongJae Park <sj@kernel.org>
Cc: SeongJae Park <sj@kernel.org>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] Docs/process/email-clients: Document HacKerMaiL
In-Reply-To: <20240624185312.94537-8-sj@kernel.org>
References: <20240624185312.94537-1-sj@kernel.org>
 <20240624185312.94537-8-sj@kernel.org>
Date: Wed, 26 Jun 2024 16:35:49 -0600
Message-ID: <874j9fz60q.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

SeongJae Park <sj@kernel.org> writes:

> HacKerMaiL (hkml) [1] is a simple tool for mailing lists-based
> development workflows such as that for most Linux kernel subsystems.  It
> is actively being maintained by DAMON maintainer, and recommended for
> DAMON community[2].  Add a simple introduction of the tool on the
> email-clients document, too.
>
> [1] https://github.com/sjp38/hackermail
> [2] https://lore.kernel.org/20240621170353.BFB83C2BBFC@smtp.kernel.org
>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/process/email-clients.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)

We should really document lei as well if we're going to do this, but I
won't try to insist on that here...:)

jon

