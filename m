Return-Path: <linux-kernel+bounces-323901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6F09744DB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7157288746
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 21:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C2E1AAE39;
	Tue, 10 Sep 2024 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Q5MYehw4"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12211AB50B;
	Tue, 10 Sep 2024 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726003863; cv=none; b=kFNGWbVviTwiuq3Ut94ENqj0YM/qK0RdtARdA9lLufqn0A+PvaXUsHqEYDXHTSbLTyTUGy9cn3+zqToBagLNj/TDhVMEJDd9k12SEOvaUfkg3Aw+F+44FLD+lZWbebuz3wg5H4c8LNWqAaaeG779X6MBewtNizLDFSpnK059unE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726003863; c=relaxed/simple;
	bh=Y9w8XYe4T6ICOB2jkY6L4dNZBgF6NHp0JTtiFIbQagc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dGrJNDfrS748wjNaS5BTzMH+YL2egSFvMbZjw6o81oL52Cqi4cqYYaLgVttxupEcy8Kwr0h6jv9d3DvY5rxkIX2umG4Oxn4Jhuv0QjPoet813GIiqv5GPVTqynIUasWJVAQbAGKzijihF1/wG3PBQkF4yr5nXAbFgmEoMBPmRrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Q5MYehw4; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D844B4188E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1726003861; bh=YNMg7zF25Lr6SZelCgmkTffdM2izIqHbF/4JqRWFuNc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Q5MYehw47ZovqUrHYjyOIlyI3Seey4BvPEgaW/SW/k157nOHFiKrkSxbwUJ1/M+M2
	 S1dtmZS6VhyyKp3Wv2vXyImp/0stkOyGTwrbvqv8QaG5XZ9eDd3dGqTURh9c8eiFRl
	 ntkg8sXhVOb1QT5f7pwQLw/1oqzxuRtPUJclPB4Og6kPHNxqoDGPVURt33N8PYPKE6
	 IDudbFwnZp7eNsi5TcDcN6Lb7Pa4eJqNmwTYnRS+QRvpeqdvNesYjKloXZWx3dkV3Q
	 BD/MxG+2eX9uRcX14Mk+U+EYMSaz7Uo5jvjzJQZJRhpl6ff2HTTj0SFNAIOPfPgyBE
	 n9vx6LoQdtIbg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D844B4188E;
	Tue, 10 Sep 2024 21:31:00 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Abdul Rahim <abdul.rahim@myyahoo.com>, bhelgaas@google.com
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Abdul Rahim
 <abdul.rahim@myyahoo.com>
Subject: Re: [PATCH] Documentation: PCI: fix typo in pci.rst
In-Reply-To: <20240906205656.8261-1-abdul.rahim@myyahoo.com>
References: <20240906205656.8261-1-abdul.rahim.ref@myyahoo.com>
 <20240906205656.8261-1-abdul.rahim@myyahoo.com>
Date: Tue, 10 Sep 2024 15:30:59 -0600
Message-ID: <87a5gf6vsc.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abdul Rahim <abdul.rahim@myyahoo.com> writes:

> Fix typo: "follow" -> "following" in pci.rst
>
> Signed-off-by: Abdul Rahim <abdul.rahim@myyahoo.com>
> ---
>  Documentation/PCI/pci.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> index dd7b1c0c21da..f4d2662871ab 100644
> --- a/Documentation/PCI/pci.rst
> +++ b/Documentation/PCI/pci.rst
> @@ -52,7 +52,7 @@ driver generally needs to perform the following initialization:
>    - Enable DMA/processing engines
>  
>  When done using the device, and perhaps the module needs to be unloaded,
> -the driver needs to take the follow steps:
> +the driver needs to take the following steps:
>  

Applied, thanks.

jon

