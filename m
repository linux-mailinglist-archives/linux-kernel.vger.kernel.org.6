Return-Path: <linux-kernel+bounces-380706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9211E9AF4C7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA05B21FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 21:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DAE2178E1;
	Thu, 24 Oct 2024 21:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LxWaFvm7"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D42B21731D;
	Thu, 24 Oct 2024 21:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729806308; cv=none; b=mlDS7JZYcocHvapR7wX1vvTF5ik9oUuuDlybpC/eIFlVyzCKNvBFkeaEn+SUu9adLzoa69o1DqjLRn4e/CXHIfQ6wIOTQ/9OYa5Xmw8vZ0aXIBXXYhA0arsv+eIF+ChHsgYzH74Z2wDZT5sCeQ/Cw9IPmFuLNizggJM6nxwjLYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729806308; c=relaxed/simple;
	bh=g5RVBrlvEqwpWKnIlUV9wO/rHpJmpn2uEP7XT895l7s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZTB25j20Zvwmu/+KWpnl4p28YqcQSogMx7EPIjm8622mpAQfCqCBjzVaF4KZfZdzcVFOg0r0mKzW+vE1lPVYtLM38owGJjUr6oy2+REuK5o+UpFjqLfwlTkpmMG5x952HlTuW9fZIKyI6qEtNydeGDxqzkMzMFINMKyBveJMI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LxWaFvm7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9A5F142C0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1729806305; bh=2icjHji/8rRsBWpMTTcOpJM8Mc4k+8M31SpjTYrBL+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LxWaFvm7xlawyi3hP1huUoWgNx1rVOh7RyMb9TY+VUs1+m6mqyeEVm0X3epNc9zQe
	 CFDmcVxD2GCJwneXUGONkOUqPjxov1cPdrFDKHw5P84zDNbHTO8A434gJM/UM6UjwH
	 gV1wEXba+04TBZf7MDkdxE6MgDqmUqDyq+hGSj04Vakb0KEg6cAiLnpkoRRJkIHuXV
	 4jQcKiwp5rDjgvB0f1d9qmSqoKwmEE8JBRzd8ePCAT4N050PI69yRncuXSslF/cMco
	 FfEvcYXVnuIYMZ38uhj4wUPup7m97eEyogF2q4vUv2V58utSB/TswIfGbnRRHDMfkH
	 I6aeSH+XfutrQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9A5F142C0D;
	Thu, 24 Oct 2024 21:45:05 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, si.yanteng@linux.dev, alexs@kernel.org
Cc: hust-os-kernel-patches@googlegroups.com, Dongliang Mu
 <dzm91@hust.edu.cn>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] update the translation of partial files in mm
In-Reply-To: <cover.1729327831.git.dzm91@hust.edu.cn>
References: <cover.1729327831.git.dzm91@hust.edu.cn>
Date: Thu, 24 Oct 2024 15:45:04 -0600
Message-ID: <87ldyd2n1b.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Dongliang Mu (6):
>   docs/zh_CN: update the translation of mm/hmm.rst
>   docs/zh_CN: update the translation of mm/active_mm.rst
>   docs/zh_CN: update the translation of mm/admon/faq.rst
>   docs/zh_CN: update the translation of mm/overcommit-accounting.rst
>   docs/zh_CN: update the translation of mm/page_table_check.rst
>   docs/zh_CN: update the translation of mm/page_owner.rst
>
>  .../translations/zh_CN/mm/active_mm.rst       |  5 ++
>  .../translations/zh_CN/mm/damon/faq.rst       | 17 -------
>  Documentation/translations/zh_CN/mm/hmm.rst   |  8 +---
>  .../zh_CN/mm/overcommit-accounting.rst        |  3 +-
>  .../translations/zh_CN/mm/page_owner.rst      | 46 +++++++++++++++++++
>  .../zh_CN/mm/page_table_check.rst             | 13 ++++++
>  6 files changed, 66 insertions(+), 26 deletions(-)
>
> -- 
> 2.43.0

Series applied, thanks.

jon

