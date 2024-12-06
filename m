Return-Path: <linux-kernel+bounces-435343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8589E7651
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F9D18817B9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6291F4E22;
	Fri,  6 Dec 2024 16:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="eIL85Int"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A131206295;
	Fri,  6 Dec 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503375; cv=none; b=BTJFvXrvS1IzXa0KTrobH+2SDhH0vc/ZXu6qdz0uK54aLvRCsfmhEiQfH8JI8N8rZy3qYfIBAN/30gef5zzzoL+6xpseIuYiyOOSEDs2OcB5s5CSkfmlVs8DsxqPYm/I90MuPXuzyRlHmitU0/PqHxt59MsyimlhLQXnCgvJZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503375; c=relaxed/simple;
	bh=YFJntjVduFMosRnOUJmWz/Q3qwcuF61r05QeDp1Yqbo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CWQG/aiKLfcQOpCi1lV1Y9p7yGYPhxg4A1ugk1Dq+MVN6HdlOunER40UfTkEjuV+MADjtAXw3bMTOvEbPqcvYEgrlHiMfGsf1YbgzY8QqImWkPhwiSQPKu/DM20ImEkINHhu8WmXQhB2b6W5/bybMTcuGoWeqnwanh51Y3P/Ug8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=eIL85Int; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A993840409
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1733503372; bh=UINKQnGuti1paPKzepiCObIdtamjzJZLCF6YAKVJ/jQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eIL85IntrzzxoH5/fyF+qn7pp0RaIKQ3SOWWEt89cyv2XRy2d2d/CniJfvQ1kouUV
	 c4CVVIoyqpyjtC7VZZdOsxkthShVZJMnLFFCye4GhnDx0vHUqcnaYImt47aAQzIiWo
	 rxOEAsDI83DnLs+VBQTCuD6eevD83nxuKZ94XcDkkrFGAtY858F5slWMoybkP6dlam
	 PECKv5qHcAJfEQs5CQ+ZPawoW+WDnKE7vIx1l/0O5tcFQqiDx3qzTEmMWbHAqeRv7C
	 wJPEGxEASxFOJ+iXMzTElF7l5k9tG4OGUB3HTnMKOVvUZDOa+1kZzilgHKpSKzg88c
	 2te7SLDKrtF+Q==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A993840409;
	Fri,  6 Dec 2024 16:42:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] docs: 5.Posting: mentioned Suggested-by: tag
In-Reply-To: <fbebad6605b02e372b24c2cfa1e05f789fed43d1.1733127086.git.linux@leemhuis.info>
References: <fbebad6605b02e372b24c2cfa1e05f789fed43d1.1733127086.git.linux@leemhuis.info>
Date: Fri, 06 Dec 2024 09:42:51 -0700
Message-ID: <87cyi4u5is.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Mention the Suggested-by: tag in 5.Posting.rst in a way similar to
> submitting-patches.rst, which according to the header of the latter is
> the less detailed document of the two.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
> v3:
> - first version, split out from another patch-set that was at v2:
>   https://lore.kernel.org/all/1609d461030094b294f08d0b4e208d32993ac799.1731749544.git.linux@leemhuis.info/
> - add Reviewed-by: from Greg
> ---
>  Documentation/process/5.Posting.rst | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks.

jon

