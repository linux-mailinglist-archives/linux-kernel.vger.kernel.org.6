Return-Path: <linux-kernel+bounces-254105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6725932EEE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78BEF1F238A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1447719FA76;
	Tue, 16 Jul 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="EFob3G+t"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DCDB641;
	Tue, 16 Jul 2024 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721149925; cv=none; b=hldQU4b83/yOwvyZS/YrNplpXJCytfGFWPfc1goN/hkw0M8Uh0UfCOd66Nklq9lh6z6P/xorNO0XJexA48vXcbCTN1vImoFTIA64dn59iHx336NY1j+4et+2ymWPZzIBopKw3WpwewO84/PSvJwLzjUUCKmU2jt9H8lVf3gSdL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721149925; c=relaxed/simple;
	bh=PrKlfPmUzsX7I9e5czwch2lOHbt9lCGeVT0p9Q2Zpk4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Tv2HN80lbPl46cbbxYshZjycSlaNs8N8Jt5uiLY94cBIrEdOY70B+eqX5oewZqa61KHJ3sO+2QSs9g2nZSr+0DIgiJ6zZk7zTkdwB/d+Hp0QqGkdTVgbXTiumxmOuF70iOkNceXu2/mna1AFfP9EnOS8fby8AUMnEJs3KX2TXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=EFob3G+t; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0A56541A2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1721149923; bh=6/zLkmeJ5oiqOUtud8sZ1vjc7rtdtBEMM+8tGxBf0Y4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EFob3G+t3hPswQm/lq6on2Z72ygLtUkTQbmwFWIIWH6zUW2ooeS+teMhZABajcDGy
	 TkxuuS7LaXbQqnYkpBVjUtLRs+scVxhx44YjWJVAyVPbAsfmvGTbFxSZc/KKRnKrl7
	 tly+Z9HopwCOqTEW21NGMAGUVPT9TIquF+FdjOd7aUgyS3eYYYs9Rcyaj6eK1wU48j
	 RbRFizoFIk4jRhx86Q7ZpaDtr9bDuUphY7cN8dTwyyc/Ve/l8u4XtQiPfySjjnbtRU
	 fiWsBj/GvfuqaJDW7TUMzdZLyja96tlXJ17bnRM8KLFU4OmGoaxseCQzyrIot9C/SG
	 wvQdwu+Rjq7dg==
Received: from localhost (c-24-9-249-71.hsd1.co.comcast.net [24.9.249.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0A56541A2D;
	Tue, 16 Jul 2024 17:12:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: marc.ferland@gmail.com, linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marc Ferland <marc.ferland@sonatest.com>
Subject: Re: [PATCH] docs/pinctrl: fix typo in mapping example
In-Reply-To: <20240709183919.3337131-1-marc.ferland@sonatest.com>
References: <20240709183919.3337131-1-marc.ferland@sonatest.com>
Date: Tue, 16 Jul 2024 11:12:02 -0600
Message-ID: <87r0bttg65.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

marc.ferland@gmail.com writes:

> From: Marc Ferland <marc.ferland@sonatest.com>
>
> Small typo. The device name in the example should be "foo-i2c.0" and
> not "foo-i2c.o".
>
> Signed-off-by: Marc Ferland <marc.ferland@sonatest.com>
> ---
>  Documentation/driver-api/pin-control.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/driver-api/pin-control.rst
> index 4639912dc9cc..27ea1236307e 100644
> --- a/Documentation/driver-api/pin-control.rst
> +++ b/Documentation/driver-api/pin-control.rst
> @@ -1002,7 +1002,7 @@ it even more compact which assumes you want to use pinctrl-foo and position
>  .. code-block:: c
>  
>  	static struct pinctrl_map mapping[] __initdata = {
> -		PIN_MAP_MUX_GROUP("foo-i2c.o", PINCTRL_STATE_DEFAULT,
> +		PIN_MAP_MUX_GROUP("foo-i2c.0", PINCTRL_STATE_DEFAULT,
>  				  "pinctrl-foo", NULL, "i2c0"),

Applied, thanks.

jon

