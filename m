Return-Path: <linux-kernel+bounces-304010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8C5961883
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 22:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADCE283B08
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 20:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E4B1D362C;
	Tue, 27 Aug 2024 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XqKF1+At";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qCwDcW6Q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5F1C5788
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 20:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790559; cv=none; b=eB4CXO31KkZpci1xIJoX8VvC2GAdtz1q4nF8i0m8CRYejXQ3v4tixOA20qOpBEvZjfyX10cn9KLmRaJ7O2PevUrdXELIXQHnzMsIGxat1oaXVlWO50g5S5C2paShTEOpYgBqTWp2KwTlhXMT1aaPxAZLOds9WNHpwTZwTbWWzTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790559; c=relaxed/simple;
	bh=jpBEmBWxelW30kdJod71HrZHykpjpBD+VRwhk5peNas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HtRAyzgIVLPg75Y/2moqTFtapkQ/vg+nCJQILOdj61nNeA8ipyjJxXEz2IQmB2Y3ZqJYGNFCUpVBjvZAHshDeq+znhqCt6g+fVpR5IfHPsrwtkfylpsQ4Eq3XzJmZF8EctbjSnfHCW5r2jnXmMiHgvS6xEAV+jvXGG0efoBDCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XqKF1+At; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qCwDcW6Q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Aug 2024 22:29:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724790549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5O8I6R+ZOt+8soub3TuoO9hBAOUMB/FUiDAn9N49VM=;
	b=XqKF1+AtTO1/JZKAZi8bqWdqDFF/b7ZolkL3BIvCYxYIvxALqSDonmzYpjyropK9p9q+tx
	C3yVXLgwVhcAhbNpcK9xn7xBcjLXs4hQ1bynIeLJFYF4+umFYzQAg6LvCLyeb3SiZmZge+
	U6J6u8hIwUGeaRNqdCV4idzr08iKuwxP6wq3qDS0aMzamAPKgeg5X562efBCtpmVG74IHr
	PlNYs7tgsWLChoU0j7nISJCaBoSFusrt2F+6tnFCYpscZKCUCuFg2fwCN7xuxS5qJ2YZuE
	dVKmFTfvrDgYFQfkahpPHzMo8OhU7OL0RpVIasMyQC1vURCSYyk+Mw108a8iRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724790549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q5O8I6R+ZOt+8soub3TuoO9hBAOUMB/FUiDAn9N49VM=;
	b=qCwDcW6QfkV8L5F+MP4pjBaecphhkFs1TFJaTMYf1rizxRbs4O47zK2o8bKBwsIyC88oi2
	QwCEy16HG1JwohCQ==
From: Nam Cao <namcao@linutronix.de>
To: Nilo Alexandre <n1lux.comp@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v3] staging: rtl8192e: Fix parenthesis alignment in
 r8192E_dev.c 325
Message-ID: <20240827202904.vnRH1diD@linutronix.de>
References: <20240827195619.34712-1-n1lux.comp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827195619.34712-1-n1lux.comp@gmail.com>

On Tue, Aug 27, 2024 at 04:56:19PM -0300, Nilo Alexandre wrote:
> Align parenthesis to improve readability.
> 
> CHECK: Alignment should match open parenthesis
> 
> Signed-off-by: Nilo Alexandre <n1lux.comp@gmail.com>
> ---
> v3: Fix typo in commit message.
> v2: Using tabs instead of spaces.
> ---
>  drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index b767dc00100aa..2d17d8e8898e7 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -322,7 +322,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
>  		if (priv->epromtype == EEPROM_93C46) {
>  			if (!priv->autoload_fail_flag) {
>  				usValue = rtl92e_eeprom_read(dev,
> -					                     EEPROM_TxPwDiff_CrystalCap >> 1);
> +								EEPROM_TxPwDiff_CrystalCap >> 1);

But it was aligned, your patch makes it misaligned, right?

Also, I couldn't apply this patch. Are you sure this patch was made on top
of Greg's staging tree?

I suspect that there is a linebreak here because of Linux's historical 80
columns limit. Now that the limit is raised to 100, perhaps it's better to
just remove the linebreak:

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b25e83743956..a80efe6c7c20 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -321,8 +321,7 @@ static void _rtl92e_read_eeprom_info(struct net_device *dev)
 
 		if (priv->epromtype == EEPROM_93C46) {
 			if (!priv->autoload_fail_flag) {
-				usValue = rtl92e_eeprom_read(dev,
-					  EEPROM_TxPwDiff_CrystalCap >> 1);
+				usValue = rtl92e_eeprom_read(dev, EEPROM_TxPwDiff_CrystalCap >> 1);
 				priv->eeprom_ant_pwr_diff = usValue & 0x0fff;
 				priv->eeprom_crystal_cap = (usValue & 0xf000)
 							 >> 12;


